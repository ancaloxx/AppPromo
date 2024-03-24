//
//  ServiceAPI.swift
//  AppPromo
//
//  Created by anca dev on 22/03/24.
//

import Foundation
import Alamofire

struct Promo: Codable {
    var promos: [Promos]
}

struct Promos: Codable {
    var id: Int
    var name: String
    var images_url: String
    var detail: String
}

protocol ServiceAPIProtocol: AnyObject {
    func getDataPromo(completion: @escaping(Promo) -> Void)
}

class ServiceAPI: ServiceAPIProtocol {
    
    static let shareInstance = ServiceAPI()
    
    func getDataPromo(completion: @escaping(Promo) -> Void) {
        if let urlStr = URL(string: ConstantFile.urlPromo) {
            let parameters: [String: String] = [
                "Authorization": ConstantFile.token
            ]
            
            AF.request(urlStr, method: .get, 
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: nil).response { response in
                switch response.result {
                case .success(let data):
                    if let data = data {
                        do {
                            let json = try JSONDecoder().decode(Promo.self,
                                                                from: data)
                            completion(json)
                        } catch {
                            print(String(describing: error))
                        }
                    }
                case .failure(let error):
                    print("request error: \(error)")
                }
            }
        }
    }
    
}
