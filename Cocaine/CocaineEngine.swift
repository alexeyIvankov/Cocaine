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
    private let dependences_storage_strong:Storage<IDependence>
    private let dependences_storage_weak:Storage<IDependence>
    private let template_dependences_storage:Storage<AnyObject>
    
    public required init()
    {
        self.event_sender = EventSender();
        self.dependences_storage_strong = Storage<IDependence>(memory_rules: DependenceMetaInfo.MemoryRules.strong)
          self.dependences_storage_weak = Storage<IDependence>(memory_rules: DependenceMetaInfo.MemoryRules.weak)
        self.template_dependences_storage = Storage<AnyObject>(memory_rules: DependenceMetaInfo.MemoryRules.strong);
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
        
        let meta_info_dependences = client.meta_info_dependences();
        
        for meta_info in meta_info_dependences
        {
            var dependence:IDependence?;
            
            if meta_info.create_type == DependenceMetaInfo.CreateType.create_new
            {
                dependence = self.build_dependence(meta_info: meta_info);
            }
            else if meta_info.create_type == DependenceMetaInfo.CreateType.load_from_storage
            {
                if meta_info.memory_rules == DependenceMetaInfo.MemoryRules.strong
                {
                    dependence = self.dependences_storage_strong.object(key: meta_info.key);
                    
                    if dependence == nil
                    {
                        dependence = self.build_dependence(meta_info: meta_info);
                        
                        if dependence != nil{
                            self.dependences_storage_strong.add(object: dependence!, key: meta_info.key)
                        }
                    }
                }
                else if meta_info.memory_rules == DependenceMetaInfo.MemoryRules.weak
                {
                     dependence = self.dependences_storage_weak.object(key: meta_info.key);
                    
                    if dependence == nil
                    {
                        dependence = self.build_dependence(meta_info: meta_info);
                        
                        if dependence != nil {
                            self.dependences_storage_weak.add(object: dependence!, key: meta_info.key)
                        }
                        
                    }
                }
            }
            
            if dependence != nil{
                dependences[meta_info.key] = dependence;
            }

        }
        client.inject_dependences(dependences: dependences);
    }
    
    private func build_dependence(meta_info:DependenceMetaInfo) -> IDependence?
    {
        let template:IDependenceTemplate? = self.template_dependences_storage.object(key: meta_info.key) as? IDependenceTemplate;
        
        let copy_template:IDependenceTemplate? = template?.copy(with: nil) as? IDependenceTemplate;
        copy_template?.configure(parametrs: meta_info.parametrs);
        
        return copy_template;
    }
    
    public func load(dependence:IDependence, memory_rules:DependenceMetaInfo.MemoryRules) {
        
        if memory_rules == DependenceMetaInfo.MemoryRules.strong {
            self.dependences_storage_strong.add(object: dependence, key: dependence.key)
        }
        else if memory_rules == DependenceMetaInfo.MemoryRules.weak {
             self.dependences_storage_weak.add(object: dependence, key: dependence.key)
        }
        
    }
    
    public func load(template:IDependenceTemplate){
        self.template_dependences_storage.add(object: template, key: template.key);
    }
    
    
    public func dependence(key:String) -> IDependence?
    {
        var dependence:IDependence?;
        
        dependence = self.dependences_storage_strong.object(key: key);
        
        if dependence != nil{
            return dependence;
        }
        
        return self.dependences_storage_strong.object(key: key);
    }
    
    public func template(key:String) -> IDependenceTemplate?{
        return self.template_dependences_storage.object(key: key) as? IDependenceTemplate;
    }
    
}
