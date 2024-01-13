//
//  ModalTransitioning.swift
//  ModalTransitioning
//
//  Created by Shaw on 8/4/18.
//  Copyright © 2018 Shaw. All rights reserved.
//

import UIKit

public protocol ModalPresentationTransitioning: AnyObject {
  var presentDuration: TimeInterval { get }
  func runPresentAnimation(completion: @escaping (Bool) -> Void)
}

public extension ModalPresentationTransitioning {
  var presentDuration: TimeInterval { 0.25 }
}

public protocol ModalDismissionTransitioning: AnyObject {
  var dismissDuration: TimeInterval { get }
  func runDismissAnimation(completion: @escaping (Bool) -> Void)
}

public extension ModalDismissionTransitioning {
  var dismissDuration: TimeInterval { 0.25 }
}

public typealias ModalTransitioning = ModalDismissionTransitioning & ModalPresentationTransitioning
