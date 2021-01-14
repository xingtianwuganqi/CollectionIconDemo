//
//  YLWaterFlowLayout.swift
//  CollectionIconDemo
//
//  Created by jingjun on 2020/margin/14.
//  Copyright © 2020 jingjun. All rights reserved.
//

import UIKit

let margin: CGFloat = 5

protocol XTWaterFlowLayoutDelegate: NSObjectProtocol {
    /**通过代理获得每个cell的宽度*/
    func waterFlowLayout(layout: XTWaterFlowLayout, withAt indexPath: IndexPath) -> CGFloat
    /**获取加载的content的高度*/
    func waterContentSizeHeight(height: CGFloat)
}

class XTWaterFlowLayout: UICollectionViewFlowLayout {
    weak var delegate: XTWaterFlowLayoutDelegate?
    var rowHeight: CGFloat = 0 ///< 固定行高
    
    var originxArray: [CGFloat] = []
    var originyArray: [CGFloat] = []
    
    init(spacing: CGFloat,margin: CGFloat) {
        super.init()
        self.minimumLineSpacing = spacing //行间距
        self.minimumInteritemSpacing = spacing //同一行不同cell间距
        self.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        self.scrollDirection = .vertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 解决高度变小时高度不变的问题
    override func invalidateLayout() {
        super.invalidateLayout()
        self.originxArray = []
        self.originyArray = []
    }
    
    //#pragma mark - 重写父类的方法，实现瀑布流布局
    //#pragma mark - 当尺寸有所变化时，重新刷新
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func prepare() {
        super.prepare()
    }
    
    //#pragma mark - 处理所有的Item的layoutAttributes
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let array = super.layoutAttributesForElements(in: rect) {
            var mutArray: [UICollectionViewLayoutAttributes] = []
            for item in array {
                let theAttri = self.layoutAttributesForItem(at: item.indexPath)!
                mutArray.append(theAttri)
            }
            return mutArray
        }
        return nil
    }
    
    //#pragma mark - 处理单个的Item的layoutAttributes
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        var x = self.sectionInset.left
        var y = self.sectionInset.top
        // 判断获得前一个cell的x和y
        let preRow = indexPath.row - 1
        if preRow >= 0 {
            if originyArray.count > preRow {
                x = originxArray[preRow]
                y = originyArray[preRow]
            }
            let preIndexPath = IndexPath.init(item: preRow, section: indexPath.section)
            let preWidth = self.delegate?.waterFlowLayout(layout: self, withAt: preIndexPath) ?? 0
            x += preWidth + self.minimumInteritemSpacing
        }
        var currentWidth = self.delegate?.waterFlowLayout(layout: self, withAt: indexPath)
        // 保证一个cell不超过最大宽度
        currentWidth = min((currentWidth ?? 0),(self.collectionView?.frame.width ?? 0) - self.sectionInset.left - self.sectionInset.right)
        if ((x + (currentWidth ?? 0)) > (self.collectionView?.frame.size.width ?? 0) - self.sectionInset.right)
        {
            // 超出范围，换行
            x = self.sectionInset.left
            y += self.rowHeight + self.minimumLineSpacing
        }
        // 创建属性
        let attrs: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        attrs.frame = CGRect(x: x, y: y, width: currentWidth ?? 0, height: rowHeight)
        originxArray.insert(x, at: indexPath.row)
        originyArray.insert(y, at: indexPath.row)
        return attrs
    }
    
    var maxY = 0
    override var collectionViewContentSize: CGSize {
        let width = self.collectionView?.frame.size.width
        var maxY : CGFloat = 0
        originyArray.forEach { (number) in
            if number > maxY {
                maxY = number
            }
        }
        let contentHeigh = maxY + rowHeight + self.sectionInset.bottom
        self.delegate?.waterContentSizeHeight(height: contentHeigh)
        return CGSize(width: width ?? 0, height: contentHeigh)
    }
}

