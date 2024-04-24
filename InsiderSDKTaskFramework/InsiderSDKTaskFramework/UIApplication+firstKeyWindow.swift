//
//  UIApplication+firstKeyWindow.swift
//  InsiderSDKTaskFramework
//
//  Created by Uslu, Teyhan on 24.04.2024.
//

import UIKit

///Source: [link](https://sarunw.com/posts/how-to-get-root-view-controller/)
/// An extension added to make alert appear on the current screen
extension UIApplication {
    var firstKeyWindow: UIWindow? {
        let windowScenes = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
        let activeScene = windowScenes
            .filter { $0.activationState == .foregroundActive }
        let firstActiveScene = activeScene.first
        let keyWindow = firstActiveScene?.keyWindow
        return keyWindow
    }
}
