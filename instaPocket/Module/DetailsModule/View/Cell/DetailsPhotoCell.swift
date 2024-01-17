//
//  DetailsPhotoCell.swift
//  instaPocket
//
//  Created by Ислам Батыргереев on 17.01.2024.
//

import UIKit

class DetailsPhotoCell: UICollectionViewCell, CollectionViewCellProtocol {
    static let reuseId: String = "DetailsPhotoCell"
    
    lazy var cellImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView(frame: bounds))
    
    lazy var imageMenuButton: UIButton = {
        $0.setBackgroundImage(.dottetIcon, for: .normal)
        $0.frame = CGRect(x: cellImage.frame.width - 50, y: 30, width: 31, height: 6)
        return $0
    }(UIButton())
    
    required override init(frame: CGRect) {
         super.init(frame: frame)
        layer.cornerRadius = 30
        clipsToBounds = true
        addSubview(cellImage)
        cellImage.addSubview(imageMenuButton)
    }
    
    func configureCell(image: String){
        cellImage.image = UIImage(named: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
