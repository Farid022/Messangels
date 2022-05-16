//
//  GuardianView.swift
//  Messangel
//
//  Created by Saad on 10/13/21.
//

import SwiftUI
import NavigationStack

struct ProtectedUserView: View {
    @State private var confirmAlert = false
 
    @ObservedObject var vm: GuardianViewModel
    @EnvironmentObject var navigationModel: NavigationModel
    var protected: MyProtected
    
    var body: some View {
        NavigationStackView(String(describing: Self.self)) {
            MenuBaseView(title:"\(protected.user.last_name) \(protected.user.first_name)") {
                ProfileImageView(imageUrlString: protected.user.image_url)
                    .padding(.vertical)
                Text(protected.user.last_name + " " + protected.user.first_name.uppercased())
                    .font(.system(size: 20), weight: .bold)
                Spacer().frame(height: 50)
                Divider()
                VStack(spacing: 15) {
                    HStack(spacing: 15) {
                        Image("ic_hour_glass")
                        Text("Ange gardien depuis le \(unixStrToDateSring(protected.user.registration_date ?? "")).")
                        Spacer()
                    }
                    HStack(spacing: 15) {
                        Image("ic_mail")
                        Text(protected.user.email)
                        Spacer()
                    }
                    HStack(spacing: 15) {
                        Image("ic_tel")
                        Text(protected.user.phone_number)
                        Spacer()
                    }
                }
                .font(.system(size: 13))
                .padding(.vertical, 20)
                Divider()
                Spacer().frame(height: 100)
                Button(action: {
                    confirmAlert.toggle()
                }, label: {
                    Text("Ne plus être Ange-gardien")
                })
                .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .black))
                Spacer().frame(height: 50)
                if vm.deaths.isEmpty || !vm.deaths.contains(where: { $0.user == protected.user.id }) {
                    Button(action: {
                        vm.death.user = protected.user.id ?? 0
                        vm.protectedUser.first_name = protected.user.first_name
                        vm.protectedUser.last_name = protected.user.last_name
                        navigationModel.pushContent(TabBarView.id) {
                            DeclareDeathIntro(vm: vm)
                        }
                    }, label: {
                        Text("Déclarer le décès")
                    })
                    .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .gray))
                }
                else
                {
                    Button(action: {
                        vm.death.user = protected.user.id ?? 0
                        vm.protectedUser.first_name = protected.user.first_name
                        vm.protectedUser.last_name = protected.user.last_name
                        var guardian : Guardian? =  Guardian(id: protected.user.id ?? 0 , user_id: 0, first_name: protected.user.first_name, last_name: protected.user.last_name, email: protected.user.email, status: "2")
                        
                        navigationModel.pushContent(TabBarView.id) {
                           
                            GuardianMonMessangelView(guardian: guardian)
                            
                           // DeclareDeathIntro(vm: vm)
                        }
                    }, label: {
                        Text("Mon Messangel")
                    })
                    .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .gray))
                }
                
            
            }
            .alert(isPresented: $confirmAlert, content: {
                Alert(title: Text("Ne plus être Ange-gardien ?"), message: Text("Un mail sera envoyé à \(protected.user.last_name) pour l’informer de votre choix."), primaryButton: .default(Text("Supprimer").foregroundColor(.accentColor), action: {
                    if let userId = protected.user.id {
                        vm.cancel(id: userId) { success in
                            if success {
                                DispatchQueue.main.async {
                                    vm.guardiansUpdated = true
                                    navigationModel.popContent("Accueil")
                                }
                            } else {
                                print("Can't remove protected user!")
                            }
                        }
                    }
                    
                }), secondaryButton: .cancel(Text("Annuler").foregroundColor(.black)))
        })
            
        }
    }
}
