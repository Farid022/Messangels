//
//  Styles.swift
//  Messengel
//
//  Created by Saad on 4/30/21.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {
    var padding: CGFloat = 70.0
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.accentColor)
            .background(
                Color.white.opacity(configuration.isPressed ? 0.5 : 1)
            )
            .cornerRadius(20)
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
