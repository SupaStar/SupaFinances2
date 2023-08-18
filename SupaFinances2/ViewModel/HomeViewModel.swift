//
//  HomeViewController
//  SupaFinances2
//
//  Created by Obed Martinez on 17/08/23
//



import Foundation

class HomeViewModel: ObservableObject {
    @Published public private(set) var usdValue: ExchangeViewModel?
    @Published public private(set) var isLoading: Bool = false
    private let dataService: DivisasService = DivisasService()
    private let pruebas: StocksService = StocksService()

    init(usdValue: ExchangeViewModel? = nil, isPreview: Bool) {
        self.usdValue = usdValue
        if isPreview {
            self.loadPreviewData()
        }
    }
    
    func loadPreviewData(){
        print("PreviewData")
    }
    
    func loadUsdValue() {
        isLoading = true
        usdValue = nil
        dataService.getUsdToMxn(completion: { response in
            let exchangeVM = ExchangeViewModel(exchange: response)
            DispatchQueue.main.async {
                self.usdValue = exchangeVM
                self.isLoading = false
            }
        })
    }
    
    func pruebaBusqueda(){
        isLoading = true
        self.pruebas.searchStocks(search: "fmty", completion: { response in
            print("busqueda \(response)")
            DispatchQueue.main.async {
                self.isLoading = false
                self.pruebaMexico()
            }
        })
    }
    func pruebaMexico(){
        isLoading = true
        self.pruebas.showMexicanStock(stockSymbol: "fmty14", completion: { response in
            print("mexico \(response)")
            DispatchQueue.main.async {
                self.isLoading = false
                self.pruebaUsa()
            }
        })
    }
    func pruebaUsa(){
        isLoading = true
        self.pruebas.showUsaStock(stockSymbol: "voo", completion: { response in
            print("usa \(response)")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        })
    }
}