class CustomLayout: UICollectionViewFlowLayout {
    // 内容区域总大小，不是可见区域
    override var collectionViewContentSize: CGSize {
        let width = collectionView!.bounds.size.width - collectionView!.contentInset.left
            - collectionView!.contentInset.right
        let height = collectionView!.bounds.size.height
        return CGSize(width: width, height: height)
    }
    
    // 所有单元格位置属性
    override func layoutAttributesForElements(in rect: CGRect)
    -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()
        let cellCount = self.collectionView!.numberOfItems(inSection: 0)
        for i in 0..<cellCount {
            let indexPath =  IndexPath(item:i, section:0)
            let attributes =  self.layoutAttributesForItem(at: indexPath)
            attributesArray.append(attributes!)
        }
        return attributesArray
    }
    
    // 这个方法返回每个单元格的位置和大小
    override func layoutAttributesForItem(at indexPath: IndexPath)
    -> UICollectionViewLayoutAttributes? {
        //当前单元格布局属性
        let attribute =  UICollectionViewLayoutAttributes(forCellWith:indexPath)
        
        // 根据数据不同展示不同的样式
        let cellCount = self.collectionView!.numberOfItems(inSection: 0)
        
        // 只显示一张图片
        if cellCount == 1 {
            // 单元格边长
            let largeCellSide = collectionViewContentSize.width
            let largeCellHeight = collectionViewContentSize.height
            attribute.frame = CGRect(x:0, y:0, width:largeCellSide,
                                     height:largeCellHeight)
            
        }else if cellCount == 2 {
            // 单元格边长
            let largeCellSide = (collectionViewContentSize.width - margin) / 2
            let largeCellHeight = collectionViewContentSize.height
            if indexPath.item % 4 == 0 {
                attribute.frame = CGRect(x:0, y:0, width:largeCellSide,
                                         height:largeCellHeight)
            }else if indexPath.item % 4 == 1 {
                attribute.frame = CGRect(x:largeCellSide + margin, y:0, width:largeCellSide,
                                         height:largeCellHeight)
            }
            
        }else if cellCount == 3 {
            // 单元格边长
            let largeCellSide = (collectionViewContentSize.width - margin) / 2
            let largeCellHeight = collectionViewContentSize.height
            
            let smallCellHeight = (collectionViewContentSize.height - margin) / 2
            let smallCellTopX = largeCellSide + margin
            let smallCellBottomY = smallCellHeight + margin
            if indexPath.item % 4 == 0 {
                attribute.frame = CGRect(x:0, y:0, width:largeCellSide,
                                         height:largeCellHeight)
            }else if indexPath.item % 4 == 1 {
                attribute.frame = CGRect(x:smallCellTopX, y:0, width:largeCellSide,
                                         height:smallCellHeight)
            }else if indexPath.item % 4 == 2 {
                attribute.frame = CGRect(x:smallCellTopX, y:smallCellBottomY, width:largeCellSide,
                                         height:smallCellHeight)
            }
        }else if cellCount == 4 {
            // 单元格边长
            let largeCellSide = (collectionViewContentSize.width - margin) / 2
            let largeCellHeight = (collectionViewContentSize.height - margin) / 2
            
            let smallCellTopX = largeCellSide + margin
            let smallCellBottomY = largeCellHeight + margin
            if indexPath.item % 4 == 0 {
                attribute.frame = CGRect(x:0, y:0, width:largeCellSide,
                                         height:largeCellHeight)
            }else if indexPath.item % 4 == 1 {
                attribute.frame = CGRect(x:smallCellTopX, y:0, width:largeCellSide,
                                         height:largeCellHeight)
            }else if indexPath.item % 4 == 2 {
                attribute.frame = CGRect(x:0, y:smallCellBottomY, width:largeCellSide,
                                         height:largeCellHeight)
            }else if indexPath.item % 4 == 3 {
                attribute.frame = CGRect(x:smallCellTopX, y:smallCellBottomY, width:largeCellSide,
                                         height:largeCellHeight)
            }
        }
        return attribute
    }
}


