//
//  HTMLAdViewController.swift
//  TradecoreDemoAppSwift
//
//  Created by Olena Stepaniuk on 14.05.2025.
//

import UIKit
import Tradecore

final class HTMLAdViewController: AdViewBaseViewController {
    
    private var tradecoreAdView: TradecoreAdView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAd()
    }
    
    private func createAd() {
        // 1. Create TradecoreAdView instance.
        let tradecoreAdView = TradecoreAdView(zoneId: "tradecore-zone-3492", delegate: self)
        
        // 2. Set root view controller that is used by the ad view to present full screen
        // content after the user interacts with the ad.
        tradecoreAdView.rootViewController = self
        
        // 3. Set zone-specific parameters if needed.
        let parameters = TradecoreGAMZoneRequestParameters()
        parameters.customTargeting = ["sample": "1"]
        parameters.categoryExclusions = ["sample"]
        parameters.keywords = ["Sample"]
        parameters.contentURL = "https://sample.com/"
        parameters.publisherProvidedID = "Sample"
        parameters.extrasParameters = ["sample": 1]
        
        tradecoreAdView.requestParameters = [parameters]
        
        // 4. Add view to UI.
        containerView.addSubview(tradecoreAdView)
        
        // 5. Store `TradecoreAdView` instance.
        self.tradecoreAdView = tradecoreAdView
        
        // 6. Load the ad.
        tradecoreAdView.load()
    }
    
    override func onReloadTapped(_ sender: UIButton) {
        super.onReloadTapped(sender)
        
        tradecoreAdView?.removeFromSuperview()
        tradecoreAdView = nil
        createAd()
    }
}

// MARK: - TradecoreAdViewDelegate
extension HTMLAdViewController: TradecoreAdViewDelegate {
    
    func tradecoreAdDidLoad(ad: TradecoreAd) {
        print("Ad successfully loaded.")
        reloadButton.isEnabled = true
    }
    
    func tradecoreAdDidFailToLoad(error: any Error) {
        print("Ad failed to load: \(error.localizedDescription)")
        reloadButton.isEnabled = true
    }
    
    func tradecoreAdDidReportClick(ad: TradecoreAd) {
        print("Ad was clicked.")
    }
    
    func tradecoreAdDidReportImpression(ad: TradecoreAd) {
        print("Ad impression reported.")
    }
    
    func tradecoreAdWillPresentScreen(ad: TradecoreAd) {
        print("Ad will present modal view controller.")
    }
    
    func tradecoreAdWillDismissScreen(ad: TradecoreAd) {
        print("Ad will dismiss modal view controller.")
    }
    
    func tradecoreAdDidDismissScreen(ad: TradecoreAd) {
        print("Ad did dismiss modal view controller.")
    }
}
