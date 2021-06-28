//
//  AdmobViewController.swift
//  Demo
//
//  Created by TrivialWorks on 14/12/19.
//  Copyright © 2019 TrivialWorks. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdmobViewController: UIViewController,GADBannerViewDelegate {
//    @IBOutlet weak var bannerView: GADBannerView!
    var bannerView = GADBannerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
    
        bannerView.adUnitID = "ca-app-pub-9533080127076086/5193995431"
        bannerView.rootViewController = self
        let request = GADRequest()
//        request.testDevices = [ (kGADSimulatorID as! String) ]
      //  GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ (kGADSimulatorID as! String) ];
//        bannerView.load(GADRequest())
        
        
        
//        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
//        bannerView.rootViewController = self
//        bannerView.load(GADRequest())
//        addBannerViewToView(bannerView)
        
        bannerView.load(request)
        bannerView.delegate = self
        
    }

    func addBannerViewToView(_ bannerView: GADBannerView) {
     bannerView.translatesAutoresizingMaskIntoConstraints = false
     view.addSubview(bannerView)
     view.addConstraints(
       [NSLayoutConstraint(item: bannerView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: view.safeAreaLayoutGuide.bottomAnchor,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0),
        NSLayoutConstraint(item: bannerView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0)
       ])
    }
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("adViewDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
    }

    @IBAction func backBtbnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
