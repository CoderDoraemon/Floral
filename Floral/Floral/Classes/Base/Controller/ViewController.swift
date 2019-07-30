//
//  ViewController.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import RxCocoa
import EmptyDataSet_Swift
import RxReachability
import Reachability

class ViewController<VM: ViewModel>: UIViewController {
    
    /// 标题
    let navigationTitle = BehaviorRelay<String?>(value: nil)
    
    lazy var viewModel: VM = {
        
        guard let classType = "\(VM.self)".classType(VM.self) else {
            return VM()
        }
        
        let viewModel = classType.init()
        
        viewModel
            .loading
            .drive(isLoading)
            .disposed(by: rx.disposeBag)
        
        viewModel
            .error
            .drive(rx.showError)
            .disposed(by: rx.disposeBag)
        
        return viewModel
    }()
    
    /// 监听网络状态改变
    lazy var reachability: Reachability? = Reachability()
    /// 是否正在加载
    let isLoading = BehaviorRelay(value: false)
    /// 当前连接的网络类型
    let reachabilityConnection = BehaviorRelay(value: Reachability.Connection.none)
    /// 数据源 nil 时点击了 view
    let emptyDataSetViewTap = PublishSubject<Void>()
    /// 数据源 nil 时显示的标题，默认 " "
    var emptyDataSetTitle: String = ""
    /// 数据源 nil 时显示的描述，默认 " "
    var emptyDataSetDescription: String = ""
    /// 数据源 nil 时显示的图片
    var emptyDataSetImage = UIImage(named: "")
    /// 没有网络时显示的图片
    var noConnectionImage = UIImage(named: "")
    /// 没有网络时显示的标题
    var noConnectionTitle: String = ""
    /// 没有网络时显示的描述
    var noConnectionDescription: String = ""
    /// 没有网络时点击了 view
    var noConnectionViewTap = PublishSubject<Void>()
    /// 数据源 nil 时是否可以滚动，默认 true
    var emptyDataSetShouldAllowScroll: Bool = true
    /// 没有网络时是否可以滚动， 默认 false
    var noConnectionShouldAllowScroll: Bool = false
    /// 状态栏 + 导航栏高度
    lazy var topH: CGFloat = UIApplication.shared.statusBarFrame.size.height + (navigationController?.navigationBar.height ?? 0)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        registerNotification()
        setupUI()
        bindVM()
        
        navigationTitle.bind(to: navigationItem.rx.title).disposed(by: rx.disposeBag)
    }
    
    // MARK: - deinit
    deinit {
        print("\(type(of: self)): Deinited")
    }
    
    // MARK: - didReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\(type(of: self)): Received Memory Warning")
    }
    
    func setupUI() {
        view.backgroundColor = .white
    }
    
    func bindVM() {}
    
    /// 重复点击 TabBar
    func repeatClickTabBar() {}
}

// MARK: - EmptyDataSetSource
extension ViewController: EmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        
        var title = ""
        switch reachabilityConnection.value {
        case .none:
            title = noConnectionTitle
        case .cellular:
            title = emptyDataSetTitle
        case .wifi:
            title = emptyDataSetTitle
        }
        return NSAttributedString(string: title)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        
        var description = ""
        switch reachabilityConnection.value {
        case .none:
            description = noConnectionDescription
        case .cellular:
            description = emptyDataSetDescription
        case .wifi:
            description = emptyDataSetDescription
        }
        return NSAttributedString(string: description)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        
        switch reachabilityConnection.value {
        case .none:
            return noConnectionImage
        case .cellular:
            return emptyDataSetImage
        case .wifi:
            return emptyDataSetImage
        }
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        return .clear
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -topH
    }
}

// MARK: - EmptyDataSetDelegate
extension ViewController: EmptyDataSetDelegate {
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return !isLoading.value
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        
        switch reachabilityConnection.value {
        case .none:
            noConnectionViewTap.onNext(())
        case .cellular:
            emptyDataSetViewTap.onNext(())
        case .wifi:
            emptyDataSetViewTap.onNext(())
        }
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        
        switch reachabilityConnection.value {
        case .none:
            return noConnectionShouldAllowScroll
        case .cellular:
            return emptyDataSetShouldAllowScroll
        case .wifi:
            return emptyDataSetShouldAllowScroll
        }
    }
}

// MARK: - 通知
extension ViewController {
    
    // MARK: - 注册通知
    private func registerNotification() {
        
    }
    
    // MARK: - tabBar重复点击
    func tabBarRepeatClick() {
        
        guard view.isShowingOnKeyWindow() else {return}
        repeatClickTabBar()
    }
}

