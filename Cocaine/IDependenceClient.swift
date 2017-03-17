//
//  IDependenceClient.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 17.11.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation

public protocol IDependenceClient : class
{
    func identifiersRequiredDependencies() -> [String];
    func injectDependences(dependences:[String:AnyObject]);
}
