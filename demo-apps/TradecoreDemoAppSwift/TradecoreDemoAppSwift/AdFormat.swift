//
//  AdFormat.swift
//  TradecoreDemoAppSwift
//
//  Created by Olena Stepaniuk on 14.05.2025.
//

import Foundation

enum AdFormat: CustomStringConvertible, CaseIterable {
    
    case banner
    case video
    case instreamVideo
    
    var description: String {
        switch self {
        case .banner:
            "Banner"
        case .video:
            "Video"
        case .instreamVideo:
            "Instream Video"
        }
    }
}
