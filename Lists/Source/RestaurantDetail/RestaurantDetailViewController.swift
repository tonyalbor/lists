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
    
    private let context: RestaurantDetailContext
    private let searchResult: RestaurantSearchResult
    
    init(context: RestaurantDetailContext, searchResult: RestaurantSearchResult) {
        self.context = context
        self.searchResult = searchResult
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.imageView.af_setImage(withURL: searchResult.imageUrl)
        setUpActions()
        // request full details
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
