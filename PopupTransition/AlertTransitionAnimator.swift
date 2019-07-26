//
//  AlertTransitionAnimator.swift
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

public struct AlertTransitionAnimator: PopupTransitionAnimator {
    
    public let preferredFrame: CGRect?
    
    public let tapToDismiss: Bool
    
    public let duration: TimeInterval
    
    public let backgroundColor: UIColor?
    
    public init(preferredFrame: CGRect? = nil, tapToDismiss: Bool = false, duration: TimeInterval = 0.25, backgroundColor: UIColor? = nil) {
        self.preferredFrame = preferredFrame
        self.tapToDismiss = tapToDismiss
        self.duration = duration
        self.backgroundColor = backgroundColor
    }
    
    public func performPresentedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning) {
        
        presentedView.transform = presentedView.transform.concatenating(.init(scaleX: 0.5, y: 0.5))
        
        presentedView.alpha = 0
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            
            presentedView.transform = .identity
            presentedView.alpha = 1
            
        }) {
            
            if context.transitionWasCancelled {
                context.completeTransition(false)
            } else {
                context.completeTransition($0)
            }
            
        }
        
    }
    
    public func performDismissedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning) {
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            
            presentedView.transform = presentedView.transform.concatenating(.init(scaleX: 0.5, y: 0.5))
            presentedView.alpha = 0
            presentingView.transform = .identity
            
        }) {
            
            if context.transitionWasCancelled {
                context.completeTransition(false)
            } else {
                context.completeTransition($0)
            }
            
        }
        
    }
    
}
