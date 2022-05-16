//
//  GuardianView.swift
//  Messangel
//
//  Created by Saad on 10/13/21.
//

import SwiftUI
import NavigationStack
import Combine
import SwiftUIX

struct GuardianView: View {
    
    
    @State private var confirmAlert = false
    @ObservedObject var vm: GuardianViewModel
    @EnvironmentObject var navigationModel: NavigationModel
    var guardian: Guardian
    
    var body: some View {
        NavigationStackView("GuardianView") {
        MenuBaseView(title:"\(guardian.last_name) \(guardian.first_name)") {
            if let user = guardian.guardian {
                ProfileImageView(imageUrlString: user.image_url)
                    .padding(.vertical)
            }
            Text(guardian.last_name + " " + guardian.first_name.uppercased())
                .font(.system(size: 20), weight: .bold)
            Spacer().frame(height: 50)
            Divider()
            VStack(spacing: 15) {
                HStack(spacing: 15) {
                    Image("ic_hour_glass")
                    Text("Ange gardien depuis le \(unixStrToDateSring(guardian.updated_at ?? guardian.created_at ?? "")).")
                    Spacer()
                }
                HStack(spacing: 15) {
                    Image("ic_mail")
                    Text(guardian.guardian?.email ?? guardian.email)
                    Spacer()
                }
                if let guardianUser = guardian.guardian {
                    HStack(spacing: 15) {
                        Image("ic_tel")
                        Text(guardianUser.phone_number)
                        Spacer()
                    }
                }
            }
            .font(.system(size: 13))
            .padding(.vertical, 20)
            Divider()
            Spacer().frame(height: 100)
            Button(action: {
                confirmAlert.toggle()
            }, label: {
                Text("Supprimer l’ange gardien")
            })
            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .black))
            .padding(.bottom, 20)
          
//            Button(action: {
//                UserDefaults.standard.set(guardian.id, forKey: "guardianID")
//                navigationModel.pushContent(TabBarView.id) {
//
//                    GuardianMonMessangelView(guardian: guardian)
//                }
//            }, label: {
//                Text("Mon Messangel")
//            })
//            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .gray))
        }
        .alert(isPresented: $confirmAlert, content: {
            Alert(title: Text("Supprimer l’Ange-gardien ?"), message: Text("Un mail sera envoyé à \(guardian.last_name) pour l’informer de votre choix."), primaryButton: .default(Text("Supprimer").foregroundColor(.accentColor), action: {
                vm.delete(id: guardian.id) { success in
                    if success {
                        DispatchQueue.main.async {
                            vm.guardiansUpdated = true
                            navigationModel.popContent("Accueil")
                        }
                    } else {
                        print("Can't remove guardian!")
                    }
                }
                
            }), secondaryButton: .cancel(Text("Annuler").foregroundColor(.black)))
        })
            
        }
    }
}

//struct GuardianView_Previews: PreviewProvider {
//    static var previews: some View {
//        GuardianView(vm: GuardianViewModel())
//    }
//}
