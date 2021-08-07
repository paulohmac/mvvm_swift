//
//  WeatherDataSource.swift
//  Classe Singleton que contém a instancia dos dados da aplicação
//  para manter apenas 1 intancia dos dados em memória
//  futuramente implementar persistencia e recuperação com histórico
//  no coreData ou Realm de forma a funcionar off line
//
//  Created by Paulo H. Machtura on 16/02/20.
//

import UIKit

class WeatherDataSource: NSObject {

    private var data : WeatherConditions?
    /*
    */
    static let shared = WeatherDataSource()
    
    override private init (){
        super.init()
    }
    
    /// baseado na latitude e longitude, faz uma requisição a API DarkSy para trazer os dados da previsão da localização passada .
    /// Caso já tenha sido carregado usa a instancia atual para evitar seguidas solicitações
    ///
    /// - warning: Metodo para ser evoluido, fazer persistencia local e retornar o "cache" de algum objeto de persitencia.
    /// - parameter latitude: latitude atual retornada do sensor GPS
    /// - parameter longitude: longitude atual retornada do sensor GPS
    /// - parameter completionHandler: completion a ser executado quando a requisição completar
    func retCurrentCondition(_ latitude : String, _ longitude : String, _ completionHandler: @escaping (Result<Any>)->Void) -> Void{
        if let retData = data {
            completionHandler(Result.Success( retData ))
        }else{
            let dark = DarkSkyApi()
            var languageCode = Locale.preferredLanguages.first?.components(separatedBy: "-")[0]
            languageCode = languageCode?.uppercased()

            dark.findWeather("\(latitude)", "\(longitude)", languageCode ?? "PT", { result in
                if let remoteData = result.associatedValue() as? WeatherConditions {
                    self.data = remoteData
                    completionHandler(Result.Success( self.data ))
                }else{
                    if let erroData = result.associatedValue() as? Error {
                        completionHandler(Result.Failure( erroData ) )
                    }
                }
            })
        }
    }
    
    
    
}
