//
//  ViewController.swift
//  SRToast
//
//  Created by 施峰磊 on 2022/6/15.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SRToastManage.shared.tipStyleData.backgroundColor = UIColor.red
        SRToastManage.shared.tipStyleData.tipColor = UIColor.green
        SRToastManage.shared.tipStyleData.showType = .center
        SRToastManage.shared.hubStyleData.isTranslucent = true
        SRToastManage.shared.hubStyleData.isDark = false
        SRToastManage.shared.hubStyleData.backgroundColor = UIColor.clear
        SRToastManage.shared.hubStyleData.indicatorColor = UIColor.green
        SRToastManage.shared.hubStyleData.tipColor = UIColor.green
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.testAction()
        }
        var str = "我们在这里"
        if let rang:Range = str.range(of: "在这"){
            if !rang.isEmpty{
//                let location = str.distance(from: str.startIndex, to: rang.lowerBound)
                
                str = String(str[rang.lowerBound..<rang.upperBound])
                print(rang.lowerBound)
            }
        }
        
//        let index = str.firstIndex { character in
//            character == "这"
//        }
//        str = str.substring(from: String.Index)
    }
    
    func testAction() -> Void {
//        let hub = self.view.showHub(filters:[self.btn.frame])
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            hub.setHubContent(value: "稍等")
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
//            hub.setHubContent(value: "稍等一会，马上就完成，不会太久的，放心，你只要安静下来，保持心平静和，时机一会就过去了")
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
//            hub.remove()
//        }
        
        let tip = self.view.showTip(title:"提示", value: "等一会，马上就完成，不会太久的，放心，你只要安静下来，保持心平静和，时机一会就过去了") { tap in
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

    @IBAction func didClick(_ sender: UIButton) {
        print("点击了")
    }
    
}

