//
//  CustomViews.swift
//  Messengel
//
//  Created by Saad on 4/30/21.
//

import SwiftUI
import NavigationStack
import PDFKit
import Kingfisher

struct MyLink: View {
    var url = "https://www.google.com/"
    var text: String
    var fontSize: CGFloat = 13
    var body: some View {
        Link(destination: URL(string: url)!, label: {
            Text(text)
                .font(.system(size: fontSize))
                .underline()
        })
    }
}

// MARK: - Buttons

struct NextButton: View {
    var isCustomAction = false
    var customAction: () -> Void = {}
    var source: String?
    var destination: AnyView?
    var color = Color.white
    var iconColor = Color.accentColor
    
    @Binding var active: Bool
    @EnvironmentObject private var navigationModel: NavigationModel
    
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .frame(width: 56, height: 56)
            .cornerRadius(25)
            .opacity(active ? 1 : 0.5)
            .overlay(
                Button(action: {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    if active && isCustomAction {
                        customAction()
                    } else if active, let source = source {
                        navigationModel.pushContent(source) {
                            destination
                        }
                    }
                }) {
                    Image(systemName: "chevron.right").foregroundColor(iconColor)
                }
            )
    }
}

struct ContactsListButton: View {
    var action: () -> Void
    var body: some View {
        HStack {
            Button(action: {
                action()
            }, label: {
                HStack {
                    Image("ic_contacts")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                    Text("Liste des contacts")
                }
            })
            .buttonStyle(MyButtonStyle(padding: 0.0, maxWidth: false, foregroundColor: .white, backgroundColor: .accentColor))
            Spacer()
        }
    }
}

struct OrgListButton: View {
    var action: () -> Void
    var body: some View {
        HStack {
            Button(action: {
                action()
            }, label: {
                HStack {
                    Image("ic_orgs")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                    Text("Liste des organismes")
                }
            })
            .buttonStyle(MyButtonStyle(padding: 0.0, maxWidth: false, foregroundColor: .white, backgroundColor: .accentColor))
            Spacer()
        }
    }
}

struct SignupProgressView: View {
    @Binding var progress: Double
    var tintColor = Color.white
    var progressMultiplier: Double
    
    var body: some View {
        Rectangle()
            .foregroundColor(tintColor)
            .frame(width: screenSize.width * (progress/100), height: 4.5)
            .padding(.horizontal, -17)
            .padding(.bottom, -17)
    }
}

struct FlowProgressView: View {
    @Binding var progress: Double
    var tintColor = Color.white
    var progressMultiplier: Double
    
    var body: some View {
        ProgressView(value: progress, total: 100.0)
            .progressViewStyle(LinearProgressViewStyle(tint: tintColor))
            .padding(.horizontal, -17)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation {
                        progress += progressMultiplier
                    }
                }
            }
    }
}

struct CustomCorner: Shape {
    
    var corners: UIRectCorner
    var radius = 25.0
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

var months = ["Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Août","Septembre","Octobre","Novembre","Décembre"]

struct MyDatePickerView: View {
    @Binding var day: Int
    @Binding var month: String
    @Binding var year: Int
    
    var body: some View {
        HStack {
            Spacer().frame(width: 20)
            Picker(selection: $day, label: HStack(alignment: .bottom) {
                Image("updown")
                Text("\(day)").font(.system(size: 20))
            }) {
                ForEach((1...31), id: \.self) {
                    Text("\($0)")
                }
            }
            Spacer()
            Picker(selection: $month, label: HStack(alignment: .bottom) {
                Image("updown")
                Text("\(month)").font(.system(size: 20))
            }) {
                ForEach(months, id: \.self) {
                    Text("\($0)")
                }
            }
            Spacer()
            Picker(selection: $year, label: HStack(alignment: .bottom) {
                Image("updown")
                Text(String(year)).font(.system(size: 20))
            }) {
                ForEach((1930...2010), id: \.self) {
                    Text(String($0))
                }
            }
            Spacer().frame(width: 20)
        }
        .padding().background(Color.white).cornerRadius(20).foregroundColor(.black).pickerStyle(MenuPickerStyle())
    }
}


struct CustomTextField: UIViewRepresentable {
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        var didBecomeFirstResponder = false
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
    }
    
    @Binding var text: String
    var isFirstResponder: Bool = false
    
    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }
    
    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text)
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}

