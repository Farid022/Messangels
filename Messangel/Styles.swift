//
//  Styles.swift
//  Messengel
//
//  Created by Saad on 4/30/21.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {
    var padding: CGFloat = 70.0
    var maxWidth = true
    var foregroundColor = Color.accentColor
    var backgroundColor = Color.white
    var cornerRadius: CGFloat = 20.0
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .if(maxWidth) { $0.frame(maxWidth: .infinity) }
            .foregroundColor(foregroundColor)
            .background(
                backgroundColor.opacity(configuration.isPressed ? 0.5 : 1)
            )
            .cornerRadius(cornerRadius)
            .padding(.horizontal, padding)
    }
}

struct MyTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .disableAutocorrection(true)
                .autocapitalization(.none)
        }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack(alignment: .top) {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 22, height: 22)
                .onTapGesture { configuration.isOn.toggle() }
            configuration.label
        }
    }
}
