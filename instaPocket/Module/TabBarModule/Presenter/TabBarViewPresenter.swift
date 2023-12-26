//
//  TabBarViewPresenter.swift
//  instaPocket
//
//  Created by Ислам Батыргереев on 26.12.2023.
//

import UIKit

protocol TabBarViewPresenterProtocol: AnyObject{
    init(view: TabBarViewProtocol)
    func buildTabBar()
    
}

class TabBarViewPresenter {
    
   
    weak var view: TabBarViewProtocol?
    
    required init(view: TabBarViewProtocol) {
        self.view = view
        self.buildTabBar()
        
    }
    
    
}

extension TabBarViewPresenter: TabBarViewPresenterProtocol{
    
    
    func buildTabBar() {
        let mainScreen = Builder.createMainScreenController()
        let cameraScreen = Builder.createCameraScreenController()
        let favoriteScreen = Builder.createFavoriteScreenController()
        
        
        self.view?.setControllers(controllers: [mainScreen, cameraScreen, favoriteScreen])
    }
}
