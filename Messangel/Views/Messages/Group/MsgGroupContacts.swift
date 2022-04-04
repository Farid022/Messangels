//
//  MsgGroupContacts.swift
//  Messangel
//
//  Created by Saad on 2/28/22.
//

import SwiftUI
import NavigationStack

struct MsgGroupContacts: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @ObservedObject var vm: GroupViewModel
    @State private var loading = false
    
    var body: some View {
        ZStack {
            NavigationStackView(String(describing: Self.self)) {
                VStack(spacing: 20) {
                    HStack {
                        BackButton(viewId: TabBarView.id, icon:"chevron.down", iconColor: .black)
                            .padding(.leading)
                        Spacer()
                        Text("Destinataires dans \(vm.group.name)")
                            .font(.system(size: 17), weight: .semibold)
                        Spacer()
                    }
                if vm.group.group_contacts == nil {
                    Spacer()
                    Text("Sélectionnez un ou plusieurs destinataires")
                        .font(.system(size: 17), weight: .semibold)
                    Button(action: {
                        navigationModel.presentContent(String(describing: Self.self)) {
                            MsgGroupContactsList(vm: vm)
                        }
                    }, label: {
                        Image("list_contact")
                    })
                } else {
                    HStack {
                        VStack {
                            Button {
                                navigationModel.presentContent(String(describing: Self.self)) {
                                    MsgGroupContactsList(vm: vm)
                                }
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 56, height: 56)
                                        .thinShadow()
                                    Image(systemName: "plus")
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(.bottom)
                            ForEach(vm.groupContacts, id: \.self) { contact in
                                FuneralCapsuleView(name: contact.first_name + " " + contact.last_name) {
                                    vm.group.group_contacts!.remove(at: vm.group.group_contacts!.firstIndex(of: contact.id)!)
                                        loading.toggle()
                                        vm.update(id: vm.group.id ?? 0) { success in
                                            if success {
                                                vm.groupContacts.remove(at: vm.groupContacts.firstIndex(of: contact)!)
                                                loading.toggle()
                                            }
                                        }
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding()
                }
                Spacer()
                }
            }
            if loading {
                UpdatingView()
            }
        }
    }
}
