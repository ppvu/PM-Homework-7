//
//  File.swift
//  
//
//  Created by spezza on 09.03.2021.
//

import Foundation

public struct Resourse {
    var method: HttpMethods
    var url: URL?
    var body: Data?
    var headers: [String:String]?
}
