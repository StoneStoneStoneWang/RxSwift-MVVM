//
//  WLReq.swift
//  RxSwift-MVVM
//
//  Created by three stone 王 on 2019/7/2.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLReqKit
import Alamofire
import RxSwift
import WLToolsKit

@discardableResult
public func onDictResp<T : WLObserverReq>(_ req: T) -> Observable<[String:Any]> {
    
    return Observable<[String:Any]>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        request(URL(string: req.host + req.reqName)!, method: req.method, parameters: params, encoding: URLEncoding.default, headers: req.headers).responseJSON { (response) in
            
            switch response.result {
                
            case let .success(result):
                
                if JSONSerialization.isValidJSONObject(result) {
                    
                    if let base = WLBaseBean(JSON: result as! [String : Any]) {
                        
                        switch base.code {
                        case .succ:
                            
                            observer.onNext(base.data as! [String:Any])
                            
                            observer.onCompleted()
                            
                        case .fail:
                            
                            observer.onError(WLBaseError.ServerResponseError(base.msg))
                            
                        case .tokenInvalid:
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tokenInvalid"), object: nil, userInfo: nil)
                            
                            observer.onError(WLBaseError.ServerResponseError(base.msg))
                        default:
                            observer.onError(WLBaseError.ServerResponseError(base.msg))
                        }
                        
                    } else {
                        
                        observer.onError(WLBaseError.MapperError("invalid json"))
                    }
                    
                } else {
                    
                    observer.onError(WLBaseError.MapperError("invalid json"))
                }
                
            case let .failure(error):
                
                observer.onError(WLBaseError.HTTPFailed(error))
            }
        }
        
        return Disposables.create { }
    })
}
@discardableResult
public func onArrayResp<T : WLObserverReq>(_ req: T) -> Observable<[Any]> {
    
    return Observable<[Any]>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        request(URL(string: req.host + req.reqName)!, method: req.method, parameters: params, encoding: URLEncoding.default, headers: req.headers).responseJSON { (response) in
            
            switch response.result {
                
            case let .success(result):
                
                if JSONSerialization.isValidJSONObject(result) {
                    
                    if let base = WLBaseBean(JSON: result as! [String: Any]) {
                        
                        switch base.code {
                        case .succ:
                            
                            observer.onNext(base.data as! [Any])
                            
                            observer.onCompleted()
                            
                        case .fail:
                            
                            observer.onError(WLBaseError.ServerResponseError(base.msg))
                            
                        case .tokenInvalid:
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tokenInvalid"), object: nil, userInfo: nil)
                            
                            observer.onError(WLBaseError.ServerResponseError(base.msg))
                        default:
                            observer.onError(WLBaseError.ServerResponseError(base.msg))
                        }
                        
                    } else {
                        
                        observer.onError(WLBaseError.MapperError("invalid json"))
                    }
                    
                } else {
                    
                    observer.onError(WLBaseError.MapperError("invalid json"))
                }
                
            case let .failure(error):
                
                observer.onError(WLBaseError.HTTPFailed(error))
            }
        }
        
        return Disposables.create { }
    })
}

// 无返回值的 在data里
@discardableResult
public func onVoidResp<T : WLObserverReq>(_ req: T) -> Observable<Void> {
    
    return Observable<Void>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        request(URL(string: req.host + req.reqName)!, method: req.method, parameters: params, encoding: URLEncoding.default, headers: req.headers).responseJSON { (response) in
            
            switch response.result {
                
            case let .success(result):
                
                if JSONSerialization.isValidJSONObject(result) {
                    
                    if let base = WLBaseBean(JSON: result as! [String : Any]) {
                        
                        switch base.code {
                        case .succ:
                            
                            observer.onNext(())
                            
                            observer.onCompleted()
                            
                        case .fail:
                            
                            observer.onError(WLBaseError.ServerResponseError(base.msg))
                            
                        case .tokenInvalid:
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tokenInvalid"), object: nil, userInfo: nil)
                            
                            observer.onError(WLBaseError.ServerResponseError(base.msg))
                        default:
                            observer.onError(WLBaseError.ServerResponseError(base.msg))
                        }
                        
                    } else {
                        
                        observer.onError(WLBaseError.MapperError("invalid json"))
                    }
                    
                } else {
                    
                    observer.onError(WLBaseError.MapperError("invalid json"))
                }
                
            case let .failure(error):
                
                observer.onError(WLBaseError.HTTPFailed(error))
            }
        }
        return Disposables.create { }
    })
}
