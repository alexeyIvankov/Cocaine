//
//  DependenceEngine.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 18.11.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation


public class DependenceEngine
{
    private let eventSender:EventSender<IDependenceClient>;
    private let storage:DependenceStorage;
    
    public required init()
    {
        self.eventSender = EventSender();
        self.storage = DependenceStorage();
    }
    
    
    //MARK: Events
    public func subscribe(subscriber:IDependenceClient, typeEvent:String){
        self.eventSender.subscribe(subscriber: subscriber, typeEvent: typeEvent);
    }
    
    func unsubscribe(subscriber:IDependenceClient, typeEvent:String){
        self.eventSender.unsubscribe(subscriber: subscriber, typeEvent: typeEvent);
    }
    
    func inject(client:IDependenceClient)
    {
        let neededDependences =  client.neededDependencesForCreatingInteractor()
        var interactor:[String:IDependence] = [:]
        
        for nameDependence in neededDependences
        {
            let dependence:IDependence? = self.storage.dependence(name: nameDependence);
            
            if dependence != nil
            {
                interactor[nameDependence] = dependence;
            }
        }
        
        client.injectInteractor(interactor: interactor);
    }
    
    
    func dependence(name:String) -> IDependence? {
        return self.storage.dependence(name: name);
    }
    
    func load(dependence:IDependence)
    {
        self.storage.add(dependence: dependence);
        let subscribers:[IDependenceClient]? = self.eventSender.subscribers(typeEvent: dependence.key()) as? [IDependenceClient]
        
        if subscribers != nil {
            for subscriber in subscribers! {
                subscriber.inject(dependence: dependence);
            }
        }
        
    }
    
}
