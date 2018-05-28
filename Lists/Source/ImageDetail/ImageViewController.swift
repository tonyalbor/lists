//
//  ImageViewController.swift
//  Lists
//
//  Created by Tony Albor on 5/27/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    override func loadView() {
        view = ImageContentView(image: image)
    }
    
    var contentView: ImageContentView {
        return view as! ImageContentView
    }
    
    private let image: UIImage?
    private(set) var interactionController: UIPercentDrivenInteractiveTransition?
    
    init(image: UIImage?) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpActions()
    }
    
    private func setUpActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleImageViewTap))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        contentView.imageView.addGestureRecognizer(tap)
        contentView.imageView.addGestureRecognizer(pan)
    }
    
    @objc
    private func handleImageViewTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func handlePan(pan: UIPanGestureRecognizer) {
        let translation = pan.translation(in: pan.view)
        let percentage = fabs(translation.y * 2 / contentView.imageView.bounds.height)
        switch pan.state {
        case .began:
            pan.setTranslation(.zero, in: pan.view)
            interactionController = UIPercentDrivenInteractiveTransition()
            dismiss(animated: true, completion: nil)
        case .changed:
            contentView.imageView.transform = CGAffineTransform(translationX: translation.x,
                                                                y: translation.y)
            interactionController?.update(percentage)
        case .ended, .cancelled, .failed:
            let velocity = abs(pan.velocity(in: pan.view).y)
            if (percentage > 0.85 && velocity >= 0) ||
               (percentage > 0.65 && velocity >= 25) ||
               (velocity > 50) {
                interactionController?.finish()
            } else {
                interactionController?.cancel()
            }
            interactionController = nil
        default:
            break
        }
    }
}
