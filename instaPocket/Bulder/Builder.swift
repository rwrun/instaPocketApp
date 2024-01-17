//
//  Builder.swift
//  instaPocket
//
//  Created by Ислам Батыргереев on 23.12.2023.
//

import UIKit

protocol BuilderProtocol{
    static func getPasscodeController(passcodeState: PasscodeState, sceneDelegate: SceneDelegateProtocol) -> UIViewController
    static func createTabBarController() -> UIViewController
    
    //vc
    
    static func createMainScreenController() -> UIViewController
    static func createCameraScreenController() -> UIViewController
    static func createFavoriteScreenController() -> UIViewController
    
}

class Builder: BuilderProtocol{
    
    static func getPasscodeController(passcodeState: PasscodeState, sceneDelegate: SceneDelegateProtocol) -> UIViewController{
        let passcodeView = PasscodeView()
        let keychainManager = KeychainManager()
        
        let presenter = PasscodePresenter(view: passcodeView, passcodeState: passcodeState, keychainManager: keychainManager, sceneDelagate: sceneDelegate)
        
        passcodeView.passcodePresenter = presenter
        return passcodeView
    }
    
    
    static func createTabBarController() -> UIViewController {
        let tabBarView = TabBarView()
        let presenter = TabBarViewPresenter(view: tabBarView)
        tabBarView.presenter = presenter
        
        return tabBarView
        
    }
    
    static func createMainScreenController() -> UIViewController {
        let mainView = MainScreenView()
        let presenter = MainScreenPresenter(view: mainView)
        mainView.presenter = presenter
        
        return mainView
    }
    
    
    static func createCameraScreenController() -> UIViewController {
        let cameraView = CameraView()
        
        return cameraView
    }
    
    
    static func createFavoriteScreenController() -> UIViewController {
        let favoriteView = FavotiteView()
        let presenter = FavoriteViewPresenter(view: favoriteView)
        
        favoriteView.presenter = presenter
        return UINavigationController(rootViewController: favoriteView) 
    }
    
    static func createDetailsController(item: PostItem) -> UIViewController{
        let detailsView = DetailsView()
        let presenter = DetailsViewPresenter(view: detailsView, item: item)
        
        detailsView.presenter = presenter
        //
        
        return detailsView
    }
}
