//
//  PullRequest_DS.swift
//  FinnersTest
//
//  Created by Lucas Correia Granados Castro on 03/01/18.
//  Copyright © 2018 Atlantic Solutions. All rights reserved.
//

import UIKit

protocol pullRequestDSDelegate:NSObjectProtocol {
    func didLoadPullRequestItems(pullRequestDS:PullRequest_DS, repoArray:Array<PullRequest>?, reponse:Dictionary<String, Any>?, lastItemsLoaded:Bool?, page:Int)
}

class PullRequest_DS: NSObject {
    
    weak var delegate:pullRequestDSDelegate?
    
    func getPullRequestList(page:Int, url:String) {
        
        if(App.Connection.isConnectionReachable) {
            
            App.Connection.getPullResquests(url: url, page: page, handler: { (response, statusCode, error) in
                
                if let _:Error = error {
                    
                    self.delegate?.didLoadPullRequestItems(pullRequestDS: self, repoArray: nil, reponse: nil, lastItemsLoaded: nil, page: page)
                    
                } else {
                    
                    var dic = Dictionary<String, Any>.init()
                    dic["items"] = response
                    
                    let items:Array<Any>? = response//dic?["items"] as! Array<Any>
                    var array:Array<PullRequest>? = Array.init()
                    for dicPR in items!{
                        let repo = PullRequest.new(dicPR as? Dictionary<String, Any>, nil)
                        array?.append(repo!)
                    }
                    
                    self.delegate?.didLoadPullRequestItems(pullRequestDS: self, repoArray:array, reponse: nil, lastItemsLoaded: nil, page: page)
                    
                }
        
            })
            
        }
        
    }
    
}
