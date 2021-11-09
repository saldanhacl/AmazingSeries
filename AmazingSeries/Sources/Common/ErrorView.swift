//
//  ErrorView.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 09/11/21.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
    func didTapReloadButton()
}

final class ErrorView: CodedView {
    
    // MARK: View Elements
    
    private let errorImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "empty")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let errorText: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        view.text = "Something went wrong, but don't worry, you can try again!"
        view.numberOfLines = .zero
        return view
    }()
    
    private let errorButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "reload"), for: .normal)
        view.setTitle("Reload", for: .normal)
        view.tintColor = .white
        view.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
        return view
    }()
    
    // MARK: Internal properties
    
    weak var delegate: ErrorViewDelegate?
        
    // MARK: Coded View
    
    override func buildHierarchy() {
        addSubview(errorImage)
        addSubview(errorText)
        addSubview(errorButton)
    }
    
    override func setupConstraints() {
        constrainErrorImage()
        constrainErrorText()
        constrainButton()
    }
    
    override func aditionalConfiguration() {
        backgroundColor = .clear
    }
    
    private func constrainErrorImage() {
        errorImage.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            width: 80,
            height: 80
        )
    }
    
    private func constrainErrorText() {
        errorText.anchor(
            top: errorImage.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingTop: 8.0
        )
    }
    
    private func constrainButton() {
        errorButton.anchor(
            top: errorText.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            paddingTop: 8.0
        )
    }
    
    // MARK: Actions
    
    @objc private func reloadButtonTapped(sender: UIButton) {
        delegate?.didTapReloadButton()
    }
}
