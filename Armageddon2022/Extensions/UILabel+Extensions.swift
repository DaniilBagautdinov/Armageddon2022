//
//  UIStackView+UIView.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 26.04.2022.
//

import UIKit

extension UILabel {
    func setFont() {
        if UIScreen.main.bounds.size.width == 320 {
            font = UIFont(name: "Helvetica", size: 17)
        }
    }
}
