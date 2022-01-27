//
//  CustomViews.swift
//  Messengel
//
//  Created by Saad on 4/30/21.
//

import SwiftUIX
import NavigationStack
import SwiftUI

struct MyLink: View {
    var url = "https://www.google.com/"
    var text: String
    var fontSize: CGFloat = 13
    var body: some View {
        Link(destination: URL(string: url)!, label: {
            Text(text)
                .font(.system(size: fontSize))
                .underline()
        })
    }
}

struct NextButton: View {
    var isCustomAction = false
    var customAction: () -> Void = {}
    var source: String
    var destination: AnyView
    
    @Binding var active: Bool
    @EnvironmentObject private var navigationModel: NavigationModel
    
    var body: some View {
        Rectangle()
            .frame(width: 56, height: 56)
            .cornerRadius(25)
            .opacity(active ? 1 : 0.5)
            .overlay(
                Button(action: {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    if active && isCustomAction {
                        customAction()
                    } else if active {
                        navigationModel.pushContent(source) {
                            destination
                        }
                    }
                }) {
                    Image(systemName: "chevron.right").foregroundColor(.accentColor)
                }
            )
    }
}

struct SignupProgressView: View {
    @Binding var progress: Double
    var tintColor = Color.white
    var progressMultiplier = 12.5
    
    var body: some View {
        ProgressView(value: progress, total: 100.0)
            .progressViewStyle(LinearProgressViewStyle(tint: tintColor))
            .padding(.horizontal, -15)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation {
                        progress += progressMultiplier
                    }
                }
            }
    }
}

struct CustomCorner: Shape {
    
    var corners: UIRectCorner
    var radius = 25.0
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

var months = ["Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Août","Septembre","Octobre","Novembre","Décembre"]

struct MyDatePickerView: View {
    @Binding var day: Int
    @Binding var month: String
    @Binding var year: Int
    
    var body: some View {
        HStack {
            Spacer().frame(width: 20)
            Picker(selection: $day, label: HStack(alignment: .bottom) {
                Image("updown")
                Text("\(day)").font(.system(size: 20))
            }) {
                ForEach((1...31), id: \.self) {
                    Text("\($0)")
                }
            }
            Spacer()
            Picker(selection: $month, label: HStack(alignment: .bottom) {
                Image("updown")
                Text("\(month)").font(.system(size: 20))
            }) {
                ForEach(months, id: \.self) {
                    Text("\($0)")
                }
            }
            Spacer()
            Picker(selection: $year, label: HStack(alignment: .bottom) {
                Image("updown")
                Text(String(year)).font(.system(size: 20))
            }) {
                ForEach((1930...2010), id: \.self) {
                    Text(String($0))
                }
            }
            Spacer().frame(width: 20)
        }
        .padding().background(Color.white).cornerRadius(20).foregroundColor(.black).pickerStyle(MenuPickerStyle())
    }
}


struct CustomTextField: UIViewRepresentable {
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        var didBecomeFirstResponder = false
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
    }
    
    @Binding var text: String
    var isFirstResponder: Bool = false
    
    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }
    
    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text)
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}

struct InputAlert: View {
    @State private var inputText = ""
    var title: String
    var message: String
    var placeholder = ""
    var ok = "Valider"
    var cancel = "Cancel"
    var action: (String?) -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 22.0)
            .foregroundColor(.white)
            .frame(width: 270, height: 188)
            .thinShadow()
            .overlay(
                VStack {
                    Text(title)
                        .font(.system(size: 17), weight: .semibold)
                        .padding(.bottom, 5)
                    Text(message)
                        .font(.system(size: 13))
                        .multilineTextAlignment(.center)
                    CocoaTextField(placeholder, text: $inputText)
                        .isInitialFirstResponder(true)
                        .borderStyle(.roundedRect)
                        .padding(.bottom, 5)
                    Divider()
                        .padding(.horizontal, -15)
                    HStack {
                        Spacer()
                        Button(action: {
                            action(nil)
                        }) {
                            Text(cancel)
                                .font(.system(size: 17))
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Divider()
                            .padding(.top, -3)
                        Spacer()
                        Button(action: {
                            action(inputText)
                        }) {
                            Text(ok)
                                .font(.system(size: 17), weight: .semibold)
                                .foregroundColor(.accentColor)
                        }
                        Spacer()
                    }
                    .padding(.vertical, -5)
                }
                .padding(.horizontal)
                .padding(.top, 25)
            )
    }
}

struct MyAlert: View {
    var title: String
    var message: String
    var ok = "Supprimer"
    var cancel = "Annuler"
    var action: () -> Void
    @Binding var showAlert: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 22.0)
            .foregroundColor(.white)
            .frame(width: 270, height: 188)
            .thinShadow()
            .overlay(
                VStack {
                    Text(title)
                        .font(.system(size: 17), weight: .semibold)
                        .padding(.bottom, 5)
                    Text(message)
                        .font(.system(size: 13))
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                    Divider()
                        .padding(.horizontal, -15)
                    HStack {
                        Spacer()
                        Button(action: {
                            showAlert.toggle()
                        }) {
                            Text(cancel)
                                .font(.system(size: 17))
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Divider()
//                            .padding(.top, -3)
                        Spacer()
                        Button(action: {
                            showAlert.toggle()
                            action()
                        }) {
                            Text(ok)
                                .font(.system(size: 17), weight: .semibold)
                                .foregroundColor(.accentColor)
                        }
                        Spacer()
                    }
                    .frame(height: 44)
//                    .padding(.vertical, -5)
                }
                .padding(.horizontal)
                .padding(.top, 25)
            )
    }
}

struct ListItemView: View {
    var name = ""
    var image = "ic_company"
    
    var body: some View {
        Capsule()
            .fill(Color.white)
            .frame(height: 56)
            .normalShadow()
            .overlay(HStack{
                Image(image)
                    .padding(.leading)
                Text(name)
                Spacer()
                Image("ic_add_circle")
                    .padding(.trailing)
            })
            .padding(.bottom)
    }
}
