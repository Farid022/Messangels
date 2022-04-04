//
//  Extensions.swift
//  Messangel
//
//  Created by Saad on 5/9/21.
//

import Foundation
import SwiftUI
import Kingfisher

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

//MARK: - String

extension NSAttributedString {
    func setFontSize(fontSize: CGFloat) -> NSMutableAttributedString {
        let newStr = self.mutableCopy() as! NSMutableAttributedString
        newStr.beginEditing()
        newStr.enumerateAttribute(.font, in: NSRange(location: 0, length: newStr.string.utf16.count)) { (value, range, stop) in
            if let oldFont = value as? UIFont {
                let newFont = oldFont.withSize(fontSize)
                newStr.addAttribute(.font, value: newFont, range: range)
            }
        }
        newStr.endEditing()
        return newStr
    }
}

extension Optional where Wrapped == String {
    var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}

extension String {
    func separate(every stride: Int = 2, with separator: Character = " ") -> String {
        return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

public extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    //right is the first encountered string after left
    func between(_ left: String, _ right: String) -> String? {
        guard
            let leftRange = range(of: left), let rightRange = range(of: right, options: .backwards)
            , leftRange.upperBound <= rightRange.lowerBound
            else { return nil }
        
        let sub = self[leftRange.upperBound...]
        let closestToLeftRange = sub.range(of: right)!
        return String(sub[..<closestToLeftRange.lowerBound])
    }
    
    var length: Int {
        get {
            return self.count
        }
    }
    
    func substring(to : Int) -> String {
        let toIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[...toIndex])
    }
    
    func substring(from : Int) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return String(self[fromIndex...])
    }
    
    func substring(_ r: Range<Int>) -> String {
        if r.lowerBound > self.startIndex.utf16Offset(in: self) {
            return ""
        }
        let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        let indexRange = Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))
        return String(self[indexRange])
    }
    
    func character(_ at: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: at)]
    }
    
    func lastIndexOfCharacter(_ c: Character) -> Int? {
        guard let index = range(of: String(c), options: .backwards)?.lowerBound else
        { return nil }
        return distance(from: startIndex, to: index)
    }
}

// MARK: - View

extension View {
    func animate(using animation: Animation = Animation.easeInOut(duration: 1), _ action: @escaping () -> Void) -> some View {
        onAppear {
            DispatchQueue.main.async {
                withAnimation(animation) {
                    action()
                }
            }
        }
    }
}

extension View {
    func animateForever(using animation: Animation = Animation.easeInOut(duration: 1), autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View {
        let repeated = animation.repeatForever(autoreverses: autoreverses)
        
        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
}

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }
}

extension View {
  @ViewBuilder
  func `if`<TrueContent: View, FalseContent: View>(
    _ condition: Bool,
    if ifTransform: (Self) -> TrueContent,
    else elseTransform: (Self) -> FalseContent
  ) -> some View {
    if condition {
      ifTransform(self)
    } else {
      elseTransform(self)
    }
  }
}

extension View {
    func xTextFieldStyle() -> some View {
        self.modifier(XTextField())
    }
    func thinShadow() -> some View {
        self.modifier(ThinShadow())
    }
    func normalShadow() -> some View {
        self.modifier(NormalShadow())
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var screenSize: CGRect {
        return UIScreen.main.bounds
    }
}

// MARK: - Application

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    static var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }
}

extension UIDevice {
    var hasNotch: Bool {
//        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        return UIApplication.keyWindow?.safeAreaInsets.bottom ?? 0 > 0
    }
    
}

//MARK: - Image Ext

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}

extension KFImage {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}
