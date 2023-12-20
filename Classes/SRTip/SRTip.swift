//
//  SRAlbumTip.swift
//  SRAlbum
//
//  Created by 施峰磊 on 2020/2/16.
//  Copyright © 2020 施峰磊. All rights reserved.
//

import UIKit

public class SRTip: UIView {
    private var centerLayout: NSLayoutConstraint!
    private var bottomLayout: NSLayoutConstraint!
    
    private var top: NSLayoutConstraint!
    private var left: NSLayoutConstraint!
    private var bottom: NSLayoutConstraint!
    private var right: NSLayoutConstraint!
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 15
        return stack
    }()
    
    private var showView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.backgroundColor = UIColor.init(red: 0x33/0xff, green: 0x33/0xff, blue: 0x33/0xff, alpha: 0.9)
        return view
    }()
    private var titleLabel: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    private var descLabel: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    var showIng = false
    private var afterWorkItem:DispatchWorkItem?
    
    private var tipStyle:SRTipStyleData!{
        didSet{
            self.showView.backgroundColor = tipStyle.backgroundColor
            self.titleLabel.textColor = tipStyle.titleColor
            self.descLabel.textColor = tipStyle.tipColor
            self.bottomLayout.isActive = tipStyle.showType == .bottom
            self.centerLayout.isActive = tipStyle.showType == .center
            self.top.constant = tipStyle.insets.top
            self.left.constant = tipStyle.insets.left
            self.bottom.constant = tipStyle.insets.bottom
            self.right.constant = tipStyle.insets.right
            self.stackView.spacing = tipStyle.spacing
            self.titleLabel.font = tipStyle.titleFont
            self.descLabel.font = tipStyle.tipFont
        }
    }
    open var completeHandle:((_ tap:Bool)->Void)?
    var showSec:Double = 2
    
    static func createView() -> SRTip{
        return SRTip.init();
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addViews(){
        self.addSubview(self.showView)
        self.showView.translatesAutoresizingMaskIntoConstraints = false
        let centerXLayout:NSLayoutConstraint = self.showView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
        let widthLayout:NSLayoutConstraint = self.showView.widthAnchor.constraint(lessThanOrEqualToConstant: 223)
        self.centerLayout = self.showView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        self.bottomLayout = self.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.showView.bottomAnchor, constant: 40)
        centerXLayout.isActive = true
        widthLayout.isActive = true
        self.centerLayout.isActive = true
        self.bottomLayout.isActive = true
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.descLabel)
        self.showView.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.top = self.stackView.topAnchor.constraint(equalTo: self.showView.topAnchor, constant: 15)
        self.left = self.stackView.leadingAnchor.constraint(equalTo: self.showView.leadingAnchor, constant: 15)
        self.bottom = self.showView.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 15)
        self.right = self.showView.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: 15)
        self.top.isActive = true
        self.left.isActive = true
        self.bottom.isActive = true
        self.right.isActive = true
        self.showView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tapDismiss(tap:))))
    }
    
    public override var frame: CGRect{
        didSet{
            
        }
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == self {
          return nil
        }
        return view
    }
    
    @objc private func tapDismiss(tap:UITapGestureRecognizer){
        if self.afterWorkItem != nil {
            self.afterWorkItem?.cancel()
            self.afterWorkItem = nil
        }
        self.tipDismiss(isTap: true)
    }
    
    private func tipDismiss(isTap:Bool) -> Void {
        UIView.animate(withDuration: self.tipStyle.dismissDuration, delay: 0, usingSpringWithDamping: self.tipStyle.springDamping, initialSpringVelocity: self.tipStyle.springVelocity, options: .curveEaseInOut, animations: {
            self.showView.transform = self.tipStyle.dismissTransform;
            self.showView.alpha = self.tipStyle.dismissFinalAlpha;
        }) { (finished) in
            self.showView.transform = .identity;
            self.showIng = false;
            self.removeFromSuperview()
            self.completeHandle?(isTap)
        }
    }
    
    func show(title:String? = nil, content:String, stype:SRTipStyleData) -> Void {
        self.tipStyle = stype
        self.setTipContent(title: title, value: content)
    }
    
    @objc open func setTipContent(title:String? = nil,value:String) -> Void {
        self.titleLabel.isHidden = title?.isEmpty ?? true
        self.titleLabel.text = title
        self.descLabel.text = value;
        if self.tipStyle.showType == .bottom {
            self.bottomLayout.constant = 40 + SRToastManage.shared.keyboardHeight
        }
        if !self.showIng {
            self.showView.transform = CGAffineTransform.init(translationX: 0, y: -15)
            self.showView.alpha = 0.0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
                self.showView.transform = .identity
                self.showView.alpha = 1.0;
            }, completion: nil)
        }
        self.showIng = true
        if self.afterWorkItem != nil {
            self.afterWorkItem?.cancel()
            self.afterWorkItem = nil
        }
        self.afterWorkItem = DispatchWorkItem.init {[weak self] in
            self?.tipDismiss(isTap:false)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+self.showSec, execute: self.afterWorkItem!)
    }
    
    open func dismiss(){
        self.tipDismiss(isTap:false)
    }
}
