//
//  RestaurantSearchResultTableViewCell.swift
//  Lists
//
//  Created by Tony Albor on 5/6/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

class RestaurantSearchResultTableViewCell: UITableViewCell, Reusable {
    
    var result: RestaurantSearchResult? {
        didSet {
            guard let result = result else { return }
            name.text = result.name
            rating.text = "\(result.rating)"
            reviewCount.text = "\(result.reviewCount)"
            price.text = result.price
        }
    }
    
    private(set) lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private(set) lazy var imageOverlay: UIView = {
        let overlay = UIView()
        overlay.backgroundColor = .black
        overlay.alpha = 0.25
        overlay.translatesAutoresizingMaskIntoConstraints = false
        return overlay
    }()
    
    private(set) lazy var name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingContainer: UIView = {
        let container = UIView()
        container.autoresizingMask = .flexibleWidth
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private(set) lazy var rating: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var reviewCount: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var price: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubview(backgroundImage)
        addSubview(imageOverlay)
        addSubview(name)
        addSubview(ratingContainer)
        addSubview(price)
        ratingContainer.addSubview(rating)
        ratingContainer.addSubview(reviewCount)
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += backgroundImage.constraintsTo(view: self)
        constraints += imageOverlay.constraintsTo(view: self)
        constraints += [
            name.topAnchor.constraint(equalTo: topAnchor, constant: 20.0),
            name.centerXAnchor.constraint(equalTo: centerXAnchor),
        ]
        constraints += [
            ratingContainer.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8.0),
            ratingContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
        ]
        constraints += [
            rating.topAnchor.constraint(equalTo: ratingContainer.topAnchor),
            rating.leadingAnchor.constraint(equalTo: ratingContainer.leadingAnchor),
            rating.bottomAnchor.constraint(equalTo: ratingContainer.bottomAnchor),
        ]
        constraints += [
            reviewCount.topAnchor.constraint(equalTo: ratingContainer.topAnchor),
            reviewCount.leadingAnchor.constraint(equalTo: rating.trailingAnchor, constant: 4.0),
            reviewCount.bottomAnchor.constraint(equalTo: ratingContainer.bottomAnchor),
            reviewCount.trailingAnchor.constraint(equalTo: ratingContainer.trailingAnchor),
        ]
        constraints += [
            price.topAnchor.constraint(equalTo: ratingContainer.topAnchor, constant: 8.0),
            price.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension UIView {
    func constraintsTo(view: UIView) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
    }
}
