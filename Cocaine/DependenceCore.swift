//
//  DependenceCore.swift
//  Cocaine
//
//  Created by Nikita on 27.07.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

fileprivate let cocaineEngine = CocaineEngine()

public func prepareInjection<T: Any>(_ injection: T, memoryPolicy: DependenceMemoryPolicy) {
    let key = String(describing: T.self)
    cocaineEngine.load(dependence: injection as AnyObject, key: key, memoryRules: memoryPolicy)
}

public func inject<T>() -> T! {
    let key = String(describing: T.self)
    return cocaineEngine.dependence(key: key) as? T
}

