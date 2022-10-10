//
//  UIHelper.swift
//  ReportApp
//
//  Created by LAP15335 on 20/09/2022.
//

import Foundation
import UIKit


//Lato - TextFont
extension UIFont{
    
    static func latoThin(size: CGFloat) -> UIFont?{
        return UIFont(name: "Lato-Thin", size: size)
    }
    
    static func latoLight(size: CGFloat) -> UIFont?{
        return UIFont(name: "Lato-Light", size: size)
    }
    
    static func latoRegular(size: CGFloat) -> UIFont?{
        return UIFont(name: "Lato-Regular", size: size)
    }
    
    static func latoBold(size: CGFloat) -> UIFont?{
        return UIFont(name: "Lato-Bold", size: size)
    }
    
    static func latoBlack(size: CGFloat) -> UIFont?{
        return UIFont(name: "Lato-Black", size: size)
    }
    
    static func latoBlackItalic(size: CGFloat) -> UIFont?{
        return UIFont(name: "Lato-BlackItalic", size: size)
    }
    
    static func latoBoldItalic(size: CGFloat) -> UIFont?{
        return UIFont(name: "Lato-BoldItalic", size: size)
    }
    
    static func latoItalic(size: CGFloat) -> UIFont?{
        return UIFont(name: "Lato-Italic", size: size)
    }
    
    static func latoLightItalic(size: CGFloat) -> UIFont?{
        return UIFont(name: "Lato-LightItalic", size: size)
    }
    static func latoThinItalic(size: CGFloat) -> UIFont?{
        return UIFont(name: "Lato-ThinItalic", size: size)
    }
}


extension UIColor{
    static func hexStringToUIColor (hex:String , alpha: Float) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    static var darkPurple = hexStringToUIColor(hex: "2E038C",alpha: 1)
    static var darkPurple80a = hexStringToUIColor(hex: "2E038C",alpha: 0.8)
    static var darkPurple40a = hexStringToUIColor(hex: "2E038C",alpha: 0.4)
    static var darkPurple20a = hexStringToUIColor(hex: "2E038C",alpha: 0.2)
    static var deepPurple = hexStringToUIColor(hex: "552FAC",alpha: 1)
    static var deepPurple60a = hexStringToUIColor(hex: "552FAC",alpha: 0.6)
    static var zingPurple = hexStringToUIColor(hex: "72179A",alpha: 1)
    static var zingPurple70a = hexStringToUIColor(hex: "72179A",alpha: 0.7)
    static var zingPurple40a = hexStringToUIColor(hex: "72179A",alpha: 0.4)
    static var gray70a = hexStringToUIColor(hex: "9C9494",alpha: 0.7)
    static var noteColor = hexStringToUIColor(hex: "FFF1A6", alpha: 1.0)
    static var darkGreen = hexStringToUIColor(hex: "2B8B2F",alpha: 1.0)
    static var darkYellow = hexStringToUIColor(hex: "DBA800", alpha: 1.0)
    static var darkRed = hexStringToUIColor(hex: "8b0000", alpha: 1.0)
    
}


extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.height / 2)
        self.layer.masksToBounds = true
    }
}


extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}


extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
            
        case UIRectEdge.bottom:
            border.frame = CGRect(x:0, y: frame.height - thickness, width: frame.width, height:thickness)
            
        case UIRectEdge.left:
            border.frame = CGRect(x:0, y:0, width: thickness, height: frame.height)
            
        case UIRectEdge.right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            
        default: do {}
        }
        
        border.backgroundColor = color.cgColor
        
        addSublayer(border)
    }
}

extension UINavigationController{
    
    func setNavBarImage(_ image:UIImage?) {
        
        guard let image = image  else {return}
        
        self.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        
        
    }
}


//Auto hide keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func keyboardMoveView(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension UIImage{
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension UITextField{
    
    func setCursorForMacCatalyst(){
        
#if targetEnvironment(macCatalyst)
        let textInputTraits = self.value(forKey: "textInputTraits") as? NSObject
        textInputTraits?.setValue(UIColor.red, forKey: "insertionPointColor")
#endif
        
    }
}

extension UITextView{
    func setCursorForMacCatalyst(){
        
#if targetEnvironment(macCatalyst)
        let textInputTraits = self.value(forKey: "textInputTraits") as? NSObject
        textInputTraits?.setValue(UIColor.red, forKey: "insertionPointColor")
#endif
        
    }
}
