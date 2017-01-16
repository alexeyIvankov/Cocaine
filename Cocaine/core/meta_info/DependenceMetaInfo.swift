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
    public enum CreateType
    {
        case create_new
        case load_from_storage
    }
    
    public enum MemoryRules
    {
        case strong
        case weak
    }
    
    let key:String;
    let create_type:CreateType;
    let memory_rules:MemoryRules;
    let parametrs:Parametrs?;
    

    
    public init(key:String,
                create_type:CreateType,
                memory_rules:MemoryRules,
                parametrs:Parametrs)
    {
        self.key = key;
        self.create_type = create_type;
        self.memory_rules = memory_rules;
        self.parametrs = parametrs;
    }
}
