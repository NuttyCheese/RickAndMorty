//
//  ResponseCode.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

public enum ResponseCode {
    static let informationalCodes = 100 ..< 200
    static let successCodes = 200 ..< 300
    static let redirectCodes = 300 ..< 400
    static let clientErrorCodes = 400 ..< 500
    static let serverErrorCodes = 500 ..< 600
}
