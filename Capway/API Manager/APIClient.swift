//
//  APIClient.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


public enum Result<T> {
    case success(T)
    case failure(ErrorResponse)
}

typealias CompletionHandler<T> = (Result<T>) -> ()
public typealias ErrorResponse = (Int, Data?, Error)


class APIClient {
    private static var privateShared : APIClient?
    
    class var shared: APIClient {
        guard let uwShared = privateShared else {
            privateShared = APIClient()
            return privateShared!
        }
        return uwShared
    }
    
    class func destroy() {
        privateShared = nil
    }
    
    private init() {}
    
    deinit {
        DLog("deinit singleton")
    }
    
    func mtHeaders() -> HTTPHeaders {
        let header: HTTPHeaders = ["Content-Type" : "application/x-www-form-urlencoded", "Accept" : "application/json", "Authorization" : "Bearer "]
        return header
    }
    
    private let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        
        let afInterceptor = AFRequestInterceptor(token: "")
        
        #if DEBUG
        return Session(configuration: configuration, interceptor: afInterceptor, eventMonitors: [AFRequestMonitor()])
        #else
        return Session(configuration: configuration, interceptor: afInterceptor)
        #endif
        
        
    }()
}

extension APIClient {
    func objectAPICall<T: Decodable>(apiEndPoint: Endpoint, modelType: T.Type,
                                     completion: @escaping CompletionHandler<T>) {
        sessionManager.request(apiEndPoint.path, method: apiEndPoint.method, parameters: apiEndPoint.query, encoding: apiEndPoint.encoding)
            .validate(statusCode: 200..<300)
            .responseDecodable { (response: AFDataResponse<T>) in
                switch response.result {
                case .success(let value):
                    completion(Result.success(value))
                case .failure(let error):
                    DLog(error.localizedDescription)
                    guard let statusCode = response.response?.statusCode else {
                        let unKnownError = ErrorResponse(-999, response.data, error)
                        let error = error.localizedDescription
                        if error.contains("The Internet connection appears to be offline"){
                            DispatchQueue.main.async {
                                Helper.showAlert(msg: Constants.noInternet)
                            }
                        }
                        completion(Result.failure(unKnownError))
                        return
                    }
                    let mError = ErrorResponse(statusCode, response.data, error)
                    let json = JSON(response.data ?? Data())
                    let msg = json["error"]["message"].stringValue
                    Helper.showAlert(msg: msg)
                    completion(Result.failure(mError))
                }
        }
    }
}
