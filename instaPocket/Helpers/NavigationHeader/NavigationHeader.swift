//
//  NavigationHeader.swift
//  instaPocket
//
//  Created by Ислам Батыргереев on 16.01.2024.
//

import UIKit

class NavigationHeader{
    
    var backAction: UIAction?
    var menuAction: UIAction?
    var closeAction: UIAction?
    var date: Date
    
    
    private lazy var navigationView: UIView = {
        $0.frame = CGRect(x: 30, y: 0, width: UIScreen.main.bounds.width - 60, height: 44)
        $0.backgroundColor = .appMain
        $0.addSubview(dateStack)
        return $0
        
    }(UIView())
    
    lazy var dateLabel: UILabel = getHeaderLabel(text: date.formattDate(formatType: .onlyDate), size: 30, weight: .bold)
    lazy var yearLabel: UILabel = getHeaderLabel(text: date.formattDate(formatType: .onlyYear) + " год", size: 14, weight: .light)
    
    lazy var backButton: UIButton = getActionButton(origin: CGPoint(x: 0, y: 9), icon: .backIcon, action: backAction)
    
    lazy var closeButton: UIButton = getActionButton(origin: CGPoint(x: navigationView.frame.width - 30, y: 0), icon: .closeIcon, action: closeAction)
    
    lazy var menuButton: UIButton = getActionButton(origin: CGPoint(x: navigationView.frame.width - 30, y: 9), icon: .menuIcon, action: menuAction)
    
    
    lazy var dateStack: UIStackView = {
        $0.axis = .vertical
        $0.addArrangedSubview(dateLabel)
        $0.addArrangedSubview(yearLabel)
        return $0
    }(UIStackView(frame: CGRect(x: 45, y: 0, width: 200, height: 44)))
    
    
    init(backAction: UIAction? = nil, menuAction: UIAction? = nil, closeAction: UIAction? = nil, date: Date) {
        self.backAction = backAction
        self.menuAction = menuAction
        self.closeAction = closeAction
        self.date = date
    }
    
    
    func getNavigationHeader(type: NavigationHeaderType) -> UIView{
        switch type {
        case .back:
            navigationView.addSubview(backButton)
            navigationView.addSubview(menuButton)
        case .close:
            navigationView.addSubview(closeButton)
        }
        
        return navigationView
    }
    
    private func getActionButton(origin: CGPoint, icon: UIImage, action: UIAction?) -> UIButton{
        let btn = UIButton(primaryAction: action)
        btn.frame.size = CGSize(width: 25, height: 25)
        btn.frame.origin = origin
        btn.setBackgroundImage(icon, for: .normal)
        return btn
    }
    
    private func getHeaderLabel(text: String, size: CGFloat, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        return label

    }
    
}

enum NavigationHeaderType {
    case back, close
}
