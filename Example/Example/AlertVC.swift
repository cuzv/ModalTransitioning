//
//  AlertVC.swift
//  Example
//
//  Created by Roy Shaw on 8/4/18.
//  Copyright © 2018 RedRain. All rights reserved.
//

import UIKit
import ModalTransitioning

final class AlertVC: BaseViewController {
    @IBOutlet weak var dimView: UIView!
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
    
    func runPresentAnimation(completion: @escaping (Bool) -> Void) {
        view.layoutIfNeeded()
        dimView.alpha = 0
        containerView.alpha = 0
        containerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)

        UIView.animate(withDuration: presentDuration, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.dimView.alpha = 1
            self.containerView.alpha = 1
            self.containerView.transform = .identity
        }, completion: completion)
    }
    
    func runDismissAnimation(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: dismissDuration, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.dimView.alpha = 0
            self.containerView.alpha = 0
            self.containerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: completion)
    }
}
