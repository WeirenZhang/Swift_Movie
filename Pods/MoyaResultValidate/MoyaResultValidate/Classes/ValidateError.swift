//
//  ValidateError.swift
//  MoyaResultValidate_Example
//
//  Created by insect on 2021/12/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Moya

public struct ValidateError: LocalizedError {
    
    public var response: Moya.Response
    
    public var errorDescription: String? {
        return "Moya.Result validate failure"
    }
    
    public init(response: Moya.Response) {
        self.response = response
    }
}

public extension Error {

    var asValidateError: ValidateError? {
        
        guard let moyaError = self as? MoyaError else { return nil }
        switch moyaError {
        case let .underlying(error, _):
            if let validateError = (error as? ValidateError) {
                return validateError
            }
        default:
            break
        }
        return nil
    }
}
