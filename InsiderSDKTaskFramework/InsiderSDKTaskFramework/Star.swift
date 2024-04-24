//
//  Star.swift
//  InsiderSDKTaskFramework
//
//  Created by Uslu, Teyhan on 18.04.2024.
//

import UIKit

class Star: Codable {
    var size: StarSize
    var color: StarColor
    var isbright: Bool
    
    var description: String {
        "Star => size: \(size.rawValue) color: \(color.rawValue) brightness: \(isbright ? "Bright" : "Not so bright")"
    }
    
    init(size: StarSize, color: StarColor, isbright: Bool) {
        self.size = size
        self.color = color
        self.isbright = isbright
    }
    
    init(size: StarSize) {
        self.size = size
        self.color = size.color
        self.isbright = Bool.random()
    }
    
    
    enum CodingKeys: String, CodingKey {
        case size
        case color
        case isbright
    }
    
    /// Decoder for Star Class
    required public convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let size = StarSize(rawValue: try values.decodeIfPresent(String.self, forKey: .size)!)!
        let color = StarColor(rawValue: try values.decodeIfPresent(String.self, forKey: .color)!)!
        let isbright = try values.decodeIfPresent(Bool.self, forKey: .isbright)!
        self.init(size: size, color: color, isbright: isbright)
    }
    
    /// Encoder for Star Class
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(size.rawValue, forKey: .size)
        try container.encode(color.rawValue, forKey: .color)
        try container.encode(isbright, forKey: .isbright)
    }
}

/// Possible Sizes of Stars
public enum StarSize: String {
    /// represents the **small** stars
    case S
    /// represents the **big** stars
    case B
    
    ///It gives to randomColor
    var color: StarColor {
        switch self {
        case .S:
            return [.red, .blue, .green].randomElement()!
        case .B:
            return [.yellow, .purple, .gray].randomElement()!
        }
    }
}

/// Possible Colors of Stars
/// There was a need to keep the names of the colors in string type.
enum StarColor: String {
    case red
    case blue
    case green
    case yellow
    case purple
    case gray
    
    var uiColor: UIColor {
        switch self {
        case .red:
            return UIColor.red
        case .blue:
            return UIColor.blue
        case .green:
            return UIColor.green
        case .yellow:
            return UIColor.yellow
        case .purple:
            return UIColor.purple
        case .gray:
            return UIColor.gray
        }
    }
}
