//
//  TextEditorView.swift
//  Messangel
//
//  Created by Saad on 6/24/21.
//

import SwiftUI
import NavigationStack

struct TextEditorView: View {
    
    @State private var htmlText = ""
    @State private var isEditingRichText = false
    @State private var showRichText = true
    @State private var showFontPicker = false
    @State private var selectedFont = "Arial"
    @EnvironmentObject var editor: RichEditorView
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var groupVM: GroupViewModel

    private let fontFamilies = ["Arial", "Verdana", "Helvetica", "Tahoma"]
    
    var body: some View {
        NavigationStackView("TextEditorView") {
        VStack(spacing: 0.0) {
            Color.accentColor
                .ignoresSafeArea()
                .frame(height: 60)
                .overlay(HStack {
                    BackButton()
                        .padding(.leading)
                    Spacer()
                    Text("Créer un message texte")
                        .foregroundColor(.white)
                    Spacer()
                    if htmlText.length > 10 {
                        Button(action: {
                            showRichText = false
                            editor.getHtml { html in
                                let finalHtml = "<div style='padding: 20px;'>" + html + "</div>"
                                let htmlAtrributedString = (html.htmlToAttributedString?.setFontSize(fontSize: 3))!
                                DispatchQueue.main.async {
                                    navigationModel.pushContent("TextEditorView") {
                                        DocThemeView(htmlAttributedString: htmlAtrributedString, htmlString: finalHtml)
                                    }
                                }
                            }
                        }, label: {
                            Text("OK")
                                .foregroundColor(.white)
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                        })
                        .padding(.trailing)
                    } else {
                        Image("help")
                            .padding(.horizontal, -30)
                    }
                }
                .if(htmlText.length <= 10 ) {$0.padding(.bottom, -30)}
                , alignment: .bottom)
                VStack {
                    if showRichText {
                        MyRichTextEditor(htmlText: $htmlText, isEditingRichText: $isEditingRichText)
                            .padding()
                    }
                    Spacer()
                    if isEditingRichText {
                        HStack(spacing: 25) {
                            Spacer()
                            Button {
                                withAnimation() {
                                    showFontPicker.toggle()
                                }
                            } label: {
                                Image("font")
                                    .renderingMode(.template)
                                    .foregroundColor(showFontPicker ? .accentColor : .black)
                            }
                            .frame(maxWidth: .infinity)
                            if showFontPicker {
                                Picker(selection: $selectedFont, label:
                                        HStack {
                                            Image(systemName: "arrowtriangle.down.fill")
                                                .font(.system(size: 11))
                                                .foregroundColor(.gray.opacity(0.3))
                                                .padding(.leading)
                                            Text("\(selectedFont)")
                                                .font(.system(size: 14))
                                            Spacer()
                                        }) {
                                    ForEach(fontFamilies, id: \.self) {
                                        Text("\($0)")
                                    }
                                }
                                .frame(width: 250, height: 30)
                                .background(Color.white).cornerRadius(10).foregroundColor(.black).pickerStyle(MenuPickerStyle())
                                .overlay(Button(action: {
                                    withAnimation() {
                                        showFontPicker.toggle()
                                    }
                                }, label: {
                                    Image("ic_xmark")
                                        .padding(.trailing)
                                }), alignment: .trailing)
                                .onChange(of: selectedFont, perform: { value in
                                    editor.setFontFamily(selectedFont)
                                })
                            } else {
                                Button { editor.bold() } label: { Image("bold") }.frame(maxWidth: .infinity)
                                Button { editor.italic() } label: { Image("italic") }.frame(maxWidth: .infinity)
                                Button { editor.alignLeft() } label: { Image("justify_left") }.frame(maxWidth: .infinity)
                                Button { editor.alignCenter() } label: { Image("justify_center") }.frame(maxWidth: .infinity)
                                Button { editor.alignRight() } label: { Image("justify_right") }.frame(maxWidth: .infinity)
                                Button { editor.blur() } label: { Image(systemName: "xmark").foregroundColor(.gray) }.frame(maxWidth: .infinity)
                            }
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 44)
                        .background(Color(UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)))
                    }
                }
        }
        }
    }
}

func writeHtmlString(html: String) -> URL {
    let filename = getDocumentsDirectory().appendingPathComponent("text_\(getUserId())_\(UUID().uuidString).html")
    do {
        try html.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
    } catch {
        // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
    }
    return filename
}



struct MyRichTextEditor: UIViewRepresentable {
  
  class Coordinator: RichEditorDelegate {
    
    var parent: MyRichTextEditor
    
    init(_ parent: MyRichTextEditor) {
      self.parent = parent
    }
    
    func richEditorTookFocus(_ editor: RichEditorView) {
      parent.isEditingRichText = true
    }
    
    func richEditorLostFocus(_ editor: RichEditorView) {
      parent.isEditingRichText = false
    }
    
    func richEditor(_ editor: RichEditorView, contentDidChange content: String) {
      parent.htmlText = content
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  @Binding var htmlText: String
  @Binding var isEditingRichText: Bool
  @EnvironmentObject var editor: RichEditorView
  
  func makeUIView(context: Context) -> RichEditorView {
    
    editor.html = htmlText
    editor.isScrollEnabled = false
    editor.delegate = context.coordinator
    editor.placeholder = "Appuyez ici pour commencer à écrire..."

//    let toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
//    toolbar.options = [RichEditorDefaultOption.font, RichEditorDefaultOption.bold, RichEditorDefaultOption.italic, RichEditorDefaultOption.alignLeft, RichEditorDefaultOption.alignCenter, RichEditorDefaultOption.alignRight]
//    toolbar.barTintColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
//    toolbar.editor = editor
//    editor.inputAccessoryView = toolbar
    return editor
  }
  
  func updateUIView(_ uiView: RichEditorView, context: Context) {
  }
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

 

