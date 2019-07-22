//
//  SearchResponseModel.swift
//  FlickrDemo
//
//  Created by Hong James on 2019/7/22.
//  Copyright © 2019 Hong James. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchResponseModel: NSObject,Mappable {
    
    var photos: PhotosModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        photos <- map["photos"]
    }
    
}

class PhotosModel: NSObject,Mappable {
    
    var photo: Array<PhotoModel>?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        photo <- map["photo"]
    }
    
}

class PhotoModel: NSObject,Mappable {
    
    var farm: Int?
    var secret: String?
    var id: String?
    var server: String?
    var title: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        farm <- map["farm"]
        secret <- map["secret"]
        id <- map["id"]
        server <- map["server"]
        title <- map["title"]
    }
    
}
