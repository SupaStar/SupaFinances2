//
//  DivisasService
//  SupaFinances2
//
//  Created by Obed Martinez on 17/08/23
//



import Foundation

class DivisasService {
    
    private var dataTask: URLSessionDataTask?
    
    func getUsdToMxn(completion: @escaping((ExchangeRateResponse) -> Void)) {
        dataTask?.cancel()
        let apiURL = URL(string: dolarMxn)
        
        dataTask = URLSession.shared.dataTask(with: apiURL!) { (data, response, error) in
            if let error = error {
                print("Error al realizar la solicitud: \(error)")
                return
            }
            
            guard let data = data else {
                print("No se recibieron datos.")
                return
            }
            
            do {
                let exchangeRateResponse = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
                completion(exchangeRateResponse)
            } catch {
                print("Error al decodificar JSON: \(error)")
            }
        }
        dataTask?.resume()
    }
}
