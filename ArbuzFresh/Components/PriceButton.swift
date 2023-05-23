//
//  PriceButton.swift
//  ArbuzFresh
//
//  Created by Mereke on 23.05.2023.
//

import Foundation
import UIKit

class PriceButton: UIButton {
    let spacing: CGFloat = 10.0

    override func layoutSubviews() {
        super.layoutSubviews()

        if let imageView = imageView, let titleLabel = titleLabel {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
            
            let insetAmount = spacing / 2 + min(imageView.frame.width, titleLabel.frame.width) / 2
            contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }
}
