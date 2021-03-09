//
//  File.swift
//  
//
//  Created by spezza on 04.03.2021.
//

import Foundation

final public class NetworkService {
    private let defaultHeaders: [String:String]
    public init(defaultHeaders: [String:String] = [:]) {
        self.defaultHeaders = defaultHeaders
    }
}

public extension NetworkService {
    func request(resourse: Resourse, validStatusCodes: Range<Int> = 200..<300, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = resourse.url else {
            completion(.failure(.badUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = resourse.method.rawValue
        request.httpBody = resourse.body
        
        if let headers = resourse.headers {
            let allHeaders = defaultHeaders.merging(headers, uniquingKeysWith: {(defaultKey, perRequestKey) in
                return perRequestKey
            })
            request.allHTTPHeaderFields = allHeaders
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  validStatusCodes.contains(httpResponse.statusCode) else {
                completion(.failure(.badStatusCode))
                return
            }
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
    func requestDecoding<T: Decodable>(resourse: Resourse, decodingType: T.Type, validStatusCodes: Range<Int> = 200..<300, completion: @escaping (Result<T, NetworkError>) -> Void) {
        request(resourse: resourse, validStatusCodes: validStatusCodes) { result in
            switch result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                do {
                    let object = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