struct InputAlert: View {
    @State private var inputText = ""
    @FocusState private var isFocused: Bool
    var title: String
    var message: String
    var placeholder = ""
    var ok = "Valider"
    var cancel = "Cancel"
    var action: (String?) -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 22.0)
            .foregroundColor(.white)
            .frame(width: 270, height: 188)
            .thinShadow()
            .overlay(
                VStack {
                    Text(title)
                        .font(.system(size: 17), weight: .semibold)
                        .padding(.bottom, 5)
                    Text(message)
                        .font(.system(size: 13))
                        .multilineTextAlignment(.center)
                    //                    CocoaTextField(placeholder, text: $inputText)
                    //                        .isInitialFirstResponder(true)
                    //                        .borderStyle(.roundedRect)
                    TextField(placeholder, text: $inputText)
                        .focused($isFocused)
                        .textFieldStyle(.roundedBorder)
                        .padding(.bottom, 5)
                    Divider()
                        .padding(.horizontal, -15)
                    HStack {
                        Spacer()
                        Button(action: {
                            action(nil)
                        }) {
                            Text(cancel)
                                .font(.system(size: 17))
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Divider()
                            .padding(.top, -3)
                        Spacer()
                        Button(action: {
                            action(inputText)
                        }) {
                            Text(ok)
                                .font(.system(size: 17), weight: .semibold)
                                .foregroundColor(.accentColor)
                        }
                        Spacer()
                    }
                    .padding(.vertical, -5)
                }
                    .padding(.horizontal)
                    .padding(.top, 25)
            )
            .onAppear() {
                isFocused = true
            }
    }
}

struct MyAlert: View {
    var title: String
    var message: String
    var ok = "Supprimer"
    var cancel = "Annuler"
    var height = 160.0
    var action: () -> Void
    @Binding var showAlert: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 22.0)
            .foregroundColor(.white)
            .frame(width: 270, height: height)
            .thinShadow()
            .overlay(
                VStack {
                    if !title.isEmpty {
                        Text(title)
                            .font(.system(size: 17), weight: .semibold)
                    }
                    Text(message)
                        .font(.system(size: 13))
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 5)
                    Divider()
                        .padding(.horizontal, -15)
                    HStack {
                        Spacer()
                        Button(action: {
                            showAlert.toggle()
                        }) {
                            Text(cancel)
                                .font(.system(size: 17))
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Divider()
                        //                            .padding(.top, -3)
                        Spacer()
                        Button(action: {
                            showAlert.toggle()
                            action()
                        }) {
                            Text(ok)
                                .font(.system(size: 17), weight: .semibold)
                                .foregroundColor(.accentColor)
                        }
                        Spacer()
                    }
                    .frame(height: 44)
                    //                    .padding(.vertical, -5)
                }
                    .padding(.horizontal)
                    .padding(.top, 25)
            )
    }
}

struct ListItemView: View {
    var name = ""
    var image = "ic_company"
    var action = {}
    
    var body: some View {
        Button {
            action()
        } label: {
            Capsule()
                .fill(Color.white)
                .frame(height: 56)
                .normalShadow()
                .overlay(HStack{
                    Image(image)
                        .padding(.leading)
                    Text(name)
                    Spacer()
                    Image("ic_add_circle")
                        .padding(.trailing)
                })
                .padding(.bottom)
        }
        
    }
}

struct ChoiceCard: View {
    var text: String
    @Binding var selected: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 22)
            .foregroundColor(.white)
            .frame(width: 160, height: 160)
            .normalShadow()
            .overlay(
                VStack {
                    Spacer().frame(height: 50)
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 26, height: 26)
                            .thinShadow()
                        Circle()
                            .fill(selected ? Color.accentColor : Color.gray)
                            .frame(width: 18, height: 18)
                    }
                    Text(text)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Spacer()
                }
            )
    }
}

