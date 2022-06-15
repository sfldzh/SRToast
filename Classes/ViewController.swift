//
//  ViewController.swift
//  SRToast
//
//  Created by 施峰磊 on 2022/6/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let hub = self.view.showHub()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            hub.setHubContent(value: "稍等")
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
//            hub.setHubContent(value: "稍等一会，马上就完成，不会太久的，放心，你只要安静下来，保持心平静和，时机一会就过去了")
//        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
//            hub.remove()
//        }
        
        let tip = self.view.showTip(value: "等一会，马上就完成，不会太久的，放心，你只要安静下来，保持心平静和，时机一会就过去了") { tap in
            if tap{
                print("点击")
            }else{
                print("自动")
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            tip.setTipContent(value: "马上就完成，不会太久的，放心")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            tip.setTipContent(value: "11111")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            tip.setTipContent(value: "2222222")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            tip.setTipContent(value: "333333")
        }
    }


}

