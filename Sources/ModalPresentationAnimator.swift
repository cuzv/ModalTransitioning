//
//  ModalPresentationAnimator.swift
//  ModalTransitioning
//
//  Created by Roy Shaw on 8/4/18.
//  Copyright © 2018 RedRain. All rights reserved.
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
        guard let to = transitionContext.viewController(forKey: .to) else {
            return transitionContext.completeTransition(false)
        }
        
        let container = transitionContext.containerView
        to.view.frame = container.bounds
        container.addSubview(to.view)        

        delegate.willPresent()
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: delegate.presentOptions, animations: {
            self.delegate.presenting()
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            self.delegate.didPresent()
        })
    }
}
