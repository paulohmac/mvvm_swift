//
//  WeatherAnimation.swift
//  Adiciona a animancao do degrade de fundo das telas que mudam
//
//  Created by Livia Cuco on 16/02/20.
//

import UIKit

protocol WeatherAnimation : UIViewController {
    
}

extension WeatherAnimation{
    /// Recebe enum representando a temperatura atual e cria um layer degrade
    /// representando essa temperatura visualmente
    /// - parameter temperature: enum representando o clima atual
    func setWeatherBackground(_ temperature : Temperature) {
        var startRed : Float = 0.0
        var startGreen : Float  = 0.0
        var startBlue : Float  = 0.0
        
        var endRed = 0.0
        var endGreen = 0.0
        var endBlue = 0.0
        
        switch temperature {
        case .cloudy:
            startRed = 15.0
            startGreen = 80.0
            startBlue = 118.0
            
            endRed = 5.0
            endGreen = 46.0
            endBlue = 50.0
            
        case .heat:
            startRed = 250.0
            startGreen = 215.0
            startBlue = 53.0
            
            endRed = 216.0
            endGreen = 137.0
            endBlue = 36.0
            
        case .rain:
            startRed = 1.0
            startGreen = 148.0
            startBlue = 253.0
            
            endRed = 117.0
            endGreen = 174.0
            endBlue = 162.0
            
        case .cold:
            startRed = 20.0
            startGreen = 76.0
            startBlue = 123.0
            
            endRed = 5.0
            endGreen = 46.0
            endBlue = 50.0
        }
        let colorTop =  UIColor(red: CGFloat(startRed/255.0), green: CGFloat(startGreen/255.0), blue: CGFloat(startBlue/255.0), alpha: 1.0).cgColor
        let colorBottom = UIColor(red: CGFloat(endRed/255.0), green: CGFloat(endGreen/255.0), blue: CGFloat(endBlue/255.0), alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.view.layer.insertSublayer(gradientLayer, at:0)
        })
    }
}


