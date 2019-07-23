//
//  ResultViewModel.swift
//  FlickrDemo
//
//  Created by Hong James on 2019/7/22.
//  Copyright © 2019 Hong James. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import ObjectMapper

class ResultViewModel {
    let apiKey = "427968a1dd06e52c6e2f66b34d098282"
    let searchUrl = "https://www.flickr.com/services/rest/"
    let methood = "flickr.photos.search"
    let realmManager = RealmManager()
    
    func search(text: String, perPage: Int, completionHandler: @escaping (SearchResponseModel?, NSError?) -> ()) -> DataRequest {
        
        let parameters: Parameters = [
            "api_key": apiKey,
            "method": methood,
            "text": text,
            "per_page": perPage,
            "format": "json",
            "nojsoncallback": 1
        ]
        
        let request = ApiManager.sharedInstance.getRequest(url: searchUrl, parameters: parameters, completionHandler: completionHandler)
        
        return request
    }
    
    func collectPhoto(photo: PhotoModel) {
        let photoModel = CollectPhotoModel()
        photoModel.id = photo.farm!
        photoModel.serverId = photo.server!
        photoModel.flickrId = photo.id!
        photoModel.secret = photo.secret!
        photoModel.title = photo.title!
        self.realmManager.saveToRealm(object: photoModel)
    }
    
    func queryCollectPhoto() -> [PhotoModel] {
        let resultElements = self.realmManager.readFromRealm(CollectPhotoModel.self)
        var result = [PhotoModel]()
        for photo in resultElements {
            let photoModel = PhotoModel(farm: photo.id, secret: photo.secret, id: photo.flickrId, server: photo.serverId, title: photo.title)
            result.append(photoModel)
        }
        return result
    }
}
