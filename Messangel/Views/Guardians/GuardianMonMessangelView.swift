//
//  GuardianMonMessangelView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 3/30/22.
//

import SwiftUI
import NavigationStack
import Combine
import SwiftUIX

struct GuardianMonMessangelView: View {
    @State private var stored: Int = 0
    @State private var current: [Int] = []
    @EnvironmentObject private var navigationModel: NavigationModel
    @StateObject private var guardianViewModel = GuardianViewModel()
    @StateObject private var volontesViewModel = VolontesViewModel()
    @StateObject var auth = Auth()
    @EnvironmentObject var envAuth: Auth
    @ObservedObject var imageLoader:ImageLoader
    @State private var cgImage = UIImage().cgImage
    
    @State private var profileImage = UIImage()
    @StateObject private var vmKeyAcc = KeyAccViewModel()

  
    var body: some View {
     
        NavigationStackView("MonMessangelView") {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(spacing: 0.0) {
                Color.accentColor
                    .ignoresSafeArea()
                    .frame(height: 5)
                NavBar()
                    .overlay(HStack {
                        BackButton()
                        Spacer()
                        Text("Mon Messangel")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                           
                        Spacer()
                        
                    }
                    .padding(.trailing)
                    .padding(.leading))
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                    ScrollView {
                       
                        VStack{
                            
                         dateView()
                            Group{
                         Image("logo_colored")
                                .padding(.top,40)
                                .padding(.bottom,40)
                                Text(envAuth.user.first_name + " " + envAuth.user.last_name)
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                                
                                if envAuth.user.image_url == nil {
                                    Image("ic_camera")
                                        .frame(width: 62, height: 62)
                                        .padding(.top,12)
                                        .padding(.bottom,12)
                                        .background(Color.gray)
                                        .clipShape(Circle())
                                        .cornerRadius(31)
                                } else {
                               
                                 
                                    
                                    AsyncImage(url: URL(string: envAuth.user.image_url ?? "")) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                            .frame(width: 62, height: 62)
                                            .padding(.top,12)
                                            .padding(.bottom,12)
                                            .clipShape(Circle())
                                           
                                            
                                }
                                
                     
                               
                                Text("Née le " + envAuth.user.getDOB() + "\nà " + envAuth.user.city)
                                    .font(.system(size: 15))
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom,40)
                            }
                            documentView(guardians: guardianViewModel.guardians)
                           
                            Group{
                            Image("ic_mesVolontes")
                                .padding(.bottom,12)
                                .padding(.top,80)
                            Text("Mes volontés")
                                   .font(.system(size: 20))
                                   .fontWeight(.bold)
                                   .multilineTextAlignment(.center)
                                   .padding(.bottom,40)
                            }
                          
                            MesVoluntesView(itemArray: volontesViewModel.tabs)
                            Group{
                           
                                Image("ic_mesMessage")
                                .padding(.bottom,12)
                                .padding(.top,80)
                                Text("Mes messages")
                                   .font(.system(size: 20))
                                   .fontWeight(.bold)
                                   .multilineTextAlignment(.center)
                                   .padding(.bottom,24)
                                Text("49 Messages prêts à être envoyés \nde manière confidentielle")
                                   .font(.system(size: 15))
                                   .fontWeight(.bold)
                                   .multilineTextAlignment(.center)
                                   .padding(.bottom,40)
                            }
                          
                            MesMessageView(items: [MesMessage(icon: "ic_people", title:  "destinataires", count: "25"), MesMessage(icon: "ic_messageVideo", title:  "Messages vidéos", count: "5"), MesMessage(icon: "ic_messageText", title:  "Messages texte", count: "8"), MesMessage(icon: "ic_messageAudio", title:  "Messages audio", count: "8"), MesMessage(icon: "ic_messagePhoto", title:  "photos", count: "25")])
                               
                            Group{
                            Image("ic_vieDigitale")
                                .padding(.bottom,12)
                                .padding(.top,56)
                            Text("Ma Vie Digitale")
                                   .font(.system(size: 20))
                                   .fontWeight(.bold)
                                   .multilineTextAlignment(.center)
                                   .padding(.bottom,40)
                            
                                if vmKeyAcc.smartphones.count < 1 && vmKeyAcc.keyAccounts.count < 1
                                {
                                    Text("Vous n'avez pas renseigne d'information concermant votre vie digitale")
                                        
                                        .font(.system(size: 15))
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                        .padding(.top,40)
                                        .padding(.leading,24)
                                        .padding(.bottom,12)
                                        .multilineTextAlignment(.leading)
                                   
                                }
                                
                            MaVieDigitaleView()
                            }
                            
                            Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus")
                                   .font(.system(size: 11))
                                   .fontWeight(.regular)
                                   .multilineTextAlignment(.leading)
                                   .padding(.bottom,40)
                                   .padding(.horizontal,18)
                            
                          
                        }
                        
                        
                        
                    
                        
                    }
                    
                   
                }
            }
        }
        }.onAppear(perform: {
            volontesViewModel.getTabs()
            guardianViewModel.getGuardians { success in
                
            }
      
            vmKeyAcc.getKeyAccounts { success in
                
            }
            vmKeyAcc.getKeyPhones()
            
           
        })
                    
        
       
       
    }
}

struct GuardianMonMessangelView_Previews: PreviewProvider {
    static var previews: some View {
        GuardianMonMessangelView( imageLoader: ImageLoader(urlString:""))
    }
}
