//
//  ApiCaller.swift
//  Avito_Chagellenge
//
//  Created by Asf on 23.10.2022.
//

import Foundation
import Cachy

struct Constants {
    static let base_URL = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
}

let cachy = CachyLoader()

enum APIError: Error {
    case failedToGetData
}


class APICaller {
    static let share = APICaller()
    
    
    
    func getCompanyName(completion: @escaping (Result<Company, Error>) -> Void) {
        
            guard let url = URL(string: Constants.base_URL) else {return}
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error  in
                if let error = error{
                    completion(.failure(error))
                }
                else if data == data{
                    do{
                        let results = try JSONDecoder().decode(Avito.self, from: data!)
                        completion(.success(results.company))
                        _ = CachyObject(value: results , key: "companyName", expirationDate: ExpiryDate.seconds(3600).date)
                    }catch{
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }

    
    func getEmployees(completion: @escaping (Result<[Employee], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.base_URL)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error  in
            if error != nil{
                completion(.failure(APIError.failedToGetData))
            }
            else if data == data{
                do{
                    let results = try JSONDecoder().decode(Avito.self, from: data!)
                    completion(.success(results.company.employees))
                    _ = CachyObject(value: results , key: "Employees", expirationDate: ExpiryDate.seconds(3600).date)
                }catch{
                    completion(.failure(APIError.failedToGetData.localizedDescription as! Error))
                }
            }
            }
        task.resume()
            }
}
