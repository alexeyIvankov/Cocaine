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
    private(set) var pr1:AnyObject?
    private(set) var pr2:AnyObject?
    private(set) var pr3:AnyObject?
    private(set) var pr4:AnyObject?
    private(set) var pr5:AnyObject?
    private(set) var pr6:AnyObject?
    private(set) var pr7:AnyObject?
    private(set) var pr8:AnyObject?
    
    public init(key:String,
                load_type:LoadType,
                pr1:AnyObject? = nil,
                pr2:AnyObject? = nil,
                pr3:AnyObject? = nil,
                pr4:AnyObject? = nil,
                pr5:AnyObject? = nil,
                pr6:AnyObject? = nil,
                pr7:AnyObject? = nil,
                pr8:AnyObject? = nil)
    {
        self.key = key;
        self.load_type = load_type;
        self.pr1 = pr1;
        self.pr2 = pr2;
        self.pr3 = pr3;
        self.pr4 = pr4;
        self.pr5 = pr5;
        self.pr6 = pr6;
        self.pr7 = pr7;
        self.pr8 = pr8;
    }
}
