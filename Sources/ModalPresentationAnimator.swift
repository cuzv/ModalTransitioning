//
//  ModalPresentationAnimator.swift
//  ModalTransitioning
//
//  Created by Shaw on 8/4/18.
//  Copyright © 2018 Shaw. All rights reserved.
//

import UIKit

open class ModalPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {    
    private let delegate: ModalPresentationTransitioning
    public init(delegate: ModalPresentationTransitioning) {
        self.delegate = delegate
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return delegate.presentDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let from = transitionContext.viewController(forKey: .from),
            let to = transitionContext.viewController(forKey: .to)
        else {
            return transitionContext.completeTransition(false)
        }
        
        let container = transitionContext.containerView
        container.addSubview(to.view)
        to.view.frame = transitionContext.finalFrame(for: to)
        to.view.layoutIfNeeded()

        delegate.willPresentFrom(viewController: from)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: delegate.presentOptions, animations: {
            self.delegate.presentingFrom(viewController: from)
        }, completion: { _ in
            self.delegate.didPresentFrom(viewController: from)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
