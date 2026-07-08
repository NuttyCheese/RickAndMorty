//
//  ResponseStatus.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

enum ResponseStatus {
    case information(Int)
    case success(Int)
    case redirect(Int)
    case clientError(Int)
    case serverError(Int)

    init?(rawValue: Int) {
        if ResponseCode.informationalCodes.contains(rawValue) {
            self = .information(rawValue)
        } else if ResponseCode.successCodes.contains(rawValue) {
            self = .success(rawValue)
        } else if ResponseCode.redirectCodes.contains(rawValue) {
            self = .redirect(rawValue)
        } else if ResponseCode.clientErrorCodes.contains(rawValue) {
            self = .clientError(rawValue)
        } else if ResponseCode.serverErrorCodes.contains(rawValue) {
            self = .serverError(rawValue)
        } else {
            return nil
        }
    }
    
    var isSuccess: Bool {
        switch self {
        case .success: true
        default: false
        }
    }
}
