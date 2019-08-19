//
//  WebkitExtenstion.swift
//  WKWebview
//
//  Created by hackeru on 19/08/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import WebKit
extension WKWebView {
    func load(_ urlString : String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
