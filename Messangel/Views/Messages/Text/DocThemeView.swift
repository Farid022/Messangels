//
//  DocThemeView.swift
//  Messangel
//
//  Created by Saad on 7/1/21.
//

import SwiftUI
import NavigationStack

struct DocThemeView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @EnvironmentObject private var groupVM: GroupViewModel
    @State private var selectedTheme = "Aucun"
    @State private var fileUrl = URL(string: "")
    var htmlAttributedString = NSAttributedString()
    var htmlString: String
    
    var body: some View {
        NavigationStackView("DocThemeView") {
            MenuBaseView(height: 60, title: "Créer un message texte", backButton: false) {
                Text("Aperçu")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                DocPreview(selectedTheme: $selectedTheme, htmlString: htmlAttributedString)
                Text("Choisir un thème")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.top, -20)
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
                    if let fileUrl = fileUrl {
                        navigationModel.pushContent("DocThemeView") {
                            DocTitleView(selectedTheme: $selectedTheme, htmlString: htmlAttributedString, filename: fileUrl)
                        }
                    }
                } label: {
                    Image("btn_save")
                }
            }
        }
        .onDidAppear {
            self.fileUrl = writeHtmlString(html: htmlString)
        }
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

struct DocPreview: View {
    @Binding var selectedTheme: String
    var htmlString: NSAttributedString
    var body: some View {
        Image(selectedTheme)
            .overlay(
                AttributedText(htmlString)
                    .font(.system(size: 3))
                    .frame(width: 108, height: 80)
                    .padding(.top, 30)
                ,
                alignment: .top
            )
    }
}

// let footer = "<div style='position:fixed;bottom:0;text-align:center;'><img width='100%' src='data:image/png;base64,\(UIImage(named: "forest_footer")?.pngData()?.base64EncodedString() ?? "")' /></div>"

//func createPDF(wkWebView: WKWebView) {
//    let fmt = wkWebView.viewPrintFormatter()
//    // 2. Assign print formatter to UIPrintPageRenderer
//    let render = UIPrintPageRenderer()
//    render.addPrintFormatter(fmt, startingAtPageAt: 0)
//    // 3. Assign paperRect and printableRect
//    let page = CGRect(x: 0, y: 0, width: 615, height: 841.8) // A4, 72 dpi
//    let printable = page.insetBy(dx: 0, dy: 0)
//    render.setValue(NSValue(cgRect: page), forKey: "paperRect")
//    render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
//    // 4. Create PDF context and draw
//    let pdfData = NSMutableData()
//    UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
//    for i in 1...render.numberOfPages {
//        UIGraphicsBeginPDFPage();
//        let bounds = UIGraphicsGetPDFContextBounds()
//        render.drawPage(at: i - 1, in: bounds)
//    }
//    UIGraphicsEndPDFContext();
//    // 5. Save PDF file
//    guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("output").appendingPathExtension("pdf")
//        else { fatalError("Destination URL not created") }
//    let result = pdfData.write(to: outputURL, atomically: true)
//    if result {
//        print("\(getDocumentsDirectory())/output.pdf")
//    }
//}

//struct PDFThumbnail : UIViewRepresentable {
//    var pdfView : PDFView
//
//    func makeUIView(context: Context) -> PDFThumbnailView {
//        let thumbnail = PDFThumbnailView()
//        thumbnail.pdfView = pdfView
//        thumbnail.thumbnailSize = CGSize(width: 128, height: 178)
//        thumbnail.layoutMode = .vertical
//        return thumbnail
//    }
//
//    func updateUIView(_ uiView: PDFThumbnailView, context: Context) {
//        //do any updates you need
//        //you could update the thumbnailSize to the size of the view here if you want, for example
//        //uiView.thumbnailSize = uiView.bounds.size
//    }
//}

//func pdfView(path: URL) -> PDFView {
////    let pdfView = PDFView(frame: CGRect(x: 50, y: 150, width: 128, height: 178))
//    let pdfView = PDFView()
//    guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("output").appendingPathExtension("pdf")
//        else { fatalError("Destination URL not created") }
//    if let document = PDFDocument(url: outputURL) {
//        pdfView.document = document
//    }
//    return pdfView
//}

//struct DocThemeView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocThemeView(htmlString: )
//    }
//}



