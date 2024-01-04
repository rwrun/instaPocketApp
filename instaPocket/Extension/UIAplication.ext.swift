//
//  UIAplication.ext.swift
//  instaPocket
//
//  Created by Ислам Батыргереев on 30.12.2023.
//

import UIKit

extension UIApplication{
    static var topSafeArea: CGFloat {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.windows.first?.safeAreaInsets.top ?? .zero
    }
}
