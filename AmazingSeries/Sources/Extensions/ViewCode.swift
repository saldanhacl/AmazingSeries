//
//  ViewCode.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

protocol ViewCode {
    func buildHierarchy()
    func setupConstraints()
    func aditionalConfiguration()
}

extension ViewCode {
    func setupView() {
        buildHierarchy()
        setupConstraints()
        aditionalConfiguration()
    }

    func buildHierarchy() {}
    func setupConstraints() {}
    func aditionalConfiguration() {}
}

class CodedView: UIView, ViewCode {
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("This view cannot be instantiated from IB.")
    }

    // MARK: - Layout Setup
    
    func buildHierarchy() {
        fatalError("You should override this function in order to setup your CodedView.")
    }

    func setupConstraints() {
        fatalError("You should override this function in order to setup your CodedView.")
    }
    
    func aditionalConfiguration() {}
}

class CodedTableViewCell: UITableViewCell, ViewCode {
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("This view cannot be instantiated from IB.")
    }

    // MARK: - Layout Setup
    
    func buildHierarchy() {
        fatalError("You should override this function in order to setup your CodedView.")
    }

    func setupConstraints() {
        fatalError("You should override this function in order to setup your CodedView.")
    }
}

class CodedCollectionViewCell: UICollectionViewCell, ViewCode {
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
     required init?(coder: NSCoder) {
        fatalError("This view cannot be instantiated from IB.")
    }

    // MARK: - Layout Setup
    
    func buildHierarchy() {
        fatalError("You should override this function in order to setup your CodedView.")
    }

    func setupConstraints() {
        fatalError("You should override this function in order to setup your CodedView.")
    }
}
