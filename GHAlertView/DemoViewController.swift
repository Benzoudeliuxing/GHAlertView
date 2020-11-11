//
//  ViewController.swift
//  GHAlertView
//
//  Created by will on 2020/11/11.
//

import UIKit
import HGAlertView
import SnapKit
class DemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
        let btn = UIButton(frame: CGRect(x: 100, y: 80, width: 100, height: 30))
        btn.backgroundColor = .orange
        btn.setTitle("弹窗演示", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc func clickBtn() {
        HGAlertView.shared.config { () -> (HGAlertBaseContainer) in
            let container = Bundle.main.loadNibNamed("AlertTextFieldView", owner: self, options: nil)?[0] as? AlertTextFieldView ?? AlertTextFieldView()
            return container
        } constraint: { (dialog, container) in
            dialog.snp.removeConstraints()
            container.snp.removeConstraints()
            container.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(10)
                make.bottom.equalTo(-10)
            }
            dialog.snp.makeConstraints { (make) in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.centerY.equalToSuperview()
                make.height.equalTo(container.snp.height).offset(20)
            }
        }.updateUI().show(options: "")

    }


}

