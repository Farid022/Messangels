//
//  TabBar.swift
//  Salad
//
//  Created by Balaji on 13/11/20.
//

import SwiftUI

struct TabBarView: View {
    @State var selectedTab = "Accueil"
    @AppStorage("onboardingShown") var onboardingShown = false
    @State var onboardingStarted = false
    @State var onboardingCompleted = false
    @State var onboardingCancelled = false
    @State var onboardingIndex = -1
    
    init() {
        UITabBar.appearance().isHidden = true
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.accentColor)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            ZStack {
                if onboardingShown {
                    TabView(selection: $selectedTab){
                        Text("Accueil")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .tag(tabs[0])
                        Text("Messages")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .tag(tabs[1])
                        Text("Mes choix")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .tag(tabs[2])
                        Text("Vie digitale")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .tag(tabs[3])
                    }
                } else if !(onboardingCompleted || onboardingCancelled) {
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

                } else if onboardingCompleted {
                    OnboardingFinishView(title: "Vous êtes prêt !")
                    
                } else if onboardingCancelled {
                    OnboardingFinishView(title: "Guide Messangel")
                }
                VStack (spacing: 0) {
                    Color.accentColor
                    Color.white
                }
                .if(!onboardingShown) { $0.brightness(-0.2) }
                .ignoresSafeArea()
            }

            BottomTabBar(onboardingShown: $onboardingShown, onboardingStarted: $onboardingStarted, selectedTab: $selectedTab)
                .if(!onboardingShown && !onboardingStarted) { $0.brightness(-0.2) }
        }
    }
}

var tabs = ["Accueil","Messages","Mes choix","Vie digitale"]
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
    ["title": "Mes choix",
     "image": "Mes choix",
     "desc": "Mes choix dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et"
    ],
    ["title": "Vie digitale",
     "image": "Vie digitale",
     "desc": "Vie digitale dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et"
    ]
]

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
                .shadow(color: .gray.opacity(0.2), radius: 5)
                .overlay(Image(image))
            Text(desc)
                .font(.system(size: 13))
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding(.bottom, 30)
    }
}

struct OnboardingFinishView: View {
    @AppStorage("onboardingShown") var onboardingShown = false
    var title: String
    
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

struct BottomTabBar: View {
    @Namespace var animation
    @State var safeArea = UIApplication.shared.windows.first?.safeAreaInsets
    @Binding var onboardingShown: Bool
    @Binding var onboardingStarted: Bool
    @Binding var selectedTab: String
    var body: some View {
        HStack(){
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(tabs,id: \.self){tab in
                        if onboardingShown {
                            Spacer()
                        }
                        TabButton(currentTab: tab, selectedTab: $selectedTab, animation: animation)
                            .if(!onboardingShown) { $0.padding([.horizontal, .bottom], 12) }
                            .if(!onboardingShown && onboardingStarted) { $0.background(tab == selectedTab ? Color.clear : Color.black.opacity(0.2)) }
                        if onboardingShown {
                            Spacer()
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .if(onboardingShown) { $0.padding(.horizontal) }
        .background(
            Color.white
                .clipShape(CustomCorner(corners: [.topLeft,.topRight]))
        )
        .shadow(color: Color.gray.opacity(0.15), radius: 5, x: -5, y: -5)
    }
}

struct TabButton: View {
    var currentTab: String
    @Binding var selectedTab : String
    var animation: Namespace.ID
    var body: some View {
        
        Button(action: {
            withAnimation(.spring()) {
                selectedTab = currentTab
            }
        }) {
            ZStack {
                VStack(spacing: 12){
                    ZStack{
                        Capsule()
                            .fill(Color.clear)
                            .frame(width: 25, height: 5)
                        if currentTab == selectedTab{
                            Capsule()
                                .fill(Color.accentColor)
                                .matchedGeometryEffect(id: "Tab", in: animation)
                                .frame(width: 25, height: 5)
                        }
                    }
                    Group {
                        Image(currentTab)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 18, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Text(currentTab)
                    }
                    .foregroundColor(currentTab == selectedTab ? .accentColor : .gray)
                }
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBarView()
        }
    }
}
