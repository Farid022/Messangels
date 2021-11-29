//
//  SignupBirthView.swift
//  Messengel
//
//  Created by Saad on 5/6/21.
//

import SwiftUIX
import NavigationStack

struct SignupBirthView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var dob = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    @State private var progress = 12.5
    @State private var valid = false
    @State private var dobSelected = false
    @State private var editing = true
    @State var offset : CGFloat = UIScreen.main.bounds.height
    @ObservedObject var userVM: UserViewModel
    
    var body: some View {
        ZStack {
            SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupPostcodeView(userVM: userVM)), currentView: "SignupBirthView", footer: AnyView(Text("Vous devez être majeur pour créer votre compte Messangel").font(.system(size: 13)))) {
                Text("Je suis né(e) le")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                Button {
                    self.offset = 0
                    self.dobSelected = true
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    HStack {
                        Text(!userVM.user.dob.isEmpty ? dateToStr(dob, dateFormat: "dd/MM/yyyy") : "Date de naissance")
                            .foregroundColor(userVM.user.dob.isEmpty ? .placeholderText : .primary)
                            .font(.system(size: 17))
                        Spacer()
                    }
                }
                .buttonStyle(MyButtonStyle(padding: 0))
                Text("Dans la ville de")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                CocoaTextField("Ville", text: $userVM.user.city, onCommit:  {
                    if valid {
                        navigationModel.pushContent("SignupBirthView") {
                            SignupPostcodeView(userVM: userVM)
                        }
                    }
                })
                .font(.systemFont(ofSize: 17))
                .xTextFieldStyle()
            }
            VStack {
                Spacer()
                CustomActionSheet(dob: $dob, dob_str: $userVM.user.dob, offset: $offset)
                    .onTapGesture {}
                    .offset(y: self.offset)
            }
            .background((self.offset <= 100 ? Color(UIColor.label).opacity(0.3) : Color.clear).edgesIgnoringSafeArea(.all))
            .edgesIgnoringSafeArea(.bottom)
            .onTapGesture {
                if dobSelected {
                    self.offset = UIScreen.main.bounds.height
                    userVM.user.dob = dateToStr(dob)
                    self.validate()
                }
            }
        }
        .animation(.default)
        .onChange(of: userVM.user.city) { value in
            self.validate()
        }
        .onDidAppear {
            self.validate()
        }
    }
    
    private func validate() {
        self.valid = !userVM.user.city.isEmpty && dob < Calendar.current.date(byAdding: .year, value: -18, to: Date())! && !userVM.user.dob.isEmpty
    }
}

struct CustomActionSheet : View {
    @Binding var dob: Date
    @Binding var dob_str: String
    @Binding var offset : CGFloat
    
    var body : some View{
        VStack(){
            DatePicker(selection: $dob, in: ...Calendar.current.date(byAdding: .year, value: -18, to: Date())!, displayedComponents: .date) {}
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
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! )
        .padding(.top)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(25)
    }
}

func dateToStr(_ date: Date, dateFormat: String = "yyyy-MM-dd") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: date)
}

//struct SignupBirthView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupBirthView()
//    }
//}
