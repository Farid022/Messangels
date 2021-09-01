//
//  SignupBirthView.swift
//  Messengel
//
//  Created by Saad on 5/6/21.
//

import SwiftUIX

struct SignupBirthView: View {
    @State private var dob_day = 1
    @State private var dob_month = "Janvier"
    @State private var dob_year = 2001
    @State private var progress = 12.5
    @State private var valid = false
    @State private var editing = true
    @ObservedObject var userVM: UserViewModel
    
    var body: some View {
        SignupBaseView(editing: $editing, progress: $progress, valid: $valid, destination: AnyView(SignupPostcodeView(userVM: userVM)), currentView: "SignupBirthView", footer: AnyView(Text("Vous devez être majeur pour créer votre compte Messangel").font(.system(size: 13)))) {
            Text("Je suis né(e) le…")
                .font(.system(size: 22))
                .fontWeight(.bold)
            MyDatePickerView(day: $dob_day, month: $dob_month, year: $dob_year)
            Text("Dans la ville de…")
                .font(.system(size: 22))
                .fontWeight(.bold)
            CocoaTextField("Ville", text: $userVM.user.city) { isEditing in
                self.editing = isEditing
                if !isEditing {
                    userVM.user.dob = "\(dob_year)-\((months.firstIndex(of: dob_month) ?? 0) + 1)-\(dob_day)"
                }
            } onCommit: {
                userVM.user.dob = "\(dob_year)-\((months.firstIndex(of: dob_month) ?? 0) + 1)-\(dob_day)"
            }
            .isFirstResponder(true)
            .xTextFieldStyle()
        }
        .onChange(of: userVM.user.city) { value in
            self.validate()
        }
    }
    
    private func validate() {
        self.valid = !userVM.user.city.isEmpty
    }
}

//struct SignupBirthView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupBirthView()
//    }
//}
