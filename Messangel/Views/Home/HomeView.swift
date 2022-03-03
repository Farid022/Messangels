//
//  HomeView.swift
//  Messangel
//
//  Created by Saad on 5/17/21.
//

import SwiftUI
import NavigationStack

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
    @EnvironmentObject private var subVM: SubscriptionViewModel
    @StateObject private var gVM = GuardianViewModel()
    @State private var loading = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Mes Anges-gardiens")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
            }
            .padding(.bottom)
            if subVM.checkingSubscription || !subVM.gotSubscription || loading  {
                Loader()
                    .padding(.top, 50)
            }
            else if subVM.subscriptions.count > 0 {
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
                SubscribeView()
            }
            if gVM.protectedUsers.count > 0 {
                HStack {
                    Text("Mes protégés")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.bottom)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(gVM.protectedUsers.filter( {$0.status == "1"}), id: \.self) { protectedUsers in
                            PotectedUserCard(vm: gVM, protected: protectedUsers)
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            Spacer().frame(height: 100)
        }
        .onChange(of: subVM.checkingSubscription) { value in
            if !subVM.checkingSubscription && subVM.subscriptions.count > 0 {
                loadGuardians()
            }
        }
        .onChange(of: gVM.guardiansUpdated) { value in
            if value {
                loadGuardians()
            }
        }
        .onAppear {
            if !loading && !subVM.checkingSubscription && subVM.subscriptions.count > 0 {
                loadGuardians()
            }
        }
    }
    
    func loadGuardians() {
        loading.toggle()
        gVM.getGuardians { _ in
            DispatchQueue.main.async {
                loading.toggle()
                gVM.guardiansUpdated = false
            }
        }
        gVM.getProtectedUsers { success in
            if success {
                gVM.getDeaths { _ in }
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

struct SubscribeView: View {
    var body: some View {
        VStack {
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
    }
}

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
    var buttonLabel: AnyView {
        if let guardianUser = guardian.guardian {
            return AnyView(ProfileImageView(imageUrlString: guardianUser.image_url, imageSize: 56.0))
        } else {
            return AnyView(Image("ic_person"))
        }
    }
    
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
                            buttonLabel
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

struct PotectedUserCard: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: GuardianViewModel
    var protected: MyProtected
    
    var buttonLabel: AnyView {
        if let imageUrlString = protected.user.image_url {
            return AnyView(ProfileImageView(imageUrlString: imageUrlString, imageSize: 56.0))
        } else {
            return AnyView(Image("ic_person"))
        }
    }
    
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
                        Button {
                            // TODO: - Think reject case what to do?!
                            if vm.deaths.isEmpty || !vm.deaths.contains(where: { $0.user == protected.user.id }) {
                                navigationModel.pushContent("Accueil") {
                                    ProtectedUserView(vm: vm, protected: protected)
                                }
                            } else if vm.deaths.contains(where: { $0.user == protected.user.id && $0.status == 2 && $0.guardian != getUserId() }) {
                                navigationModel.pushContent("Accueil") {
                                    DeathConfirmationView(vm: vm, protected: protected)
                                }
                            }
                        } label: {
                            buttonLabel
                        })
                VStack {
                    Text(protected.user.last_name)
                        .font(.system(size: 13))
                    Text(protected.user.first_name)
                        .font(.system(size: 13), weight: .semibold)
                }
            })
    }
}
