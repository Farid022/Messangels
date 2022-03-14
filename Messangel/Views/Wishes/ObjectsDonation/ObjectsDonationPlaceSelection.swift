//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct ObjectsDonationPlaceSelection: View {
    var donationTypes = [ClothsDonationPlace.contact, ClothsDonationPlace.organization]
    @State private var selectedDonation = ClothsDonationPlace.none
    @ObservedObject var vm: ObjectDonationViewModel
    
    var body: some View {
        ZStack {
            FlowBaseView(stepNumber: 4.0, totalSteps: 7.0, menuTitle: "Objets", title: "À qui souhaitez vous donner \(vm.objectDonation.single_object! ? "cet objet?" : "ce groupe d’objets?")", valid: .constant(selectedDonation != .none), destination: selectedDonation == .organization ? AnyView(ObjectsDonationOrganization(vm: vm)) : AnyView(ObjectsDonationContact(vm: vm))) {
                HStack {
                    ForEach(donationTypes, id: \.self) { type in
                        ChoiceCard(text: type == .contact ? "Un contact" : "Un organisme", selected: .constant(selectedDonation == type))
                            .onTapGesture {
                                selectedDonation = type
                            }
                    }
                }
            }
            .onDidAppear {
                if vm.objectDonation.object_contact_detail != nil {
                    selectedDonation = .contact
                } else if vm.objectDonation.organization_detail != nil {
                    selectedDonation = .organization
                }
            }
        }
    }
}
