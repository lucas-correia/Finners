//
//  Repository_DS.swift
//  FinnersTest
//
//  Created by Lucas Castro on 02/01/2018.
//  Copyright © 2018 Atlantic Solutions. All rights reserved.
//

import UIKit

protocol repositoryDSDelegate:NSObjectProtocol {
    func didLoadRepositoryItems(repoDS:Repository_DS, repoArray:Array<Repository>?, reponse:Dictionary<String, Any>?, lastItemsLoaded:Bool?)
}

class Repository_DS: NSObject {
    
    weak var delegate:repositoryDSDelegate?
    
    func getRepositories(page:Int) {
        
        if(App.Connection.isConnectionReachable) {
            
            App.Connection.getRepositories(page: page, handler: { (response, statusCode, error) in
                
                if let _:Error = error {
                    
                    self.delegate?.didLoadRepositoryItems(repoDS: self, repoArray: nil, reponse: nil, lastItemsLoaded: nil)
                    
                } else {
                    
                    let items:Array<Any>? = response?["items"] as? Array<Any>
                    var array:Array<Repository>? = Array.init()
                    for dicRepo in items! {
                        let repo = Repository.new(dicRepo as? Dictionary<String, Any>, nil)
                        array?.append(repo!)
                    }
                    
                    if ((array?.count)! < App.Constants.ITEMS_PER_PAGE) {
                        
                        self.delegate?.didLoadRepositoryItems(repoDS: self, repoArray: array, reponse: response, lastItemsLoaded: true)
                        
                    } else {
                        
                        self.delegate?.didLoadRepositoryItems(repoDS: self, repoArray: array, reponse: response, lastItemsLoaded: false)
                        
                    }
                    
                }
                
                
            })
            
        }
        
        
    }
}
