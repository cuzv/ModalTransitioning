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
        coverView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        coverView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        return coverView
    }()
    
    private var isPresent: Bool = false
    
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
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.25
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // MARK: Helpers
        
        func animationOptionsForAnimationCurve(curve: UInt) -> UIViewAnimationOptions {
            return UIViewAnimationOptions(rawValue: curve << 16)
        }
        
        func animation(animations: () -> Void, completion: (Bool) -> Void) {
            UIView.animateWithDuration(0.25, delay: 0, options: animationOptionsForAnimationCurve(7), animations: animations, completion: completion)
        }
        
        func executePresentAnimation(container: UIView, toView: UIView, fromView: UIView, completion: (Bool) -> Void) {
            coverView.frame = container.bounds
            coverView.alpha = 0
            container.addSubview(coverView)
            toView.frame = container.bounds
            container.addSubview(toView)
            
            prepareForPresentActionHandler?(fromView, toView)
            animation({
                self.coverView.alpha = 1
                self.duringPresentingActionHandler?(fromView, toView)
            }, completion: completion)
            
            animation({ 
                self.coverView.alpha = 1
                self.duringPresentingActionHandler?(fromView, toView)
            }) { (flag) in
                self.didPresentedActionHandler?(fromView, toView)
                completion(flag)
            }
        }
        
        func executeDismissAnimation(container: UIView, toView: UIView, fromView: UIView, completion: (Bool) -> Void) {
            container.addSubview(fromView)
            
            prepareForDismissActionHandler?(fromView, toView)
            animation({ 
                self.duringDismissingActionHandler?(fromView, toView)
                self.coverView.alpha = 0
            }) { (flag) in
                self.didDismissedActionHandler?(fromView, toView)
                completion(flag)
            }
        }
        
        // MARK: Real logical
        
        guard let to = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return transitionContext.completeTransition(false)
        }
        guard let from = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
            return transitionContext.completeTransition(false)
        }
        
        let container = transitionContext.containerView()
        if isPresent {
            executePresentAnimation(container, toView: to.view, fromView: from.view) { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
        } else {
            executeDismissAnimation(container, toView: to.view, fromView: from.view) { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
        }
    }
}
