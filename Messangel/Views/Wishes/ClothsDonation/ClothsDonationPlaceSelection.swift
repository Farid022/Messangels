//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct ClothsDonationPlaceSelection: View {
    var donationTypes = [ClothsDonationPlace.contact, ClothsDonationPlace.organization]
    @State private var selectedDonation = ClothsDonationPlace.none
    @ObservedObject var vm: ClothDonationViewModel
    
    var body: some View {
        ZStack {
            FlowBaseView(stepNumber: 4.0, totalSteps: 7.0, menuTitle: "Vêtements et accessoires", title: "\(vm.clothDonation.clothing_name) - À qui souhaitez vous donner \(vm.clothDonation.single_clothing! ? "cet article?" : "ces articles?")", valid: .constant(selectedDonation != .none), destination: selectedDonation == .organization ? AnyView(ClothsDonationOrganization(vm: vm)) : AnyView(ClothsDonationContact(vm: vm))) {
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
                if vm.clothDonation.clothing_contact_detail != nil {
                    selectedDonation = .contact
                } else if vm.clothDonation.clothing_organization_detail != nil {
                    selectedDonation = .organization
                }
            }
        }
    }
}
