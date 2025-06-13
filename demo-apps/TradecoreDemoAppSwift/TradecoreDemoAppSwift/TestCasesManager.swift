//
//  TestCasesManager.swift
//  TradecoreDemoAppSwift
//
//  Created by Olena Stepaniuk on 14.05.2025.
//

import UIKit

struct TestCase {
    let title: String
    let adFormats: Set<AdFormat>
    let configurationClosure: () -> UIViewController
}

struct TestCasesManager {
    
    static let allCases: [TestCase] = [
        
        TestCase(
            title: "HTML Ad View (Prebid + Amazon + GAM)",
            adFormats: [.banner],
            configurationClosure: {
                HTMLAdViewController()
            }
        ),
        
        TestCase(
            title: "Instream Video (Prebid + GIMA)",
            adFormats: [.instreamVideo],
            configurationClosure: {
                InstreamVideoIMAViewController()
            }
        ),
    ]
}
