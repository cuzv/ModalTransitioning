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
    
    func willPresent()
    func presenting()
    func didPresent()
}

public extension ModalPresentationTransitioning {
    public var presentDuration: TimeInterval { return 0.25 }
    public var presentOptions: UIView.AnimationOptions { return .curveEaseInOut }
    public func willPresent() {}
    public func didPresent() {}
}

public protocol ModalDismissionTransitioning: class {
    var dismissDuration: TimeInterval { get }
    var dismissOptions: UIView.AnimationOptions { get }
    
    func willDismiss()
    func dismissing()
    func didDismiss()
}

public extension ModalDismissionTransitioning {
    public var dismissDuration: TimeInterval { return 0.25 }
    public var dismissOptions: UIView.AnimationOptions { return .curveEaseInOut }
    public func willDismiss() {}
    public func didDismiss() {}
}

public typealias ModalTransitioning = ModalPresentationTransitioning & ModalDismissionTransitioning
