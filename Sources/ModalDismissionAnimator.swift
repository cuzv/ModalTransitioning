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
        guard let to = transitionContext.viewController(forKey: .to) else {
            return transitionContext.completeTransition(false)
        }
        
        to.beginAppearanceTransition(true, animated: true)
        delegate.willDismissTo(viewController: to)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: delegate.dismissOptions, animations: {
            self.delegate.dismissingTo(viewController: to)
        }, completion: { _ in
            self.delegate.didDismissTo(viewController: to)
            to.endAppearanceTransition()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
