//
//  Extentions.swift
//  Kawthar
//
//  Created by Mostafa on 12/24/17.
//  Copyright © 2017 Mostafa. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog


//UIVIEW Extentions
extension UIView{
    
    func setRounded() {
        let radius = self.frame.height / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setRounded(_ radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setBorder(size:CGFloat,color:UIColor) {
        self.layer.borderWidth = size
        self.layer.borderColor = color.cgColor
    }
    
    
    func addShadowView(color:CGColor,width:Int,height:Int,Opacidade:Float,radius:CGFloat) {
        self.layer.shadowColor = color
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowOpacity = Opacidade
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        self.layer.cornerRadius = radius
    }
}

//UIViewController Extentions
extension UIViewController {
    //simple alert
    func showAlert(title: String, message:String, okAction: String = "ok", completion: ((UIAlertAction) -> Void)? = nil ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okAction, style: .default, handler: completion))
        
        present(alert, animated: true, completion: nil)
    }
    //with completion
    func showAlertWithCancel(title: String, message:String, okAction: String = "ok", completion: ((UIAlertAction) -> Void)? = nil ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okAction, style: .default, handler: completion))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true, completion: nil)
    }
    
    func showOkAlert(title:String,message:String) {
        
        // Create the dialog
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                gestureDismissal: false,
                                hideStatusBar: true) {
        }
        
        let okButton = DefaultButton(title: "Ok".localized) {
            popup.dismiss()
        }
        
        popup.addButton(okButton)
        self.present(popup, animated: true, completion: nil)
    }
    
    func showCustomAlert(okFlag:Bool,title:String,message:String,okTitle:String,cancelTitle:String,completion:@escaping (Bool) -> Void) {
        
        // Create the dialog
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                gestureDismissal: false,
                                hideStatusBar: true) {
        }
        
        let cancelButton = CancelButton(title: cancelTitle) {
            completion(false)
            popup.dismiss()
        }
        
        cancelButton.titleColor = UIColor.red
        
        let okButton = DefaultButton(title: okTitle) {
            completion(true)
        }
        
        if okFlag {
            popup.addButton(okButton)
        }else{
            popup.addButtons([okButton,cancelButton])
        }
        
        self.present(popup, animated: true, completion: nil)
    }
    
    func showOkAlertWithComp(title:String,message:String,completion:@escaping (Bool) -> Void) {
        
        // Create the dialog
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                gestureDismissal: false,
                                hideStatusBar: true) {
        }
        
        let okButton = DefaultButton(title: "موافق") {
            completion(true)
        }
        
        popup.addButton(okButton)
        self.present(popup, animated: true, completion: nil)
    }
}


extension String
{
//    var localized: String {
//        return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: "", comment: "")
//    }
    var localized: String {
        
        var lang = "en"
        
        if(L102Language.isRTL)
        {
            lang = "ar"
        }
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        if (L102Language.isRTL) {
            return NSLocalizedString(self, tableName: "Localizable", bundle: bundle!, value: "", comment: "")
            
        } else {
            return NSLocalizedString(self, tableName: "Localizable", bundle: bundle!, value: "", comment: "")
            
        }
    }
    func replacingCharacter(newStr:String,range:NSRange) -> String {
        let str = NSString(string: self).replacingCharacters(in: range, with : newStr) as NSString
        return String(str)
    }
    
    var TOURL: URL {
        if self == ""{
            return URL(string: "www.google.ps")!
        }else{
            return URL(string: self)!
        }
    }
    
    var toImage: UIImage{
        if self == ""{
            return UIImage(named: "placeholder")!
        }else{
            return UIImage(named: self) ?? UIImage()
        }
    }
    
    var toString : String {
        return String(describing: self)
    }
    //cut first caracters from full names
    public func getAcronyms(separator: String = "") -> String {
        let acronyms = self.components(separatedBy: " ").map({ String($0.first!) }).joined(separator: separator);
        return acronyms;
    }
    //remove spaces from text
    var trimmed:String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isEmailValid: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isEmptyStr:Bool{
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty
    }
    
    var color: UIColor {
        let hex = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return UIColor.clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    var cgColor: CGColor {
        return self.color.cgColor
    }
    
    var replaceEmptySpace:String
    {
        return self.replacingOccurrences(of: " ", with: "%20")
    }
    
    var removeEmptySpace:String
    {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    var removeCurrency:String
    {
        return self.replacingOccurrences(of: "SR", with: "")
    }
    
}


//UINavigation Extentions

extension UINavigationController
{
    func pop(animated: Bool) {
        _ = self.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        _ = self.popToRootViewController(animated: animated)
    }
}




//UITextField extentions

extension UITextField
{
    //@Change placeholder color
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
}


//Date
extension Date {
    
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}


extension UIDevice {
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case iPhoneX
        case unknown
    }
    
    var screenType: ScreenType {
        guard iPhone else { return .unknown }
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhone5
        case 1334:
            return .iPhone6
        case 1920, 2208: //2208
            return .iPhone6Plus
        case 2436:
            return .iPhoneX
        default:
            return .unknown
        }
    }
}



public extension UIImage
{
    func base64Encode() -> String?
    {
        guard let imageData = UIImagePNGRepresentation(self) else
        {
            return nil
        }
        let base64String = imageData.base64EncodedString(options: .lineLength76Characters)
        
        let fullBase64String = base64String
        
        return fullBase64String
    }
}


extension UITableView {
    func dequeueTVCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
        }
        return cell
    }
}
extension UICollectionView {
    func dequeueCVCell<T: UICollectionViewCell>(indexPath:IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
        }
        return cell
    }
}

extension UIStoryboard {
    func instanceVC<T: UIViewController>() -> T {
        guard let vc = instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
        }
        return vc
    }
}


extension UINavigationItem
{
    func hideBackWord()  {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.backBarButtonItem = backItem
    }
}

extension Int64{
//    
//    var toDateAgo:String{
//        let date = Date(timeIntervalSince1970: TimeInterval(((self)/1000)))
//        return DateFormatter().timeZone(from: date)
//    }
}


extension UITableView{
    
    func registerCell(id: String) {
        self.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
    }
}

extension UICollectionView{
    
    func registerCell(id: String) {
        self.register(UINib(nibName: id, bundle: nil), forCellWithReuseIdentifier: id)
    }
}




