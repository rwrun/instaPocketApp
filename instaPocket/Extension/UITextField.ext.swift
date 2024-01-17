//
//  UITextField.ext.swift
//  instaPocket
//
//  Created by Ислам Батыргереев on 17.01.2024.
//

import UIKit

extension UITextField{
    func setLeftOffset(){
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 10))
        self.leftViewMode = .always
    }
}
