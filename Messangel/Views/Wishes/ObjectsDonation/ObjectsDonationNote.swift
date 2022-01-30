//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct ObjectsDonationNote: View {
    @State private var showNote = false
    @State private var loading = false
    @ObservedObject var vm: ObjectDonationViewModel
    @EnvironmentObject var navModel: NavigationModel
    
    var body: some View {
        FuneralNoteCutomActionView(showNote: $showNote, note: $vm.objectDonation.object_note, loading: $loading, menuTitle: "Objets", title: "\(vm.objectDonation.object_name) – Photo") {
            loading.toggle()
            vm.create() { success in
                loading.toggle()
                if success {
                    UserDefaults.standard.set(100.0, forKey: "Objets")
                    navModel.pushContent("\(vm.objectDonation.object_name) – Photo") {
                        ObjectsDonationsList(vm: vm)
                    }
                }
            }
        }
    }
}
