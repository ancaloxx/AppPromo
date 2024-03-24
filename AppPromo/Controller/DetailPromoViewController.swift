//
//  DetailPromoViewController.swift
//  AppPromo
//
//  Created by anca dev on 22/03/24.
//

import UIKit
import WebKit

class DetailPromoViewController: UIViewController {

    @IBOutlet weak var webViewDetail: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var urlStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        activityIndicator.startAnimating()
        
        webViewSetup()
    }
    
    private func webViewSetup() {
        guard let urlStr, 
              let url = URL(string: urlStr) else {
            return
        }
        
        webViewDetail.navigationDelegate = self
        webViewDetail.isUserInteractionEnabled = false
        webViewDetail.load(URLRequest(url: url))
    }

}

extension DetailPromoViewController: WKNavigationDelegate {
    
    func webView(_ webview: WKWebView, didFinish navigation: WKNavigation?) {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        
        webViewDetail.isUserInteractionEnabled = true
    }
    
}

extension DetailPromoViewController {
    
    static func getViewController() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailPromo") as? DetailPromoViewController else {
            return UIViewController()
        }
        return vc
    }
    
}
