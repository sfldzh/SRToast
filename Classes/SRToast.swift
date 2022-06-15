//
//  SRToast.swift
//  SRToast
//
//  Created by 施峰磊 on 2022/6/15.
//

import Foundation
import UIKit

class SRToastManage {
    open var hubStyleData:SRHubStyleData = {
        let hubData = SRHubStyleData.init()
        hubData.isTranslucent = true
        return hubData
    }()
    
    open var tipStyleData:SRTipStyleData = {
        let hubData = SRTipStyleData.init()
        return hubData
    }()
    /// TODO:单利
    static let shared: SRToastManage = {
        let instance = SRToastManage()
        return instance
    }()
    
    
}

extension UIView{
    
    @discardableResult
    func showHub(value:String = "", style:SRHubStyleData? = nil) -> SRHub {
        let hub = SRHub.createView()!
        hub.style = style
        hub.frame = self.bounds
        self.addSubview(hub)
        hub.setHubContent(value: value)
        return hub
    }
    
    @discardableResult
    func showTip(value:String,style:SRTipStyleData? = nil,completeHandle:((_ tap:Bool)->Void)? = nil) -> SRTip {
        let tip = SRTip.createView()!
        tip.completeHandle = completeHandle
        tip.frame = self.bounds
        self.addSubview(tip)
        tip.show(content: value, stype: style ?? SRToastManage.shared.tipStyleData)
        return tip
    }
}
