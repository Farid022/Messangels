//
//  FuneralCoffinOptions.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralGuestsDress: View {
    @State private var showNote = false
    @ObservedObject var vm: FueneralAstheticViewModel
    
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $vm.asthetic.attendence_dress_note, menuTitle: "Esthétique", title: "Indiquez vos souhaits concernant la tenue des invités", destination: AnyView(FuneralGuestsWearings(vm: vm)))
    }
}
