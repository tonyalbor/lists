//
//  RestaurantDetailViewController.swift
//  Lists
//
//  Created by Tony Albor on 5/6/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    override func loadView() {
        view = RestaurantDetailView()
    }
    
    var contentView: RestaurantDetailView {
        return view as! RestaurantDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://o.aolcdn.com/images/dims3/GLOB/legacy_thumbnail/1600x900/format/jpg/quality/85/https%3A%2F%2Fstatic.makers.com%2Ffield%2Fimage%2Fsushiplate+crop.jpg")!
        contentView.imageView.af_setImage(withURL: url)
        setUpActions()
    }
    
    private func setUpActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleImageViewTap))
        contentView.imageView.addGestureRecognizer(tap)
    }
    
    @objc
    private func handleImageViewTap() {
        let imageViewController = ImageViewController(image: contentView.imageView.image)
        imageViewController.transitioningDelegate = self
        present(imageViewController, animated: true, completion: nil)
    }
}

class ImageViewAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let isPresenting: Bool
    var presentedViewController: UIViewController?
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    private func present(context: UIViewControllerContextTransitioning) {
        guard let from = context.viewController(forKey: .from) as? RestaurantDetailViewController,
            let to = context.viewController(forKey: .to) as? ImageViewController else {
                return
        }
        presentedViewController = to
        let startingWidth = from.contentView.imageView.bounds.width
        let finishingWidth = context.finalFrame(for: to).width
        let pct = 1.0 / (startingWidth / finishingWidth)
        context.containerView.addSubview(to.view)
        UIView.animate(withDuration: transitionDuration(using: context), animations: {
            from.contentView.imageViewContainer.backgroundColor = .black
            from.view.backgroundColor = .black
            from.contentView.imageView.transform = CGAffineTransform(scaleX: pct, y: pct)
        }) { (completed) in
            to.view.frame = context.finalFrame(for: to)
            context.completeTransition(!context.transitionWasCancelled)
        }
    }
    
    private func dismiss(context: UIViewControllerContextTransitioning) {
        guard let from = context.viewController(forKey: .from) as? ImageViewController,
            let to = context.viewController(forKey: .to) as? RestaurantDetailViewController,
            let fromView = context.view(forKey: .from) as? ImageContentView else {
                return
        }
        presentedViewController = from
        let toFinalFrame = context.finalFrame(for: to)
        let fromWidth = fromView.bounds.width
        let toWidth = to.contentView.imageView.bounds.width
        let scale = toWidth / fromWidth
        context.containerView.insertSubview(to.view, belowSubview: fromView)
        to.view.frame = toFinalFrame
        UIView.animate(withDuration: transitionDuration(using: context), animations: {
            fromView.alpha = 0
            fromView.backgroundColor = .white
            fromView.imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            to.contentView.imageView.transform = .identity
            to.view.backgroundColor = .white
            to.contentView.backgroundColor = .white
            to.contentView.imageViewContainer.backgroundColor = .white
        }) { (completed) in
            let success = !context.transitionWasCancelled
            if success {
                to.view.removeFromSuperview()
            }
            fromView.frame = context.finalFrame(for: from)
            context.completeTransition(success)
            self.presentedViewController = nil
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            present(context: transitionContext)
        } else {
            dismiss(context: transitionContext)
        }
    }
}

extension RestaurantDetailViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = ImageViewAnimator(isPresenting: true)
        animator.presentedViewController = presented
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = ImageViewAnimator(isPresenting: false)
        animator.presentedViewController = dismissed
        return animator
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? ImageViewAnimator else {
            return nil
        }
        guard let imageViewController = animator.presentedViewController as? ImageViewController else {
            return nil
        }
        return imageViewController.interactionController
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return nil
    }
}
