//
//  CustomTextField.swift
//  ReportApp
//
//  Created by LAP15335 on 21/09/2022.
//

import Foundation
import UIKit
class CustomTextField : UITextField {
    let insets : UIEdgeInsets
    
    init(insets: UIEdgeInsets, text: String , imageName: String){
        self.insets = insets
        super.init(frame: .zero)
        
        layer.borderWidth = 1.0
        layer.cornerRadius = 18
        layer.borderColor = UIColor.darkPurple40a.cgColor
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkPurple40a,
                         NSAttributedString.Key.font : UIFont.latoLight(size: 18)!]
        )
        
        let imageView = UIImageView(frame: CGRect(x: -2, y: 8.0, width: 24.0, height: 24.0))
        let image = UIImage(named: imageName)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
       

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        view.backgroundColor = .clear
        rightViewMode = UITextField.ViewMode.always
        rightView = view
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error Create CustomTextField")
    }
    
}
