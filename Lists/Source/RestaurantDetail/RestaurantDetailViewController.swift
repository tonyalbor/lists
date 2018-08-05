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
    private let allResults: [RestaurantSearchResult]
    
    init(context: RestaurantDetailContext, searchResult: RestaurantSearchResult, allResults: [RestaurantSearchResult]) {
        self.context = context
        self.searchResult = searchResult
        self.allResults = allResults
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.imageView.af_setImage(withURL: searchResult.imageUrl)
        setUpNavBar()
        setUpActions()
//        context.getDetails(id: searchResult.id) { result in
//
//        }
    }
    
    private func setUpNavBar() {
        navigationItem.title = searchResult.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didPressAdd))
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
    
    @objc
    private func didPressAdd() {
        let saveToContext = SaveToContext(detail: searchResult, searchResults: allResults)
        let saveTo = SaveToViewController(context: saveToContext)
        saveTo.modalPresentationStyle = .custom
        saveTo.transitioningDelegate = self
        present(saveTo, animated: true, completion: nil)
    }
}

extension RestaurantDetailViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch presented {
        case is ImageViewController:
            return ImageViewAnimator(isPresenting: true)
        case is SaveToViewController:
            return SaveToAnimator(isPresenting: true)
        default:
            return nil
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch dismissed {
        case is ImageViewController:
            return ImageViewAnimator(isPresenting: false)
        case is SaveToViewController:
            return SaveToAnimator(isPresenting: false)
        default:
            return nil
        }
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let presented = presentedViewController as? ImageViewController else {
            return nil
        }
        return presented.interactionController
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        guard presented is SaveToViewController else {
            return nil
        }
        return HalfModalPresentationController(presentedViewController: presented,
                                               presenting: presenting)
    }
}
