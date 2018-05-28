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

extension RestaurantDetailViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ImageViewAnimator(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ImageViewAnimator(isPresenting: false)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (presentedViewController as? ImageViewController)?.interactionController
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return nil
    }
}
