//
//  HGAlertBaseView.swift
//  HGAlertView
//
//  Created by will on 2020/11/11.
//

import UIKit

class HGAlertBaseView: UIView {

    ///动画时间
    private var duration: Float = 0.2
    ///对话框
    private var dialogView: UIView!
    
    private var containerView: HGAlertBaseContainer!
    
    /// 内容block
    private var containerBlock: (()->(HGAlertBaseContainer))? = nil
    /// 约束block
    private var constraintBlock: ((_ dialogView: UIView,_ containerView: UIView)->())? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.createAlertView()
    }
    ///block方式
    init(frame: CGRect, config: (()->(HGAlertBaseContainer))?, updateUI: ((_ dialogView: UIView,_ containerView: UIView)->())?) {
        super.init(frame: frame)
        
        self.containerBlock = config
        self.containerView = self.containerBlock?()
        self.constraintBlock = updateUI
        self.createAlertView()
    }
    ///配置view
    func config(container: (()->(HGAlertBaseContainer))?, constraint: ((_ dialogView: UIView,_ containerView: UIView)->())?) {
        self.containerBlock = container
        self.containerView = self.containerBlock?()
        self.containerView.close = { [weak self] in
            self?.closeAlert()
        }
        dialogView.addSubview(containerView)
        self.constraintBlock = constraint
    }
    
    func updataViews() {
        self.constraintBlock?(dialogView, containerView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == self {
            self.closeAlert()
        }
    }
    
    private func createAlertView() {
        dialogView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 10
        dialogView.layer.masksToBounds = true
        dialogView.layer.shouldRasterize = true
        dialogView.layer.rasterizationScale = UIScreen.main.scale
        self.addSubview(dialogView)
    }
    
    func showAlert(options: String) {
        if self.superview == nil {
            self.alpha = 1
            self.frontWindow()?.addSubview(self)
        }
        dialogView.layer.opacity = 0.5
        dialogView.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1.0)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            self.dialogView.layer.opacity = 1
            self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1.0)
        } completion: { (finish) in
                
        }

    }
    
    @objc func closeAlert() {
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: .curveEaseInOut) {
            self.alpha = 0
        } completion: { (finish) in
            if finish {
                self.containerView.removeFromSuperview()
                self.containerView = nil
                self.removeFromSuperview()
            }
        }
    }
    
    func frontWindow() -> UIWindow? {
        let frontToBackWindows = UIApplication.shared.windows.reversed()
        for window in frontToBackWindows {
            let windowOnMainScreen = window.screen == UIScreen.main
            let windowIsVisible = !window.isHidden && window.alpha > 0
            let windowLevelSupported = window.windowLevel >= .normal && window.windowLevel <= .normal
            let windowKeyWindow = window.isKeyWindow
            if windowOnMainScreen && windowIsVisible && windowLevelSupported && windowKeyWindow {
                return window
            }
        }
        return nil
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
