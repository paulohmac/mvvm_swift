//
//  HTTPRequest.swift
//  Interface que faz as requisições para a API Dark sky
//  Precisa ser refeita codigo
//  Created by Paulo Henrique on 15/02/20.
//

import UIKit



protocol Request{
    
}


extension Request {
    /// Faz requisição para o serviço dark sky.
    ///
    /// - warning: Código mal implementado.
    /// - parameter latitude: latitude atual
    /// - parameter longitude: longitude atual
    /// - parameter language: linguagem
    /// - parameter completion: completion como resultado da requisicao

    func sendRequest(
        _ latitude: String,
        _ longitude: String,
        _ language: String,
        _ completion: @escaping (Result<Any>) -> Void) {
        
        let urlServer = String( format:Config.endpointDarkSky, latitude, longitude, language)
        do {
            
            let requestURL: URL = URL(string: urlServer)!
            var urlRequest = URLRequest(url:requestURL)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.httpMethod  = "GET"
            
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
            
            let task = session.dataTask(with: urlRequest, completionHandler: {
                (data, response, error) -> Void in
                
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                print (String(data: data!, encoding: String.Encoding.utf8))
                
                if (statusCode == 200) {
                    do{
                        if error != nil {
                            print(error)
                            return completion( Result.Failure(error!))
                        }
                        
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let avaliacoes : WeatherConditions  = try! decoder.decode(WeatherConditions.self, from: data!)
                        return completion( Result.Success( avaliacoes ))
                    }catch {
                        return completion( Result.Failure(error))
                    }
                }else{
                    let errorRet = NSError(domain:"Erro HTTP: \(statusCode)", code:httpResponse.statusCode, userInfo:nil)
                    return completion( Result.Failure(errorRet))
                }
            })
            
            task.resume()
        } catch {
            return completion( Result.Failure(error))
        }
    }
    
    
}

