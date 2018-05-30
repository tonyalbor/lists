//
//  SaveToViewController.swift
//  Lists
//
//  Created by Tony Albor on 5/28/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import UIKit

class SaveToViewController: UIViewController {
    
    override func loadView() {
        view = SaveToContentView()
    }
    
    var contentView: SaveToContentView {
        return view as! SaveToContentView
    }
    
    private let context: SaveToContext
    
    init(context: SaveToContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpActions()
    }
    
    private func setUpCollectionView() {
        contentView.lists.dataSource = self
        contentView.lists.delegate = self
        contentView.lists.registerCell(SaveToItemCollectionViewCell.self)
    }
    
    private func setUpActions() {
        contentView.cancel.addTarget(self, action: #selector(tappedCancel), for: .touchUpInside)
        contentView.add.addTarget(self, action: #selector(tappedAdd), for: .touchUpInside)
    }
    
    @objc
    private func tappedCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func tappedAdd() {
        let newListContext = NewListContext(detail: context.detail)
        let vc = NewListViewController(context: newListContext)
        vc.modalPresentationStyle = .overCurrentContext
        vc.transitioningDelegate = transitioningDelegate
        present(vc, animated: false, completion: nil)
    }
}

extension SaveToViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return context.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueResuableCell(indexPath: indexPath) as SaveToItemCollectionViewCell
        let result = context.searchResults[indexPath.item]
        cell.imageView.af_setImage(withURL: result.imageUrl)
        cell.title.text = result.name
        return cell
    }
}

extension SaveToViewController: UICollectionViewDelegate {
    
}

extension SaveToViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height * 0.5,
                      height: collectionView.bounds.height * 0.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
