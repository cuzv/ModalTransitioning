//
//  AlertVC.swift
//  Example
//
//  Created by Roy Shaw on 8/4/18.
//  Copyright © 2018 RedRain. All rights reserved.
//

import UIKit
import ModalTransitioning

final class AlertVC: UIViewController {
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var containerView: UIView!

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
    
    @IBAction func handleDismissAction(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension AlertVC: ModalTransitioning {
    func willPresent() {
        view.layoutIfNeeded()
        coverView.alpha = 0
        containerView.alpha = 0
        containerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
    }
    
    func presenting() {
        view.layoutIfNeeded()
        coverView.alpha = 1
        containerView.alpha = 1
        containerView.transform = .identity
    }
    
    func dismissing() {
        view.layoutIfNeeded()
        coverView.alpha = 0
        containerView.alpha = 0
        containerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
    }
}
