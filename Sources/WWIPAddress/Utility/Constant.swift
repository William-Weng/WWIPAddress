//
//  Constant.swift
//  WWIPAddress
//
//  Created by William.Weng on 2025/5/9.
//

import Foundation

// MARK: - 常數
public extension WWIPAddress {
    
    /// 自定義錯誤
    enum CustomError: Error {
        case isEmpty        // 數值為空值
        case isNotFormat    // 回傳的資料格式錯誤
    }
    
    /// 取得API的服務選項
    enum ServiceType {
        
        case ifconfig
        case myip
        case ipfy
        case ipapi
        
        /// API網址
        /// - Returns: String
        func api() -> String {
            switch self {
            case .ifconfig: return "https://ifconfig.me/all.json"
            case .myip: return "https://api.myip.com"
            case .ipfy: return "https://api.ipify.org/?format=json"
            case .ipapi: return "http://ip-api.com/json"
            }
        }
        
        /// 該服務網址
        /// - Returns: String
        func url() -> String {
            switch self {
            case .ifconfig: return "https://ifconfig.me"
            case .myip: return "https://www.myip.com"
            case .ipfy: return "https://api.ipify.org"
            case .ipapi: return "http://ip-api.com"
            }
        }
        
        /// 取得IP參數的Key值 => {"ip_addr": "127.0.0.1"}
        /// - Returns: String
        func key() -> String {
            switch self {
            case .ifconfig: return "ip_addr"
            case .myip: return "ip"
            case .ipfy: return "ip"
            case .ipapi: return "query"
            }
        }
    }
    
    /// 反查IP資訊服務的選項
    enum InformationType {
        
        case ipapi(_ ip: String)
        case ip_api(_ ip: String)
        
        /// API網址
        /// - Returns: String
        func api() -> String {
            
            switch self {
            case .ipapi(let ip): return "http://ip-api.com/json/\(ip)"
            case .ip_api(let ip): return "https://ipapi.co/\(ip)/json/"
            }
        }
        
        /// 該服務網址
        /// - Returns: String
        func url() -> String {
            
            switch self {
            case .ipapi(_): return "https://ip-api.com/"
            case .ip_api(_): return "https://ipapi.co"
            }
        }
    }
}
