//
//  WLReqApi.swift
//  RxSwift-MVVM
//
//  Created by three stone 王 on 2019/6/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLReqKit
import Alamofire
import WLToolsKit

public enum WLReqApi {
    
    case login(_ phone: String,password: String)
    
    case smsCode(_ phone: String)
    
    case swiftLogin(_ phone: String,code: String)
    
    case reg(_ phone: String,password: String ,code: String)
    
    case smsPassword(_ phone: String)
    
    case resettingPassword(_ phone: String,password: String ,code: String)
    
    case modifyPassword(_ oldPassword: String,password: String)
}
extension WLReqApi: WLObserverReq {
    public var reqName: String {
        
        switch self {
            
        case .login: return "other/login_mobLoginPhone?"
            
        case .swiftLogin: return "other/login_mobQuickLogin?"
            
        case .smsCode: return "mob/sms_mobSendQuickLoginCode?"
            
        case .reg: return "mob/users_mobPhoneAddUsers?"
            
        case .smsPassword: return "mob/sms_mobSendForgetPwdCode?"
            
        case .resettingPassword: return "mob/users_mobForgetPassword?"
            
        case .modifyPassword: return "mob/users_mobUpdatePassword?"
            
        }
    }
    
    public var params: Dictionary<String, Any> {
        
        switch self {
        case let .login(phone, password: password): return ["phone": phone,"password": password,"platform": "1" ,"deviceId": DeviceId]
            
        case let .smsCode(phone): return ["phone": phone,"signName":"纸盒App","templateCode":"SMS_160576175"]
            
        case let .swiftLogin(phone, code): return ["phone":phone,"code":code,"platform":"1"]
            
        case let .reg(phone, password: password, code: code): return ["phone": phone,"password": password,"platform": "1","code": code,"openid": ""]
            
        case let .smsPassword(phone): return ["phone": phone,"signName":"纸盒App","templateCode":"SMS_160571563"]
            
        case let .resettingPassword(phone, password: password, code: code): return ["phone": phone,"password": password,"platform": "1","code": code]
            
        case let .modifyPassword(oldPassword, password: password): return ["oldPassword": oldPassword,"password": password]
            
        }
    }
    
    public var headers: Dictionary<String, String> {
        
        switch self {
            
        default: return [:]
            
        }
    }
    
    public var method: HTTPMethod {
        switch self {
            
        default: return .post
            
        }
    }
    
    public var host: String {
        
        switch self {
        // 服务器
        default: return "https://zhih.ecsoi.com/"
            
        }
    }
}


