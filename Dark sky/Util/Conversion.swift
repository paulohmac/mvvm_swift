//
//  Conversion.swift
//  Classe para conversão de escalas
//
//  Created by Paulo H. Machtura on 16/02/20.
//

import UIKit

class Conversion: NSObject {
    /// Converte da escala de temperatura fahrenheit, padrão do Dark Skyes para Celsius
    /// - parameter value:valor em fahrenheit
    /// - returns: valor convertido para Celsius
    public static func fahrenheitToCelsius(_ value : Double)->Double{
        return (value - 32)/1.8
    }

}
