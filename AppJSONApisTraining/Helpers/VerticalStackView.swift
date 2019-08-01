//
//  VerticalStackView.swift
//  AppJSONApisTraining
//
//  Created by Mai Le Duong on 8/1/19.
//  Copyright © 2019 Mai Le Duong. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {
    init(arrangedSubVies: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        
        arrangedSubVies.forEach({addArrangedSubview($0)})
        self.axis = .vertical
        self.spacing = spacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
