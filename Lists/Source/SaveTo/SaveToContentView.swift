//
//  SaveToContentView.swift
//  Lists
//
//  Created by Tony Albor on 5/28/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import UIKit

class SaveToContentView: UIView {
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Save to"
        label.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var add: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var topSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    private(set) lazy var lists: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var bottomSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    private(set) lazy var cancel: UIButton = {
        let button = UIButton()
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.setTitle("Cancel", for: .normal)
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
    
    private func setUpSubviews() {
        addSubview(title)
        addSubview(add)
        addSubview(topSeparator)
        addSubview(lists)
        addSubview(bottomSeparator)
        addSubview(cancel)
    }

    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            title.heightAnchor.constraint(equalToConstant: 32.0),
        ]
        constraints += [
            add.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            add.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1 * 8),
        ]
        constraints += [
            topSeparator.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            topSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale),
        ]
        constraints += [
            lists.topAnchor.constraint(equalTo: topSeparator.bottomAnchor),
            lists.leadingAnchor.constraint(equalTo: leadingAnchor),
            lists.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        constraints += [
            bottomSeparator.topAnchor.constraint(equalTo: lists.bottomAnchor),
            bottomSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSeparator.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale),
        ]
        constraints += [
            cancel.topAnchor.constraint(equalTo: bottomSeparator.bottomAnchor, constant: 8),
            cancel.leadingAnchor.constraint(equalTo: leadingAnchor),
            cancel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            cancel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
