//
//  PopupTransition.swift
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

public final class PopupTransition: NSObject {
    
    enum TransitionState {
        case presented
        case dismissed
    }
    
    private var transitionState = TransitionState.presented
    
    private let animator: PopupTransitionAnimator
    
    public init(animator: PopupTransitionAnimator) {
        self.animator = animator
        super.init()
    }
    
    public func prepare(viewController: UIViewController) {
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
    }
    
}

extension PopupTransition: UIViewControllerTransitioningDelegate {
    
    public final func animationController(forPresented presented: UIViewController,
                                          presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionState = .presented
        return self
    }
    
    public final func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionState = .dismissed
        return self
    }
    
    public final func presentationController(forPresented presented: UIViewController,
                                             presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentation = PopupPresentation(preferredFrame: animator.preferredFrame,
                                             tapToDismiss: animator.tapToDismiss,
                                             backgroundColor: animator.backgroundColor)
        return PopupPresentationController(presentedViewController: presented, presentingViewController: presenting, presentation: presentation)
    }
    
}

extension PopupTransition: UIViewControllerAnimatedTransitioning {
    
    public final func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animator.duration
    }
    
    public final func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toController = transitionContext.toController, let fromController = transitionContext.fromController else {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            return
        }
        
        transitionContext.toView?.frame = transitionContext.finalFrame(for: toController)
        
        switch transitionState {
        case .presented:
            animator.performPresentedTransition(presentingView: fromController.view, presentedView: transitionContext.toView!, context: transitionContext)
        case .dismissed:
            animator.performDismissedTransition(presentingView: fromController.view, presentedView: transitionContext.fromView!, context: transitionContext)
        }
        
    }
    
}

private extension UIViewControllerContextTransitioning {
    
    var fromController: UIViewController? {
        return viewController(forKey: UITransitionContextViewControllerKey.from)
    }
    
    var toController: UIViewController? {
        return viewController(forKey: UITransitionContextViewControllerKey.to)
    }
    
    var fromView: UIView? {
        return view(forKey: UITransitionContextViewKey.from)
    }
    
    var toView: UIView? {
        return view(forKey: UITransitionContextViewKey.to)
    }
    
}
