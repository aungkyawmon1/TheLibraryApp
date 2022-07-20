//
//  BaseModel.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 10/07/2565 BE.
//

import Foundation
class BaseModel: NSObject {
    let networkAgent : BookNetworkAgentProtocol = BookNetworkAgent.shared
}
