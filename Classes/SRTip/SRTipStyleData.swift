//
//  SRTipStyleData.swift
//  SRToast
//
//  Created by 施峰磊 on 2022/6/15.
//

import Foundation
import UIKit

public class SRTipStyleData: SRStyleData {
    var dismissTransform:CGAffineTransform = CGAffineTransform.init(translationX: 0, y: -15)
    var showInitialTransform:CGAffineTransform = CGAffineTransform.init(translationX: 0, y: -15)
    var showFinalTransform:CGAffineTransform = .identity
    var springDamping:CGFloat = 0.7//阻尼率
    var springVelocity:CGFloat = 0.7//加速率
    var showInitialAlpha:CGFloat = 0.0
    var dismissFinalAlpha:CGFloat = 0.0
    var showDuration:TimeInterval = 0.5
    var dismissDuration:TimeInterval = 1
    var edgeInsets:UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 15, bottom: 15, right: 60)
}
