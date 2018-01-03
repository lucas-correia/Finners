//
//  ConnectionManager.swift
//  Project-Swift
//
//  Created by Erico GT on 3/30/17.
//  Copyright © 2017 Atlantic Solutions. All rights reserved.
//

//MARK: - • INTERFACE HEADERS
import Alamofire
import SwiftyJSON

//MARK: - • FRAMEWORK HEADERS
import UIKit

//MARK: - • OTHERS IMPORTS

//@objc protocol ConnectionManagerDelegate:NSObjectProtocol
//{
//    @objc optional func didConnectWithSuccess(response:Dictionary<String, Any>)
//    @objc optional func didConnectWithFailure(error:NSError)
//    @objc optional func didConnectWithSuccess(responseData:Data)
//    @objc optional func didConnectWithSuccess(progress:Float)
//}

class ConnectionManager
{
    //MARK: - • LOCAL DEFINES
    
    
    //MARK: - • PUBLIC PROPERTIES
    
    var isConnectionReachable:Bool{
        return (Reachability()?.isReachable)!
    }
    
    var isConnectionReachableViaWiFi:Bool{
        return (Reachability()?.isReachableViaWiFi)!
    }
    
    //MARK: - • PRIVATE PROPERTIES
    
    
    //MARK: - • INITIALISERS
    init() {
    }
    
    //MARK: - • CUSTOM ACCESSORS (SETS & GETS)
    
    
    //MARK: - • DEALLOC
    
    deinit {
        // NSNotificationCenter no longer needs to be cleaned up!
    }
    
    //MARK: - • SUPER CLASS OVERRIDES
    
    
    //MARK: - • INTERFACE/PROTOCOL METHODS
    
    
    //MARK: - • PUBLIC METHODS
    
    func getRepositories(page:Int, handler:@escaping (_ response:Dictionary<String, Any>?, _ statusCode:Int?, _ error:NSError?) -> ()){
        
        //URL destino
        var urlRequest:String = App.Constants.SERVICE_URL_GET_REPOSITORIES
        urlRequest = urlRequest.replacingOccurrences(of: "<PAGE>", with: String.init(format: "%i", page))
        urlRequest = urlRequest.replacingOccurrences(of: "<PER_PAGE>", with: String.init(format: "%i", App.Constants.ITEMS_PER_PAGE))
        
        
        
        //Headers
        let header: HTTPHeaders = self.createDefaultHeader()
        
        //Request
        Alamofire.request(urlRequest,
                       method: HTTPMethod.get,
                   parameters: nil,
                     encoding: URLEncoding.default,
                      headers: header
            ).validate().responseJSON { (dResponse) in
                  
                switch dResponse.result {
                case .success:
                    
                    do{
                        let resultDic:Dictionary<String, Any> = try (JSONSerialization.jsonObject(with: dResponse.data!, options: []) as? [String: Any])!
                        handler(resultDic, (dResponse.response!.statusCode), nil)
                    }catch let error{
                        handler(nil, (dResponse.response!.statusCode), NSError(domain:String.init(format: "JSONSerialization Error: %@", arguments:[error.localizedDescription]), code:dResponse.response!.statusCode, userInfo:nil))
                    }
                    
                case .failure(let error):
                    
                    handler(nil, dResponse.response?.statusCode, error as NSError)
                }
        }        
    }
    
    func getPullResquests(url:String, page:Int, handler:@escaping (_ response:Array<Dictionary<String, Any>>?, _ statusCode:Int, _ error:NSError?) -> ()){
        
        //URL destino
        var urlRequest:String = url
        
        urlRequest = urlRequest.replacingOccurrences(of: "{/number}", with: "?state=all&page=<PAGE>&per_page=<PER_PAGE>")
        urlRequest = urlRequest.replacingOccurrences(of: "<PAGE>", with: String.init(format: "%i", page))
        urlRequest = urlRequest.replacingOccurrences(of: "<PER_PAGE>", with: String.init(format: "%i", App.Constants.ITEMS_PER_PAGE))
        
        print(urlRequest)
        
        //Headers
        let header: HTTPHeaders = self.createDefaultHeader()
        
        //Request
        Alamofire.request(urlRequest,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: header
            ).validate().responseJSON { (dResponse) in
                
                switch dResponse.result {
                case .success:
                    
                    do{
                        let resultDic:Array<Dictionary<String, Any>> = try (JSONSerialization.jsonObject(with: dResponse.data!, options: []) as! Array<Dictionary<String, Any>>)
                        handler(resultDic, (dResponse.response!.statusCode), nil)
                    }catch let error{
                        handler(nil, (dResponse.response!.statusCode), NSError(domain:String.init(format: "JSONSerialization Error: %@", arguments:[error.localizedDescription]), code:dResponse.response!.statusCode, userInfo:nil))
                    }
                    
                case .failure(let error):
                    
                    handler(nil, (dResponse.response?.statusCode)!, error as NSError)
                }
        }
    }
    
    //MARK: - • ACTION METHODS
    
    
    //MARK: - • PRIVATE METHODS (INTERNAL USE ONLY)
    private func getDeviceInfo() ->  Dictionary<String, String>{
        
        var deviceDic:Dictionary<String, String> =  Dictionary.init()
        //
        deviceDic["name"] = ToolBox.deviceHelper_Name()
        deviceDic["model"] = String.init(format: "Apple - %@", arguments: [ToolBox.deviceHelper_Model()])
        deviceDic["system_version"] = ToolBox.deviceHelper_SystemVersion()
        deviceDic["system_language"] = ToolBox.deviceHelper_SystemLanguage()
        deviceDic["storage_capacity"] = ToolBox.deviceHelper_StorageCapacity()
        deviceDic["free_memory_space"] = ToolBox.deviceHelper_FreeMemorySpace()
        deviceDic["identifier_for_vendor"] = ToolBox.deviceHelper_IdentifierForVendor()
        deviceDic["app_version"] = ToolBox.applicationHelper_VersionBundle()
        //
        return deviceDic
    }
    
    private func createDefaultHeader() -> HTTPHeaders{
    
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
//            "idiom": NSLocalizedString("LANGUAGE_APP", comment: ""),
//            "device_info": ToolBox.converterHelper_StringJsonFromDictionary(dictionary: getDeviceInfo() as NSDictionary, prettyPrinted: false),
            
        ]
        return header
    }
}




