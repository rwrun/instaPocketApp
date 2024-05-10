//
//  SceneDelegate.swift
//  instaPocket
//
//  Created by Ислам Батыргереев on 23.12.2023.
//

import UIKit

protocol SceneDelegateProtocol{
    func startMainScreen()
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var keychainManager = KeychainManager()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = Builder.createTabBarController()//Builder.getPasscodeController(passcodeState: checkIssetPasscode(), sceneDelegate: self, isSetting: false)
        window?.makeKeyAndVisible()
    }

    
    private func checkIssetPasscode() -> PasscodeState {
        let keychainPasscodeResult = keychainManager.load(key: KeychainKeys.passcode.rawValue)
        switch keychainPasscodeResult {
            
        case .success(let code):
            return code.isEmpty ? .setNewPasscode : .inputPasscode
        case .failure:
            return .setNewPasscode
        }
    }
    


}

extension SceneDelegate: SceneDelegateProtocol{
    func startMainScreen() {
        self.window?.rootViewController = Builder.createTabBarController()
    }
    
    
}
