//
//  DarkSkyApi.swift
//  Faz requisição para a APi dark sky
//
//  Created by Paulo Henrique on 15/02/20.
//

import UIKit

class DarkSkyApi: NSObject, Request {
    /// Solicita dados para a APi do dark sky.
    ///
    /// - parameter latitude: latitude
    /// - parameter longitude: longitude
    /// - parameter language: idioma atual
    /// - parameter completion: completion a ser executado quando API retornar dados
    func findWeather(
               _ latitude: String,
               _ longitude: String,
               _ language: String,
               _ completion: @escaping (Result<Any>) -> Void) {
      return sendRequest(latitude, longitude, language, { result  in
            completion(result)
        })
    }
    
    
}
