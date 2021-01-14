//
//  CollectionIconView.swift
//  CollectionIconDemo
//
//  Created by jingjun on 2020/10/14.
//  Copyright © 2020 jingjun. All rights reserved.
//

import UIKit

class CollectionIconView: UIView {
    
    var titles: [String] = [] {
        didSet {
            if titles.count > 0 {
                self.collectionView.reloadData()
            }
        }
    }
    
    lazy var collectionView : UICollectionView = {
        let layout = XTWaterFlowLayout.init(spacing: 10, margin: 20)
        layout.rowHeight = 20
        layout.delegate = self
        
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(self.collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CollectionIconView: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.iconBtn.setTitle(titles[indexPath.item], for: .normal)
        return cell
    }
    
    
}

extension CollectionIconView: XTWaterFlowLayoutDelegate {
    func waterFlowLayout(layout: XTWaterFlowLayout, withAt indexPath: IndexPath) -> CGFloat {
        let str = titles[indexPath.row] as NSString
        let w = str.boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width, height: CGFloat.infinity), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil).width
        return w + 20
    }
    
    func waterContentSizeHeight(height: CGFloat) {
        print("=====height:",height)
    }
}
