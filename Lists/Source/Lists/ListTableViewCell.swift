//
//  ListTableViewCell.swift
//  Lists
//
//  Created by Tony Albor on 8/4/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell, Reusable {
    
    private(set) lazy var listImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
        addSubview(listImage)
        addSubview(name)
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            listImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            listImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
            listImage.widthAnchor.constraint(equalTo: listImage.heightAnchor),
            listImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0),
        ]
        constraints += [
            name.centerYAnchor.constraint(equalTo: centerYAnchor),
            name.leadingAnchor.constraint(equalTo: listImage.trailingAnchor, constant: 16.0),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * 24.0),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
