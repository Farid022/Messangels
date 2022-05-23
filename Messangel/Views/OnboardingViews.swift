//
//  OnboardingView.swift
//  Messangel
//
//  Created by Saad on 5/27/21.
//

import SwiftUI

struct OnboardingView: View {
    @State var onboardingIndex = -1
    @Binding var onboardingStarted: Bool
    @Binding var onboardingCompleted: Bool
    @Binding var onboardingCancelled: Bool
    @Binding var selectedTab: String
    
    var body: some View {
        Rectangle()
            .fill(Color("bg"))
            .frame(width: 270, height: 400)
            .cornerRadius(25)
            .zIndex(1.0)
            .overlay(
                VStack {
                    TabView(selection: $onboardingIndex) {
                        ForEach(0 ..< tutorials.count - 1) { _ in
                            TutorialView(title: tutorials[onboardingIndex+1]["title"]!, image: tutorials[onboardingIndex+1]["image"]!, desc: tutorials[onboardingIndex+1]["desc"]!)
                                .gesture(DragGesture())
                        }
                    }
                    .disabled(!onboardingStarted)
                    .tabViewStyle(PageTabViewStyle())
                    Rectangle()
                        .fill(Color.gray.opacity(0.25))
                        .frame(height: 1)
                    Button(action: {
                        withAnimation {
                            if onboardingIndex < tutorials.count - 2 {
                                onboardingStarted = true
                                onboardingIndex += 1
                                selectedTab = tabs[onboardingIndex]
                            } else {
                                onboardingCompleted = true
                            }
                        }
                    }, label: {
                        Text(onboardingStarted ? "Continuer" : "Oui")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                    })
                    .padding(.vertical, 5)
                    Rectangle()
                        .fill(Color.gray.opacity(0.25))
                        .frame(height: 1)
                    Button(onboardingStarted ? "Quitter" :"Non, passer", action: {
                        withAnimation {
                            onboardingCancelled = true
                        }
                    })
                    .accentColor(.black)
                    .padding(.top, 5)
                    .padding(.bottom, 15)
                }
            )
    }
}

struct OnboardingFinishView: View {
    @AppStorage("onboardingShown") var onboardingShown = false
    var title: String
    @Binding var selectedTab: String
    
    var body: some View {
        Rectangle()
            .fill(Color("bg"))
            .frame(width: 270, height: 300)
            .cornerRadius(25)
            .zIndex(1.0)
            .overlay(
                VStack {
                    TutorialView(title: title, image: "info", desc: "Conseil : Servez-vous du guide Messangel pour vous aider dans vos choix si besoin.")
                        .padding(.bottom, -40)
                    Rectangle()
                        .fill(Color.gray.opacity(0.25))
                        .frame(height: 1)
                    Button(action: {
                        withAnimation {
                            onboardingShown = true
                            selectedTab = "Accueil"
                        }
                    }, label: {
                        Text("Ok, démarrer")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                    })
                    .padding(.vertical, 5)
                }
            )
    }
}

struct TutorialView: View {
    var title: String
    var image: String
    var desc: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 17))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
            Rectangle()
                .fill(Color.white)
                .frame(width: 80, height: 80)
                .cornerRadius(35)
                .thinShadow()
                .overlay(Image(image))
            Text(desc)
                .font(.system(size: 13))
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding(.bottom, 30)
    }
}

var tutorials = [
    ["title": "Voulez-vous suivre le tutoriel de démarrage ?",
     "image": "Messangels",
     "desc": "Ce tutoriel de 2 minutes vous permettra de vous familiariser avec les services proposés par Messangel."
    ],
    ["title": "Accueil : Mon Messangel",
     "image": "Accueil",
     "desc": "Accueil dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et"
    ],
    ["title": "Messages",
     "image": "Messages",
     "desc": "Messages dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et"
    ],
    ["title": "Mes souhaits",
     "image": "Mes souhaits",
     "desc": "Mes choix dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et"
    ],
    ["title": "Vie digitale",
     "image": "Vie digitale",
     "desc": "Vie digitale dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et"
    ]
]
