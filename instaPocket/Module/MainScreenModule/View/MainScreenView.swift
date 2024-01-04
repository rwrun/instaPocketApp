//
//  MainScreenView.swift
//  instaPocket
//
//  Created by Ислам Батыргереев on 26.12.2023.
//

import UIKit

protocol MainScreenViewProtocol: AnyObject{
    func showPosts()
}

class MainScreenView: UIViewController {

    var presenter: MainScreenPresenterProtocol!
    private var topInsets: CGFloat = 0
    private var menuViewHeight = UIApplication.topSafeArea + 70
    
    private lazy var topMenuView: UIView = {
        $0.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: menuViewHeight)
        $0.backgroundColor = .appMain
        $0.addSubview(menuAppName)
        $0.addSubview(settingButton)
        return $0
    }(UIView())
    
    
    private lazy var menuAppName: UILabel = {
        $0.text = "instaPocket"
        $0.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        $0.textColor = .white
        $0.frame = CGRect(x: 50, y: menuViewHeight - 40, width: view.bounds.width, height: 30)
        return $0
    }(UILabel())
    
    private lazy var settingButton: UIButton = {
        $0.frame = CGRect(x: view.bounds.width - 50, y: menuViewHeight - 35, width: 20, height: 20)
        $0.setBackgroundImage(UIImage(systemName: "gearshape"), for: .normal)
        $0.tintColor = .white
        return $0
    }(UIButton())
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: view.frame.width - 60,
                                 height: view.frame.width - 60)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 40, right: 0)
        
        $0.contentInset.top = 130
        $0.backgroundColor = .appMain
        $0.dataSource = self
        $0.delegate = self
        $0.alwaysBounceVertical = true
        $0.register(MainPostCell.self, forCellWithReuseIdentifier: MainPostCell.reuseId)
        $0.register(MainPostHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainPostHeader.reuseId)
        
        return $0
        
    }(UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout()))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .appMain
        view.addSubview(collectionView)
        view.addSubview(topMenuView)
        
        topInsets = collectionView.adjustedContentInset.top
    }
    

}

extension MainScreenView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.presenter.posts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter.posts?[section].items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPostCell.reuseId, for: indexPath) as? MainPostCell
        else { return UICollectionViewCell() }
        
        if let item = presenter.posts?[indexPath.section].items[indexPath.row] {
            cell.configureCell(item: item)
        }
        
        
        cell.backgroundColor = .gray
        return cell
    }
    
 
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainPostHeader.reuseId, for: indexPath) as! MainPostHeader
        
        header.setHeaderText(header: presenter.posts?[indexPath.section].date.getDateDiference())
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width - 60, height: 40)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let menuTopPosition = scrollView.contentOffset.y + topInsets
        
        if menuTopPosition < 40, menuTopPosition > 0{
            topMenuView.frame.origin.y = -menuTopPosition
            self.menuAppName.font = UIFont.systemFont(ofSize: 30 - menuTopPosition * 0.2,
                                                      weight: .bold)
        }
    }
    
}

extension MainScreenView: MainScreenViewProtocol{
    func showPosts() {
        collectionView.reloadData()
    }
}
