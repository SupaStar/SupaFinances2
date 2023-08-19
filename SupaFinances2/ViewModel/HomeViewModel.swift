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
    @Published var stocks: [StockEntity] = []
    @Published var holds: [HoldingEntity] = []
    @Published var portfolio: PortafolioEntity?
    private let dataService: DivisasService = DivisasService()
    private let pruebas: StocksService = StocksService()
    private let portafolioServ = PortafolioService()
    
    init(usdValue: ExchangeViewModel? = nil, isPreview: Bool) {
        self.usdValue = usdValue
        if isPreview {
            self.loadPreviewData()
        }
        loadStocks()
    }
    func loadStocks(){
        self.portfolio = portafolioServ.portFolios[0]
        guard let portfolio = self.portfolio else {
            return
        }
//        portafolioServ.addStock(name: "Dhanhos", marketVal: 22, symbol: "Dhanhos", country: "MX", portfolio: portfolio)
        stocks = portafolioServ.savedStocks
        testHold()
    }
    
    func testHold() {
        var stock = stocks[0]
        portafolioServ.addHold(stock: stock, price: 200.0, quantity: 30, hold_date: Date())
        holds = stock.holds?.allObjects as! [HoldingEntity]
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
//                self.pruebaBusqueda()
            }
        })
    }
    
    func pruebaBusqueda(){
        isLoading = true
        self.pruebas.searchStocks(search: "fmty", completion: { (response, error) in
            if let error = error {
                print(error)
            }
            print("busqueda \(response)")
            DispatchQueue.main.async {
                self.isLoading = false
                self.pruebaMexico()
            }
        })
    }
    func pruebaMexico(){
        isLoading = true
        self.pruebas.showMexicanStock(stockSymbol: "fmty14", completion: { (response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response else {
                return
            }
            print("mexico \(response)")
            DispatchQueue.main.async {
                self.isLoading = false
                self.pruebaUsa()
            }
        })
    }
    func pruebaUsa(){
        isLoading = true
        self.pruebas.showUsaStock(stockSymbol: "voo", completion: { (response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response else {
                return
            }
            print("usa \(response)")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        })
    }
}
