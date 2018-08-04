//
//  ModalTransitioningDelegate.swift
//  ModalTransitioning
//
//  Created by Roy Shaw on 8/4/18.
//  Copyright © 2018 RedRain. All rights reserved.
//

import UIKit

open class ModalTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    private weak var delegate: ModalTransitioning!
    public init(delegate: ModalTransitioning) {
        self.delegate = delegate
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalPresentationAnimator(delegate: delegate)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalDismissionAnimator(delegate: delegate)
    }
}
