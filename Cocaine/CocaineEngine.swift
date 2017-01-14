//
//  DependenceEngine.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 18.11.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation

public class CocaineEngine
{
    private let event_sender:EventSender<IDependenceClient>;
    private let dependences_storage:Storage<IDependence>
    private let builders_storage:Storage<IBuilder>;
    
    public required init()
    {
        self.event_sender = EventSender();
        self.dependences_storage = Storage<IDependence>()
        self.builders_storage = Storage<IBuilder>();
    }
    
    //MARK: Events
    public func subscribe(subscriber:IDependenceClient, typeEvent:String){
        self.event_sender.subscribe(subscriber: subscriber, typeEvent: typeEvent);
    }
    
    public func unsubscribe(subscriber:IDependenceClient, typeEvent:String){
        self.event_sender.unsubscribe(subscriber: subscriber, typeEvent: typeEvent);
    }
    
    public func inject(client:IDependenceClient)
    {
        var dependences:[String:IDependence] = [:]
        
        let needed_dependences =  client.needed_dependences()
        
        for meta in needed_dependences
        {
            var dependence:IDependence?;
            
            if meta.load_type == DependenceMetaInfo.LoadType.reuse {
                dependence = self.dependences_storage.object(key: meta.key)
            }
            else if meta.load_type == DependenceMetaInfo.LoadType.build_new
            {
                let builder = self.builders_storage.object(key: meta.key);
                dependence = builder?.build_dependence(pr1: meta.pr1, pr2: meta.pr2, pr3: meta.pr3, pr4: meta.pr4, pr5: meta.pr5, pr6: meta.pr6, pr7: meta.pr7, pr8: meta.pr8)
            }
            
            if dependence != nil{
                dependences[meta.key] = dependence;
            }
        }
        client.inject_dependences(dependences: dependences);
    }
    
    public func load(dependence:IDependence){
        self.dependences_storage.add(object: dependence, key: dependence.key);
    }
    
    public func load(builder:IBuilder){
        self.builders_storage.add(object: builder, key: builder.key);
    }
    
    public func dependence(key:String) -> IDependence?{
        return self.dependences_storage.object(key: key);
    }
    
    public func builder(key:String) -> IBuilder?{
        return self.builders_storage.object(key: key);
    }
    
}
