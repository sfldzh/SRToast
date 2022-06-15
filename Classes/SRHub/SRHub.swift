//
//  SRHub.swift
//  SRToast
//
//  Created by 施峰磊 on 2022/6/15.
//

import UIKit

class SRHub: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var effectView: UIVisualEffectView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var contentWidth: NSLayoutConstraint!
    
    open var style:SRHubStyleData?
    open var value:String = ""
    
    static func createView() -> SRHub?{
        let datas = Bundle.main.loadNibNamed("SRHub", owner:nil, options:nil)!;
        var view:SRHub?
        for data in datas {
            if let temp = data as? SRHub{
                view = temp
                break
            }
        }
        return view;
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func configer() -> Void {
        self.indicatorView.hidesWhenStopped = true
        self.backgroundColor = UIColor.init(white: 0.2, alpha: 0.1)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configer()
        self.configerStyle(styleData: self.style ?? SRToastManage.shared.hubStyleData)
        self.indicatorView.startAnimating()
    }
    
    private func configerStyle(styleData:SRHubStyleData) -> Void {
        self.effectView.isHidden = !styleData.isTranslucent
        self.contentView.backgroundColor = styleData.backgroundColor
        self.indicatorView.color = styleData.indicatorColor
        self.tipLabel.textColor = styleData.tipColor
    }
    
    open func setHubContent(value:String){
        self.tipLabel.isHidden = value.isEmpty ? true : false
        self.tipLabel.text = value
        DispatchQueue.main.async {
            self.contentWidth.constant = self.contentView.frame.height
            self.layoutIfNeeded()
        }
    }
    
    open func remove(){
        self.removeFromSuperview()
    }

}
