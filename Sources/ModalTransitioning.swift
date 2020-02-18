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
    func runPresentAnimation(completion: @escaping (Bool) -> Void)
}

extension ModalPresentationTransitioning {
    public var presentDuration: TimeInterval { return 0.25 }
}

public protocol ModalDismissionTransitioning: class {
    var dismissDuration: TimeInterval { get }
    func runDismissAnimation(completion: @escaping (Bool) -> Void)
}

extension ModalDismissionTransitioning {
    public var dismissDuration: TimeInterval { return 0.25 }
}

public typealias ModalTransitioning = ModalPresentationTransitioning & ModalDismissionTransitioning
