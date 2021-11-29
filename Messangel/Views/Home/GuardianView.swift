//
//  GuardianView.swift
//  Messangel
//
//  Created by Saad on 10/13/21.
//

import SwiftUI
import NavigationStack

struct GuardianView: View {
    @State private var confirmAlert = false
    @ObservedObject var vm: GuardianViewModel
    @EnvironmentObject var navigationModel: NavigationModel
    var guardian: Guardian
    
    var body: some View {
        MenuBaseView(title:"Marianne MILON") {
            Image("gallery_preview")
                .frame(width: 64, height: 64)
                .clipShape(Circle())
                .padding(.vertical)
            Text(guardian.last_name + " " + guardian.first_name.uppercased())
                .font(.system(size: 20), weight: .bold)
            Spacer().frame(height: 50)
            Divider()
            VStack(spacing: 15) {
                HStack(spacing: 15) {
                    Image("ic_hour_glass")
                    Text("Ange gardien depuis le 09/02/2021.")
                    Spacer()
                }
                HStack(spacing: 15) {
                    Image("ic_mail")
                    Text(guardian.email)
                    Spacer()
                }
                HStack(spacing: 15) {
                    Image("ic_tel")
                    Text("06 00 00 00 00")
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
                Text("Supprimer l’ange gardien")
            })
            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .black))
        }
        .alert(isPresented: $confirmAlert, content: {
            Alert(title: Text("Supprimer l’Ange-gardien ?"), message: Text("Un mail sera envoyé à Marianne pour l’informer de votre choix."), primaryButton: .default(Text("Supprimer").foregroundColor(.accentColor), action: {
                vm.delete(id: guardian.id, userId: guardian.user_id) { success in
                    if success {
                        DispatchQueue.main.async {
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

//struct GuardianView_Previews: PreviewProvider {
//    static var previews: some View {
//        GuardianView(vm: GuardianViewModel())
//    }
//}