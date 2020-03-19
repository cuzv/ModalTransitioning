//
//  ModalPresentationAnimator.swift
//  ModalTransitioning
//
//  Created by Shaw on 8/4/18.
//  Copyright © 2018 Shaw. All rights reserved.
//

import UIKit

// See https://github.com/pronebird/CustomModalTransition
// See https://stackoverflow.com/questions/25488267/custom-transition-animation-not-calling-vc-lifecycle-methods-on-dismiss
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

        from.beginAppearanceTransition(false, animated: true)
        delegate.runPresentAnimation { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            from.endAppearanceTransition()
        }
    }
}
