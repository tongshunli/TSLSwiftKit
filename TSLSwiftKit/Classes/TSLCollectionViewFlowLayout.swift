//
//  TSLCollectionViewFlowLayout.swift
//  TSLSwiftKit
//
//  Created by 佟顺利 on 2024/11/12.
//

import Foundation

public enum AlignType: Int {
    case left
    case center
    case right
}

public class TSLCollectionViewFlowLayout: UICollectionViewFlowLayout {
 
    // MARK: 在居中对齐的时候需要知道这行所有cell的宽度总和
    var sumCellWidth = 0.0
    
    override convenience init() {
        self.init(.center, betweenOfCell: 10.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ cellType: AlignType) {
        self.init(cellType, betweenOfCell: 10.0)
    }
    
    public init(_ cellType: AlignType, betweenOfCell: CGFloat) {
        super.init()
        
        self.scrollDirection = .vertical
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        self.sectionInset = UIEdgeInsets.zero
        
        self.betweenOfCell = betweenOfCell
        self.cellType = cellType
    }
    
    var betweenOfCell: CGFloat? {
        didSet {
            self.minimumInteritemSpacing = betweenOfCell ?? 10.0
        }
    }
    
    var cellType: AlignType? {
        didSet {
            
        }
    }
    
    func layoutAttributesForElementsInRect(_ rect: CGRect) -> NSArray {
        guard let tmpLayoutAttributes = super.layoutAttributesForElements(in: rect) else { return [] }
        
        let layoutAttributes = NSArray(array: tmpLayoutAttributes, copyItems: true)
        
        // MARK: 用来临时存放一行的Cell数组
        let layoutAttributesTemp = NSMutableArray()
        
        for index in 0..<layoutAttributes.count {
            // MARK: 当前cell的位置信息
            let currentAttr = layoutAttributes[index] as? UICollectionViewLayoutAttributes
            
            // MARK: 上一个cell的位置信
            let previousAttr = index == 0 ? nil : layoutAttributes[index - 1] as? UICollectionViewLayoutAttributes
            
            // MARK: 下一个cell位置信息
            let nextAttr = index + 1 == layoutAttributes.count ? nil : layoutAttributes[index + 1] as? UICollectionViewLayoutAttributes
            
            // MARK: 加入临时数组
            layoutAttributesTemp.add(currentAttr)
            
            self.sumCellWidth += Double(currentAttr?.frame.size.width ?? 0.0)
            
            let previousY = previousAttr == nil ? 0 : CGRectGetMaxY(previousAttr?.frame ?? CGRect.zero)
            
            let currentY = CGRectGetMaxY(currentAttr?.frame ?? CGRect.zero)
            
            let nextY = nextAttr == nil ? 0 : CGRectGetMaxY(nextAttr?.frame ?? CGRect.zero)
            
            if currentY != previousY && currentY != nextY { // MARK: 如果当前cell是单独一行
                if currentAttr?.representedElementKind == UICollectionView.elementKindSectionHeader || currentAttr?.representedElementKind == UICollectionView.elementKindSectionFooter {
                    layoutAttributesTemp.removeAllObjects()
                    self.sumCellWidth = 0.0
                } else {
                    self.cellFrameWith(layoutAttributesTemp)
                }
            } else if currentY != nextY { // MARK: 如果下一个cell在本行，这开始调整Frame位置
                self.cellFrameWith(layoutAttributesTemp)
            }
        }
        return layoutAttributes
    }
    
    // MARK: 调整属于同一行的cell的位置frame
    func cellFrameWith(_ layoutAttributes: NSMutableArray) {
        var nowWidth = 0.0
        
        switch self.cellType {
        case .left:
            nowWidth = self.sectionInset.left
            
            for attributes in layoutAttributes {
                guard let attributes = attributes as? UICollectionViewLayoutAttributes else { return }
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + (self.betweenOfCell ?? 0.0)
            }
            self.sumCellWidth = 0
            layoutAttributes.removeAllObjects()
        case .center:
            guard let totalCount = layoutAttributes.count - 1 as? CGFloat else { return }
            
            let totalBet = totalCount * (self.betweenOfCell ?? 0.0)
            
            guard let collectionViewWidth = self.collectionView?.frame.size.width else { return }
            
            nowWidth = (collectionViewWidth - self.sumCellWidth - totalBet) / 2
            
            for attributes in layoutAttributes {
                guard let attributes = attributes as? UICollectionViewLayoutAttributes else { return }
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + (self.betweenOfCell ?? 0.0)
            }
            self.sumCellWidth = 0
            layoutAttributes.removeAllObjects()
        case .right:
            guard let collectionViewWidth = self.collectionView?.frame.size.width else { return }

            nowWidth = collectionViewWidth - self.sectionInset.right
            
            for index in (layoutAttributes.count - 1)...0 {
                let attributes = layoutAttributes[index] as? UICollectionViewLayoutAttributes
                
                guard var nowFrame = attributes?.frame else { return }
                nowFrame.origin.x = nowWidth - (nowFrame.size.width ?? 0.0)
                attributes?.frame = nowFrame ?? CGRect.zero
                nowWidth = nowWidth - nowFrame.size.width - (self.betweenOfCell ?? 0.0)
            }
            self.sumCellWidth = 0.0
            layoutAttributes.removeAllObjects()
        default:
            break
        }
    }
    
}
