//
//  HalfModalPresentationController.swift
//  Lists
//
//  Created by Tony Albor on 5/28/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import UIKit

class HalfModalPresentationController: UIPresentationController {
    
    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedDimmedView))
        view.addGestureRecognizer(tap)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var shouldPresentInFullscreen: Bool {
        return false
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let frame = containerView?.frame ?? .zero
        let height = frame.height * 0.34
        let originY = frame.height - height
        return CGRect(x: frame.origin.x, y: originY, width: frame.width, height: height)
    }
    
    override func presentationTransitionWillBegin() {
        setUpSubviews()
        setUpConstraints()
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                self?.dimmingView.alpha = 0.6
            }, completion: nil)
        } else {
            dimmingView.alpha = 0.6
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                self?.dimmingView.alpha = 0.0
            }, completion: nil)
        } else {
            dimmingView.alpha = 0.0
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView.removeFromSuperview()
        }
    }
    
    private func setUpSubviews() {
        containerView?.addSubview(dimmingView)
    }
    
    private func setUpConstraints() {
        guard let containerView = containerView else {
            print("WARNING: No container view set for half modal presentation")
            return
        }
        let constraints = dimmingView.constraintsTo(view: containerView)
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    private func tappedDimmedView() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
