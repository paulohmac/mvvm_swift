//
//  NowViewModel.swift
//  Dark sky
//  Viewmodel da ViewController Now que exibe os dados da temperatura atual
//  Created by Paulo H. Machtura on 16/02/20.
//

import UIKit



class NowViewModel: NSObject {
    
    private var condition : WeatherConditions?
    private var error : String?

    override init(){
        super.init()
    }
    ///  faz uma chamada assincrona ao serviço da Api
    ///
    /// - parameter completionHandler: baseado no retorno do serviço retorna true ou false
    public func getCurrentWeather(completionHandler: @escaping (Bool)->Void) -> Void {
        let latitude = "\(String(describing: DarkSkyLocation.shared.currentLocation?.coordinate.latitude ?? 0.0))"
        let longitude = "\(DarkSkyLocation.shared.currentLocation?.coordinate.longitude ?? 0.0)"
        WeatherDataSource.shared.retCurrentCondition(latitude, longitude , { resultado  in
            let valor = resultado.associatedValue()
            if let retCondition = valor as? WeatherConditions{
                self.condition = retCondition
                completionHandler(true)
            }
            if let errorRet = valor as? Error {
                self.error = errorRet.localizedDescription
                completionHandler(false)
            }
            completionHandler(false)
        })
        
    }
    /// A condicçao atual
    func getCondition()->WeatherConditions?{
        return condition
    }

    /// mensagem de erro do serviço.
    func getErrorMsg()->String{
        return error ?? ""
    }
    /// texto resumido da temperatura atual.
    func getSumary()->String{
        return condition?.currently?.summary ?? ""
    }
    /// Formata a temperatura da leitura que veio do serviço.
    ///
    /// - returns: Temperatura formatada

    func getTemperatureString()->String{
        return String.localizedStringWithFormat( Config.temperatureFormat, Conversion.fahrenheitToCelsius(condition?.currently?.temperature ?? 0.0))
    }

    /// Formata a velocidade do vento.
    /// - returns: velocidade formatada

    func getWindSpeed()->String{
        return String.localizedStringWithFormat( Config.windFormat, condition?.currently?.windSpeed ?? 0.0)
    }
    /// Formata a umidade.
    ///
    /// - returns: humidade formatada
    func getHumidity()->String{
        return String.localizedStringWithFormat( Config.humityFormat, (condition?.currently?.humidity ?? 0.0) * 100 )
    }

    /// Trata a data e retorna no padrão da view
    /// - returns: data tratada e formatada
    func getCurrentDate()->String{
        let dataCurrent = Date(timeIntervalSince1970: condition?.currently!.time ?? 0.0 )
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Config.dateFormat
        return dateFormatter.string(from: dataCurrent)
    }
    /// Temepratura em formato double.
    ///
    /// - returns: temperatura
    func getTemperature()->Double{
        return condition?.currently?.temperature ?? 0.0
    }

    
    /// Representação climática da aplicação baseado no parametro
    ///  icon, alguns itens foram agrupados por similaridade
    ///
    /// - returns: enum represetando a temperatura atual

    func getCurrentState()->Temperature{
        switch condition?.currently?.icon {
        case "clear-day", "clear-night":
            return .heat
        case "cloudy", "partly-cloudy-day":
            return .cloudy
        case "snow", "sleet", "fog" :
            return .cold
        case "rain":
            return .rain
        default:
            return .heat
        }
    }

    
}