struct FlowChoicesView<VM: CUViewModel>: View {
    @State var showNote = false
    var tab = 0
    var stepNumber: Double
    var totalSteps: Double
    @Binding var noteText: String
    @Binding var noteAttachmentIds: [Int]?
    @Binding var oldAttachedFiles: [URL]?
    var choices: [FuneralChoice]
    @Binding var selectedChoice: Int
    var menuTitle: String
    var title: String
    var destination: AnyView
    @ObservedObject var vm: VM
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $noteText, oldAttachedFiles: $oldAttachedFiles, noteAttachmentIds: $noteAttachmentIds)
                 .zIndex(1.0)
                 .background(.black.opacity(0.8))
            }
            WishesFlowBaseView(tab: tab, stepNumber: stepNumber, totalSteps: totalSteps, noteText: $noteText, note: true, showNote: $showNote, menuTitle: menuTitle, title: title, valid: .constant(true), destination: destination, viewModel: vm) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: -70){
                        ForEach(choices, id: \.self) { choice in
                            VStack(spacing: 0) {
                                Image(choice.name)
                                Rectangle()
                                    .foregroundColor(selectedChoice == choice.id ? .accentColor : .white)
                                    .frame(width: 161, height: 44)
                                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight]))
                                    .overlay(
                                        Text(choice.name)
                                            .foregroundColor(selectedChoice == choice.id ? .white : .black)
                                    )
                                    .padding(.top, -50)
                            }
                            .thinShadow()
                            .onTapGesture {
                                selectedChoice = choice.id
                            }
                        }
                    }
                    .padding(.leading, -20)
                }
                .padding(.top, -20)
            }
        }
    }
}

struct FlowMultipleChoicesView<VM: CUViewModel>: View {
    @State var showNote = false
    var tab = 0
    var stepNumber: Double
    var totalSteps: Double
    @Binding var noteText: String
    @Binding var noteAttachmentIds: [Int]?
    @Binding var oldAttachedFiles: [URL]?
    var choices: [FuneralChoice]
    @Binding var selectedChoice: [Int]
    var menuTitle: String
    var title: String
    var destination: AnyView
    @ObservedObject var vm: VM
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $noteText, oldAttachedFiles: $oldAttachedFiles, noteAttachmentIds: $noteAttachmentIds)
                 .zIndex(1.0)
                 .background(.black.opacity(0.8))
            }
            WishesFlowBaseView(tab: tab, stepNumber: stepNumber, totalSteps: totalSteps, noteText: $noteText, note: true, showNote: $showNote, menuTitle: menuTitle, title: title, valid: .constant(true), destination: destination, viewModel: vm) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: -70){
                        ForEach(choices, id: \.self) { choice in
                            VStack(spacing: 0) {
                                Image(choice.name)
                                Rectangle()
                                    .foregroundColor(selectedChoice.contains(choice.id) ? .accentColor : .white)
                                    .frame(width: 161, height: 44)
                                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight]))
                                    .overlay(
                                        Text(choice.name)
                                            .foregroundColor(selectedChoice.contains(choice.id) ? .white : .black)
                                    )
                                    .padding(.top, -50)
                            }
                            .thinShadow()
                            .onTapGesture {
                                if selectedChoice.contains(choice.id) {
                                    selectedChoice.removeAll(where: {$0 == choice.id})
                                } else {
                                    selectedChoice.append(choice.id)
                                }
                            }
                        }
                    }
                    .padding(.leading, -20)
                }
                .padding(.top, -20)
            }
        }
    }
}

// MARK: - Custom Note Views

struct NoteView: View {
    @Binding var showNote: Bool
    @Binding var note: String
    
    var body: some View {
        VStack(spacing: 0.0) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 161, height: 207.52)
                .clipShape(CustomCorner(corners: [.topLeft, .topRight]))
                .overlay(
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(note.isEmpty ? Color.gray : Color.accentColor)
                        .frame(width: 56, height: 56)
                        .overlay(
                            Button(action: {
                                showNote.toggle()
                            }) {
                                Image(note.isEmpty ? "ic_add_note" : "ic_notes")
                            }
                        )
                )
            Rectangle()
                .fill(Color.white)
                .frame(width: 161, height: 44)
                .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight]))
                .overlay(Text("Note"))
        }
        .thinShadow()
    }
}

