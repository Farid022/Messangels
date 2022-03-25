//
//  ProfileView.swift
//  Messangel
//
//  Created by Saad on 5/20/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var auth: Auth
    @StateObject var userVM = UserViewModel()
    @State private var profileImage = UIImage()
    @State private var isShowImagePickerOptions = false
    @State private var isPerformingTask = false
    
    var body: some View {
        MenuBaseView(title:"Profil") {
            ImageSelectionView(showImagePickerOptions: $isShowImagePickerOptions, localImage: $profileImage, remoteImage: auth.user.image_url ?? "")
                .padding(.bottom)
            HStack {
                Text("Né(e) le \(formatDateString(auth.user.dob, inFormat:"yyyy-MM-dd", outFormat: "d MMM yyyy")) à \(auth.user.city)")
                Spacer()
            }
            .padding(.bottom)
            Group {
                TextField("", text: $userVM.profile.last_name)
                TextField("", text: $userVM.profile.first_name)
                TextField("", text: $userVM.profile.postal_code)
                TextField("", text: .constant(Genders[Int(userVM.profile.gender) ?? 0]))
            }
            .textFieldStyle(MyTextFieldStyle(editable: true))
            .normalShadow()
            .padding(.bottom)
            Button("Enregister") {
                isPerformingTask = true
                if self.profileImage.cgImage != nil {
                    Task {
                        if let response = await Networking.shared.upload(profileImage.jpegData(compressionQuality: 1)!, fileName: "msgl_profil.jpeg", fileType: "image") {
                            DispatchQueue.main.async {
                                self.userVM.profile.image_url = response.files.first?.path
                                updateProfile { success in
                                    if success {
                                        isPerformingTask = false
                                    }
                                }
                            }
                        }
                    }
                } else {
                    updateProfile { success in
                        if success {
                            isPerformingTask = false
                        }
                    }
                }
            }
            .disabled(isPerformingTask)
            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
            .padding(.bottom)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Supprimer mon compte")
                    .underline()
                    .accentColor(.red)
                    .font(.system(size: 11))
            })
        }
        .onDidAppear() {
            self.userVM.profile = Profile(first_name: auth.user.first_name, last_name: auth.user.last_name, postal_code: auth.user.postal_code, gender: "1", image_url: auth.user.image_url)
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
