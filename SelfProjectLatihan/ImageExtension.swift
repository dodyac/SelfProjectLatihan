//
//  ImageExtension.swift
//  SelfProjectLatihan
//
//  Created by mac pro on 22/11/21.
//

import Foundation
import UIKit
import Kingfisher


extension UIImageView {
    
    func setImage(_ imageUrl: String, placeHolder: String) {
        self.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: placeHolder))
    }
}
