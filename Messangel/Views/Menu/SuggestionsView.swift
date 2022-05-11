//
//  SuggestionsView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI
import NavigationStack
//import module

struct Suggestion: Codable {
    var type: Int
    var suggestion: String
    var user = getUserId()
}

struct SuggestionsView: View {
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var suggestion = ""
    @State private var selectedOption = 0
    @State private var alert = false;
    private let options = ["Fonctionnement général", "Service Messages", "Service Mes choix", "Service Vie Digitale", "Autre"]
    var body: some View {
        MenuBaseView(title: "Proposer une amélioration") {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Merci de proposer une amélioration")
                            .fontWeight(.bold)
                            .padding(.bottom)
                        Text("Votre proposition d’amélioration concerne:")
                            .font(.system(size: 13))
                            .padding(.bottom)
                        ForEach((1...5), id: \.self) { i in
                            HStack {
                                Circle()
                                    .fill(selectedOption == i ? Color.accentColor : Color.gray)
                                    .frame(width: 12.11, height: 12.11)
                                Text(options[i-1])
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)
                            }
                            .padding(.bottom)
                            .onTapGesture {
                                selectedOption = i
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.bottom)
            Group {
                TextEditor(text: $suggestion)
                    .frame(height: 120)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .onChange(of: suggestion) { _ in
                        if !suggestion.filter({ $0.isNewline }).isEmpty {
                            hideKeyboard()
                        }
                    }
                    
                Button("Envoyer") {
                    APIService.shared.post(model: Suggestion(type: selectedOption, suggestion: suggestion), response: Suggestion(type: 0, suggestion: ""), endpoint: "users/suggestions") { result in
                        switch result {
                            
                        case .success(_):
                            DispatchQueue.main.async {
                                alert.toggle()
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
            .buttonStyle(MyButtonStyle(foregroundColor: .black))
            .padding(.bottom)
            .normalShadow()
            }
            .offset(y: kGuardian.slide == 0 ? 0 : -(kGuardian.slide - 300))
            .animation(.default, value: kGuardian.slide)
        }
        .onAppear { self.kGuardian.addObserver() }
        .onDisappear { self.kGuardian.removeObserver() }
        .alert("Merci de votre contribution", isPresented: $alert, actions: {
            Button("OK", role: .cancel) {
                navigationModel.popContent("Accueil")
            }
        }, message: {
            Text("Nous vous remercions de contribuer à l'évolution de Messangel.")
        })
    }
}

final class KeyboardGuardian: ObservableObject {
    public var rects: Array<CGRect>
    public var keyboardRect: CGRect = CGRect()

    // keyboardWillShow notification may be posted repeatedly,
    // this flag makes sure we only act once per keyboard appearance
    public var keyboardIsHidden = true

    @Published var slide: CGFloat = 0

    var showField: Int = 0 {
        didSet {
            updateSlide()
        }
    }

    init(textFieldCount: Int) {
        self.rects = Array<CGRect>(repeating: CGRect(), count: textFieldCount)

    }

    func addObserver() {
NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
}

func removeObserver() {
 NotificationCenter.default.removeObserver(self)
}

    deinit {
        NotificationCenter.default.removeObserver(self)
    }



    @objc func keyBoardWillShow(notification: Notification) {
        if keyboardIsHidden {
            keyboardIsHidden = false
            if let rect = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
                keyboardRect = rect
                updateSlide()
            }
        }
    }

    @objc func keyBoardDidHide(notification: Notification) {
        keyboardIsHidden = true
        updateSlide()
    }

    func updateSlide() {
        if keyboardIsHidden {
            slide = 0
        } else {
            let tfRect = self.rects[self.showField]
            let diff = keyboardRect.minY - tfRect.maxY

            if diff > 0 {
                slide += diff
            } else {
                slide += min(diff, 0)
            }

        }
    }
}

struct GeometryGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { geometry in
            Group { () -> AnyView in
                DispatchQueue.main.async {
                    self.rect = geometry.frame(in: .global)
                }

                return AnyView(Color.clear)
            }
        }
    }
}
