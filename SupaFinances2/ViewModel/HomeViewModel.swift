//
//  HomeViewController
//  SupaFinances2
//
//  Created by Obed Martinez on 17/08/23
//



import Foundation

class HomeViewModel: ObservableObject {
    @Published public var usdValue: ExchangeViewModel?
    private let dataService: DivisasService = DivisasService()
    var showLoader: (()-> Void)?

    func loader() {
        if let showLoader = self.showLoader {
            showLoader()
        }
    }
    
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
//        finances.isLoading = true
        usdValue = nil
        dataService.getUsdToMxn(completion: { response in
            let exchangeVM = ExchangeViewModel(exchange: response)
            DispatchQueue.main.async {
                self.usdValue = exchangeVM
//                self.finances.isLoading = false
            }
        })
    }
}
