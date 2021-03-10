//
//  File.swift
//  
//
//  Created by spezza on 09.03.2021.
//

import Foundation

public enum NetworkError: Error {
    
    case badUrl
    case badStatusCode
    case badData
    case networkError(Error)
    case decodingError(Error)
}
