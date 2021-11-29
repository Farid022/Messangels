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
    var editable = false
    func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .if(editable) { $0.modifier(TextFieldEditButton()) }
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .disableAutocorrection(true)
                .autocapitalization(.none)
        }
}

struct TextFieldEditButton: ViewModifier {
    @State private var disabled = true
    
    func body(content: Content) -> some View {
        HStack {
            content
                .disabled(disabled)
            Button(
                action: { disabled.toggle() },
                label: {
                    Image("ic_edit")
                }
            )
        }
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

struct XTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
}

struct ThinShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .gray.opacity(0.2), radius: 5)
    }
}

struct NormalShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .gray.opacity(0.2), radius: 10)
    }
}
