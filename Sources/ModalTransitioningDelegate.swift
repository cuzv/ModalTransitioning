//
//  ModalTransitioningDelegate.swift
//  ModalTransitioning
//
//  Created by Shaw on 8/4/18.
//  Copyright © 2018 Shaw. All rights reserved.
//

import UIKit

@MainActor
open class ModalTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
  private weak var delegate: ModalTransitioning!
  public init(delegate: ModalTransitioning) {
    self.delegate = delegate
  }

  public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    ModalPresentationAnimator(delegate: delegate)
  }

  public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    ModalDismissionAnimator(delegate: delegate)
  }
}
