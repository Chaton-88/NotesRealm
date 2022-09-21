//
//  TaskList.swift
//  Note_Realm
//
//  Created by Valeriya Trofimova on 14.06.2022.
//

import Foundation
import RealmSwift

class TaskList: Object {
    @objc dynamic var title = ""
    @objc dynamic var note = ""
}
