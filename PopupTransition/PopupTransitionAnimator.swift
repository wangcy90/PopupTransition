//
//  PopupTransitionAnimator.swift
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

import Foundation

public protocol PopupTransitionAnimator {
    
    var preferredFrame: CGRect? { get }
    
    var duration: TimeInterval { get }
    
    var tapToDismiss: Bool { get }
    
    var backgroundColor: UIColor? { get }
    
    func performPresentedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning)
    
    func performDismissedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning)
    
}

public extension PopupTransitionAnimator {
    
    var duration: TimeInterval {
        return 0.25
    }
    
    var tapToDismiss: Bool {
        return false
    }
    
    var backgroundColor: UIColor? {
        return nil
    }
    
}
