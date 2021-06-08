//
//  SuggestionsView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI

struct SuggestionsView: View {
    @State private var suggestion = "|"
    var body: some View {
        MenuBaseView(title: "Proposer une amélioration") {
            HStack {
                VStack(alignment: .leading) {
                    Text("Merci de proposer une amélioration")
                        .fontWeight(.bold)
                        .padding(.bottom)
                    Text("Votre proposition d’amélioration concerne:")
                        .padding(.bottom)
                    HStack {
                        HStack {
                            Circle()
                                .fill(Color.accentColor)
                                .frame(width: 12.11, height: 12.11)
                            Text("Fonctionnement général")
                        }
                    }
                    HStack {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 12.11, height: 12.11)
                        Text("Service Mes choix")
                    }
                    HStack {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 12.11, height: 12.11)
                        Text("Service Vie Digitale")
                    }
                    HStack {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 12.11, height: 12.11)
                        Text("Autre")
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
                    
                Button("Envoyer") {
                    
                }
                
            }
            .buttonStyle(MyButtonStyle(foregroundColor: .black))
            .padding(.bottom)
            .shadow(color: .gray.opacity(0.2), radius: 10)
        }
    }
}

struct SuggestionsView_Previews: PreviewProvider {
    static var previews: some View {
        
            SuggestionsView()
        
    }
}
