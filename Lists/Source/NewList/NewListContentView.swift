//
//  NewListContentView.swift
//  Lists
//
//  Created by Tony Albor on 5/29/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import UIKit

class NewListContentView: UIView {
    
    private(set) lazy var title: UILabel = {
        let label = UILabel()
        label.text = "New List"
        label.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var back: UIButton = {
        let button = UIButton()
        // TODO: get back arrow image
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(UIColor.black.withAlphaComponent(0.6), for: .highlighted)
        button.setTitle("Back", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var topSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    private(set) lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var textField: UITextField = {
        let field = UITextField()
        field.tintColor = .blue
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    // consider adding underline that is constrained to textfield width and is just below the textfield
    
    private(set) lazy var bottomSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    private(set) lazy var cancel: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var done: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cyan
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpSubviews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.height * 0.15
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1.0 / UIScreen.main.scale
    }
    
    private func setUpSubviews() {
        addSubview(title)
        addSubview(back)
        addSubview(topSeparator)
        addSubview(imageView)
        addSubview(textField)
        addSubview(bottomSeparator)
        addSubview(cancel)
        addSubview(done)
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            title.heightAnchor.constraint(equalToConstant: 32.0),
        ]
        constraints += [
            back.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            back.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        ]
        constraints += [
            topSeparator.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            topSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale),
        ]
        constraints += [
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topSeparator.bottomAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
        ]
        constraints += [
            textField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
        ]
        constraints += [
            bottomSeparator.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 12),
            bottomSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSeparator.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale),
            bottomSeparator.bottomAnchor.constraint(equalTo: cancel.topAnchor),
        ]
        constraints += [
            cancel.heightAnchor.constraint(equalToConstant: 40),
            cancel.leadingAnchor.constraint(equalTo: leadingAnchor),
            cancel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            cancel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        constraints += done.constraintsTo(view: cancel)
        NSLayoutConstraint.activate(constraints)
    }
}
