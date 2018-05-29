//
//  ImageContentView.swift
//  Lists
//
//  Created by Tony Albor on 5/27/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import UIKit

class ImageContentView: UIView {
    
    private(set) lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(image: UIImage?) {
        super.init(frame: .zero)
        backgroundColor = .black
        imageView.image = image
        setUpSubviews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        addSubview(imageView)
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
