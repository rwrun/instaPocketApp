//
//  CameraViewPresenter.swift
//  instaPocket
//
//  Created by Ислам Батыргереев on 12.02.2024.
//

import UIKit

protocol CameraViewPresenterProtocol: AnyObject {
    init(view: CameraViewProtocol)
    var photos: [UIImage] { get set }
    
    var closeViewAction: UIAction? { get set }
    var switchCamera: UIAction? { get set }
    
}

class CameraViewPresenter: CameraViewPresenterProtocol{
    private weak var view: CameraViewProtocol?
    
    required init(view: CameraViewProtocol) {
        self.view = view
    }
    
    var photos: [UIImage] = []
    
    var closeViewAction: UIAction? = UIAction { _ in
        NotificationCenter.default.post(name: .goToMain, object: nil)
    }
    
    var switchCamera: UIAction? = UIAction { _ in
        
    }
    
    
}
