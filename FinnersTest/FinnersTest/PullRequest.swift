//
//  PullRequest.swift
//  FinnersTest
//
//  Created by Lucas Correia Granados Castro on 03/01/18.
//  Copyright © 2018 Atlantic Solutions. All rights reserved.
//

import UIKit

//MARK: - ENUMS

//MARK: - DEFINES

//Repository
struct p {
    static let pullrequest_key = "pullRequest"
    
    static let pullrequest_id = "id"
    static let pullrequest_title = "name"
    static let pullrequest_body = "full_name"
    static let pullrequest_status = "status"
    static let pullrequest_url = "html_url"
    static let pullrequest_owner = "owner"
}

//MARK: - USER CLASS

class PullRequest: ObjectProtocol {
    
    typealias T = PullRequest
    
    //Properties:
    var id:Int?
    var title:String?
    var body:String?
    var status:String?
    var url:String?
    var owner:Owner?
    
    //Initializer:
    required init() {
        
        id = 0
        title = ""
        body = ""
        url = ""
        status = ""
        owner = Owner()
        
    }
    
    //Protocol
    class func new(_ objectDictionary:Dictionary<String, Any>?, _ typeD:String?) -> T? {
        
        if let dic = objectDictionary{
            
            if (dic.keys.count == 0){
                return nil
            }else{
                
                let newPR:PullRequest = PullRequest.init()
                let keysList:Array = Array.init(dic.keys)
                
                //id:
                if (keysList.contains(p.pullrequest_id)){newPR.id = dic[p.pullrequest_id] as? Int}
                //title:
                if (keysList.contains(p.pullrequest_title)){newPR.title = dic[p.pullrequest_title] as? Int}
                //body:
                if (keysList.contains(p.pullrequest_body)){newPR.body = dic[p.pullrequest_body] as? Int}
                //status:
                if (keysList.contains(p.pullrequest_status)){newPR.status = dic[p.pullrequest_status] as? String}
                //url:
                if (keysList.contains(p.pullrequest_url)){newPR.url = dic[p.pullrequest_url] as? String}
                //owner:
                if (keysList.contains(p.pullrequest_owner)){newPR.owner = Owner.new(dic[p.pullrequest_owner] as!Dictionary<String, Any>?, nil)}
                
                return newRepo
            }
            
        }else{
            return nil
        }
    }
    
    func copy() -> T {
        
        let copyObject:PullRequest = PullRequest.init()
        copyObject.id = self.id
        copyObject.title = self.title
        copyObject.body = self.body
        copyObject.status = self.status
        copyObject.url = self.url
        copyObject.owner = self.owner?.copy()
        //
        return copyObject
    }
    
    func isEqual(_ objectToCompare:T?) -> Bool {
        
        if (objectToCompare?.id != self.id){return false}
        if (objectToCompare?.title != self.title){return false}
        if (objectToCompare?.body != self.body){return false}
        if (objectToCompare?.status != self.status){return false}
        if (objectToCompare?.url != self.url){return false}
        if (!(objectToCompare?.owner?.isEqual(self.owner))!){return false}
        //
        return true
    }
    
    func dictionary(_ typeD:String?) -> Dictionary<String, Any> {
        
        var dic:Dictionary<String, Any> = Dictionary.init()
        
        dic[p.pullrequest_id] = self.id
        dic[p.pullrequest_title] = self.title
        dic[p.pullrequest_body] = self.body
        dic[p.pullrequest_status] = self.status
        dic[p.pullrequest_url] = self.url
        dic[r.repository_owner] = self.owner?.dictionary(nil)
        //
        return dic
        
    }
}
