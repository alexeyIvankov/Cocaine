//
//  AssemblyTemplate.swift
//  CocaineExample
//
//  Created by Alexey Ivankov on 27.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation
import Cocaine

class AssemblyTemplate : I_Assembly
{
    let buildType: Any
    let scope: DependenceScope
    let isLazy: Bool
    let buildBlock: ()->AnyObject
    
    required public init(buildType: Any,
                         scope: DependenceScope,
                         isLazy: Bool,
                         buildBlock:  @escaping ()->AnyObject)
    {
        self.buildType = buildType
        self.scope = scope
        self.isLazy = isLazy
        self.buildBlock = buildBlock
    }
    
    func build() -> AnyObject {
        return self.buildBlock()
    }
}
