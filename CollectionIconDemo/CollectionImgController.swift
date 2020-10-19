//
//  CollectionImgController.swift
//  CollectionIconDemo
//
//  Created by jingjun on 2020/10/19.
//  Copyright © 2020 jingjun. All rights reserved.
//

import UIKit

class CollectionImgController: UIViewController {
    
    let titles : [String] = ["https://app-icon.pgyer.com/f/4/3/e/6/f43e675edf4bd421429b504e1c9b83f1?x-oss-process=image/resize,m_lfit,h_120,w_120/format,jpg",
                             "https://app-icon.pgyer.com/f/4/3/e/6/f43e675edf4bd421429b504e1c9b83f1?x-oss-process=image/resize,m_lfit,h_120,w_120/format,jpg",
                             "https://app-icon.pgyer.com/f/4/3/e/6/f43e675edf4bd421429b504e1c9b83f1?x-oss-process=image/resize,m_lfit,h_120,w_120/format,jpg",
                             "https://app-icon.pgyer.com/f/4/3/e/6/f43e675edf4bd421429b504e1c9b83f1?x-oss-process=image/resize,m_lfit,h_120,w_120/format,jpg",
    ]
    
    lazy var collectionView : UICollectionView = {
        let layout = CustomLayout.init()

        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = true
        collectionView.register(CollectionImgCell.self, forCellWithReuseIdentifier: "CollectionImgCell")
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: self.view.frame.size.width * 0.6).isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}
extension CollectionImgController: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionImgCell", for: indexPath) as! CollectionImgCell
        let url = URL(string: titles[indexPath.item])!
        
        if let data = try? Data.init(contentsOf: url) {
            let image = UIImage.init(data: data)
            cell.imgView.image = image
        }
        
        return cell
    }
    
    
}
