//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2025/5/9.
//

import UIKit
import WWIPAddress

// MARK: - ViewController
final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WWIPAddress.shared.v4(with: .ifconfig) { result in
            switch result {
            case .failure(let error): print(error)
            case .success(let ip): print(ip)            // 8.8.8.8
            }
        }
    }
}


