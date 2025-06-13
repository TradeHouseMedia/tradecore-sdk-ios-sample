//
//  BannerBaseViewController.swift
//  TradecoreDemoAppSwift
//
//  Created by Olena Stepaniuk on 14.05.2025.
//

import UIKit

fileprivate let adViewBaseViewControllerNibName = "AdViewBaseViewController"

class AdViewBaseViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var containerWidth: NSLayoutConstraint!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    
    @IBOutlet weak var reloadButton: UIButton!
    
    private(set) var adSize = CGSize(width: 300, height: 250)
    
    convenience init(adSize: CGSize) {
        self.init(nibName: adViewBaseViewControllerNibName, bundle: nil)
        self.adSize = adSize
    }
    
    convenience init() {
        self.init(nibName: adViewBaseViewControllerNibName, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerWidth.constant = adSize.width
        containerHeight.constant = adSize.height
    }
    
    @IBAction func onReloadTapped(_ sender: UIButton) {
        reloadButton.isEnabled = false
    }
}