struct NoteWithAttachementView: View {
    @Binding var showNote: Bool
    @Binding var note:String
    @Binding var oldAttachedFiles: [URL]?
    @Binding var noteAttachmentIds: [Int]?
    @State var expandedNote = false
    @State var loading = false
    @State var showExitAlert = false
    @FocusState private var isFocused: Bool
    @State private var attachements = [Attachment]()
    @State private var showFileImporter = false
    @State private var attachedFiles = [URL]()
    var multiple = true
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer().frame(height: 100)
                HStack {
                    Button(action: {
//                        showExitAlert.toggle()
                        showNote.toggle()
                    }, label: {
                        Image("ic_close_note")
                    })
                    Spacer()
                    Button(action: {
                        note.removeAll()
                        attachements.removeAll()
                        noteAttachmentIds?.removeAll()
                        attachedFiles.removeAll()
                        oldAttachedFiles?.removeAll()
                        showNote.toggle()
                    }) {
                        Image("ic_del")
                    }
                }
                Spacer()
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(.white)
                    .frame(height: 56)
                    .overlay(
                        HStack {
                            Image("ic_note")
                            Text("Note")
                                .font(.system(size: 17), weight: .semibold)
                                .foregroundColor(.black)
                            Spacer()
                        }
                            .padding(.horizontal)
                    )
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(.white)
                    .frame(height: expandedNote ? 295 : 160)
                    .overlay(
                        VStack {
                            TextEditor(text: $note)
                                .focused($isFocused)
                            HStack {
                                Button(action: {
                                    isFocused = false
                                    showFileImporter.toggle()
                                }, label: {
                                    HStack {
                                        Image("ic_attachement")
                                        Text("Joindre un fichier")
                                            .foregroundColor(.gray)
                                            .underline()
                                    }
                                })
                                Spacer()
                                Button(action: {
                                    Task {
                                        loading.toggle()
                                        if !attachedFiles.isEmpty && (attachements.isEmpty || attachedFiles != oldAttachedFiles) {
                                            attachements.removeAll()
                                            let uploadedFiles = await uploadFiles(attachedFiles)
                                            for uploadedFile in uploadedFiles {
                                                attachements.append(Attachment(url: uploadedFile))
                                            }
                                            APIService.shared.post(model: attachements, response: attachements, endpoint: "users/note_attachment") { result in
                                                switch result {
                                                case .success(let attachements):
                                                    DispatchQueue.main.async {
                                                        self.attachements = attachements
                                                        var attachementIds = [Int]()
                                                        for attachement in self.attachements {
                                                            if let id = attachement.id {
                                                                attachementIds.append(id)
                                                            }
                                                        }
                                                        noteAttachmentIds = attachementIds
                                                        loading.toggle()
                                                        showNote.toggle()
                                                    }
                                                case .failure(let error):
                                                    DispatchQueue.main.async {
                                                        print(error.error_description)
                                                        loading.toggle()
                                                        showNote.toggle()
                                                    }
                                                }
                                            }
                                        } else {
                                            loading.toggle()
                                            showNote.toggle()
                                        }
                                    }
                                }, label: {
                                    Image("ic_save_note")
                                })
                            }
                        }
                            .padding(.horizontal)
                            .padding(.vertical, 20)
                    )
                if !attachedFiles.isEmpty {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 180))], alignment: .leading, spacing: 16.0)  {
                        ForEach(attachedFiles, id: \.self) { file in
                            FuneralCapsuleView(name: file.lastPathComponent) {
                                attachedFiles.remove(at: attachedFiles.firstIndex(of: file)!)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                Spacer()
            }
            .padding()
            .onAppear() {
                if oldAttachedFiles == nil {
                    isFocused = true
                }
                if let oldAttachedFiles = oldAttachedFiles {
                    self.attachedFiles = oldAttachedFiles
                }
            }
            .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.pdf, .image], allowsMultipleSelection: multiple) { result in
                switch result {
                case .success(let fileUrl):
                    fileUrl.forEach { url in
                        self.attachedFiles.append(url)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
//            if showExitAlert {
//                Color.black.opacity(0.8)
//                    .ignoresSafeArea()
//                    .overlay(MyAlert(title: "Quitter les notes", message: "Vos modifications ne seront pas enregistrées", ok: "Oui", cancel: "Non", action: {
//                        showNote.toggle()
//                    }, showAlert: $showExitAlert))
//            }
            if loading {
                UpdatingView(text: "Note enregistrée")
            }
        }
    }
}

