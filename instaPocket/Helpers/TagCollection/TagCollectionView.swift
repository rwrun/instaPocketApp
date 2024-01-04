//
//  TagCollectionView.swift
//  instaPocket
//
//  Created by Ислам Батыргереев on 30.12.2023.
//

import UIKit


protocol TagCollectionViewProtocol: AnyObject {
    var dataSource: UICollectionViewDataSource { get set }
    init(dataSource: UICollectionViewDataSource)
    func getCollectionView() -> UICollectionView
    var isEditin: Bool { get set }
}

class TagCollectionView: TagCollectionViewProtocol{
    var isEditin: Bool = false
    
    var dataSource: UICollectionViewDataSource
    
    required init(dataSource: UICollectionViewDataSource) {
        self.dataSource = dataSource
    }
    
    func getCollectionView() -> UICollectionView {
        return {
            .configure(view: $0) { [weak self] collection in
                guard let self = self else { return }
                
                let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
                layout.scrollDirection = .horizontal
                layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                
                collection.alwaysBounceHorizontal = true
                collection.showsHorizontalScrollIndicator = false
                collection.dataSource = self.dataSource
                collection.backgroundColor = .clear
                collection.register(TagCollectionCell.self, forCellWithReuseIdentifier: TagCollectionCell.reuseId)
            }
        }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    }
    
    
}
