//
//  DocTitleView.swift
//  Messangel
//
//  Created by Saad on 7/8/21.
//

import SwiftUI
import NavigationStack

struct DocTitleView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var groupVM: GroupViewModel
    @StateObject private var textVM = TextViewModel()
    @Binding var selectedTheme: String
    var htmlString: NSAttributedString
    var filename: URL
    @State var valid = false
    
    var body: some View {
        NavigationStackView("DocTitleView") {
            MenuBaseView(height: 60, title: "Filtre") {
                Text("Aperçu")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                DocPreview(selectedTheme: $selectedTheme, htmlString: htmlString)
                Text("Choisir un titre")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .padding(.top, -20)
                TextField("Titre de du texte", text: $textVM.text.name, onCommit: {
                    valid = !textVM.text.name.isEmpty
                })
                    .textFieldStyle(MyTextFieldStyle())
                    .normalShadow()
                    .padding(.bottom)
                HStack {
                    Spacer()
                    Rectangle()
                        .fill(valid ? Color.accentColor : Color.accentColor.opacity(0.2))
                        .frame(width: 56, height: 56)
                        .cornerRadius(25)
                        .overlay(
                            Button(action: {
                                navigationModel.pushContent("DocTitleView") {
                                    DocGroupView(selectedTheme: $selectedTheme, htmlString: htmlString, filename: filename, vm: textVM)
                                }
                            }) {
                                Image(systemName: "chevron.right").foregroundColor(Color.white)
                            }
                        )
                }
            }
        }
    }
}

//struct DocTitleView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocTitleView(selectedTheme: .constant("Forêt"), htmlString: NSAttributedString())
//    }
//}
