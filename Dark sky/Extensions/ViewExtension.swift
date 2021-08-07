//
//  ViewExtension.swift
//  Extensão para geração de degrade vertical
//
//  Created by Livia Cuco on 16/02/20.
//

import UIKit

extension UIView {

    /// Configura o view atual com um degrade horizontal que representa
    /// o clima atual
    ///
    /// - parameter temperature: enum contendo a representação do clima
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
        let colorLeft =  UIColor(red: CGFloat(startRed/255.0), green: CGFloat(startGreen/255.0), blue: CGFloat(startBlue/255.0), alpha: 1.0).cgColor
        let colorRight = UIColor(red: CGFloat(endRed/255.0), green: CGFloat(endGreen/255.0), blue: CGFloat(endBlue/255.0), alpha: 1.0).cgColor
        
        let gradientLayer = WeatherGradientLayer()
        gradientLayer.colors = [colorLeft, colorRight]
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = self.bounds
        gradientLayer.tag = 5656

        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.layer.insertSublayer(gradientLayer, at:0)
        })
    }
}

class WeatherGradientLayer: CAGradientLayer{
    var tag = 0
}
