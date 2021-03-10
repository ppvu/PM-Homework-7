//
//  File.swift
//  
//
//  Created by spezza on 10.03.2021.
//

import Foundation

public extension NetworkClient {
    typealias DataResponse = (Result<Data, NetworkError>) -> Void
    typealias DataResponseDecoding<T> = (Result<T, NetworkError>) -> Void
}
