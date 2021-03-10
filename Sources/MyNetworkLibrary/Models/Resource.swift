//
//  File.swift
//  
//
//  Created by spezza on 09.03.2021.
//

import Foundation

public struct Resource {
    
    let method: HttpMethods
    let url: URL?
    let body: Data?
    let headers: [String:String]?
    
    public init(method: HttpMethods,
                url: URL?,
                body: Data?,
                headers: [String:String]?) {
        self.method = method
        self.url = url
        self.body = body
        self.headers = headers
    }
}
