//
//  IBuilder.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 14.01.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

@objc public protocol IBuilder : AnyObject {
    
    var key:String { get }
    
    func build_dependence() -> IDependence;
}
