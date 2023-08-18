//
//  StocksService
//  SupaFinances2
//
//  Created by Obed Martinez on 17/08/23
//



import Foundation

class StocksService {
    
    private var dataTask: URLSessionDataTask?
    
    // MARK: PETITION TO SEARCH STOCKS
    func searchStocks(search: String, completion: @escaping( ([UsaStockSearch]) -> Void)){

        dataTask?.cancel()
        
        guard let url = buildUrl(forTerm: search) else {
          completion([])
          return
        }

        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        
        request.addValue("87baf13dcemshd809eaa7e7a6972p1c29edjsnfcbd3e8bdb23", forHTTPHeaderField: "X-RapidAPI-Key")
        
        request.httpMethod = "GET"
        
        dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error al realizar la solicitud: \(error)")
                return
            }
            
            guard let data = data else {
                print("No se recibieron datos.")
                return
            }
            
            do {
                let searchResponse = try JSONDecoder().decode(UsaStockSearchResponse.self, from: data)
                completion(searchResponse.data)
            } catch {
                print("Error al decodificar JSON: \(error)")
            }
        }
        dataTask?.resume()
    }
    
    // MARK: SHOW DATA MEXICAN STOCK
    func showMexicanStock(stockSymbol: String, completion: @escaping( (MexicanStock) -> Void)) {
        dataTask?.cancel()
        
        guard let apiURL = URL(string: urlMexico(serie: stockSymbol)) else {
            print("Error al obtener la url")
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            if let error = error {
                print("Error al realizar la solicitud: \(error)")
                return
            }
            
            guard let data = data else {
                print("No se recibieron datos.")
                return
            }
            
            do {
                print(String(data: data, encoding: .utf8)!)
                let mexicanStockDetail = try JSONDecoder().decode(MexicanStockResponse.self, from: data)
                completion(mexicanStockDetail.BMV)
            } catch {
                print("Error al decodificar JSON: \(error)")
            }
        }
        dataTask?.resume()
    }
    
    // MARK: SHOW DATA USA STOCK
    func showUsaStock(stockSymbol: String, completion: @escaping( (UsaStockResponse) -> Void )){
        dataTask?.cancel()
        
        guard let apiURL = URL(string: urlUSA(serie: stockSymbol)) else {
            print("Error al obtener la url")
            return
        }
        var request = URLRequest(url: apiURL, timeoutInterval: Double.infinity)
        
        request.addValue("87baf13dcemshd809eaa7e7a6972p1c29edjsnfcbd3e8bdb23", forHTTPHeaderField: "X-RapidAPI-Key")
        
        request.httpMethod = "GET"
     
        dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error al realizar la solicitud: \(error)")
                return
            }
            
            guard let data = data else {
                print("No se recibieron datos.")
                return
            }
            
            do {
                let usaStock = try JSONDecoder().decode(UsaStockResponse.self, from: data)
                completion(usaStock)
            } catch {
                print("Error al decodificar JSON: \(error)")
            }
        }
        dataTask?.resume()
    }
    
    // MARK: Build URL with query params
    private func buildUrl(forTerm searchTerm: String) -> URL? {
      guard !searchTerm.isEmpty else { return nil }
      
      let queryItems = [
        URLQueryItem(name: "symbol", value: searchTerm),
        URLQueryItem(name: "outputsize", value: "30"),
      ]
      var components = URLComponents(string: urlbusqueda)
      components?.queryItems = queryItems
      
      return components?.url
    }
}
