//
//  ModalTransitioning.swift
//  ModalTransitioning
//
//  Created by Shaw on 8/4/18.
//  Copyright © 2018 Shaw. All rights reserved.
//

import UIKit

public protocol ModalPresentationTransitioning: class {
    var presentDuration: TimeInterval { get }
    var presentOptions: UIView.AnimationOptions { get }
    
    func willPresentFrom(viewController: UIViewController)
    func presentingFrom(viewController: UIViewController)
    func didPresentFrom(viewController: UIViewController)
}

extension ModalPresentationTransitioning {
    public var presentDuration: TimeInterval { return 0.25 }
    public var presentOptions: UIView.AnimationOptions { return .curveEaseInOut }
    
    public func willPresentFrom(viewController: UIViewController) {}
    public func presentingFrom(viewController: UIViewController) {}
    public func didPresentFrom(viewController: UIViewController) {}
}

public protocol ModalDismissionTransitioning: class {
    var dismissDuration: TimeInterval { get }
    var dismissOptions: UIView.AnimationOptions { get }
    
    func willDismissTo(viewController: UIViewController)
    func dismissingTo(viewController: UIViewController)
    func didDismissTo(viewController: UIViewController)
}

extension ModalDismissionTransitioning {
    public var dismissDuration: TimeInterval { return 0.25 }
    public var dismissOptions: UIView.AnimationOptions { return .curveEaseInOut }
    
    public func willDismissTo(viewController: UIViewController) {}
    public func dismissingTo(viewController: UIViewController) {}
    public func didDismissTo(viewController: UIViewController) {}
}

public typealias ModalTransitioning = ModalPresentationTransitioning & ModalDismissionTransitioning
