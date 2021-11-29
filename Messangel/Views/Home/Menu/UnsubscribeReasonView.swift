//
//  UnsubscribeReasonView.swift
//  Messangel
//
//  Created by Saad on 5/26/21.
//

import SwiftUI
import NavigationStack

struct UnsubscribeReasonView: View {
    
    @State private var showAlert = false
    var body: some View {
        ZStack{
            MenuBaseView(title: "Désabonnement") {
                VStack(spacing: 30.0) {
                    HStack {
                        Text("Nous sommes désolés d’apprendre votre choix.")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    Text("Quelles sont les raisons qui vous poussent à vous désabonner ?")
                    ChoicesView()
                    
                    Button("Confirmer désabonnement") {
                        withAnimation {
                            showAlert = true
                        }
                    }
                    .buttonStyle(MyButtonStyle(padding: 50,foregroundColor: .white, backgroundColor: .black))
                    .normalShadow()
                }
            }
            if showAlert {
                CustomAlert(isPresented: $showAlert, title: "Vous n’êtes plus abonné(e)", bodyText: "Si vous changez d’avis, vous pourrez récupérer vos données sous 30 jours en vous réabonnant.", buttonText: "OK")
            }
        }
    }
}

struct ReasonCoice: View {
    var text = ""
    var body: some View {
        Button(action: {
            
        }) {
            HStack {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.gray)
                Text(text)
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                Spacer()
            }
        }
    }
}

struct CustomAlert: View {
    @EnvironmentObject var navigationModel: NavigationModel
    
    @Binding var isPresented: Bool
    var title: String
    var bodyText: String
    var buttonText: String
    
    var body: some View {
        Color.black
            .opacity(0.2)
            .ignoresSafeArea()
        VStack(spacing: 15) {
            Text(title)
                .bold()
            Text(bodyText)
                .multilineTextAlignment(.center)
                .font(.system(size: 13))
            Divider()
            Button(action: {
                navigationModel.hideTopViewWithReverseAnimation()
            }) {
                Text(buttonText)
                    .foregroundColor(.accentColor)
            }
        }
        .frame(width: 270)
        .padding(20)
        .background(
            Color.white
                .cornerRadius(20)
        )
    }
}

struct ChoicesView: View {
    @State private var suggestion = "|"
    @State private var choice1 = false
    var body: some View {
        Button(action: {
            withAnimation {
                choice1.toggle()
            }
        }) {
            HStack {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(choice1 ? .accentColor : .gray)
                Text("Choix 1")
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                Spacer()
            }
        }
        ReasonCoice(text: "Choix 2")
        ReasonCoice(text: "Choix 3")
        ReasonCoice(text: "Choix 4")
        ReasonCoice(text: "Autre")
        if choice1 {
            Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam.")
                .foregroundColor(.secondary)
                .font(.system(size: 13))
        }
        TextEditor(text: $suggestion)
            .frame(height: 120)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .normalShadow()
    }
}

struct UnsubscribeReasonView_Previews: PreviewProvider {
    static var previews: some View {
        UnsubscribeReasonView()
    }
}
