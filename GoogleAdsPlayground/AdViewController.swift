//
//  AdViewController.swift
//  GoogleAdsPlayground
//
//  Created by Li, Haoxin on 10/27/18.
//  Copyright © 2018 Haoxin Li. All rights reserved.
//

import GoogleMobileAds
import UIKit
import WebKit

final class AdViewController: UIViewController {
    
    @IBOutlet private weak var adContainer: UIView!
    
    @IBOutlet private weak var webView: WKWebView! {
        didSet {
            guard let fileUrl = Bundle.main.url(forResource: "PhoneLink", withExtension: "html") else {
                    assertionFailure()
                    return
            }
            webView.loadFileURL(fileUrl, allowingReadAccessTo: fileUrl)
        }
    }
    
    @IBOutlet private weak var deprecatedWebView: UIWebView! {
        didSet {
            guard let fileUrl = Bundle.main.url(forResource: "PhoneLink", withExtension: "html"),
            let htmlString = try? String(contentsOf: fileUrl) else {
                assertionFailure()
                return
            }
            deprecatedWebView.loadHTMLString(htmlString, baseURL: nil)
        }
    }
    
    
    private lazy var adView: GADBannerView = {
        let v = GADBannerView(adSize: kGADAdSizeFluid)
        v.delegate = self
        v.adSizeDelegate = self
        v.rootViewController = self
        v.adUnitID = "/12930815/TILE1/RDC2/SRPLIST/SALE/DESK"
        v.bounds = CGRect(origin: .zero, size: CGSize(width: 320, height: 50))
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adContainer.addSubview(adView)
        adView.load(adRequest)
    }
}

private extension AdViewController {
    
    var adRequest: DFPRequest {
        let request = DFPRequest()
        request.testDevices = [kGADSimulatorID]
        
        let zip = "90802"
        var info: [String: String] = [:]
        info["ZIPSRCH"] = zip
        info["SRPZIP1"] = zip
        info["JY"] = "5931abcd666b2c49ad00066c" // user ID
        info["PLATFORM"] = "APP_PH"
        request.customTargeting = info
        
        let extras = GADExtras()
        extras.additionalParameters = ["POS": "TILE1"]
        request.register(extras)
        
        return request
    }
}

extension AdViewController: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("\(#function)")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("\(#function) \(error.localizedDescription)")
    }
    
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("\(#function)")
    }
    
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("\(#function)")
    }
    
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("\(#function)")
    }
    
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("\(#function)")
    }
}

extension AdViewController: GADAdSizeDelegate {
    
    func adView(_ bannerView: GADBannerView, willChangeAdSizeTo size: GADAdSize) {
        print("\(#function) \(size.size)")
        bannerView.frame = CGRect(origin: .zero, size: size.size)
    }
}
