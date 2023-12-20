//
//  SRToast.swift
//  SRToast
//
//  Created by 施峰磊 on 2022/6/15.
//

import Foundation
//import UIKit
import SwiftUI

@objc open class SRToastManage:NSObject {
    @objc open var hubStyleData:SRHubStyleData = {
        let hubData = SRHubStyleData.init()
        hubData.isTranslucent = true
        return hubData
    }()
    
    @objc open var tipStyleData:SRTipStyleData = {
        let tipData = SRTipStyleData.init()
        tipData.backgroundColor = .black
        tipData.tipColor = .white
        tipData.tipFont = UIFont.systemFont(ofSize: 15, weight: .regular)
        return tipData
    }()
    
    var keyboardHeight:CGFloat = 0
    var durationValue:TimeInterval = 0
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// TODO:单利
    @objc public static let shared: SRToastManage = {
        let instance = SRToastManage()
        instance.registerAllNotifications()
        return instance
    }()
    
    /// 添加注册
    private func registerAllNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// 键盘将要显示
    /// - Parameter notification: 通知
    @objc internal func keyboardWillShow(_ notification : Notification) {
        if let info:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue, let duration:NSNumber = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            self.keyboardHeight = info.cgRectValue.size.height
            self.durationValue = duration.doubleValue
        }
    }
    
    /// 键盘将要隐藏
    /// - Parameter notification: 通知
    @objc internal func keyboardWillHide(_ notification : Notification) {
        if let duration:NSNumber = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            self.keyboardHeight = 0
            self.durationValue = duration.doubleValue
        }
    }
    
}

public extension UIView{
    
    @discardableResult
    @objc func showHub(value:String? = nil, isAnimate:Bool = true, style:SRHubStyleData? = nil, filters:[CGRect] = []) -> SRHub {
        let hub = SRHub.createView()
        hub.style = style
        hub.filters = filters
        self.addSubview(hub)
        hub.translatesAutoresizingMaskIntoConstraints = false
        hub.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true  //顶部约束
        hub.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true  //左端约束
        self.trailingAnchor.constraint(equalTo: hub.trailingAnchor, constant: 0).isActive = true  //右端约束
        self.bottomAnchor.constraint(equalTo: hub.bottomAnchor, constant: 0).isActive = true  //底部约束
        hub.setHubContent(value: value ?? "")
        if isAnimate {
            hub.showAnimate()
        }
        return hub
    }
    
    @discardableResult
    @objc func showTip(title:String? = nil,value:String,style:SRTipStyleData? = nil,sec:Double = 2,completeHandle:((_ tap:Bool)->Void)? = nil) -> SRTip {
        if let tip:SRTip = self.subviews.first(where: { subView in
            return subView.isKind(of: SRTip.self)
        }) as? SRTip {
            tip.completeHandle = completeHandle
            tip.showSec = sec
//            tip.frame = self.bounds
            tip.show(title:title, content: value, stype: style ?? SRToastManage.shared.tipStyleData)
            return tip
        }else{
            let tip = SRTip.createView()
            tip.completeHandle = completeHandle
            tip.showSec = sec
//            tip.frame = self.bounds
            self.addSubview(tip)
            tip.translatesAutoresizingMaskIntoConstraints = false
            tip.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true  //顶部约束
            tip.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true  //左端约束
            self.trailingAnchor.constraint(equalTo: tip.trailingAnchor, constant: 0).isActive = true  //右端约束
            self.bottomAnchor.constraint(equalTo: tip.bottomAnchor, constant: 0).isActive = true  //底部约束
            tip.show(title:title, content: value, stype: style ?? SRToastManage.shared.tipStyleData)
            return tip
        }
    }
}

public class SRToast{
    private weak var hub:SRHub?
    
    public private(set) static var shared = SRToast()
    
    @discardableResult
    public func showHub(value:String? = nil, isAnimate:Bool = true, style:SRHubStyleData? = nil, filters:[CGRect] = []) -> SRHub? {
        if let window = UIApplication.keyWindow() {
            var isOld:Bool = false
            if self.hub == nil {
                let hub = SRHub.createView()
                self.hub = hub
                window.addSubview(hub)
                hub.translatesAutoresizingMaskIntoConstraints = false
                hub.topAnchor.constraint(equalTo: window.topAnchor, constant: 0).isActive = true  //顶部约束
                hub.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 0).isActive = true  //左端约束
                window.trailingAnchor.constraint(equalTo: hub.trailingAnchor, constant: 0).isActive = true  //右端约束
                window.bottomAnchor.constraint(equalTo: hub.bottomAnchor, constant: 0).isActive = true  //底部约束
            }else{
                isOld = true
            }
            self.hub?.style = style
            self.hub?.filters = filters
            self.hub?.setHubContent(value: value ?? "")
            if isAnimate && !isOld {
                self.hub?.showAnimate()
            }
            return hub
        }else{
            return nil;
        }
    }
    
    @discardableResult
    public func showTip(title:String? = nil,value:String,style:SRTipStyleData? = nil,sec:Double = 2,completeHandle:((_ tap:Bool)->Void)? = nil) -> SRTip? {
        if let window = UIApplication.keyWindow() {
            if let tip:SRTip = window.subviews.first(where: { subView in
                return subView.isKind(of: SRTip.self)
            }) as? SRTip {
                tip.completeHandle = completeHandle
                tip.showSec = sec
                tip.show(title:title, content: value, stype: style ?? SRToastManage.shared.tipStyleData)
                return tip
            }else{
                let tip = SRTip.createView()
                tip.completeHandle = completeHandle
                tip.showSec = sec
                window.addSubview(tip)
                tip.translatesAutoresizingMaskIntoConstraints = false
                tip.topAnchor.constraint(equalTo: window.topAnchor, constant: 0).isActive = true  //顶部约束
                tip.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 0).isActive = true  //左端约束
                window.trailingAnchor.constraint(equalTo: tip.trailingAnchor, constant: 0).isActive = true  //右端约束
                window.bottomAnchor.constraint(equalTo: tip.bottomAnchor, constant: 0).isActive = true  //底部约束
                tip.show(title:title, content: value, stype: style ?? SRToastManage.shared.tipStyleData)
                return tip
            }
        }else{
            return nil;
        }
    }
}

extension UIApplication{
    static func keyWindow()->UIWindow?{
        var window:UIWindow?
        if #available(iOS 15.0, *){
            window = self.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }// Keep only active scenes, onscreen and visible to the user
                .first(where: { $0 is UIWindowScene })// Keep only the first `UIWindowScene`
                .flatMap({ $0 as? UIWindowScene })?.windows// Get its associated windows
                .first(where: \.isKeyWindow)// Finally, keep only the key window
        }else{
            window = self.shared.windows.filter({ $0.isKeyWindow }).first
        }
        return window
    }
}
