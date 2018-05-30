//
//  NewListViewController.swift
//  Lists
//
//  Created by Tony Albor on 5/29/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

import UIKit

class NewListViewController: UIViewController {
    
    override func loadView() {
        view = NewListContentView()
    }
    
    var contentView: NewListContentView {
        return view as! NewListContentView
    }
    
    private let context: NewListContext
    
    init(context: NewListContext) {
        self.context = context
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImageView()
        setUpTextField()
        setUpActions()
    }
    
    override func becomeFirstResponder() -> Bool {
        return contentView.textField.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        return contentView.textField.resignFirstResponder()
    }
    
    override var isFirstResponder: Bool {
        return contentView.textField.isFirstResponder
    }
    
    private func setUpActions() {
        contentView.back.addTarget(self, action: #selector(handleBackTap), for: .touchUpInside)
        contentView.cancel.addTarget(self, action: #selector(handleCancelTap), for: .touchUpInside)
        contentView.done.addTarget(self, action: #selector(handleDoneTap), for: .touchUpInside)
    }
    
    private func setUpImageView() {
        contentView.imageView.af_setImage(withURL: context.detail.imageUrl)
    }
    
    private func setUpTextField() {
        contentView.textField.addTarget(self,
                                        action: #selector(handleTextFieldDidChange),
                                        for: .editingChanged)
        updateButtonState(textField: contentView.textField)
    }
    
    @objc
    private func handleTextFieldDidChange(textField: UITextField) {
        updateButtonState(textField: textField)
    }
    
    @objc
    private func handleBackTap() {
        dismiss(animated: false, completion: nil)
    }
    
    @objc
    private func handleCancelTap() {
        dismiss(animated: true, completion: nil) // maybe cancel whole presentation
    }
    
    @objc
    private func handleDoneTap() {
        guard let title = contentView.textField.text else {
            // TODO: show error?
            return
        }
        context.createList(title: title)
    }
    
    private func updateButtonState(textField: UITextField) {
        let text = textField.text ?? ""
        contentView.cancel.isHidden = !text.isEmpty
        contentView.done.isHidden = text.isEmpty
        contentView.textField.returnKeyType = text.isEmpty ? .default : .done
    }
}
