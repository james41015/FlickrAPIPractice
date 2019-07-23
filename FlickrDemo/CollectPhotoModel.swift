//
//  CollectPhotoModel.swift
//  FlickrDemo
//
//  Created by Hong James on 2019/7/23.
//  Copyright © 2019 Hong James. All rights reserved.
//

import Foundation
import RealmSwift

class CollectPhotoModel: Object {
    @objc dynamic var PK = UUID().uuidString
    @objc dynamic var id = 0
    @objc dynamic var serverId = ""
    @objc dynamic var flickrId = ""
    @objc dynamic var secret = ""
    @objc dynamic var title = ""
    
    override static func primaryKey() -> String? {
        return "PK"
    }
}
