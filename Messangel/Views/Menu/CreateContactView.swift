//
//  AddContactView.swift
//  Messangel
//
//  Created by Saad on 5/25/21.
//

import SwiftUI
import NavigationStack
import Combine

struct CreateContactView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var vm: ContactViewModel
    @State private var minorAge = false
    @State private var alert = false
    @State private var loading = false
    @State private var dob = Date()
    @State private var offset : CGFloat = UIScreen.main.bounds.height
    @State private var dobSelected = false
    @State private var phone_number = ""
    @Binding var refresh: Bool
    
    var body: some View {
        ZStack {
            MenuBaseView(title: "Créer un contact") {
                HStack {
                    Text("Coordonnées du contact")
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.bottom, 20)
                Group {
                    TextField("Prénom", text: $vm.contact.last_name)
                    TextField("Nom", text: $vm.contact.first_name)
                    TextField("Adresse mail", text: $vm.contact.email)
                        .keyboardType(.emailAddress)
                    TextField("Numéro de téléphone mobile", text: $phone_number)
                        .keyboardType(.phonePad)
                        .onReceive(Just(phone_number)) { inputValue in
                            if inputValue.count > 17 {
                                phone_number.removeLast()
                            }
                        }
                        .onChange(of: phone_number) { value in
                            phone_number = value.applyPatternOnNumbers(pattern: "## ## ## ## ## ##", replacmentCharacter: "#")
                            vm.contact.phone_number = phone_number.replacingOccurrences(of: " ", with: "")
                        }
                }
                .textFieldStyle(MyTextFieldStyle())
                .normalShadow()
                .padding(.bottom)
                Spacer().frame(height: 20)
                HStack {
                    VStack {
                        Group {
                            Toggle("Cette personne est majeure", isOn: $vm.contact.legal_age)
                                .onChange(of: vm.contact.legal_age) { value in
                                    minorAge = !vm.contact.legal_age
                                }
                            Toggle("Cette personne est mineure", isOn: $minorAge)
                                .onChange(of: minorAge) { value in
                                    vm.contact.legal_age = !minorAge
                                }
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        .padding(.bottom, 30)
                    }
                    Spacer()
                }
                if minorAge {
                    Text("Si cette personne est encore mineure au moment de votre décès, vos messages seront envoyés à vos Anges-gardiens.")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 13))
                        .padding(.bottom)
                    HStack {
                        Text("Date de naissance du destinataire")
                        Spacer()
                    }
                    Button {
                        self.offset = 0
                        self.dobSelected = true
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    } label: {
                        HStack {
                            Text(vm.contact.dob != nil && !vm.contact.dob!.isEmpty ? dateToStr(dob, dateFormat: "dd/MM/yyyy") : "Date de naissance")
                                .foregroundColor(vm.contact.dob == nil || vm.contact.dob != nil && vm.contact.dob!.isEmpty ? .placeholderText : .primary)
                                .font(.system(size: 17))
                            Spacer()
                        }
                    }
                    .buttonStyle(MyButtonStyle(padding: 0))
                    .normalShadow()
                    .padding(.bottom, 20)
                }
                Button(action: {
                    if !vm.contact.last_name.isEmpty && !vm.contact.last_name.isEmpty {
                        loading.toggle()
                        vm.contact.user = getUserId()
                        vm.createContact { success in
                            loading.toggle()
                            if success {
                                refresh.toggle()
                                navigationModel.hideTopViewWithReverseAnimation()
                            } else {
                                alert.toggle()
                            }
                        }
                    }
                }){
                    HStack {
                        Image("ic_add-user")
                        Text("Créer")
                    }
                }
                .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
                if loading {
                    Loader()
                        .padding(.top)
                }
            }
            .alert(isPresented: $alert, content: {
                Alert(title: Text(vm.apiError.error), message: Text(vm.apiError.error_description))
        })
            VStack {
                Spacer()
                DateActionSheet(dob: $dob, dob_str: $vm.contact.dob, offset: $offset)
                    .onTapGesture {}
                    .offset(y: self.offset)
                    .padding(.bottom, 80)
            }
            .background((self.offset <= 100 ? Color(UIColor.label).opacity(0.3) : Color.clear).edgesIgnoringSafeArea(.all))
            .edgesIgnoringSafeArea(.bottom)
            .onTapGesture {
                if dobSelected {
                    self.offset = UIScreen.main.bounds.height
                    vm.contact.dob = dateToStr(dob)
                }
            }
        }
    }
}

struct DateActionSheet : View {
    @Binding var dob: Date
    @Binding var dob_str: String?
    @Binding var offset : CGFloat
    
    var body : some View{
        VStack(){
            DatePicker(selection: $dob, displayedComponents: .date) {}
                .environment(\.locale, Locale(identifier: "fr"))
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            Divider()
            Button(action: {
                offset = UIScreen.main.bounds.height
                dob_str = dateToStr(dob)
            }) {
                Text("OK")
            }
        }
        .padding(.bottom, (UIApplication.keyWindow?.safeAreaInsets.bottom)! )
        .padding(.top)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(25)
    }
}
