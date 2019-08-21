//
//  ActionSheetTransitionAnimator.swift
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

public struct ActionSheetTransitionAnimator: PopupTransitionAnimator {
    
    public let preferredFrame: CGRect?
    
    public let tapToDismiss: Bool
    
    public let duration: TimeInterval
    
    public let backgroundColor: UIColor?
    
    public init(preferredFrame: CGRect, tapToDismiss: Bool = false, duration: TimeInterval = 0.25, backgroundColor: UIColor? = nil) {
        self.preferredFrame = preferredFrame
        self.tapToDismiss = tapToDismiss
        self.duration = duration
        self.backgroundColor = backgroundColor
    }
    
    public func performPresentedTransition(presentingView: UIView, presentedView: UIView, context: UIViewControllerContextTransitioning) {
        
        var initialFrame = preferredFrame!
        
        initialFrame.origin = .init(x: (context.containerView.frame.width - initialFrame.width) / 2, y: context.containerView.frame.height)
        
        let finalFrame = presentedView.frame
        
        presentedView.frame = initialFrame
        
        UIView.animate(withDuration: duration, animations: {
            
            presentedView.frame = finalFrame
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
        
        let initialFrame = presentedView.frame
        
        var finalFrame = preferredFrame!
        
        finalFrame.origin = .init(x: (context.containerView.frame.width - finalFrame.width) / 2, y: context.containerView.frame.height)
        
        presentedView.frame = initialFrame
        
        UIView.animate(withDuration: duration, animations: {
            
            presentedView.frame = finalFrame
            presentedView.alpha = 0
            
        }) {
            
            if context.transitionWasCancelled {
                context.completeTransition(false)
            } else {
                context.completeTransition($0)
            }
            
        }
        
    }
    
}

