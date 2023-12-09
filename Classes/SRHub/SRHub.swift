//
//  SRHub.swift
//  SRToast
//
//  Created by 施峰磊 on 2022/6/15.
//

import UIKit

open class SRHub: UIView {
    private var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    private var effectView: UIVisualEffectView = {
        let view = UIVisualEffectView.init(effect: UIBlurEffect(style: .dark))
        return view
    }()
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 15
        return stack
    }()
    
    private var zsView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView.init(style: .large)
        if #available(iOS 13.0, *) {
            view.style = .large
        }else{
            view.style = .whiteLarge
        }
        view.color = .white
        view.hidesWhenStopped = true
        return view
    }()
    private var tipLabel: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    private var contentWidth: NSLayoutConstraint!
    private var ratioLayout: NSLayoutConstraint!
    
    open var style:SRHubStyleData?{
        didSet{
            if style != nil{
                self.configerStyle(styleData: style!)
            }
        }
    }
    open var value:String = ""
    open var filters:[CGRect] = []
    
    static func createView() -> SRHub{
        return SRHub.init()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addViews()
        self.configer()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addViews(){
        self.addSubview(self.contentView);
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        [self.contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
         self.contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)].forEach{$0.isActive = true}
        self.ratioLayout = self.contentView.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 1.0)
        self.contentWidth = self.contentView.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
        self.ratioLayout.isActive = true
        self.contentWidth.isActive = true
        self.contentView.addSubview(self.effectView)
        self.effectView.translatesAutoresizingMaskIntoConstraints = false
        [self.effectView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
         self.effectView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
         self.contentView.bottomAnchor.constraint(equalTo: self.effectView.bottomAnchor, constant: 0),
         self.contentView.trailingAnchor.constraint(equalTo: self.effectView.trailingAnchor, constant: 0)].forEach{$0.isActive = true}

        self.zsView.addSubview(self.indicatorView)
        [self.indicatorView.topAnchor.constraint(equalTo: self.zsView.topAnchor, constant: 0),
         self.zsView.bottomAnchor.constraint(equalTo: self.indicatorView.bottomAnchor, constant: 0),
         self.indicatorView.centerXAnchor.constraint(equalTo: self.zsView.centerXAnchor, constant: 0)].forEach{$0.isActive = true}
        
        self.stackView.addArrangedSubview(self.zsView)
        self.stackView.addArrangedSubview(self.tipLabel)
        
        self.contentView.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        [self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
         self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
         self.contentView.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 20),
         self.contentView.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: 20)].forEach{$0.isActive = true}
    }
    
    private func configer() -> Void {
        self.backgroundColor = UIColor.clear
        self.configerStyle(styleData: self.style ?? SRToastManage.shared.hubStyleData)
        self.indicatorView.startAnimating()
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.filters.contains(where: { rect in
            return rect.contains(point)
        }) {
            return nil
        }else{
            return super.hitTest(point, with: event)
        }
    }
    
    private func configerStyle(styleData:SRHubStyleData) -> Void {
        if styleData.isTranslucent{
            self.effectView.isHidden = false
            self.effectView.effect = UIBlurEffect.init(style: styleData.isDark ? .dark : .extraLight)
            self.contentView.backgroundColor = .clear
            if styleData.isDark{
                self.indicatorView.color = UIColor.white
                self.tipLabel.textColor = UIColor.white
            }else{
                self.indicatorView.color = UIColor.init(white: 0.0, alpha: 0.7)
                self.tipLabel.textColor = UIColor.init(white: 0.0, alpha: 0.7)
            }
        }else{
            self.effectView.isHidden = true
            self.contentView.backgroundColor = styleData.backgroundColor
            self.indicatorView.color = styleData.indicatorColor
            self.tipLabel.textColor = styleData.tipColor
        }
    }
    
    func showAnimate(){
        self.contentView.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        self.contentView.alpha = 0
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            self.contentView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.contentView.alpha = 1
        } 
    }
    
    @objc open func setHubContent(value:String){
        self.tipLabel.text = value
        self.tipLabel.isHidden = value.isEmpty ? true : false
        self.contentView.layoutIfNeeded()
        self.ratioLayout.isActive = self.contentView.frame.height < 112
//        DispatchQueue.main.async {
//            self.contentWidth.constant = self.contentView.frame.height
//            self.layoutIfNeeded()
//        }
    }
    
    @objc open func remove(){
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            self.contentView.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
            self.contentView.alpha = 0
        } completion: { isFinish in
            self.removeFromSuperview()
        }
    }

}
