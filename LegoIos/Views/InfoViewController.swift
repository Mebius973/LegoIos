//
//  InfoViewController.swift
//  LegoIos
//
//  Created by Mebius on 04/01/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import UIKit
import WebKit

class InfoViewController: UIViewController, WKUIDelegate {

   var webView: WKWebView!

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string: Constants.PoliciesURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
