//
//  RealmManager.swift
//  FlickrDemo
//
//  Created by Hong James on 2019/7/23.
//  Copyright © 2019 Hong James. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    static let sharedInstance = RealmManager()
    
    func saveToRealm(object: Object) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    func readFromRealm<Element: Object>(_ type: Element.Type) -> Results<Element> {
        let realm = try! Realm()
        
        return realm.objects(Element.self)
    }
    
}

