//
//  SaveToAnimator.swift
//  Lists
//
//  Created by Tony Albor on 5/28/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import UIKit

class SaveToAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let isPresenting: Bool
    private let springTransitionDuration = 0.6
    private let linearTransitionDuration = 0.25
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return isPresenting ? springTransitionDuration : linearTransitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresenting ? present(context: transitionContext) : dismiss(context: transitionContext)
    }
    
    private func present(context: UIViewControllerContextTransitioning) {
        guard let to = context.viewController(forKey: .to) as? SaveToViewController else {
            return
        }
        context.containerView.addSubview(to.view)
        var startingFrame = context.finalFrame(for: to)
        startingFrame.origin.y += startingFrame.height
        to.view.frame = startingFrame
        UIView.animate(
            withDuration: transitionDuration(using: context),
            delay: 0,
            usingSpringWithDamping: 0.85,
            initialSpringVelocity: 0.75,
            options: .curveEaseOut,
            animations: {
                to.view.frame = context.finalFrame(for: to)
            }) { finished in
                let success = !context.transitionWasCancelled
                if !success {
                    to.view.removeFromSuperview()
                }
                context.completeTransition(success)
            }
    }
    
    private func dismiss(context: UIViewControllerContextTransitioning) {
        guard let from = context.viewController(forKey: .from) as? SaveToViewController else {
            return
        }
        var toFrame = context.finalFrame(for: from)
        toFrame.origin.y += from.view.bounds.height
        UIView.animate(
            withDuration: transitionDuration(using: context),
            animations: {
                from.view.frame = toFrame
            }) { _ in
                context.completeTransition(!context.transitionWasCancelled)
            }
    }
}
