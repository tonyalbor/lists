//
//  ImageViewAnimator.swift
//  Lists
//
//  Created by Tony Albor on 5/28/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import UIKit

class ImageViewAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let isPresenting: Bool
    private let transitionDuration = 0.6
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresenting ? present(context: transitionContext) : dismiss(context: transitionContext)
    }
    
    private func present(context: UIViewControllerContextTransitioning) {
        guard let from = context.viewController(forKey: .from) as? RestaurantDetailViewController,
            let to = context.viewController(forKey: .to) as? ImageViewController else {
                return
        }
        let startingWidth = from.contentView.imageView.bounds.width
        let finishingWidth = context.finalFrame(for: to).width
        let pct = 1.0 / (startingWidth / finishingWidth)
        context.containerView.addSubview(to.view)
        UIView.animate(
            withDuration: transitionDuration(using: context),
            delay: 0,
            usingSpringWithDamping: 0.65, // less for more bounces
            initialSpringVelocity: 0.75,
            options: UIViewAnimationOptions.curveEaseOut,
            animations: {
                from.contentView.imageViewContainer.backgroundColor = .black
                from.view.backgroundColor = .black
                from.contentView.imageView.transform = CGAffineTransform(scaleX: pct, y: pct)
            },
            completion: { finished in
                to.view.frame = context.finalFrame(for: to)
                from.contentView.imageView.transform = .identity
                from.view.backgroundColor = .white
                from.contentView.backgroundColor = .white
                from.contentView.imageViewContainer.backgroundColor = .white
                context.completeTransition(!context.transitionWasCancelled)
            })
    }
    
    private func dismiss(context: UIViewControllerContextTransitioning) {
        if !context.isInteractive {
            dismissAnimated(context: context)
        } else {
            dismissInteractive(context: context)
        }
    }
    
    private func dismissAnimated(context: UIViewControllerContextTransitioning) {
        guard let from = context.viewController(forKey: .from) as? ImageViewController,
            let to = context.viewController(forKey: .to) as? RestaurantDetailViewController,
            let fromView = context.view(forKey: .from) as? ImageContentView else {
                return
        }
        let toFinalFrame = context.finalFrame(for: to)
        let fromWidth = fromView.bounds.width
        let toWidth = to.contentView.imageView.bounds.width
        let scale = toWidth / fromWidth
        context.containerView.insertSubview(to.view, belowSubview: fromView)
        to.view.frame = toFinalFrame
        let originalFrame = to.contentView.imageView.frame
        to.contentView.imageView.frame = fromView.imageView.frame
        UIView.animate(
            withDuration: transitionDuration(using: context),
            delay: 0,
            usingSpringWithDamping: 0.75, // less for more bounces
            initialSpringVelocity: 0.75,
            options: UIViewAnimationOptions.curveEaseOut,
            animations: {
                fromView.alpha = 0
                fromView.backgroundColor = .white
                fromView.imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
                to.contentView.imageView.frame = originalFrame
                to.view.backgroundColor = .white
                to.contentView.backgroundColor = .white
                to.contentView.imageViewContainer.backgroundColor = .white
            },
            completion: { finished in
                let success = !context.transitionWasCancelled
                if success {
                    to.view.removeFromSuperview()
                }
                fromView.frame = context.finalFrame(for: from)
                context.completeTransition(success)
            })
    }
    
    private func dismissInteractive(context: UIViewControllerContextTransitioning) {
        guard let from = context.viewController(forKey: .from) as? ImageViewController,
            let to = context.viewController(forKey: .to) as? RestaurantDetailViewController,
            let fromView = context.view(forKey: .from) as? ImageContentView else {
                return
        }
        context.containerView.insertSubview(to.view, belowSubview: fromView)
        to.view.frame = context.finalFrame(for: to)
        to.view.backgroundColor = .black
        to.contentView.imageViewContainer.backgroundColor = .black
        to.contentView.imageView.isHidden = true
        UIView.animate(
            withDuration: 0.1,
            animations: {
                to.view.backgroundColor = .white
                to.contentView.imageViewContainer.backgroundColor = .white
                fromView.backgroundColor = .clear
            },
            completion: { _ in
                UIView.animate(
                    withDuration: self.transitionDuration(using: context),
                    delay: 0,
                    usingSpringWithDamping: 0.75,
                    initialSpringVelocity: 0.75,
                    options: .curveEaseOut,
                    animations: {
                        if context.transitionWasCancelled {
                            fromView.backgroundColor = .black
                            fromView.imageView.transform = .identity
                        } else {
                            to.view.backgroundColor = .white
                            to.contentView.imageViewContainer.backgroundColor = .white
                            fromView.backgroundColor = .clear
                            fromView.imageView.frame = to.contentView.imageView.frame
                        }
                    },
                    completion: { _ in
                        let success = !context.transitionWasCancelled
                        if success {
                            to.contentView.imageView.isHidden = false
                            to.view.removeFromSuperview()
                        }
                        fromView.frame = context.finalFrame(for: from)
                        context.completeTransition(success)
                    })
            })
    }
}
