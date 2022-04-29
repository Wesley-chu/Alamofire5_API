//
//  APIManager.swift
//  Alamofire5_API
//
//  Created by 朱偉綸 on 2022/4/29.
//

import Foundation
import Alamofire
import PromiseKit


public typealias Item = [String : Any?]

public enum CallResult<T>{
    case success(T)
    case failure(APIError)
}

public enum APIError: Error, CustomStringConvertible  {
    case unknown
    case invalidURL
    case invalidResponse
    case unacceptableStatusCode(code: Int)
    public var description: String {
        switch self {
        case .unknown: return "不明なエラーです"
        case .invalidURL: return "無効なURLです"
        case .invalidResponse: return "フォーマットが無効なレスポンスを受け取りました"
        case .unacceptableStatusCode(code: let code):
            return "errorCode: \(code)"
        }
    }
}

final class APIManager {
    public static let shared = APIManager()
    private func callForItem(
        request: Alamofire.URLRequestConvertible,
        queue: DispatchQueue? = nil,
        resultHandler: @escaping (CallResult<Data>) -> Void
    ) -> DataRequest{
        return AF.request(request).validate().responseData(queue: .main) { dataResponse in
            self.handleResponse(request: request, dataResponse: dataResponse, resultHandler: resultHandler)
        }
    }
    
    public func callForItem(
        request: Alamofire.URLRequestConvertible,
        queue: DispatchQueue) -> Promise<Data>{
        return Promise { seal in
            callForItem(request: request, queue: queue) { result in
                switch result {
                case let .success(item):
                    seal.fulfill(item)
                case let .failure(error):
                    seal.reject(error)
                }
            }
        }
    }
    
    
    private func handleResponse<T>(
        request: Alamofire.URLRequestConvertible,
        dataResponse: DataResponse<T,AFError>,
        resultHandler: @escaping (CallResult<T>) -> Void) {
        resultHandler(self.createResult(request: request, dataResponse: dataResponse))
    }
    
    public func createResult<T>(request: Alamofire.URLRequestConvertible,dataResponse: DataResponse<T,AFError>) -> CallResult<T>{
        if (dataResponse.value != nil),
           let value = dataResponse.value {
            return .success(value)
        }else{
            let statusCode = dataResponse.response?.statusCode ?? 0
            return .failure(.unacceptableStatusCode(code: statusCode))
        }
    }
    
}



extension DataRequest {
    @discardableResult
    func responseData(
        queue: DispatchQueue,
        options: JSONSerialization.ReadingOptions = .allowFragments,
        completionHandler: @escaping (AFDataResponse<Data>) -> Void)
    -> Self{
        let responseSerializer = DataResponseSerializer()
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
    
    
    
    
    
    
    
}










