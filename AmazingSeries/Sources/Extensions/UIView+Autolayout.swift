//
//  UIView+Autolayout.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit

extension UIView {
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom : NSLayoutYAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        paddingTop: CGFloat = .zero,
        paddingLeading: CGFloat = .zero,
        paddingBottom: CGFloat = .zero,
        paddingTrailing: CGFloat = .zero,
        width: CGFloat = .zero,
        height: CGFloat = .zero
    ){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
        }
        
        if  width != .zero {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if  height != .zero {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerWithSuperview(constant: CGFloat = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let anchorX = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchorX, constant: constant).isActive = true
        }
        
        if let anchorY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchorY, constant: constant).isActive = true
        }
    }
    
    func fillSuperview(
        paddingTop: CGFloat = .zero,
        paddingLeading: CGFloat = .zero,
        paddingBottom: CGFloat = .zero,
        paddingTrailing: CGFloat = .zero
    ) {
        anchor(
            top: superview?.topAnchor,
            leading: superview?.leadingAnchor,
            bottom: superview?.bottomAnchor,
            trailing: superview?.trailingAnchor,
            paddingTop: paddingTop,
            paddingLeading: paddingLeading,
            paddingBottom: paddingBottom,
            paddingTrailing: paddingTrailing
        )
    }
}
