//
//  ViewController.swift
//  CollectionIconDemo
//
//  Created by jingjun on 2020/10/14.
//  Copyright © 2020 jingjun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let titles : [String] = ["苹果苹果苹果苹果苹果苹果","梨梨梨梨梨梨梨梨","西瓜西瓜西瓜西瓜西瓜西瓜西瓜","kjkadjfajd","aaaaaaaagegeeadfa","YLWaterFlowLayoutDelegate"]
    
    lazy var collectionView : UICollectionView = {
        let layout = XTWaterFlowLayout.init()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.collectionView)
        collectionView.frame = self.view.frame
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
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

extension ViewController: XTWaterFlowLayoutDelegate {
    func waterFlowLayout(layout: XTWaterFlowLayout, withAt indexPath: IndexPath) -> CGFloat {
        let str = titles[indexPath.row] as NSString
        let w = str.boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width, height: CGFloat.infinity), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil).width
        return w + 20
    }
    
    func waterContentSizeHeight(height: CGFloat) {
        print("=====height:",height)
    }
}
