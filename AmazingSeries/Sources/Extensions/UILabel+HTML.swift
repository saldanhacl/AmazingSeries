//
//  UILabel+HTML.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

extension UILabel {
    func renderAsHTML(
        _ string: String,
        with font: UIFont,
        color: UIColor
    ) {
        guard !string.isEmpty else { return }

        do {
            let modifiedFont = String(
                format:
                    "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/><span style=\"font-family: '-apple-system', \(font.fontName.replacingOccurrences(of: ".", with: "")); font-size: \(font.pointSize); color: \(color.toHexString() )\">%@</span>"
                ,string
            )

            guard let data = modifiedFont.data(using: .utf8) else {
                text = string
                return
            }

            let attributedText = try NSMutableAttributedString(
                data: data,
                options: [
                    NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                ],
                documentAttributes: nil
            )

            self.attributedText = attributedText
        } catch {
            text = string
        }
    }
}
