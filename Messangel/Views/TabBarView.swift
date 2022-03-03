//
//  TabBarView.swift
//  Messangels
//
//  Created by Saad Ibrahim on 15/05/21.
//

import SwiftUI
import NavigationStack

struct TabBarView: View {
    @AppStorage("onboardingShown") var onboardingShown = false
    @EnvironmentObject private var navigationModel: NavigationModel
    @EnvironmentObject private var keyAccRegVM: AccStateViewModel
    @StateObject private var vmGroup = GroupViewModel()
    @StateObject private var vmKeyAcc = KeyAccViewModel()
    @StateObject private var vmOnlineService = OnlineServiceViewModel()
    @State private var selectedTab = "Accueil"
    @State private var onboardingStarted = false
    @State private var onboardingCompleted = false
    @State private var onboardingCancelled = false
    @State private var loading = true
    @State private var showNewServicePopUp = false
    @State private var showNewMessagePopUp = false
    static let id = String(describing: Self.self)
    
    init() {
        UITabBar.appearance().isHidden = true
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.accentColor)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        NavigationStackView(TabBarView.id) {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                if onboardingShown {
                    NavigationStackView(selectedTab) {
                        TabView(selection: $selectedTab){
                            TabContent(showButtonsPopup: $showNewMessagePopUp, showNewServicePopup: $showNewServicePopUp, selectedTab: $selectedTab, navBarContent: AnyView(HomeNavBar()), topContent: AnyView(HomeTopView()), bottomContent: AnyView(HomeBottomView()))
                                .tag(tabs[0])
                            TabContent(showButtonsPopup: $showNewMessagePopUp, showNewServicePopup: $showNewServicePopUp, selectedTab: $selectedTab, topContent: AnyView(NonHomeTopView(title: "Volontés", detail: wishesDiscription)), bottomContent: AnyView(WishesMenuView()))
                                .tag(tabs[1])
                            TabContent(showButtonsPopup: $showNewMessagePopUp, showNewServicePopup: $showNewServicePopUp, selectedTab: $selectedTab, topContent: AnyView(NonHomeTopView(title: "Messages", detail: messagesDiscription)), bottomContent: AnyView(MessagesMainView(showButtonsPopup: $showNewMessagePopUp, vm: vmGroup)))
                                .tag(tabs[2])
                            TabContent(showButtonsPopup: $showNewMessagePopUp, showNewServicePopup: $showNewServicePopUp, selectedTab: $selectedTab, topContent: AnyView(NonHomeTopView(title: "Vie digitale", detail: socialAndServicesDesc)), bottomContent: AnyView(SocialAndServicesHomeView(vmOnlineService: vmOnlineService, loading: $loading, showPopUp: $showNewServicePopUp)))
                                .tag(tabs[3])
                        }
                    }
                    .onChange(of: selectedTab) { value in
                        if value == "Vie digitale" && loading {
                            vmKeyAcc.getKeyAccounts { success in
                                if success {
                                    keyAccRegVM.keyAccRegistered = vmKeyAcc.keyAccounts.count > 0
                                    vmOnlineService.getAccounts { success in
                                        if success {
                                            loading.toggle()
                                        }
                                    }
                                }
                            }
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
                ZStack(alignment: .bottom) {
                    if keyAccRegVM.showSuccessScreen {
                        KeyAccRegSuccessView()
                    }
                    if showNewServicePopUp {
                        NewAccPopupView(showPopUp: $showNewServicePopUp)
                    }
                    if showNewMessagePopUp {
                        PopupButtonsView(showPopUp: $showNewMessagePopUp, vm: vmGroup)
                    }
                    BottomTabBar(onboardingShown: $onboardingShown, onboardingStarted: $onboardingStarted, selectedTab: $selectedTab)
                        .if(!onboardingShown && !onboardingStarted) { $0.brightness(-0.2) }
                }
            }
            .ignoresSafeArea()
        }
    }
}

var tabs = ["Accueil","Volontés","Messages","Vie digitale"]
var messagesDiscription = "Créez des messages vidéos, textes et audio pour une personne ou un groupe de destinataires."
var wishesDiscription = "Indiquez vos volontés sur les sujets qui comptent pour vous. Vous pouvez revenir sur vos choix à tout moment."
var socialAndServicesDesc = "Préparez les accès aux réseaux sociaux et services en ligne que vous utilisez : Alimentation, e-Commerce, Streaming…"

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


struct NonHomeTopView: View {
    var title: String
    var detail: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 34))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.bottom, 20)
            Text(detail)
                .font(.caption)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.white)
                .padding(.trailing, 100)
            ZStack {
                VStack {
                    Color.accentColor
                        .frame(height: 25)
                    Color.white
                        .frame(height: 25)
                }
                .padding(.horizontal, -15)
                HStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 56, height: 56)
                        .cornerRadius(25)
                        .normalShadow()
                        .overlay(Image("info"))
                        .padding(.trailing)
                }
            }
            
        }
        .padding(.horizontal, 15)
    }
}

struct NavBar: View {
    var body: some View {
        Color.accentColor
            .ignoresSafeArea()
            .frame(height: 50)
    }
}

struct HomeNavBar: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                navigationModel.presentContent("Accueil") {
                    MenuView()
                }
            }) {
                Image("menu")
                    .padding()
            }
        }
        .padding(.top)
    }
}

struct TopSection: View {
    @Binding var selectedTab: String
    var body: some View {
        Color.accentColor
            .frame(height: selectedTab == "Accueil" ? 340 : 240)
    }
}

struct BottomSection: View {
    var body: some View {
        Color.white
    }
}

struct TabContent: View {
    @EnvironmentObject private var keyAccRegVM: AccStateViewModel
    @Binding var showButtonsPopup: Bool
    @Binding var showNewServicePopup: Bool
    @Binding var selectedTab: String
    var navBarContent: AnyView?
    var topContent: AnyView
    var bottomContent: AnyView
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.accentColor
                .ignoresSafeArea()
            ZStack(alignment: .bottom) {
                VStack(spacing: 0.0) {
                    Color.accentColor
                        .ignoresSafeArea()
                        .frame(height: 1)
                    ScrollView {
                        navBarContent
                            .background(Color.accentColor)
                        TopSection(selectedTab: $selectedTab)
                            .overlay(topContent, alignment: .bottom)
                            .padding(.top, -8)
                        bottomContent
                    }
                }
                if selectedTab == "Messages" {
                    NewMessageButtonView(showButtonsPopup: $showButtonsPopup)
                } else if selectedTab == "Vie digitale" {
                    if keyAccRegVM.keyAccRegistered {
                        NewAccountServiceButtonView(showPopUp: $showNewServicePopup)
                    } else {
                        NewMainAccButtonView()
                    }
                }
            }
            .background(Color.white)
        }
    }
}
