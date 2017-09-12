//
//  DesignView.swift
//  GreatLookingLoginInterface
//
//  Created by Arkadijs Makarenko on 26/06/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit

@IBDesignable class DesignView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
}
