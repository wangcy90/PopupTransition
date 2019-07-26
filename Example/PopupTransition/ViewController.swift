//
//  ViewController.swift
//  PopupTransition
//
//  email：chongyangfly@163.com
//  QQ：1909295866
//  github：https://github.com/wangcy90
//  blog：http://wangcy90.github.io
//
//  Created by WangChongyang on 07/06/2019.
//  Copyright (c) 2019 WangChongyang. All rights reserved.
//

import UIKit
import PopupTransition

class ViewController: UIViewController {
    
    lazy var alertTransition = PopupTransition(animator: AlertTransitionAnimator(preferredFrame: .init(x: (view.bounds.width - 200) / 2,
                                                                                                      y: (view.bounds.height - 200) / 2,
                                                                                                      width: 200, height: 200),
                                                                                tapToDismiss: true, backgroundColor: .init(white: 0, alpha: 0.3)))
    
    lazy var actionSheetTransition = PopupTransition(animator: ActionSheetTransitionAnimator(preferredFrame: .init(x: (view.bounds.width - 200) / 2,
                                                                                                                   y: view.bounds.height - 220,
                                                                                                                   width: 200, height: 200),
                                                                                             tapToDismiss: true, backgroundColor: .init(white: 0, alpha: 0.3)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func alert(_ sender: Any) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        
        alertTransition.prepare(viewController: vc)
        
        present(vc, animated: true)
        
    }
    
    @IBAction func actionSheet(_ sender: Any) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = .orange
        
        actionSheetTransition.prepare(viewController: vc)
        
        present(vc, animated: true)
        
    }
    
}
