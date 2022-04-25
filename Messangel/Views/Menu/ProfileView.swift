//
//  ProfileView.swift
//  Messangel
//
//  Created by Saad on 5/20/21.
//

import SwiftUI
import NavigationStack

struct ProfileView: View {
    @EnvironmentObject var auth: Auth
    @EnvironmentObject var navModel: NavigationModel
    @StateObject var userVM = UserViewModel()
    @State private var profileImage = UIImage()
    @State private var isShowImagePickerOptions = false
    @State private var isPerformingTask = false
    @State private var confirmModify = false
    @State private var validError = false
    @State private var postcodeError = false
    var valid: Bool {
        return !userVM.profile.last_name.isEmpty && !userVM.profile.last_name.isEmpty && userVM.profile.postal_code.count == 5
    }
    var profileUpdated: Bool {
        return userVM.profile.last_name != auth.user.last_name ||
        userVM.profile.first_name != auth.user.first_name ||
        userVM.profile.postal_code != auth.user.postal_code ||
        profileImage.cgImage != nil
    }
    
    var body: some View {
        ZStack {
            NavigationStackView(String(describing: Self.self)) {
                MenuBaseView(title:"Profil") {
                    ImageSelectionView(showImagePickerOptions: $isShowImagePickerOptions, localImage: $profileImage, remoteImage: auth.user.image_url ?? "", title: "modifier photo de profil", underlineTitle: false)
                        .padding(.bottom)
                    //                HStack {
                    //                    Text("Né(e) le \(formatDateString(auth.user.dob, inFormat:"yyyy-MM-dd", outFormat: "d MMM yyyy")) à \(auth.user.city)")
                    //                    Spacer()
                    //                }
                    //                .padding(.bottom)
                    Group {
                        TextField("", text: $userVM.profile.last_name)
                            .onSubmit {
                                validError = userVM.profile.last_name.isEmpty
                            }
                        TextField("", text: $userVM.profile.first_name)
                            .onSubmit {
                                validError = userVM.profile.first_name.isEmpty
                            }
                        TextField("", text: $userVM.profile.postal_code)
                            .onSubmit {
                                postcodeError = userVM.profile.postal_code.count != 5
                            }
                        TextField("", text: .constant(Genders[Int(userVM.profile.gender) ?? 0]))
                    }
                    .textFieldStyle(MyTextFieldStyle())
                    .normalShadow()
                    .padding(.bottom)
                    Button("Enregister") {
                        if !valid {
                            return
                        }
                        if profileUpdated {
                            confirmModify.toggle()
                        }
                    }
                    .disabled(isPerformingTask || !valid)
                    .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
                    .padding(.bottom)
                    Button(action: {
                        navModel.pushContent(String(describing: Self.self)) {
                            ProfileDeleteConfirmView()
                        }
                    }, label: {
                        Text("Supprimer mon compte")
                            .foregroundColor(.gray)
                            .underline()
                            .font(.system(size: 11))
                    })
                }
                .onDidAppear() {
                    self.userVM.profile = Profile(first_name: auth.user.first_name, last_name: auth.user.last_name, postal_code: auth.user.postal_code, gender: "1", image_url: auth.user.image_url)
                }
            }
            .alert("Désolé", isPresented: $validError, actions: {
                Button("OK", role: .cancel) {}
            }, message: {
                Text("Vous ne pouvez pas supprimer ce champ")
            })
            .alert("Désolé", isPresented: $postcodeError, actions: {
                Button("OK", role: .cancel) {}
            }, message: {
                Text("Votre code postal doit comporter 5 chiffres")
            })
            if confirmModify {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                    .overlay(MyAlert(title: "", message: "Êtes-vous sur de vouloir modifier cette information ?", ok: "Confirmer", action: {
                        isPerformingTask = true
                        if self.profileImage.cgImage != nil {
                            Task {
                                if let response = await Networking.shared.upload(profileImage.jpegData(compressionQuality: 1)!, fileName: "msgl_profil.jpeg", fileType: "image") {
                                    DispatchQueue.main.async {
                                        self.userVM.profile.image_url = response.files.first?.path
                                        updateProfile { success in
                                            isPerformingTask = false
                                        }
                                    }
                                }
                            }
                        } else {
                            updateProfile { success in
                                isPerformingTask = false
                            }
                        }
                    }, showAlert: $confirmModify))
                    .zIndex(1.0)
            }
        }
    }
    
    func updateProfile(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: userVM.profile, response: auth.user, endpoint: "users/\(getUserId())/profile", method: "PATCH") { result in
            switch result {
            case .success(let user):
                print(user.first_name)
                DispatchQueue.main.async {
                    let password = auth.user.password
                    auth.user = user
                    auth.user.password = password
                    auth.updateUser()
                    completion(true)
                }
            case .failure(let error):
                print(error.error_description)
                completion(false)
            }
        }
    }
}

let Genders = ["", "Masculin", "Féminin", "Autre"]
