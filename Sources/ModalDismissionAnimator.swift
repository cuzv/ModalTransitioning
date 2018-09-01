//
//  ModalDismissionAnimator.swift
//  ModalTransitioning
//
//  Created by Shaw on 8/4/18.
//  Copyright © 2018 Shaw. All rights reserved.
//

import UIKit

open class ModalDismissionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let delegate: ModalDismissionTransitioning
    public init(delegate: ModalDismissionTransitioning) {
        self.delegate = delegate
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return delegate.dismissDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let from = transitionContext.viewController(forKey: .from) else {
            return transitionContext.completeTransition(false)
        }
        
        let container = transitionContext.containerView
        container.addSubview(from.view)
        
        delegate.willDismiss()
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: delegate.dismissOptions, animations: {
            self.delegate.dismissing()
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            self.delegate.didDismiss()
        })
    }
}
