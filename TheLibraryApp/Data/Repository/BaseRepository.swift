//
//  BaseRepository.swift
//  TheLibraryApp
//
//  Created by MacBook Pro on 05/07/2022.
//

import Foundation
import RealmSwift

class BaseRepository: NSObject {
    override init() {
        super.init()
    }
    
    let realmInstance = try! Realm()
    
    func clearAllData() {
        try! realmInstance.write({
            realmInstance.deleteAll()
        })
        
    }
}
