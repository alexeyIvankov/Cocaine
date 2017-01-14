//
//  IDependence.swift
//  DependenceStorageSwift
//
//  Created by Ivankov Alexey on 06.05.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation


public class DependenceMetaInfo
{
    public enum LoadType
    {
        case build_new
        case reuse
    }
    
    private(set) var key:String;
    private(set) var load_type:LoadType;
    
    public init(key:String, load_type:LoadType)
    {
        self.key = key;
        self.load_type = load_type;
    }
}
