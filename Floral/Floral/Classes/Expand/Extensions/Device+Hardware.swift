//
//  Device+Hardware.swift
//  JianZhongBang
//
//  Created by Apple on 2018/8/26.
//  Copyright © 2018年 文刂Rn. All rights reserved.
//

import UIKit
import DeviceKit

// MARK: - 手机系列判断
extension Device {
    
    /// 是否是iPhone 4.7系列手机
    public static  var isPhone4_7Serier: Bool {
        return (((Device.current.diagonal ) == 4.7) ? true: false)
    }
    
    /// 是否是iPhone 5.5系列手机
    public static var isPhone5_5Series: Bool {
        return (((Device.current.diagonal ) >= 5.5) ? true: false)
    }
    
    /// 是否是iPhone 5 以下 系列手机
    public static var isPhone5Earlier: Bool {
        return (((Device.current.diagonal ) <= 4.0) ? true: false)
    }
    
    /// 是否是iPhone X手机
    public static var isPhoneXSerise: Bool {
        
        let device = Device.current
        
        var _bool = false
        
        if Device.allXSeriesDevices.contains(device) {
            _bool = true
        } else if Device.allSimulatorXSeriesDevices.contains(device) {
            _bool = true
        }
        
        return _bool
    }
}

// MARK: - 手机信息
extension Device {
    
    /// 设备系统名称
    public static var deviceSystemName: String {
        return UIDevice.current.systemName
    }
    
    /// 设备名称
    public static var deviceName: String {
        return UIDevice.current.name
    }
    
    /// 设备版本
    public static var deviceSystemVersion: String {
        return UIDevice.current.systemVersion
    }
}

extension Device {
    
    /// 设备型号
    public static var machineModelName: String {
        
        switch Device.current {
        case .iPodTouch5:
            return "iPod_Touch_5"
        case .iPodTouch6:
            return "iPod_Touch_6"
        case .iPhone4:
            return "iPhone_4"
        case .iPhone4s:
            return "iPhone_4s"
        case .iPhone5:
            return "iPhone_5"
        case .iPhone5c:
            return "iPhone_5c"
        case .iPhone5s:
            return "iPhone_5s"
        case .iPhone6:
            return "iPhone_6"
        case .iPhone6Plus:
            return "iPhone_6_Plus"
        case .iPhone6s:
            return "iPhone_6s"
        case .iPhone6sPlus:
            return "iPhone_6s_Plus"
        case .iPhone7:
            return "iPhone_7"
        case .iPhone7Plus:
            return "iPhone_7_Plus"
        case .iPhoneSE:
            return "iPhone_SE"
        case .iPhone8:
            return "iPhone_8"
        case .iPhone8Plus:
            return "iPhone_8_Plus"
        case .iPhoneX:
            return "iPhone_X"
        case .iPhoneXS:
            return "iPhone_Xs"
        case .iPhoneXSMax:
            return "iPhone_Xs_Max"
        case .iPhoneXR:
            return "iPhone_Xr"
        case .iPad2:
            return "iPad_2"
        case .iPad3:
            return "iPad_3"
        case .iPad4:
            return "iPad_4"
        case .iPadAir:
            return "iPad_Air"
        case .iPadAir2:
            return "iPad_Air2"
        case .iPad5:
            return "iPad_5"
        case .iPad6:
            return "iPad_6"
        case .iPadMini:
            return "iPad_Mini"
        case .iPadMini2:
            return "iPad_Mini2"
        case .iPadMini3:
            return "iPad_Mini3"
        case .iPadMini4:
            return "iPad_Mini4"
        case .iPadPro9Inch:
            return "iPad_Pro_9Inch"
        case .iPadPro12Inch:
            return "iPad_Pro_12Inch"
        case .iPadPro12Inch2:
            return "iPad_Pro_12Inch2"
        case .iPadPro10Inch:
            return "iPad_Pro_10Inch"
        case .iPadPro11Inch:
            return "iPad_Pro_11Inch"
        case .iPadPro12Inch3:
            return "iPad_Pro_12Inch3"
        default:
            return "其他型号"
        }
    }
}

