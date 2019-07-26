//
//  PopupPresentationController.swift
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

class PopupPresentationController: UIPresentationController {
    
    private lazy var backgroundView = UIView()
    
    private let presentation: PopupPresentation
    
    init(presentedViewController: UIViewController, presentingViewController: UIViewController?, presentation: PopupPresentation) {
        self.presentation = presentation
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        
        var ret: CGRect
        
        if let frame = presentation.preferredFrame {
            
            ret = frame
            
        }else {
            
            let size = presentedViewController.view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            
            presentedViewController.view.translatesAutoresizingMaskIntoConstraints = true
            
            ret = .init(x: (UIScreen.main.bounds.width - size.width) * 0.5,
                          y: (UIScreen.main.bounds.height - size.height) * 0.5,
                          width: size.width, height: size.height)
            
        }
        
        if let containerView = containerView {
            adjust(frame: &ret, withSize: containerView.bounds.size)
        }
        
        return ret
        
    }
    
    override func presentationTransitionWillBegin() {
        
        containerView?.addSubview(presentedView!)
        
        if presentation.tapToDismiss || presentation.backgroundColor != nil {
            setupBackgroundView()
            animateBackgroundView()
        }
        
    }
    
    override func dismissalTransitionWillBegin() {
        
        if presentation.tapToDismiss || presentation.backgroundColor != nil {
            
            presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
                self?.backgroundView.alpha = 0
            })
            
        }
        
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
}

private extension PopupPresentationController {
    
    func setupBackgroundView() {
        
        guard let containerView = containerView else { return }
        
        if let color = presentation.backgroundColor {
            backgroundView.backgroundColor = color
        }
        
        backgroundView.alpha = 0
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        if presentation.tapToDismiss {
            backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissAction)))
        }
        
        containerView.insertSubview(backgroundView, at: 0)
        
        containerView.addConstraint(.init(item: backgroundView, attribute: .left, relatedBy: .equal, toItem: containerView,
                                          attribute: .left, multiplier: 1, constant: 0))
        
        containerView.addConstraint(.init(item: backgroundView, attribute: .right, relatedBy: .equal, toItem: containerView,
                                          attribute: .right, multiplier: 1, constant: 0))
        
        containerView.addConstraint(.init(item: backgroundView, attribute: .top, relatedBy: .equal, toItem: containerView,
                                          attribute: .top, multiplier: 1, constant: 0))
        
        containerView.addConstraint(.init(item: backgroundView, attribute: .bottom, relatedBy: .equal, toItem: containerView,
                                          attribute: .bottom, multiplier: 1, constant: 0))
        
    }
    
    func animateBackgroundView() {
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            backgroundView.alpha = 1
            return
        }
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.backgroundView.alpha = 1
        })
        
    }
    
    @objc func dismissAction() {
        presentingViewController.dismiss(animated: true)
    }
    
    func adjust(frame: inout CGRect, withSize size: CGSize) {
        
        if frame.size.height > size.height {
            frame.origin.y = 0
            frame.size.height = size.height
        }
        
        if frame.size.width > size.width {
            frame.origin.x = 0
            frame.size.width = size.width
        }
        
    }
    
}
