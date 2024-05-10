//
//  SettingsViewPresenter.swift
//  instaPocket
//
//  Created by Ислам Батыргереев on 28.02.2024.
//

import Foundation

protocol SettingsViewPresenterProtocol: AnyObject{
    init(view: SettingsViewProtocol)
}

class SettingsViewPresenter: SettingsViewPresenterProtocol{
    private weak var view: SettingsViewProtocol?
    
    required init(view: SettingsViewProtocol) {
        self.view = view
    }
    
}


