//
//  Router.swift
//  Alamofire5_API
//
//  Created by 朱偉綸 on 2021/3/28.
//

import Foundation
import Alamofire

enum Router:URLRequestConvertible {
    case getRate
    
    var path: String {
        switch self {
        case .getRate:
            return "dotnsf-fx.herokuapp.com"
        }
    }
    
    
    
    
    func asURLRequest() throws -> URLRequest {
        let str_url = "https://" + path
        let url = try str_url.asURL()
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        return request
    }
    
}


















