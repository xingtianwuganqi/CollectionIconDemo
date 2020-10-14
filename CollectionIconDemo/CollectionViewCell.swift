//
//  CollectionViewCell.swift
//  CollectionIconDemo
//
//  Created by jingjun on 2020/10/14.
//  Copyright © 2020 jingjun. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    lazy var iconBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setBackgroundImage(UIImage(named: ""), for: .normal)
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = true
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(iconBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.iconBtn.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
