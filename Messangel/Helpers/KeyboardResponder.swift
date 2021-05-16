//
//  KeyboardResponder.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import Foundation
import SwiftUI

class KeyboardResponder: ObservableObject {
    
    @Published var currentHeight: CGFloat = 0
    private var _center: NotificationCenter
    
    init(center: NotificationCenter = .default) {
        _center = center
        _center.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        _center.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                    withAnimation {
                       currentHeight = keyboardSize.height
                    }
                }
    }
    
    @objc func keyBoardWillHide(notification: Notification) {
        withAnimation {
            currentHeight = 0
        }
    }
}
