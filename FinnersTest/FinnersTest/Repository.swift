//
//  Repository.swift
//  FinnersTest
//
//  Created by Lucas Castro on 02/01/2018.
//  Copyright © 2018 Atlantic Solutions. All rights reserved.
//

import UIKit

//MARK: - ENUMS

//MARK: - DEFINES

//Repository
struct r {
    static let repository_key = "repository"
    
    static let repository_id = "id"
    static let repository_name = "name"
    static let repository_fullName = "full_name"
    static let repository_description = "description"
    static let repository_pullsURL = "pulls_url"
    static let repository_stars = "watchers_count"
    static let repository_forks = "forks_count"
    static let repository_owner = "owner"
}

//Owner
struct o {
    static let owner_key = "owner"
    
    static let owner_id = "id"
    static let owner_name = "login"
    static let owner_avatarURL = "avatar_url"

}

//MARK: - USER CLASS

class Repository: ObjectProtocol {
    
    typealias T = Repository
    
    //Properties:
    var id:Int?
    var name:String?
    var full_name:String?
    var description:String?
    var pulls_url:String?
    var stars_count:Int?
    var forks_count:Int?
    var owner:Owner?
    
    //Initializer:
    required init() {
       
        id = 0
        name = ""
        full_name = ""
        description = ""
        pulls_url = ""
        stars_count = 0
        forks_count = 0
        owner = Owner()
        
    }
    
    //Protocol
    class func new(_ objectDictionary:Dictionary<String, Any>?, _ typeD:String?) -> T? {
        
        if let dic = objectDictionary{
            
            if (dic.keys.count == 0){
                return nil
            }else{
                
                let newRepo:Repository = Repository.init()
                let keysList:Array = Array.init(dic.keys)
                
                //id:
                if (keysList.contains(r.repository_id)){newRepo.id = dic[r.repository_id] as? Int}
                //forks:
                if (keysList.contains(r.repository_forks)){newRepo.forks_count = dic[r.repository_forks] as? Int}
                //stars:
                if (keysList.contains(r.repository_stars)){newRepo.stars_count = dic[r.repository_stars] as? Int}
                //name:
                if (keysList.contains(r.repository_name)){newRepo.name = dic[r.repository_name] as? String}
                //full name:
                if (keysList.contains(r.repository_fullName)){newRepo.full_name = dic[r.repository_fullName] as? String}
                //description:
                if (keysList.contains(r.repository_description)){newRepo.description = dic[r.repository_description] as? String}
                //pulls url:
                if (keysList.contains(r.repository_pullsURL)){newRepo.pulls_url = dic[r.repository_pullsURL] as? String}
                //owner:
                if (keysList.contains(r.repository_owner)){newRepo.owner = Owner.new(dic[r.repository_owner] as!Dictionary<String, Any>?, nil)}
                
                return newRepo
            }
            
        }else{
            return nil
        }
    }
    
    func copy() -> T {
        
        let copyObject:Repository = Repository.init()
        copyObject.id = self.id
        copyObject.name = self.name
        copyObject.full_name = self.full_name
        copyObject.description = self.description
        copyObject.pulls_url = self.pulls_url
        copyObject.forks_count = self.forks_count
        copyObject.stars_count = self.stars_count
        copyObject.owner = self.owner?.copy()
        
        //
        return copyObject
    }
    
    func isEqual(_ objectToCompare:T?) -> Bool {
        
        if (objectToCompare?.id != self.id){return false}
        if (objectToCompare?.name != self.name){return false}
        if (objectToCompare?.full_name != self.full_name){return false}
        if (objectToCompare?.description != self.description){return false}
        if (objectToCompare?.pulls_url != self.pulls_url){return false}
        if (objectToCompare?.forks_count != self.forks_count){return false}
        if (objectToCompare?.stars_count != self.stars_count){return false}
        if (!(objectToCompare?.owner?.isEqual(self.owner))!){return false}
        //
        return true
    }
    
    func dictionary(_ typeD:String?) -> Dictionary<String, Any> {
        
        var dic:Dictionary<String, Any> = Dictionary.init()
        
        dic[r.repository_id] = self.id
        dic[r.repository_name] = self.name
        dic[r.repository_fullName] = self.full_name
        dic[r.repository_description] = self.description
        dic[r.repository_pullsURL] = self.pulls_url
        dic[r.repository_forks] = self.forks_count
        dic[r.repository_stars] = self.stars_count
        dic[r.repository_owner] = self.owner?.dictionary(nil)
        
        //
        return dic
        
    }
}

class Owner: ObjectProtocol {
    
    typealias T = Owner
    
    //Properties:
    var name:String?
    var id:Int?
    var avatar_url:String?
    
    //Initializer:
    required init() {
        
        name = ""
        id = 0
        avatar_url = ""
        
    }
    
    //Protocol
    class func new(_ objectDictionary:Dictionary<String, Any>?, _ typeD:String?) -> T? {
        
        if let dic = objectDictionary{
            
            if (dic.keys.count == 0){
                return nil
            }else{
                
                let newOwner:Owner = Owner.init()
                //ignore 'typeD'
                let keysList:Array = Array.init(dic.keys)
                
                //id:
                if (keysList.contains(o.owner_id)){newOwner.id = dic[o.owner_id] as? Int}
                //name:
                if (keysList.contains(o.owner_name)){newOwner.name = dic[o.owner_name] as? String}
                //avatar_url:
                if (keysList.contains(o.owner_avatarURL)){newOwner.avatar_url = dic[o.owner_avatarURL] as? String}
                
                return newOwner
            }
            
        }else{
            return nil
        }
    }
    
    func copy() -> T {
        
        let copyObject:Owner = Owner.init()
        
        copyObject.id = self.id
        copyObject.name = self.name
        copyObject.avatar_url = self.avatar_url
        //
        return copyObject
    }
    
    func isEqual(_ objectToCompare:T?) -> Bool {
        
        if (objectToCompare?.id != self.id){return false}
        if (objectToCompare?.name != self.name){return false}
        if (objectToCompare?.avatar_url != self.avatar_url){return false}
        //
        return true
    }
    
    func dictionary(_ typeD:String?) -> Dictionary<String, Any> {
        
        var dic:Dictionary<String, Any> = Dictionary.init()
        
        dic[o.owner_id] = self.id
        dic[o.owner_name] = self.name
        dic[o.owner_avatarURL] = self.avatar_url
        //
        return dic
        
    }
}



