//
//  UICollectionView+Extension.swift
//  College
//
//  Created by Liudongdong on 2019/4/4.
//  Copyright © 2019 zeroLu. All rights reserved.
//

import UIKit

// MARK: - Properties
public extension UICollectionView {
    
    /// Index path of last item in collectionView.
    var indexPathForLastItem: IndexPath? {
        return indexPathForLastItem(inSection: lastSection)
    }
    
    /// Index of last section in collectionView.
    var lastSection: Int {
        return numberOfSections > 0 ? numberOfSections - 1 : 0
    }
    
}

// MARK: - Methods
public extension UICollectionView {
    
    /// Number of all items in all sections of collectionView.
    ///
    /// - Returns: The count of all rows in the collectionView.
    func numberOfItems() -> Int {
        var section = 0
        var itemsCount = 0
        while section < numberOfSections {
            itemsCount += numberOfItems(inSection: section)
            section += 1
        }
        return itemsCount
    }
    
    /// IndexPath for last item in section.
    ///
    /// - Parameter section: section to get last item in.
    /// - Returns: optional last indexPath for last item in section (if applicable).
    func indexPathForLastItem(inSection section: Int) -> IndexPath? {
        guard section >= 0 else {
            return nil
        }
        guard section < numberOfSections else {
            return nil
        }
        guard numberOfItems(inSection: section) > 0 else {
            return IndexPath(item: 0, section: section)
        }
        return IndexPath(item: numberOfItems(inSection: section) - 1, section: section)
    }
    
    /// 刷新数据
    ///
    /// - Parameter completion: 刷新完成回调
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
    /// 获取 UICollectionViewCell
    ///
    /// - Parameters:
    ///   - name: 继承UICollectionViewCell类Class
    ///   - indexPath: indexPath
    /// - Returns: UICollectionViewCell
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(String(describing: name)), make sure the cell is registered with collection view")
        }
        return cell
    }
    
    /// 获取 UICollectionView头部和尾部
    ///
    /// - Parameters:
    ///   - kind: UICollectionView.elementKindSectionHeader / UICollectionView.elementKindSectionFooter
    ///   - name: 继承UICollectionReusableView类Class
    ///   - indexPath: indexPath
    /// - Returns: UICollectionView头部和尾部
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionReusableView for \(String(describing: name)), make sure the view is registered with collection view")
        }
        return cell
    }
    
    /// 注册 UICollectionView头部和尾部
    ///
    /// - Parameters:
    ///   - nib: Nib
    ///   - kind: UICollectionView.elementKindSectionHeader / UICollectionView.elementKindSectionFooter
    ///   - name: 继承UICollectionReusableView类Class
    func register<T: UICollectionReusableView>(supplementaryViewOfKind kind: String, withClass name: T.Type) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
    }
    
    /// 注册 Nib UICollectionViewCell
    ///
    /// - Parameters:
    ///   - nib: Nib
    ///   - name: 继承UICollectionReusableView类Class
    func register<T: UICollectionViewCell>(nib: UINib?, forCellWithClass name: T.Type) {
        register(nib, forCellWithReuseIdentifier: String(describing: name))
    }
    
    /// 注册UICollectionViewCell
    ///
    /// - Parameter name: 继承UICollectionReusableView类Class
    func register<T: UICollectionViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: name))
    }
    
    /// 注册 Nib UICollectionView头部和尾部
    ///
    /// - Parameters:
    ///   - nib: Nib
    ///   - kind: UICollectionView.elementKindSectionHeader / UICollectionView.elementKindSectionFooter
    ///   - name: 继承UICollectionReusableView类Class
    func register<T: UICollectionReusableView>(nib: UINib?, forSupplementaryViewOfKind kind: String, withClass name: T.Type) {
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
        
    }
    
    /// 注册Nib Cell
    ///
    /// - Parameters:
    ///   - name: 继承UICollectionViewCell类Class
    ///   - bundleClass: bundleClass
    func register<T: UICollectionViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?
        
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        
        register(UINib(nibName: identifier, bundle: bundle), forCellWithReuseIdentifier: identifier)
    }
    
}
