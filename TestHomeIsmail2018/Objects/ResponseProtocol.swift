//
//  ResponseProtocol.swift
//  SwiftTemplate
//
//  Created by Ismail Safadi on 7/26/17.
//  Copyright © 2017 YM. All rights reserved.
//

import UIKit
import  Foundation

@objc protocol ResponseProtocol  {
  init (dictionary withDictionary:Dictionary<String, AnyObject>)
}
