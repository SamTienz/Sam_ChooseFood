//
//  UserDetail.swift
//  ChooseFood
//
//  Created by Tien on 2017/8/27.
//  Copyright © 2017年 Tien. All rights reserved.
//

import UIKit
import RealmSwift
class UserDetail: Object {
    dynamic var userName = ""
    dynamic var logInID = ""
    dynamic var password = ""
    let physiques = List<physique>()
    let symptoms = List<symptom>()
    override static func primaryKey() -> String? {
        return "logInID"
    }
}
class physique: Object {
    dynamic var physiqueName = ""
}
class symptom: Object {
    dynamic var symptomName = ""
}

