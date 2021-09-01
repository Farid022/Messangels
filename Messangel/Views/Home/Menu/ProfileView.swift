//
//  ProfileView.swift
//  Messangel
//
//  Created by Saad on 5/20/21.
//

import SwiftUI
import Combine

struct ProfileView: View {
    @EnvironmentObject var auth: Auth
    @StateObject var userVM = UserViewModel()
    @ObservedObject var imageLoader:ImageLoader
    @State private var profileImage = UIImage()
    @State private var isShowPhotoLibrary = false
    @State private var cgImage = UIImage().cgImage
    
    var body: some View {
        MenuBaseView(title:"Profil") {
            Rectangle()
                .fill(Color.gray)
                .frame(width: 66, height: 66)
                .cornerRadius(30)
                .overlay(
                    Button(action: {
                        isShowPhotoLibrary.toggle()
                    }, label: {
                        ZStack {
                            if auth.user.image_url == nil {
                                Image("ic_camera")
                            } else {
                                Loader()
                            }
                            Image(uiImage: profileImage)
                                .resizable()
                                .frame(width: 66, height: 66)
                                .clipShape(Circle())
                                .onReceive(imageLoader.didChange) { data in
                                    self.profileImage = UIImage(data: data) ?? UIImage()
                                    self.cgImage = self.profileImage.cgImage
                                }
                        }
                    })
                )
            if auth.user.image_url == nil {
                Text("Choisir une photp")
                    .foregroundColor(.secondary)
                    .font(.system(size: 13))
                    .padding(.bottom)
            }
            HStack {
                Text("Né(e) le \(auth.user.dob) à \(auth.user.city)")
                Spacer()
            }
            .padding(.bottom)
            Group {
                TextField("", text: $userVM.profile.last_name)
                TextField("", text: $userVM.profile.first_name)
                TextField("", text: $userVM.profile.postal_code)
                TextField("", text: .constant(userVM.profile.gender == "1" ? "Mâle" : "Féminin"))
            }
            .textFieldStyle(MyTextFieldStyle(editable: true))
            .shadow(color: .gray.opacity(0.2), radius: 10)
            .padding(.bottom)
            Button("Enregister") {
                if self.cgImage != self.profileImage.cgImage {
                    Networking.shared.upload(profileImage.jpegData(compressionQuality: 1)!, fileName: "msgl_profil.jpeg", fileType: "image") { result in
                        switch result {
                        case .success(let response):
                            DispatchQueue.main.async {
                                self.userVM.profile.image_url = response.files.first?.path
                            }
                            updateProfile()
                        case .failure(let error):
                            print("Profile image upload failed: \(error)")
                        }
                    }
                } else {
                    updateProfile()
                }
              
            }
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
//            do {
//                let imageData = try Data(contentsOf: profileImageUrl())
//                self.selectedImage = UIImage(data: imageData) ?? UIImage()
//            } catch {
//                print("Error loading image : \(error)")
//            }
//            let imageView = UIImageView()
//            if auth.user.image_url != nil {
//                imageView.af.setImage(withURL: URL(fileURLWithPath: auth.user.image_url!))
//                if let image = imageView.image {
//                    self.selectedImage = image
//                    self.cgImage = self.selectedImage.cgImage
//                }
//            }
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(selectedImage: $profileImage)
        }
    }
    
    func updateProfile() {
        APIService.shared.post(model: userVM.profile, response: auth.user, endpoint: "users/\(auth.user.id ?? 0)/profile", method: "PATCH") { result in
            switch result {
            case .success(let user):
                print(user.first_name)
                DispatchQueue.main.async {
                    let password = auth.user.password
                    auth.user = user
                    auth.user.password = password
                    auth.updateUser()
                }
            case .failure(let error):
                print(error.error_description)
            }
        }
    }
}

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
