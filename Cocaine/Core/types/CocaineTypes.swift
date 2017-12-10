//
//  IDependence.swift
//  DependenceStorageSwift
//
//  Created by Ivankov Alexey on 06.05.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

public enum MemoryPolicy
{
    case Strong
    case Weak
}

public enum InstanceScope
{
    case Singleton
    case New
}
