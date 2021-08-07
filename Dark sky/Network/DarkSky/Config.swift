//
//  Config.swift
//  CLasse de constante gerais da aplicação
//
//  Created by Paulo Henrique on 15/02/20.
//

import UIKit

struct Config {
    //Key no serviço
    static let darkSkyKey = "e22a2b9af2c934ce7d3d257217d21c21"
    //Endpoint
    static let endpointDarkSky = "https://api.darksky.net/forecast/\(darkSkyKey)/%@,%@?lang=%@"
    //Mascara de formataçao para a temperatura
    static let temperatureFormat = "%.f°"
    //Mascara de formataçao para a velocidade do vento
    static let windFormat = "%0.1f km/h"

    static let dateFormat = "MMM dd - HH:mm"
    static let weekDateFormat = "EEEE, dd - MMM"

    //Mascara de formataçao para a umidade
    static let humityFormat = "%0.1f %"

}
