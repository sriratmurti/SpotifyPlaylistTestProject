//
//  BaseAPI.swift
//  AssesmentSpotifyApp
//
//  Created by Sri Endah Ramurti on 07/12/24.
//

import Foundation
import Moya

protocol BaseAPI: TargetType {
    
    var baseURL: URL {
        get
    }
    
    var path: String {
        get
    }
    
    var method: Moya.Method {
        get
    }
    
    var sampleData: Data {
        get
    }
    
    var task: Task {
        get
    }
    
    var headers: [String: String]? {
        get
    }
    
}

extension TargetType {
    
    var sampleData: Data {
        return Data()
    }
    
    var baseURL: URL {
        guard let url = URL(string: "https://itunes.apple.com/search?") else { fatalError("Server in problem") }
        return url
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any] {
        return [:]
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
    
    var headers: [String: String]? {
        return [:]
    }
    
}


