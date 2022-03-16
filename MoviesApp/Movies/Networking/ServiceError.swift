//
//  ServiceError.swift
//  Movies
//
//  Created by MAC on 25/01/22.
//

import Foundation

enum ServiceError: Error {
    case failedToCreateRequest
    case dataNotFound
    case parsingError
    case networkNotAvailable

}
