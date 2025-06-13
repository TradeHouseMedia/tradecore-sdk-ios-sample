//
//  InstreamBaseViewController.swift
//  TradecoreDemoAppSwift
//
//  Created by Olena Stepaniuk on 14.05.2025.
//

import UIKit

fileprivate let instreamBaseViewControllerNibName = "InstreamBaseViewController"

class InstreamBaseViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var containerWidth: NSLayoutConstraint!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    
    private(set) var adSize = CGSize(width: 300, height: 250)
    
    convenience init(adSize: CGSize) {
        self.init(nibName: instreamBaseViewControllerNibName, bundle: nil)
        self.adSize = adSize
    }
    
    convenience init() {
        self.init(nibName: instreamBaseViewControllerNibName, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.layer.zPosition = CGFloat.greatestFiniteMagnitude
        reloadButton.isEnabled = false
    }
    
    @IBAction func onReloadTapped(_ sender: Any) {
        reloadButton.isEnabled = false
    }
    
    @IBAction func onPlayTapped(_ sender: Any) {
        playButton.isHidden = true
    }
}
