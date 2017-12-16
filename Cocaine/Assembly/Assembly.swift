//
//  Assembly.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 28.11.2017.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation


public class Assembly : I_Assembly
{
    public let buildType: Any
    public let memoryPolicy: MemoryPolicy
    public let instanceScope: InstanceScope
    
    let buildBlock: (_ injector:I_Injector)->AnyObject
    
    required public init(buildType: Any,
                         memoryPolicy: MemoryPolicy,
                         instanceScope: InstanceScope,
                         buildBlock:  @escaping (_ injector:I_Injector)->AnyObject)
    {
        self.buildType = buildType
        self.memoryPolicy = memoryPolicy
        self.instanceScope = instanceScope
        self.buildBlock = buildBlock
    }
    
    public func build(injector:I_Injector) -> AnyObject {
        return self.buildBlock(injector)
    }
}
