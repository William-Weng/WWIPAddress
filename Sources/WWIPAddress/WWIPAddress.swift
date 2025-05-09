//
//  WWIPAddress.swift
//  WWIPAddress
//
//  Created by William.Weng on 2025/5/9.
//

import Foundation
import WWNetworking

// MARK: - 對外IP查詢工具
open class WWIPAddress {
 
    public static let shared = WWIPAddress()
}

// MARK: - 公開函式
public extension WWIPAddress {
    
    /// 取得對外IP相關資訊
    /// - Parameters:
    ///   - type: ServiceType
    ///   - timeout: TimeInterval
    ///   - result: Result<Data, Error>
    func detail(with type: ServiceType, timeout: TimeInterval = 5, result: @escaping (Result<Data, Error>) -> Void) {
        
        let apiUrlString = type.api()
        
        WWNetworking.shared.request(urlString: apiUrlString, timeout: timeout) { _result_ in
            
            switch _result_ {
            case .failure(let error): result(.failure(error))
            case .success(let info):
                guard let data = info.data else { result(.failure(CustomError.isEmpty)); return }
                result(.success(data))
            }
        }
    }
    
    /// [取得對外IPv4地址](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/沒有-s-的-http-還可以連線嗎-29235037e161)
    /// - Parameters:
    ///   - type: ServiceType
    ///   - timeout: TimeInterval
    ///   - result: Result<Data, Error>
    func v4(with type: ServiceType, timeout: TimeInterval = 5, result: @escaping (Result<String, Error>) -> Void) {
        
        let result = detail(with: type, timeout: timeout) { _result_ in
            
            switch _result_ {
            case .failure(let error): result(.failure(error))
            case .success(let data):
                
                guard let jsonObject = data._jsonObject(),
                      let dictionary = jsonObject as? [String: Any],
                      let ip = dictionary[type.key()] as? String
                else {
                    result(.failure(CustomError.isNotFormat)); return
                }
                                
                result(.success(ip))
            }
        }
    }
    
    /// 反查IP相關資訊
    /// - Parameters:
    ///   - type: ServiceType
    ///   - timeout: TimeInterval
    ///   - result: Result<Data, Error>
    func information(with type: InformationType, timeout: TimeInterval = 5, result: @escaping (Result<Data, Error>) -> Void) {
        
        let apiUrlString = type.api()
        
        WWNetworking.shared.request(urlString: apiUrlString, timeout: timeout) { _result_ in
            
            switch _result_ {
            case .failure(let error): result(.failure(error))
            case .success(let info):
                guard let data = info.data else { result(.failure(CustomError.isEmpty)); return }
                result(.success(data))
            }
        }
    }
}

// MARK: - 公開函式 (async / await)
public extension WWIPAddress {
    
    /// 取得相關資訊
    /// - Parameters:
    ///   - type: ServiceType
    ///   - timeout: TimeInterval
    /// - Returns: Result<Data, Error>
    func detail(with type: ServiceType, timeout: TimeInterval = 5) async -> Result<Data, Error> {
        
        await withCheckedContinuation { continuation in
            detail(with: type, timeout: timeout) { continuation.resume(returning: $0) }
        }
    }
    
    /// 取得對外的IPv4地址
    /// - Parameters:
    ///   - type: ServiceType
    ///   - timeout: TimeInterval
    /// - Returns: Result<Data, Error>
    func v4(with type: ServiceType, timeout: TimeInterval = 5) async -> Result<String, Error> {
        
        await withCheckedContinuation { continuation in
            v4(with: type, timeout: timeout) { continuation.resume(returning: $0) }
        }
    }
    
    /// 反查IP相關資訊
    /// - Parameters:
    ///   - type: ServiceType
    ///   - timeout: TimeInterval
    ///   - result: Result<Data, Error>
    func information(with type: InformationType, timeout: TimeInterval = 5) async -> Result<Data, Error> {
        
        await withCheckedContinuation { continuation in
            information(with: type, timeout: timeout) { continuation.resume(returning: $0) }
        }
    }
}
