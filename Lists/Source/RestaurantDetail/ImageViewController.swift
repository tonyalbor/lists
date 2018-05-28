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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("nice")
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
    
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    @objc
    private func handlePan(pan: UIPanGestureRecognizer) {
        let translation = pan.translation(in: pan.view)
        let percentage = fabs(translation.y / view.bounds.height) * 2
        switch pan.state {
        case .began:
            pan.setTranslation(.zero, in: pan.view)
            interactionController = UIPercentDrivenInteractiveTransition()
            dismiss(animated: true, completion: nil)
        case .changed:
            interactionController?.update(percentage)
        case .ended, .cancelled, .failed:
            let velocity = abs(pan.velocity(in: pan.view).y)
            if (percentage > 0.5 && velocity >= 0) || velocity > 0 {
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
