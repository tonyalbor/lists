//
//  RestaurantDetailView.swift
//  Lists
//
//  Created by Tony Albor on 5/6/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import UIKit

class RestaurantDetailView: UIView {
    
    private(set) lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var imageViewContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.borderColor = UIColor.black.cgColor
        container.layer.borderWidth = 1.0
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubview(imageViewContainer)
        addSubview(imageView)
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200.0),
        ]
        constraints += [
            imageViewContainer.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -10),
            imageViewContainer.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10),
            imageViewContainer.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            imageViewContainer.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
