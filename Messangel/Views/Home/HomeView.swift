//
//  HomeView.swift
//  Messangel
//
//  Created by Saad on 5/17/21.
//

import SwiftUI
import NavigationStack

struct HomeNavBar: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        HStack {
            Spacer()
            Button(action: {}, label: {
                Image("help")
                    .padding(.horizontal, -30)
            })
            Button(action: {
                navigationModel.presentContent("Accueil") {
                    MenuView()
                }
            }) {
                Image("menu")
                    .padding()
            }
            .padding(.bottom, 10)
        }
    }
}

struct HomeTopView: View {
    @EnvironmentObject var auth: Auth
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Group {
                    Text("Bonjour,")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    Text(auth.user.first_name)
                        .font(.system(size: 20))
                        .fontWeight(.light)
                        .padding(.bottom, 30)
                }
                .foregroundColor(.white)
                Button(action: {}, label: {
                    Text("Voir mon Messangel")
                        .font(.system(size: 15))
                })
                .buttonStyle(MyButtonStyle(padding: 0, maxWidth: false))
                .padding(.bottom)
            }
            Spacer()
        }
        .padding()
        .padding(.top, 70)
        .overlay(Image("backgroundLogo")
                    .resizable()
                    .frame(width: 280.05, height: 251.9)
                    .offset(x: 180))
    }
}

struct HomeBottomView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @StateObject private var gVM = GuardianViewModel()
    @State var subscribed = true
    @State var loading = false
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Mes Anges-gardiens")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.bottom)
                if subscribed {
                    if !loading {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(gVM.guardians, id: \.self) { guardian in
                                    GuardianCard(vm: gVM, guardian: guardian)
                                }
                                AddGuardianView(gVM: gVM)
                                Spacer()
                            }
                            .padding()
                        }
                    } else {
                        Loader()
                            .padding(.top, 50)
                    }
                } else {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 56, height: 56)
                        .cornerRadius(25)
                        .thinShadow()
                        .overlay(
                            Image("add-user")
                                .opacity(0.5)
                        )
                    Text("Abonnez-vous pour ajouter vos Anges-gardiens.")
                        .font(.system(size: 13))
                        .padding([.bottom, .horizontal])
                    SubscribeButton()
                }
                Spacer().frame(height: 100)
            }
        }
        .onAppear() {
            loading.toggle()
            gVM.getGuardians { finished in
                if finished {
                    loading.toggle()
                }
            }
        }
    }
}

struct SubscribeButton: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        Button(action: {
            navigationModel.pushContent(TabBarView.id) {
                SubscriptionView()
            }
        }) {
            Text("Je m’abonne (2€/mois)")
                .font(.system(size: 15))
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 56)
        .foregroundColor(.white)
        .background(Color.accentColor)
        .cornerRadius(25)
        .padding(.horizontal, 70)
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            HomeNavBar()
//                .background(Color.accentColor)
//            HomeTopView()
//                .background(Color.accentColor)
//            HomeBottomView()
//        }
//        .previewLayout(.sizeThatFits)
//    }
//}

struct AddGuardianView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var gVM: GuardianViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .frame(width: 166, height: 180)
            .normalShadow()
            .overlay(VStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 56, height: 56)
                    .cornerRadius(25)
                    .thinShadow()
                    .overlay(
                        Button(action: {
                            navigationModel.pushContent(TabBarView.id) {
                                GuardianFormIntroView(vm: gVM)
                            }
                        }) {
                            Image("add-user")
                                .opacity(0.5)
                        })
                Text("""
Ajouter un
Ange-gardien
""")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            })
    }
}

struct GuardianCard: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: GuardianViewModel
    var guardian: Guardian
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .frame(width: 166, height: 180)
            .normalShadow()
            .overlay(VStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 56, height: 56)
                    .cornerRadius(25)
                    .thinShadow()
                    .overlay(
                        Button(action: {
                            navigationModel.pushContent("Accueil") {
                                GuardianView(vm:vm, guardian: guardian)
                            }
                        }) {
                            Image("gallery_preview")
                        })
                VStack {
                    Text(guardian.last_name)
                        .font(.system(size: 13))
                    Text(guardian.first_name)
                        .font(.system(size: 13), weight: .semibold)
                }
            })
    }
}
