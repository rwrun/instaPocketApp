//
//  PhotoViewPresenter.swift
//  instaPocket
//
//  Created by Ислам Батыргереев on 25.01.2024.
//

import UIKit

protocol PhotoViewPresenterProtocol: AnyObject{
    init(view: PhotoViewProtocol, image: UIImage?)
    var image: UIImage? { get set }
}

class PhotoViewPresenter: PhotoViewPresenterProtocol{
    
    var image: UIImage?
    private weak var view: PhotoViewProtocol?
    
    required init(view: PhotoViewProtocol, image: UIImage?) {
        self.image = image
        self.view = view
    }
    
    
}
