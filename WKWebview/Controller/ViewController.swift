//
//  ViewController.swift
//  WKWebview
//
//  Created by hackeru on 19/08/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let slideIn = SlideInAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        webView.load("https://www.walla.co.il")
        webView.navigationDelegate = self
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped =  true
    }


    
    @IBAction func menuAction(_ sender: UIBarButtonItem) {
        guard let menu = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        
        menu.didTapMenu = {[weak self] catgory in
            guard let self = self else { return }
           self.loadWebViewFromSelection(catgory)
            
        }
        
        menu.modalPresentationStyle = .currentContext
        menu.transitioningDelegate = self
        self.present(menu, animated: true)
    }
    
    private func loadWebViewFromSelection(_ catgory: MenuViewController.MenuCatgorty ) {
        switch catgory {
        case .finance:
            self.webView.load("https://finance.walla.co.il")
        case .health:
            self.webView.load("https://healthy.walla.co.il")
        case .sport:
            self.webView.load("https://sports.walla.co.il")
        case .googleInSafari:
            guard let url = URL(string: "https://www.google.com") else { return }
            UIApplication.shared.open(url)
        }
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideIn.isMenuOpen = false
        return slideIn
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideIn.isMenuOpen = true
        return slideIn
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = webView.title
        self.activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.activityIndicator.startAnimating()

    }
}


