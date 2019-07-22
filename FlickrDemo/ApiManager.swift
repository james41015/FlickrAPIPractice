//
//  ApiManager.swift
//  FlickrDemo
//
//  Created by Hong James on 2019/7/22.
//  Copyright © 2019 Hong James. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ApiManager {
    static let sharedInstance = ApiManager()
    
    func getRequest(url: String ,parameters: Parameters ,completionHandler: @escaping (SearchResponseModel?, NSError?) -> ()) -> DataRequest {
        return request(method: .get, url: url, parameters: parameters, completionHandler: completionHandler)
    }
    
    private func request(method: HTTPMethod, url: String ,parameters: Parameters ,completionHandler: @escaping (SearchResponseModel?, NSError?) -> ()) -> DataRequest {
        return Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(_):
                let responseRootModel = Mapper<SearchResponseModel>().map(JSON: response.result.value as! [String : Any])
                completionHandler(responseRootModel,nil)
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
        }
    }
}
