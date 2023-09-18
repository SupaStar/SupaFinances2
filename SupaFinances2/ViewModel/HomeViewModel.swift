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
    @Published var total: Double = 0
    @Published var showToast: Bool = false
    @Published var isToastError: Bool = true
    @Published var toastError: String = ""
    private let today: Date = Date()
    private let dataService: DivisasService = DivisasService()
    private let stockService: StocksService = StocksService()
    private var portafolioServ = PortafolioService()
    
    init(usdValue: ExchangeViewModel? = nil, isPreview: Bool) {
        self.usdValue = usdValue
        if isPreview {
            self.loadPreviewData()
        }
        loadStocks()
    }
    func loadStocks(){
        portafolioServ = PortafolioService()
        self.portfolio = portafolioServ.portFolios.first
        stocks = portafolioServ.savedStocks
        total = 0
        var needRefresh: Bool = false
        for stock in stocks {
            total += stock.price_prom * stock.quantity
            if let modifyDate = stock.modify_date {
                if !Calendar.current.isDate(today, equalTo: modifyDate, toGranularity: .day) {
                    needRefresh = true
                }
            }
        }
        if needRefresh {
            refreshValues()
        }
    }

    func newValue() {
        saveNewValue(symbol: "FMTY14", price: 1)
    }
    
    func deleteStock(offsets: IndexSet) {
        let selectedStocks = offsets.map { stocks[$0] }
        portafolioServ.deleteStocks(stocks: selectedStocks)
        loadStocks()
        print(selectedStocks)
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
    
    func refreshValues() {
        isLoading = true
        let dispatchGroup = DispatchGroup()
        
        portafolioServ = PortafolioService()
        self.portfolio = portafolioServ.portFolios.first
        let stocksSaved = portafolioServ.savedStocks
        
        for stock in stocksSaved {
            dispatchGroup.enter()
            
            guard let stockSymbol = stock.symbol else {
                showAlert(message: "No se pudo obtener información", isError: true)
                dispatchGroup.leave()
                continue
            }
            
            if stock.country == "Mexico" {
                stockService.showMexicanStock(stockSymbol: stockSymbol) { (response, error) in
                    defer {
                        dispatchGroup.leave()
                    }
                    
                    if let error = error {
                        self.showAlert(message: error, isError: true)
                        return
                    }
                    
                    guard let response = response else {
                        return
                    }
                    self.saveNewValue(symbol: stockSymbol, price: response.ultimo)
                }
            } else {
                stockService.showUsaStock(stockSymbol: stockSymbol) { (response, error) in
                    defer {
                        dispatchGroup.leave()
                    }
                    
                    if let error = error {
                        self.showAlert(message: error, isError: true)
                        return
                    }
                    
                    guard let response = response else {
                        return
                    }
                    self.saveNewValue(symbol: stockSymbol, price: response.price)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.isLoading = false
            self.loadStocks()
        }
    }
    
    func saveNewValue(symbol:String, price: Double){
        guard let stockEntity = self.portafolioServ.findStock(stock: nil, symbol: symbol) else {
            showAlert(message: "No se pudo obtener informacion", isError: true)
            return
        }
        self.portafolioServ.updateValue(stock: stockEntity, value: price)
    }
    func showAlert(message: String, isError: Bool) {
        toastError = message
        isToastError = isError
        showToast.toggle()
    }
}
