//
//  PresentAnimatedTransitioningController.swift
//  PresentAnimatedTransitioningController
//
//  Created by Moch Xiao on 4/19/16.
//  Copyright © @2016 Moch Xiao (http://mochxiao.com).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public final class PresentAnimatedTransitioningController: NSObject {
    /// (fromView, toView)
    public typealias ContextAction = (UIView, UIView) -> ()
    public var prepareForPresentActionHandler: ContextAction?
    public var duringPresentingActionHandler: ContextAction?
    public var didPresentedActionHandler: ContextAction?
    public var prepareForDismissActionHandler: ContextAction?
    public var duringDismissingActionHandler: ContextAction?
    public var didDismissedActionHandler: ContextAction?
    
    /// Default cover is a dim view, you could override this property to your preferred style view.
    public var coverView: UIView = {
        let coverView = UIView()
        coverView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        coverView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return coverView
    }()
    
    fileprivate var isPresent: Bool = false
    
    public func prepareForPresent() -> Self {
        isPresent = true
        return self
    }
    
    public func prepareForDismiss() -> Self {
        isPresent = false
        return self
    }
}

// MARK: UIViewControllerAnimatedTransitioning

extension PresentAnimatedTransitioningController: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // MARK: Helpers
        
        func animationOptions(curve: UInt) -> UIViewAnimationOptions {
            return UIViewAnimationOptions(rawValue: curve << 16)
        }
        
        func execute(animations: @escaping () -> Void, completion: @escaping (Bool) -> Void) {
            // Prevent other interactions disturb
            UIApplication.shared.beginIgnoringInteractionEvents()
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: animationOptions(curve: 7), animations: animations) { (flag: Bool) in
                completion(flag)
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
        
        func executePresentAnimation(with container: UIView, fromView: UIView, toView: UIView, completion: @escaping (Bool) -> Void) {
            coverView.frame = container.bounds
            coverView.alpha = 0
            container.addSubview(coverView)
            toView.frame = container.bounds
            container.addSubview(toView)
            
            prepareForPresentActionHandler?(fromView, toView)
            execute(animations: { 
                self.coverView.alpha = 1
                self.duringPresentingActionHandler?(fromView, toView)
            }, completion: completion)
        }
        
        func executeDismissAnimation(with container: UIView, fromView: UIView, toView: UIView, completion: @escaping (Bool) -> Void) {
            container.addSubview(fromView)
            
            prepareForDismissActionHandler?(fromView, toView)
            execute(animations: { 
                self.duringDismissingActionHandler?(fromView, toView)
                self.coverView.alpha = 0
            }) { (flag) in
                self.didDismissedActionHandler?(fromView, toView)
                completion(flag)
            }
        }
        
        // MARK: Real logical
        
        guard let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return transitionContext.completeTransition(false)
        }
        guard let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return transitionContext.completeTransition(false)
        }
        
        let container = transitionContext.containerView
        if isPresent {
            executePresentAnimation(with: container, fromView: from.view, toView: to.view) { (_) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        } else {
            executeDismissAnimation(with: container, fromView: from.view, toView: to.view) { (_) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
