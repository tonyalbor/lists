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
        guard let tabBar = context.viewController(forKey: .from) as? UITabBarController,
              let fromNavigation = tabBar.selectedViewController as? UINavigationController,
              let from = fromNavigation.childViewControllers.last as? RestaurantDetailViewController,
              let to = context.viewController(forKey: .to) as? ImageViewController else {
                return
        }
        let overlay = UIView(frame: context.finalFrame(for: to))
        overlay.backgroundColor = .black
        overlay.alpha = 0.0
        context.containerView.addSubview(overlay)
        
        let imageCopy = UIImageView(image: from.contentView.imageView.image)
        context.containerView.addSubview(imageCopy)
        imageCopy.frame = from.contentView.imageView.frame
        imageCopy.contentMode = from.contentView.imageView.contentMode
        
        let startingWidth = imageCopy.bounds.width
        let finishingWidth = context.finalFrame(for: to).width
        let scale = 1.0 / (startingWidth / finishingWidth)
        context.containerView.addSubview(to.view)
        to.view.isHidden = true
        UIView.animate(
            withDuration: transitionDuration(using: context),
            delay: 0,
            usingSpringWithDamping: 0.65, // less for more bounces
            initialSpringVelocity: 0.75,
            options: UIViewAnimationOptions.curveEaseOut,
            animations: {
                overlay.alpha = 1.0
                imageCopy.transform = CGAffineTransform(scaleX: scale, y: scale)
            },
            completion: { finished in
                imageCopy.removeFromSuperview()
                overlay.removeFromSuperview()
                to.view.frame = context.finalFrame(for: to)
                to.view.isHidden = false
                from.view.frame = context.finalFrame(for: from)
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
            let tabBar = context.viewController(forKey: .to) as? UITabBarController,
            let toNav = tabBar.selectedViewController as? UINavigationController,
            let to = toNav.childViewControllers.last as? RestaurantDetailViewController,
            let fromView = context.view(forKey: .from) as? ImageContentView else {
                return
        }
//        context.containerView.insertSubview(toNav.view, belowSubview: fromView)
        context.containerView.insertSubview(tabBar.view, belowSubview: fromView)
        let imageCopy = UIImageView(image: fromView.imageView.image)
        context.containerView.addSubview(imageCopy)
        imageCopy.contentMode = .scaleAspectFit
        imageCopy.frame = fromView.imageView.frame
//        toNav.view.frame = context.finalFrame(for: toNav)
        tabBar.view.frame = context.finalFrame(for: tabBar)
        to.view.frame = context.finalFrame(for: to)
        UIView.animate(
            withDuration: transitionDuration(using: context),
            delay: 0,
            usingSpringWithDamping: 0.75, // less for more bounces
            initialSpringVelocity: 0.75,
            options: UIViewAnimationOptions.curveEaseOut,
            animations: {
                fromView.alpha = 0
                fromView.backgroundColor = .white
                imageCopy.frame = to.contentView.imageView.frame
                toNav.view.backgroundColor = .white
                tabBar.view.frame = context.finalFrame(for: tabBar)
                tabBar.view.backgroundColor = .white
                to.contentView.backgroundColor = .white
                to.contentView.imageViewContainer.backgroundColor = .white
            },
            completion: { finished in
                let success = !context.transitionWasCancelled
//                toNav.view.frame = context.finalFrame(for: toNav)
                tabBar.view.frame = context.finalFrame(for: tabBar)
                if success {
//                    toNav.view.removeFromSuperview()
                    tabBar.view.removeFromSuperview()
                    imageCopy.removeFromSuperview()
                }
                fromView.frame = context.finalFrame(for: from)
                context.completeTransition(success)
            })
    }
    
    private func dismissInteractive(context: UIViewControllerContextTransitioning) {
        guard let from = context.viewController(forKey: .from) as? ImageViewController,
            let tabBar = context.viewController(forKey: .to) as? UITabBarController,
            let toNav = tabBar.selectedViewController as? UINavigationController,
            let to = toNav.childViewControllers.last as? RestaurantDetailViewController,
            let fromView = context.view(forKey: .from) as? ImageContentView else {
                return
        }
        context.containerView.insertSubview(tabBar.view, belowSubview: fromView)
        tabBar.view.frame = context.finalFrame(for: tabBar)
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
                            fromView.imageView.contentMode = .scaleAspectFit
                            fromView.imageView.frame = to.contentView.imageView.frame
                        }
                    },
                    completion: { _ in
                        let success = !context.transitionWasCancelled
                        if success {
                            to.contentView.imageView.isHidden = false
                            tabBar.view.removeFromSuperview()
                        }
                        fromView.frame = context.finalFrame(for: from)
                        context.completeTransition(success)
                    })
            })
    }
}
