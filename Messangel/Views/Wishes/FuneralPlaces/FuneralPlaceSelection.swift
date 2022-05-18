//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralPlaceSelection: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @State private var showNote = false
    @ObservedObject var vm: FuneralLocationViewModel
    private let title = "Indiquez le lieu de cérémonie"
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.location.bury_location_note.bound)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(stepNumber: 2.0, totalSteps: 6.0, noteText: $vm.location.bury_location_note.bound, note: true, showNote: $showNote, menuTitle: "Lieux", title: title, valid: .constant(!vm.orgName.isEmpty), destination: AnyView(FuneralRestingPlace(vm: vm))) {
                if vm.orgName.isEmpty {
                    HStack {
                        Button(action: {
                            navigationModel.presentContent(title) {
                                SingleOrgSelectionList(orgId: $vm.location.bury_location.toUnwrapped(defaultValue: 0), orgName: $vm.orgName, orgType: 9)
                            }
                        }, label: {
                            Image("list_org")
                        })
                        Spacer()
                    }
                } else {
                    HStack {
                        FuneralCapsuleView(name: vm.orgName) {
                            vm.location.bury_location = nil
                            vm.orgName = ""
                        }
                        Spacer()
                    }
                }
            }
            
        }
    }
}
