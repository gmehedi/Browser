//
//  ViewController.swift
//  Easy Browser Project4
//
//  Created by Mehedi on 3/1/20.
//  Copyright © 2020 MatrixSolution. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    @IBOutlet weak var view1: UIView!
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        //view.sizeThatFits(CGSize(width: 424, height: 774))
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       //MARK: Set Bar Button Item
        let rightBarButtonItem1 = UIBarButtonItem(title: "Browser", style: .plain, target: self, action: #selector(nowTapped))
        let leftBarButtonItem1 = UIBarButtonItem(title:"<", style: .plain, target: self, action: #selector(goBack))
        let leftBarButtonItem2 = UIBarButtonItem(title:" >", style: .plain, target: self, action: #selector(goForwrd))
        navigationItem.setRightBarButtonItems([rightBarButtonItem1], animated: true)
      //navigationItem.setLeftBarButtonItems([leftBarButtonItem1, leftBarButtonItem2], animated: true)
      //MARK: Set Tool Bar Item
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        navigationController?.isToolbarHidden = true
        
        // MARK: Progress View
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        toolbarItems = [leftBarButtonItem1, leftBarButtonItem2, progressButton, spacer, refresh]
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

    }
    
    @objc func goBack(){
        if webView.canGoBack{
            print("DDFDFDFDFDFDFFffffff")
            webView.goBack()
        }
        else{
            print("LLLLLLLLLLLLLL")
            view = webView
        }
    }
    
    @objc func goForwrd(){
           if webView.canGoForward{
               print("111DDFDFDFDFDFDFFffffff")
               webView.goForward()
           }
           else{
               print("222LLLLLLLLLLLLLL")
           }
       }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    @objc func nowTapped() {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "google.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "facebook.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    func openPage(action: UIAlertAction) {
        navigationController?.isToolbarHidden = false
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
}

