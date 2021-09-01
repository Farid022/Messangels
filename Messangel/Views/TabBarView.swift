//
//  TabBarView.swift
//  Messangels
//
//  Created by Saad Ibrahim on 15/05/21.
//

import SwiftUI
import NavigationStack

struct TabBarView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    static let id = String(describing: Self.self)
    @State var selectedTab = "Accueil"
    @AppStorage("onboardingShown") var onboardingShown = false
    @State var onboardingStarted = false
    @State var onboardingCompleted = false
    @State var onboardingCancelled = false
    
    init() {
        UITabBar.appearance().isHidden = true
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.accentColor)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    var body: some View {
        NavigationStackView(TabBarView.id) {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                if onboardingShown {
                    NavigationStackView(selectedTab) {
                        TabView(selection: $selectedTab){
                            TabContent(selectedTab: $selectedTab, navBarContent: AnyView(HomeNavBar()), topContent: AnyView(HomeTopView()), bottomContent: AnyView(HomeBottomView()))
                                .tag(tabs[0])
                            TabContent(selectedTab: $selectedTab, navBarContent: AnyView(NonHomeNavBar()), topContent: AnyView(NonHomeTopView(title: "Messages", detail: messagesDetail)), bottomContent: AnyView(MessagesBottomView()))
                                .tag(tabs[1])
                            TabContent(selectedTab: $selectedTab, navBarContent: AnyView(NonHomeNavBar()), topContent: AnyView(EmptyView()), bottomContent: AnyView(Text("Mes choix")))
                                .tag(tabs[2])
                            TabContent(selectedTab: $selectedTab, navBarContent: AnyView(NonHomeNavBar()), topContent: AnyView(EmptyView()), bottomContent: AnyView(Text("Vie digitale")))
                                .tag(tabs[3])
                        }
                    }
                    //                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                } else {
                    VStack {
                        Color.accentColor
                        Color.white
                    }
                    .overlay(Group {
                        if !(onboardingCompleted || onboardingCancelled) {
                            OnboardingView(onboardingStarted: $onboardingStarted, onboardingCompleted: $onboardingCompleted, onboardingCancelled: $onboardingCancelled, selectedTab: $selectedTab)
                        }
                        else if onboardingCompleted {
                            OnboardingFinishView(title: "Vous êtes prêt !", selectedTab: $selectedTab)
                        }
                        else if onboardingCancelled {
                            OnboardingFinishView(title: "Guide Messangel", selectedTab: $selectedTab)
                        }
                    })
                }
                BottomTabBar(onboardingShown: $onboardingShown, onboardingStarted: $onboardingStarted, selectedTab: $selectedTab)
                    .if(!onboardingShown && !onboardingStarted) { $0.brightness(-0.2) }
            }
            .ignoresSafeArea()
        }
    }
}

var tabs = ["Accueil","Messages","Mes choix","Vie digitale"]
var messagesDetail = "Créez des messages vidéos, textes et audio pour une personne ou un groupe de destinataires."

struct BottomTabBar: View {
    @Namespace var animation
    @Binding var onboardingShown: Bool
    @Binding var onboardingStarted: Bool
    @Binding var selectedTab: String
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs,id: \.self){tab in
                TabButton(currentTab: tab, selectedTab: $selectedTab, animation: animation)
                    .if(!onboardingShown && onboardingStarted) { $0.background(tab == selectedTab ? Color.clear : Color.black.opacity(0.2)) }
            }
        }
        .padding(.leading, -10)
        .frame(maxWidth: .infinity)
        .background(
            Color.white
                .clipShape(CustomCorner(corners: [.topLeft,.topRight]))
        )
        .shadow(color: Color.gray.opacity(0.15), radius: 5, x: -5, y: -5)
        .padding(.bottom, 30)
        .background(Color.white)
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
                            .frame(width: 20, height: 18, alignment: .center)
                        
                        Text(currentTab)
                            .font(.system(size: 13))
                            .fontWeight(.medium)
                    }
                    .foregroundColor(currentTab == selectedTab ? .accentColor : .gray)
                }
            }
        }
        .frame(width: (UIScreen.main.bounds.size.width - 20.0) / 4)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .previewDevice("iPhone 12")
        TabBarView()
            .previewDevice("iPhone 12 Pro Max")
        TabBarView()
            .previewDevice("iPhone 8")
    }
}

struct NonHomeTopView: View {
    var title: String
    var detail: String
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .font(.system(size: 34))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(detail)
                .font(.caption)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.white)
                .padding(.trailing, 100)
        }
        .padding(.horizontal, 15)
        VStack {
            Color.accentColor
                .frame(height: 25)
            Color.white
                .frame(height: 25)
        }
        .frame(height: 50)
        .overlay(
            HStack {
                Spacer()
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 56, height: 56)
                    .cornerRadius(25)
                    .shadow(color: .gray.opacity(0.2), radius: 10)
                    .overlay(Image("info"))
                    .padding(.trailing)
            })
    }
}

struct NonHomeNavBar: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: {}, label: {
                Image("help")
                    .padding(.horizontal, -30)
            })
        }
    }
}

struct NavBar: View {
    var body: some View {
        Color.accentColor
            .ignoresSafeArea()
            .frame(height: 50)
    }
}

struct TopSection: View {
    @Binding var selectedTab: String
    var body: some View {
        Color.accentColor
            .frame(height: selectedTab == "Accueil" ? 300 : 200)
    }
}

struct BottomSection: View {
    var body: some View {
        Color.white
    }
}

struct TabContent: View {
    @Binding var selectedTab: String
    var navBarContent: AnyView
    var topContent: AnyView
    var bottomContent: AnyView
    
    var body: some View {
        VStack(spacing: 0.0) {
            NavBar()
                .overlay(navBarContent)
            TopSection(selectedTab: $selectedTab)
                .overlay(topContent, alignment: .bottom)
            BottomSection()
                .overlay(bottomContent.padding(.top))
        }
    }
}