struct DetailsNoteView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    var note: String
    var attachments: [Attachement]?
    var navId = ""
    var body: some View {
        VStack {
            if !note.isEmpty {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(.gray.opacity(0.2))
                        .frame(maxHeight: .infinity)
                    VStack(alignment: .leading) {
                        HStack{
                            Image("ic_note")
                            Text("Note")
                                .font(.system(size: 15), weight: .bold)
                            Spacer()
                        }
                        Text(note)
                        if let attachments = attachments, !attachments.isEmpty {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 180))], alignment: .leading, spacing: 16.0) {
                                ForEach(attachments, id: \.self) { file in
                                    FuneralCapsuleView(trailingButton: false, name: URL(string: file.url)?.lastPathComponent ?? "") {}
                                    .onTapGesture(count: 2) {}
                                    .onTapGesture(count: 1) {
                                        if let fileUrl = URL(string: file.url), !navId.isEmpty {
                                            navigationModel.presentContent(navId) {
                                                if fileUrl.pathExtension == "pdf" {
                                                    VStack {
                                                        HStack {
                                                            BackButton(iconColor: .accentColor)
                                                                .padding(.leading)
                                                            Spacer()
                                                        }
                                                        PDFKitRepresentedView(fileUrl)
                                                    }
                                                } else {
                                                    VStack {
                                                        HStack {
                                                            BackButton(iconColor: .accentColor)
                                                                .padding(.leading)
                                                            Spacer()
                                                        }
                                                        AsyncImage(url: fileUrl) { image in
                                                            image.resizable()
                                                        } placeholder: {
                                                            Loader()
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 30)
            }
        }
    }
}

struct FuneralNote: View {
    @Binding var showNote: Bool
    @Binding var note:String
    @State var expandedNote = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 50)
            HStack {
                Button(action: {
                    showNote.toggle()
                }, label: {
                    Image("ic_close_note")
                })
                Spacer()
            }
            Spacer()
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.gray)
                .frame(height: 56)
                .overlay(
                    HStack {
                        Image("ic_notes")
                        Text("Notes")
                            .font(.system(size: 17), weight: .semibold)
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            expandedNote.toggle()
                        }, label: {
                            Image("ic_expand_notes")
                        })
                    }
                    .padding(.horizontal)
                )
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.white)
                .frame(height: expandedNote ? 295 : 160)
                .overlay(
                    VStack {
                        TextEditor(text: $note)
                            .focused($isFocused)
                        HStack {
                            Spacer()
                            Button(action: {
                                showNote.toggle()
                            }, label: {
                                Image("ic_save_note")
                            })
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                )
            Spacer()
        }
        .padding()
        .onAppear() {
            isFocused = true
        }
    }

}
struct FuneralNoteView<VM: CUViewModel>: View {
    var tab = 0
    var stepNumber: Double
    var totalSteps: Double
    @Binding var showNote: Bool
    @Binding var note: String
    @Binding var noteAttachmentIds: [Int]?
    @Binding var oldAttachedFiles: [URL]?
    var menuTitle: String
    var title: String
    var destination: AnyView
    @ObservedObject var vm: VM
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $note, oldAttachedFiles: $oldAttachedFiles, noteAttachmentIds: $noteAttachmentIds)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            WishesFlowBaseView(tab: tab, stepNumber: stepNumber, totalSteps: totalSteps, note: false, showNote: .constant(false),menuTitle: menuTitle, title: title, valid: .constant(true), destination: destination, viewModel: vm) {
              NoteView(showNote: $showNote, note: $note)
            }
        }
    }
}

struct FuneralNoteAttachCutomActionView: View {
    var totalSteps: Double
    @Binding var showNote: Bool
    @Binding var note: String
    @Binding var loading: Bool
    @Binding var oldAttachedFiles: [URL]?
    @Binding var noteAttachmentIds: [Int]?
    var menuTitle: String
    var title: String
    var customAction: () -> Void
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $note, oldAttachedFiles: $oldAttachedFiles, noteAttachmentIds: $noteAttachmentIds)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            FlowBaseView(stepNumber: totalSteps, totalSteps: totalSteps, isCustomAction: true, customAction: customAction, note: false, showNote: .constant(false), menuTitle: menuTitle, title: title, valid: .constant(true)) {
                NoteView(showNote: $showNote, note: $note)
                if loading {
                    Loader()
                        .padding(.top)
                }
            }
        }
    }
}

struct FuneralCapsuleView: View {
    var trailingButton = true
    var name: String
    var action: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(height: 56)
                .foregroundColor(.white)
                .thinShadow()
            HStack(spacing: 20) {
                Text(name)
                    .font(.system(size: 14))
                if trailingButton {
                    Button(action: {
                        action()
                    }, label: {
                        ZStack {
                            Circle()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            Image("ic_remove")
                        }
                    })
                        .thinShadow()
                }
            }
            .padding(.horizontal)
        }
        .fixedSize()
    }
}

// MARK: - PDF

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL
    
    init(_ url: URL) {
        self.url = url
    }
    
    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        return pdfView
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}

//MARK: - Image Views
struct ProfileImageView: View {
    var imageUrlString: String?
    var imageSize = 64.0
    var body: some View {
        if let imageUrlString = imageUrlString, let imageUrl = URL(string: imageUrlString) {
            KFImage(imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: imageSize, height: imageSize)
                .clipShape(Circle())
        }
    }
}

