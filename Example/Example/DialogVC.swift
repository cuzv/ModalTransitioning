//
//  DialogVC.swift
//  Example
//
//  Created by Roy Shaw on 8/4/18.
//  Copyright © 2018 RedRain. All rights reserved.
//

import UIKit
import ModalTransitioning

final class DialogVC: BaseViewController {
    @IBOutlet weak var dimView: UIView!
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
        let parent = presentingViewController
        presentingViewController?.dismiss(animated: true, completion: {
            let vc = BaseViewController()
            vc.view.backgroundColor = .cyan
            parent?.show(vc, sender: nil)
        })
    }
}

extension DialogVC: ModalTransitioning {
    func runPresentAnimation(completion: @escaping (Bool) -> Void) {
        view.layoutIfNeeded()
        dimView.alpha = 0
        containerView.alpha = 0
        containerCenterYConstraint.constant = 0

        UIView.animate(withDuration: presentDuration, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.dimView.alpha = 1
            self.containerView.alpha = 1
        }, completion: completion)
    }
    
    func runDismissAnimation(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: dismissDuration, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.dimView.alpha = 0
            self.containerView.alpha = 0
        }, completion: completion)
    }
}
