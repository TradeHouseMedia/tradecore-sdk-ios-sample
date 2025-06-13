//
//  UIButton++.swift
//  TradecoreDemoAppSwift
//
//  Created by Olena Stepaniuk on 14.05.2025.
//

import UIKit

extension UIButton {
    
    func setupPullDown(with actions: [UIAction]) {
        showsMenuAsPrimaryAction = true
        changesSelectionAsPrimaryAction = true
        
        actions.first?.state = .on
        
        menu = UIMenu(children: actions)
    }
}
