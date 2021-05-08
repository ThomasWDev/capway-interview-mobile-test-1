//
//  AFRequestMonitor.swift
//  Capway
//
//  Created by Thomas Woodfin on 5/8/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import Foundation
import Alamofire

final class AFRequestMonitor: EventMonitor {
    func requestDidResume(_ request: Request) {
        let allHeaders = request.request.flatMap { $0.allHTTPHeaderFields.map { $0.description } } ?? "None"
        let headers = """
        ⚡️⚡️⚡️⚡️ Request Started: \(request)
        ⚡️⚡️⚡️⚡️ Headers: \(allHeaders)
        """
        print(headers)


        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let message = """
        ⚡️⚡️⚡️⚡️ Body Data: \(body)\n
        """
        print(message)
    }
  
    func request<Value>(_ request: DataRequest, didParseResponse response: AFDataResponse<Value>) {
        debugPrint("⚡️⚡️⚡️⚡️ ================ RESPONSE =================== ⚡️⚡️⚡️⚡️")
        debugPrint(response)
        debugPrint("⚡️⚡️⚡️⚡️ ================ RESPONSE END =============== ⚡️⚡️⚡️⚡️")
    }
}
