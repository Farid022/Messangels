//
//  DDConfirmView.swift
//  Messangel
//
//  Created by Saad on 2/26/22.
//

import SwiftUI
import NavigationStack

struct DDConfirmView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: GuardianViewModel
    
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
                    Text("Confirmation")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                    Spacer().frame(height: 10)
                    Button("Déclarer le décès") {
                        APIService.shared.post(model: vm.death, response: vm.death, endpoint: "users/\(getUserId())/death_declaration") { result in
                            switch result {
                            case .success(_):
                                DispatchQueue.main.async {
                                    vm.guardiansUpdated = true
                                    navigationModel.pushContent(String(describing: Self.self)) {
                                        DDDoneView(vm: vm)
                                    }
                                }
                            case .failure(let error):
                                print(error.error_description)
                            }
                        }
                    }
                        .buttonStyle(MyButtonStyle())
                        .accentColor(.black)
                    Spacer()
                }.padding()
            }
            .foregroundColor(.white)
        }
    }
}
