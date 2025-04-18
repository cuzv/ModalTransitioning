//
//  ModalDismissionAnimator.swift
//  ModalTransitioning
//
//  Created by Shaw on 8/4/18.
//  Copyright © 2018 Shaw. All rights reserved.
//

import UIKit

@MainActor
open class ModalDismissionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  private let delegate: ModalDismissionTransitioning
  public init(delegate: ModalDismissionTransitioning) {
    self.delegate = delegate
  }

  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    delegate.dismissDuration
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    if let from = transitionContext.viewController(forKey: .from),
       let to = transitionContext.viewController(forKey: .to)
    {
      from.beginAppearanceTransition(false, animated: true)
      to.beginAppearanceTransition(true, animated: true)

      delegate.runDismissAnimation { complete in
        from.endAppearanceTransition()
        to.endAppearanceTransition()
        transitionContext.completeTransition(complete)
      }
    } else {
      return transitionContext.completeTransition(false)
    }
  }
}
