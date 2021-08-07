//
//  WeekViewModel.swift
//  View model para a classe que representa as temperaturas previstas para 1 semanas
//
//  Created by Paulo H. Machtura on 16/02/20.
//

import UIKit

class WeekViewModel:  NSObject {
    //Model dos dados da API
    private var condition : WeatherConditions?
    //Lista semanal
    private var conditionWeek = [CurrentWeather]()
    private var error : String?

    override init(){
        super.init()
    }
    ///  faz uma chamada assincrona ao serviço da Api
    ///
    /// - parameter completionHandler: baseado no retorno do serviço retorna true ou false

    public func getCurrentDailyWeather(completionHandler: @escaping (Bool)->Void) -> Void {
        let latitude = "\(DarkSkyLocation.shared.currentLocation?.coordinate.latitude ?? 0.0))"
        let longitude = "\(DarkSkyLocation.shared.currentLocation?.coordinate.longitude ?? 0.0)"
        WeatherDataSource.shared.retCurrentCondition(latitude, longitude , { resultado  in
            let valor = resultado.associatedValue()
            if let retCondition = valor as? WeatherConditions{
                self.conditionWeek = retCondition.daily!.data
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
    
    /// Conta os items retornado na leitura semanal.
    func countItens()->Int{
      return conditionWeek.count
     }
       
    /// Retorna a leitura baseada na posição.
     func getItem(_ pos : Int)->CurrentWeather{
          return conditionWeek[pos]
     }
    
    /// Retorna a leitura baseada na posição.
    /// - parameter pos: posição na lista
    func getCondition(_ pos : Int)->CurrentWeather?{
        return conditionWeek[pos]
    }
    /// mensagem de erro do serviço.
    func getErrorMsg()->String{
        return error ?? ""
    }

    /// resumo da leitura.
    /// - parameter pos: posição na lista
    func getSumary(_ pos : Int)->String{
        return conditionWeek[pos].summary
    }

    /// Formata a temperatura baseado na posição da leituras que vieram do serviço.
    ///
    /// - parameter pos: posição na lista
    /// - returns: Temperatura formatada
    func getTemperatureString(_ pos : Int)->String{
        return String.localizedStringWithFormat( Config.temperatureFormat, Conversion.fahrenheitToCelsius(conditionWeek[pos].apparentTemperatureMax ?? 0.0))
    }

    
    /// Formata a velocidade do vento.
    ///
    /// - parameter pos: posição na lista
    /// - returns: velocidade formatada
    func getWindSpeed(_ pos : Int)->String{
        return String.localizedStringWithFormat( Config.windFormat, conditionWeek[pos].windSpeed ?? 0.0)
    }

    /// Formata a umidade.
    ///
    /// - parameter pos: posição na lista
    /// - returns: humidade formatada
    func getHumidity(_ pos : Int)->String{
        return String.localizedStringWithFormat( Config.humityFormat, (conditionWeek[pos].humidity ?? 0.0) * 100 )
    }
    
    /// Temepratura em formato double.
    ///
    /// - parameter pos: posição na lista
    /// - returns: temperatura

    func getTemperature(_ pos : Int)->Double{
        return conditionWeek[pos].temperature ?? 0.0
    }

    /// Trata a data do item passado como parametro
    ///
    /// - parameter pos: posição na lista
    /// - returns: data tratada e formatada

    func getItemDate(_ pos : Int)->String{
        let dataCurrent = Date(timeIntervalSince1970: conditionWeek[pos].time )
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Config.weekDateFormat
        return dateFormatter.string(from: dataCurrent)
    }
    

    /// Representação climática da aplicação baseado no parametro
    ///  icon, alguns itens foram agrupados por similaridade
    ///
    /// - parameter pos: posição na lista
    /// - returns: enum represetando a temperatura atual
    func getItemState(_ pos : Int)->Temperature{
        switch conditionWeek[pos].icon {
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
    /// Representação climática atual da aplicação
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
