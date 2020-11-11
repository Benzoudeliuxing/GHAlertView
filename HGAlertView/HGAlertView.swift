//
//  HGAlertView.swift
//  HGAlertView
//
//  Created by will on 2020/11/11.
//

import UIKit

open class HGAlertView: NSObject {
    
    public static let shared = HGAlertView()
    
    var floorView: HGAlertBaseView!
        
    override init() {
        self.floorView = HGAlertBaseView(frame: UIScreen.main.bounds)
    }
    
    public func config(container: (()->(HGAlertBaseContainer))?, constraint: ((_ dialogView: UIView,_ containerView: UIView)->())?) -> HGAlertView {
        self.floorView.config(container: container, constraint: constraint)
        return self
    }
    
    public func updateUI() -> HGAlertView {
        self.floorView.updataViews()
        return self
    }
    
    public func show(options: String) {
        self.floorView.showAlert(options: options)
    }
    
    public func close() {
        self.floorView.closeAlert()
    }
    
    func action<T>(block: T) {
        
    }
    
}
