//
//  DialogVC.swift
//  Example
//
//  Created by Roy Shaw on 8/4/18.
//  Copyright © 2018 RedRain. All rights reserved.
//

import UIKit
import ModalTransitioning

final class DialogVC: UIViewController {
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerCenterYConstraint: NSLayoutConstraint!
    
    private lazy var modalTransitioningDelegate = ModalTransitioningDelegate(delegate: self)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commitInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitInit()
    }
    
    private func commitInit() {
        modalPresentationStyle = .custom
        transitioningDelegate = modalTransitioningDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerCenterYConstraint.constant = view.bounds.height + containerView.bounds.height / 2.0
    }
    
    @IBAction func handleDismissAction(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension DialogVC: ModalTransitioning {
    func willPresent() {
        view.layoutIfNeeded()
        coverView.alpha = 0
        containerView.alpha = 0
        containerCenterYConstraint.constant = 0
    }
    
    func presenting() {
        view.layoutIfNeeded()
        coverView.alpha = 1
        containerView.alpha = 1
    }
    
    func willDismiss() {
        view.layoutIfNeeded()
        containerCenterYConstraint.constant = view.bounds.height + containerView.bounds.height / 2.0
    }
    
    func dismissing() {
        view.layoutIfNeeded()
        coverView.alpha = 0
        containerView.alpha = 0
    }
}
