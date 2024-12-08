//
//  NetworkManager.swift
//  AssesmentSpotifyApp
//
//  Created by Sri Endah Ramurti on 07/12/24.
//

import Foundation
import Moya

class NetworkManager<T: BaseAPI> {
    let ERROR_MESSAGE = "Internal Error"
    var isVerbose: Bool!
    
    init(isVerbose: Bool!) {self.isVerbose = isVerbose}
    
    func api() -> MoyaProvider<T> {
        let provider = MoyaProvider<T>()
        return provider
    }
}
