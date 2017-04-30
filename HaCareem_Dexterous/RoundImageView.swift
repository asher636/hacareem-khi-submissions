//
//  RoundImageView.swift
//  HaCareem_Dexterous
//
//  Created by Mubeen Nisar on 4/29/17.
//  Copyright © 2017 Asher Ahsan. All rights reserved.
//

import UIKit
extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
