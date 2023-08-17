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
}
