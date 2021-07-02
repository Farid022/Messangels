//
//  DocThemeView.swift
//  Messangel
//
//  Created by Saad on 7/1/21.
//

import SwiftUI
import PDFKit

struct DocThemeView: View {
    @State var selectedTheme = "Aucun" {
        willSet {
            
        }
    }
    var body: some View {
        MenuBaseView(height: 60, title: "Créer un message texte") {
            Text("Aperçu")
                .font(.system(size: 17))
                .fontWeight(.bold)
            PDFThumbnail(pdfView: pdfView(path: URL(fileURLWithPath: "\(getDocumentsDirectory())/output.pdf")))
                .shadow(color: .gray.opacity(0.2), radius: 5)
                .padding(.vertical, 30)
            Text("Choisir un thème")
                .font(.system(size: 17))
                .fontWeight(.bold)
                .padding(.top, 200)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0.0){
                    ForEach(themes, id: \.self) { theme in
                        DocTheme(image: theme["image"]!, name: theme["name"]!, selectedTheme: $selectedTheme)
                            .onTapGesture {
                                selectedTheme = theme["name"]!
                            }
                    }
                }
            }
            Button {
                
            } label: {
                Image("btn_save")
            }

        }
    }
}

struct PDFThumbnail : UIViewRepresentable {
    var pdfView : PDFView
    
    func makeUIView(context: Context) -> PDFThumbnailView {
        let thumbnail = PDFThumbnailView()
        thumbnail.pdfView = pdfView
        thumbnail.thumbnailSize = CGSize(width: 128, height: 178)
        thumbnail.layoutMode = .vertical
        return thumbnail
    }
    
    func updateUIView(_ uiView: PDFThumbnailView, context: Context) {
        //do any updates you need
        //you could update the thumbnailSize to the size of the view here if you want, for example
        //uiView.thumbnailSize = uiView.bounds.size
    }
}

func pdfView(path: URL) -> PDFView {
//    let pdfView = PDFView(frame: CGRect(x: 50, y: 150, width: 128, height: 178))
    let pdfView = PDFView()
    guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("output").appendingPathExtension("pdf")
        else { fatalError("Destination URL not created") }
    if let document = PDFDocument(url: outputURL) {
        pdfView.document = document
    }
    return pdfView
}

struct DocThemeView_Previews: PreviewProvider {
    static var previews: some View {
        DocThemeView()
    }
}

struct DocTheme: View {
    var image: String
    var name: String
    @Binding var selectedTheme: String
    var body: some View {
        VStack{
            Image(image)
                .padding(.top, -20)
                .padding(.bottom, -56)
            Rectangle()
                .fill(name == selectedTheme ? Color.accentColor : Color.white)
                .frame(width: 161, height: 44)
                .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight]))
                .overlay(Text(name).foregroundColor(name == selectedTheme ? .white : .black))
        }
        .padding(.horizontal, -37)
    }
}

let themes = [
    ["name" : "Aucun", "image" : "no_theme"],
    ["name" : "Forêt", "image" : "forest"],
    ["name" : "Plage", "image" : "beach"],
    ["name" : "Soleil couchant", "image" : "sunset"],
    ["name" : "Papier", "image" : "paper"],
]
