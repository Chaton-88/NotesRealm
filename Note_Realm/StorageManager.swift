//
//  StorageManager.swift
//  Note_Realm
//
//  Created by Valeriya Trofimova on 14.06.2022.
//

import Foundation

import RealmSwift

let realm = try! Realm() 

class StorageManager {
    
    static func saveObject(_ task: TaskList) {
        
        try! realm.write {
            realm.add(task)
        }
    }
    
    static func deleteObject(_ task: TaskList) {
        
        try! realm.write {
            realm.delete(task)
        }
    }
}
