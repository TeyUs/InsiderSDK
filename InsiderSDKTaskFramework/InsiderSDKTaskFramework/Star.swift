//
//  Star.swift
//  InsiderSDKTaskFramework
//
//  Created by Uslu, Teyhan on 18.04.2024.
//

import UIKit

class Star {
    let size: StarSize
    let color: UIColor
    let isbright: Bool
    
    var description: String {
        "Star => size: \(size.rawValue) color: \(color.accessibilityName) brightness: \(isbright ? "Bright" : "Not so bright")"
    }
    
    init(size: StarSize, color: UIColor, isbright: Bool) {
        self.size = size
        self.color = color
        self.isbright = isbright
    }
    
    init(size: StarSize) {
        self.size = size
        self.color = size.color
        self.isbright = Bool.random()
    }
}

public enum StarSize: String {
    case S
    case B
    
    var color: UIColor {
        switch self {
        case .S:
            return [.red, .blue, .green].randomElement()!
        case .B:
            return [.yellow, .purple, .gray].randomElement()!
        }
    }
}

