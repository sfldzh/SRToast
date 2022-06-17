//
//  SRTipStyleData.swift
//  SRToast
//
//  Created by 施峰磊 on 2022/6/15.
//

import Foundation
import UIKit

public class SRTipStyleData: SRStyleData {
    open var dismissTransform:CGAffineTransform = CGAffineTransform.init(translationX: 0, y: -15)
    open var showInitialTransform:CGAffineTransform = CGAffineTransform.init(translationX: 0, y: -15)
    open var showFinalTransform:CGAffineTransform = .identity
    open var springDamping:CGFloat = 0.7//阻尼率
    open var springVelocity:CGFloat = 0.7//加速率
    open var showInitialAlpha:CGFloat = 0.0
    open var dismissFinalAlpha:CGFloat = 0.0
    open var showDuration:TimeInterval = 0.5
    open var dismissDuration:TimeInterval = 1
    open var edgeInsets:UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 15, bottom: 15, right: 60)
}
