//
//  HTTPSessionManager.swift
//  SwiftTemplate
//
//  Created by Ismail Safadi on 7/26/17.
//  Copyright © 2017 YM. All rights reserved.
//

import UIKit
import AFNetworking

class HTTPSessionManager: AFHTTPSessionManager {

  private static var __once:() = {
//  let configuration = URLSessionConfiguration.default
//    let url = URL(string: AppConstants.kAPIBaseURL)
//    Singleton.instance = HTTPSessionManager(baseURL:url , sessionConfiguration:configuration)
//    Singleton.instance?.requestSerializer.setValue("application/json", forHTTPHeaderField:"Accept")
    
  }()
  
  
  class func sharedManager() -> HTTPSessionManager {
  
  struct Singleton {
    static var onceToken : Int = 0
    static var instance : HTTPSessionManager? = nil
  }
    _ = HTTPSessionManager.__once
    let configuration = URLSessionConfiguration.default
    let url = URL(string: AppConstants.kAPIBaseURL)
    Singleton.instance = HTTPSessionManager(baseURL:url , sessionConfiguration:configuration)
    Singleton.instance?.requestSerializer.setValue("application/json", forHTTPHeaderField:"Accept")

  return Singleton.instance!
  }
}


