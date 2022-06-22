//
//  MyMessagesIntro.swift
//  Messangel
//
//  Created by Saad on 6/17/22.
//

import SwiftUI
import NavigationStack

struct MyMessagesIntro: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        NavigationStackView(String(describing: Self.self)) {
            ZStack {
                Color.accentColor
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    HStack {
                        BackButton()
                        Spacer()
                    }
                    Spacer()
                    Text("Les messages de mes proches")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                    Text("""
                                Ceci est un message d’avertissement à rédiger
                                    Lorem ipsum dolor sit amet, consetetur
                                       sadipscing elitr, sed diam nonumy.
                                """)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                    Spacer().frame(height: 10)
                    Button("Continuer") {
                        navigationModel.pushContent(String(describing: Self.self)) {
                            MyMessagesSec()
                        }
                    }
                    .buttonStyle(MyButtonStyle(foregroundColor: .accentColor))
                    Spacer()
                }.padding()
            }
            .foregroundColor(.white)
        }
    }
}
