//
//  AppMacro.swift
//  Floral
//
//  Created by LDD on 2019/7/18.
//  Copyright © 2019 文刂Rn. All rights reserved.
//

import UIKit
import DeviceKit
import AutoInch

// MARK: 全局常量
/** 屏幕宽度 */
let ScreenWidth = UIScreen.main.bounds.width
/** 屏幕高度 */
let ScreenHeight = UIScreen.main.bounds.height

/// GCD延迟运行
///
/// - Parameters:
///   - delayTime: 延迟时间 比如：.seconds(5)、.milliseconds(500)
///   - qosClass: 要使用的全局QOS类（默认为 nil，表示主线程）
///   - execute: GCD延迟运行
public func delay(by delayTime: TimeInterval, qosClass: DispatchQoS.QoSClass? = nil, _ execute: @escaping () -> Void) {
    let dispatchQueue = (qosClass != nil ? DispatchQueue.global(qos: qosClass!) : .main)
    dispatchQueue.asyncAfter(deadline: DispatchTime.now() + delayTime, execute: execute)
}

/// 屏幕适配 375 6S尺寸
///
/// - Parameter at: 尺寸
/// - Returns: 屏幕适配 375 6S尺寸
func autoDistance(_ at: CGFloat) -> CGFloat {
    return at.auto()
}

func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
    return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
}

/** 设备屏幕比例 */
let screenScale = UIScreen.main.scale
/** 状态栏高度 */
let statusBarHeight = UIApplication.shared.statusBarFrame.height
/** iphoneX 底部间距 */
let iPhoneXBottomSafeHeight: CGFloat = 34.0

/** CGFloat 的无穷大 */
let CGFloatHUGE = CGFloat(HUGE)

// MARK: 判断设备
let isPhoneX: Bool = Device.isPhoneXSerise
let isPhone5Below: Bool = Device.isPhone5Earlier

let kStatusBarHeight: CGFloat = isPhoneX ? 44.0: 20.0
let kBottomSafeHeight: CGFloat = isPhone5Below ? iPhoneXBottomSafeHeight : 0.0
let kTopBarHeight: CGFloat = 44.0
let kStatusBarAndTopBarHeight: CGFloat = kStatusBarHeight + kTopBarHeight
let kTabBarHeight: CGFloat = 49.0
let kCellHeight: CGFloat = autoDistance(44.0)

// MARK: 通用的 Block 回调
/** 无参数 Block 回调 */
typealias NoParamterBlock = (()->())
/** 单个字符串回调 */
typealias StringParameterBlock = ((String)->())

// MARK: 空URL
let emptyUrl: URL = URL(string: "https://")!




