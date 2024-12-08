//
//  ConstantAPI.swift
//  AssesmentSpotifyApp
//
//  Created by Sri Endah Ramurti on 07/12/24.
//

import Foundation
import Moya

enum ConstantAPI {
    case songList(keyword: String)
}

extension ConstantAPI: BaseAPI {
    var baseURL: URL {
        switch self {
        case .songList(let keyword):
            guard let url = URL(string: "https://itunes.apple.com/search?term=\(keyword)&entity=song") else { fatalError("Server in problem") }
            return url
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .songList(let keyword):
            var parameters = [String: Any]()
            parameters["term"] = keyword
            parameters["entity"] = "song"
            return parameters
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .songList:
                .get
        }
    }
    
    
}
