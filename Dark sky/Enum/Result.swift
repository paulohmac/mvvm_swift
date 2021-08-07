//
//  Result.swift
//  enum que contem dados dos serviços para o viewmodel
//  Created by Paulo Henrique on 15/02/20.
//

import UIKit

enum Result<T> {
    case Success(T)
    case Failure(Error)
    
    func associatedValue() -> Any {
        switch self {
        case .Success(let value):
            return value
        case .Failure(let value):
            return value
        }
    }
}
