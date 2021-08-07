//
//  ColorExtension.swift
//  Extensão para a a classe UiColor
//
//  Created by Livia Cuco on 16/02/20.
//

import UIKit

extension UIColor {

    /// Construtor que recebe uma String representando a cor em hex
    ///  e configura a instancia com essa representacao
    /// - parameter hexString: String com o hex da cor
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars = ["F","F"] + chars
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }
}
