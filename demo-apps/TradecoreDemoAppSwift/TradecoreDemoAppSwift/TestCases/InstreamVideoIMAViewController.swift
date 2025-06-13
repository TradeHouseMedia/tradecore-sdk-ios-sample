//
//  InstreamVideoIMAViewController.swift
//  TradecoreDemoAppSwift
//
//  Created by Olena Stepaniuk on 14.05.2025.
//

import Foundation
import Tradecore
import GoogleInteractiveMediaAds

fileprivate let videoContentURL = URL(string: "https://storage.googleapis.com/gvabox/media/samples/stock.mp4")!
fileprivate let BASE_AD_TAG_URL = "https://pubads.g.doubleclick.net/gampad/ads?output=xml_vast4&unviewed_position_start=1&gdfp_req=1&env=vp&sz=300x250&iu=/22786333977/ca-video-pub-6078204731134206-tag/ROS_player"

final class InstreamVideoIMAViewController: InstreamBaseViewController {
    
    private lazy var contentPlayer: AVPlayer = {
        let player = AVPlayer(url: videoContentURL)
        return player
    }()
    
    private lazy var playerLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer(player: contentPlayer)
        layer.frame = containerView.layer.bounds
        return layer
    }()
    
    // GIMA SDK
    
    private lazy var contentPlayhead: IMAAVPlayerContentPlayhead = {
        IMAAVPlayerContentPlayhead(avPlayer: contentPlayer)
    }()
    
    private var adsLoader: IMAAdsLoader?
    private var adsManager: IMAAdsManager?
    
    // Tradecore SDK
    private var tradecoreInstreamVideo: TradecoreInstreamVideo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.addSublayer(playerLayer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        contentPlayer.pause()
    }
    
    private func createAd() {
        // 1. Create TradecoreInstreamVideo
        let instreamVideo = TradecoreInstreamVideo(
            zoneId: "tradecore-zone-3495",
            delegate: self
        )
        
        // 2. Store the `TradecoreInstreamVideo`
        tradecoreInstreamVideo = instreamVideo
        
        // 3. Load the ad
        instreamVideo.load()
    }
    
    override func onPlayTapped(_ sender: Any) {
        super.onPlayTapped(sender)
        createAd()
    }
    
    override func onReloadTapped(_ sender: Any) {
        super.onReloadTapped(sender)
        
        adsManager?.destroy()
        
        // Reset TradecoreInstreamVideo
        tradecoreInstreamVideo = nil
        
        // Reset player
        contentPlayer.pause()
        contentPlayer.seek(to: .zero)
        playButton.isHidden = false
    }
}

extension InstreamVideoIMAViewController: TradecoreInstreamVideoDelegate {
    
    func tradecoreAdDidLoad(ad: TradecoreAd) {
        print("Ad successfully loaded.")
        reloadButton.isEnabled = true
        
        // 3. Generate GAM Instream URI
        guard let adTagURLString = generateInstreamUriForGAM(
            customKeywords: ad.pbsTargeting as? [String: String]
        ) else {
            print("App failed to generate ad tag URL.")
            self.contentPlayer.play()
            return
        }
        
        print("App generated ad tag URL: \(adTagURLString)")
        
        // 4. Create IMAAdDisplayContainer
        let adDisplayContainer = IMAAdDisplayContainer(
            adContainer: self.containerView,
            viewController: self
        )
        
        // 5. Create IMAAdsRequest
        let request = IMAAdsRequest(
            adTagUrl: adTagURLString,
            adDisplayContainer: adDisplayContainer,
            contentPlayhead: contentPlayhead,
            userContext: nil
        )
        
        // 6. Create IMAAdsLoader
        self.adsLoader = IMAAdsLoader()
        self.adsLoader?.delegate = self
        
        // 7. Load IMA ad request
        self.adsLoader?.requestAds(with: request)
    }
    
    func tradecoreAdDidFailToLoad(error: any Error) {
        print("Ad failed to load: \(error.localizedDescription)")
        reloadButton.isEnabled = true
        
        contentPlayer.play()
    }
}

// MARK: - Ad Tag Generation
extension InstreamVideoIMAViewController {
    
    private func generateInstreamUriForGAM(
        customKeywords: [String: String]?
    ) -> String? {
        guard let customKeywords else {
             return BASE_AD_TAG_URL
        }
        
        let joined = customKeywords.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        let allowedSet = CharacterSet(charactersIn: "&=\"#%/<>?@\\^`{|}").inverted
        let escaped = joined.addingPercentEncoding(withAllowedCharacters: allowedSet) ?? ""
        
        let queryStringKeywords = String(format: "cust_params=%@", escaped)
        return String(format: "%@&%@", BASE_AD_TAG_URL, queryStringKeywords)
    }
}

// MARK: - IMAAdsLoaderDelegate
extension InstreamVideoIMAViewController: IMAAdsLoaderDelegate {
    
    func adsLoader(_ loader: IMAAdsLoader, adsLoadedWith adsLoadedData: IMAAdsLoadedData) {
        // 8. Grab the instance of the IMAAdsManager and set ourselves as the delegate.
        adsManager = adsLoadedData.adsManager
        adsManager?.delegate = self
        
        // 9. Initialize the ads manager.
        adsManager?.initialize(with: nil)
    }
    
    func adsLoader(_ loader: IMAAdsLoader, failedWith adErrorData: IMAAdLoadingErrorData) {
        print("Google IMA SDK failed to load an ad: \(String(describing: adErrorData.adError.message))")
        contentPlayer.play()
    }
}

extension InstreamVideoIMAViewController: IMAAdsManagerDelegate {
    
    func adsManager(_ adsManager: IMAAdsManager, didReceive event: IMAAdEvent) {
        // 10. When the SDK notifies us that ads have been loaded, play them.
        if event.type == IMAAdEventType.LOADED {
            adsManager.start()
        }
    }
    
    func adsManager(_ adsManager: IMAAdsManager, didReceive error: IMAAdError) {
        print("Google IMA SDK failed to load an ad: \(String(describing: error.message))")
        contentPlayer.play()
    }
    
    func adsManagerDidRequestContentPause(_ adsManager: IMAAdsManager) {
        // 11. The Google IMA SDK is going to play ads, so pause the content.
        contentPlayer.pause()
    }
    
    func adsManagerDidRequestContentResume(_ adsManager: IMAAdsManager) {
        // 12. The Google IMA SDK is done playing ads (at least for now), so resume the content.
        contentPlayer.play()
    }
}
