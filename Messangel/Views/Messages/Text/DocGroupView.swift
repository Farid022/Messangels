//
//  DocGroupView.swift
//  Messangel
//
//  Created by Saad on 7/12/21.
//

import SwiftUI
import NavigationStack

struct DocGroupView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @Binding var selectedTheme: String
    @State private var selectedGroup = 0
    var htmlString: NSAttributedString
    var filename: URL
    @State private var valid = false
    @State private var loading = false
    @State private var showNewGroupBox = false
    @ObservedObject var vm:TextViewModel
    @EnvironmentObject var groupVM: GroupViewModel
    
    var body: some View {
        NavigationStackView("DocGroupView") {
            ZStack {
                if loading {
                    RoundedRectangle(cornerRadius: 15.0)
                        .foregroundColor(.white)
                        .frame(width:236, height: 51)
                        .shadow(radius: 10)
                        .overlay(
                            Text("Texte enregistré")
                                .font(.system(size: 17), weight: .semibold)
                                .foregroundColor(.accentColor)
                        )
                        .zIndex(1.0)
                }
                if showNewGroupBox {
                    InputAlert(title: "Donnez un nom au groupe", message: newGroupMessage) { result in
                        showNewGroupBox.toggle()
                        if let text = result {
                            if !text.isEmpty && text.count > 2 {
                                groupVM.group.name = text
                                groupVM.group.user = getUserId()
                                groupVM.create { success in
                                    print("Group \(text) created: \(success)")
                                        if success {
                                            groupVM.getAll()
                                        }
                                }
                            }
                        }
                    }
                    .zIndex(1.0)
                }
                ZStack(alignment: .bottom) {
                    if loading {
                        Color.black.opacity(0.3)
                            .ignoresSafeArea()
                            .zIndex(1.0)
                    }
                    MenuBaseView(height: 60, title: "Destinataires") {
                        Text("Aperçu")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                        DocPreview(selectedTheme: $selectedTheme, htmlString: htmlString)
                    }
                    VStack {
                        Text("Choisir ou créer un groupe")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0.0){
                                ForEach(groupVM.groups, id: \.self) { group in
                                    ZStack {
                                        if group.id == selectedGroup {
                                            RoundedRectangle(cornerRadius: 20.0)
                                                .stroke(Color.accentColor)
                                                .frame(width: 341, height: 111)
                                        }
                                        GroupCapsule(group: group, tappable: false, width: 339)
                                            .onTapGesture {
                                                selectedGroup = group.id
                                                if selectedGroup > 0 {
                                                    valid = true
                                                }
                                            }
                                            .padding()
                                    }
                                }
                                CreateGroupView(width: 339, showNewGroupBox: $showNewGroupBox)
                            }
                            .padding()
                        }
                        HStack {
                            Button(action: {
                                if valid {
                                    upload()
                                }
                            }, label: {
                                Text("Valider")
                                    .font(.system(size: 15))
                                    .padding(3)
                            })
                            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: valid ? .accentColor : .gray))
                            .padding(.bottom, 50)
                            .padding(.top, 20)
                        }
                        .frame(maxWidth: .infinity)
                        .background(
                            Color.white
                                .clipShape(CustomCorner(corners: [.topLeft,.topRight]))
                        )
                        .shadow(color: Color.gray.opacity(0.15), radius: 5, x: -5, y: -5)
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
    
    func upload() {
        loading = true
        do {
            let data = try Data(contentsOf: filename)
            Networking.shared.upload(data, fileName: filename.lastPathComponent, fileType: "text") { result in
                loading = false
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        vm.uploadResponse = response
                        vm.text.message = response.files.first?.path ?? ""
                        vm.text.size = "\(response.files.first?.size ?? 0)"
                        vm.text.group = selectedGroup
                        vm.create {
                            navigationModel.popContent(TabBarView.id)
                        }
                    }
                case .failure(_):
                   return
                }
            }
        } catch let err {
            print(err)
        }
    }
}

//struct DocGroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocGroupView(selectedTheme: .constant("Forêt"), htmlString: NSAttributedString())
//        //        DocGroupView()
//    }
//}