struct ImageSelectionView: View {
    @State private var showImagePicker: Bool = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @Binding var showImagePickerOptions: Bool
    @Binding var localImage: UIImage
    var remoteImage: String
    var imageSize = 66.0
    var title = "Ajouter une photo"
    var underlineTitle = true
    
    var body: some View {
        Button {
            showImagePickerOptions.toggle()
        } label: {
            if remoteImage.isEmpty && localImage.cgImage == nil {
                VStack {
                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(width: 66, height: 66)
                        .clipShape(Circle())
                        .overlay(Image("ic_camera"))
                    Text(title)
                        .foregroundColor(.gray)
                        .if (underlineTitle) { $0.underline() }
                }
            } else if localImage.cgImage != nil {
                Image(uiImage: localImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(Circle())
            } else if !remoteImage.isEmpty {
                KFImage.url(URL(string: remoteImage))
                    .placeholder {
                        Rectangle()
                            .fill(Color.accentColor)
                            .frame(width: 66, height: 66)
                            .clipShape(Circle())
                            .overlay(Loader(tintColor: .white))
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(Circle())
            }
        }
        .ActionSheet(showImagePickerOptions: $showImagePickerOptions, showImagePicker: $showImagePicker, sourceType: $sourceType)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$localImage, isShown: self.$showImagePicker, sourceType: $sourceType)
        }
    }
}

struct DetailsPhotoView: View {
    var imageUrlString: String?
    @Binding var fullScreenPhoto: Bool
    
    var body: some View {
        if let imageUrlString = imageUrlString, let imageUrl = URL(string: imageUrlString) {
            HStack {
                KFImage(imageUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 128, height: 128)
                    .clipShape(Circle())
                    .overlay(alignment: .bottomTrailing) {
                        Image("ic_full_photo")
                            .onTapGesture {
                                fullScreenPhoto.toggle()
                            }
                    }
                Spacer()
            }
            .padding(.bottom)
        }
    }
}

struct DetailsFullScreenPhotoView: View {
    var imageUrlString: String
    @Binding var fullScreenPhoto: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Spacer()
                KFImage(URL(string: imageUrlString))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 310)
                    .clipped()
                Spacer()
            }
            .background(Color.black.opacity(0.5))
            .background(.ultraThinMaterial)
            HStack {
                Button {
                    fullScreenPhoto.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding()
        }
        .zIndex(1.0)
    }
}

// MARK: -
struct UpdatingView: View {
    var text = "Ajouté"
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.white)
                    .frame(width: 236, height: 51)
                Text(text)
                    .font(.system(size: 17), weight: .semibold)
                    .foregroundColor(.accentColor)
            }
        }
    }
}

struct Loader : View {
    var tintColor = Color.accentColor
    var body: some View{
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}

struct AlertMessageView: View {
    var message: String
    @Binding var showAlert: Bool
    var body: some View {
        VStack {
            if showAlert {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.black.opacity(0.42))
                    HStack(alignment: .top) {
                        Text(message)
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                            .padding(.leading)
                            .padding(.vertical, 25)
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .padding(.trailing, 15)
                            .padding(.top)
                            .onTapGesture {
                                showAlert = false
                            }
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding()
            }
        }
    }
}

// MARK: - MyTextField
struct MyTextField: UIViewRepresentable {
    var placeholder = ""
    @Binding var text: String
    @Binding var isSecureTextEntry: Bool
//    var textContentType: UITextContentType = .newPassword
    var onCommit: () -> Void = { }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.placeholder = placeholder
        textField.delegate = context.coordinator
        textField.returnKeyType = .next
        textField.text = self.text
        textField.passwordRules = UITextInputPasswordRules(descriptor: "required: upper; required: digit; max-consecutive: 2; minlength: 8;")

        
        _ = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
            .compactMap {
                guard let field = $0.object as? UITextField else {
                    return nil
                }
                return field.text
            }
            .sink {
                self.text = $0
            }
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.isSecureTextEntry = isSecureTextEntry
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: MyTextField
        
        init(_ textField: MyTextField) {
            self.parent = textField
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let currentValue = textField.text as NSString? {
                let proposedValue = currentValue.replacingCharacters(in: range, with: string) as String
                self.parent.text = proposedValue
            }
            return true
        }
//        func textFieldDidEndEditing(_ textField: UITextField) {
//            parent.onCommit()
//        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            parent.onCommit()
            return true
        }
    }
}
