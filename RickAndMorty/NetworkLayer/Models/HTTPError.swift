//
//  HTTPError.swift
//  RickAndMorty
//
//  Created by Борис Павлов on 19.06.2026.
//

import Foundation

public enum HTTPError: Error {
    case networkError(Error)
    case invalidResponse(URLResponse?)
    case invalidStatusCode(Int, Data?)
    case noData
    case failedToDecodeResponse(Error)
    /// Ошибка API (включая client и server errors), с парсированным ErrorDTO.
    case apiError(ErrorDTO)
}

public struct ErrorDTO: Codable {
    let name: String?
    let message: String?
    var statusCode: Int?
    let code: Int?
    let status: StatusValue?
    let type: String?
    let errors: Errors?
    let error: String?
    let attempts: Int?
    let timer: Int?
    var field: String?
}

struct Errors: Codable {
    let login, password: String?
}

enum StatusValue: Codable {
    case int(Int)
    case string(String)
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            self = .unknown
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .int(value):
            try container.encode(value)
        case let .string(value):
            try container.encode(value)
        case .unknown:
            try container.encodeNil()
        }
    }

    var intValue: Int? {
        switch self {
        case let .int(value):
            value
        case let .string(value):
            Int(value)
        case .unknown:
            nil
        }
    }

    var stringValue: String? {
        switch self {
        case let .int(value):
            String(value)
        case let .string(value):
            value
        case .unknown:
            nil
        }
    }
}
