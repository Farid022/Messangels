//
//  AudioRecorderView.swift
//  Messangel
//
//  Created by Saad on 6/15/21.
//

import SwiftUI
import AVKit
import NavigationStack

struct AudioRecorderView: View {
    @State var isRecording = false
    // creating instance for recroding...
    @State var session : AVAudioSession!
    @State var recorder : AVAudioRecorder!
    @State var alert = false
    @State var audios : [URL] = []
    @StateObject var stopWatch = StopWatchManager()
    
    var body: some View{
        ZStack {
            Color.black
                .ignoresSafeArea()
            Color("darkGray")
            VStack{
                Rectangle()
                    .frame(height: 60)
                    .overlay(
                        HStack {
                            BackButton()
                                .padding(.leading)
                            Spacer()
                            Text(stopWatch.stopWatchTime)
                                .foregroundColor(.white)
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                                .padding(.leading, -16)
                            Spacer()
                        }
                    )
                Spacer()
                Image("Audio_Waves")
                Spacer().frame(height: 100)
                Text("APPUYEZ POUR VOUS ENREGISTRER")
                    .foregroundColor(.white)
                    .font(.system(size: 13))
                    .fontWeight(.semibold)
                Button(action: {
                    do {
                        if isRecording {
                            stopWatch.stop()
                            recorder.stop()
                            isRecording.toggle()
                            // updating data for every rcd...
                            getAudios()
                            return
                        } else {
                            stopWatch.start()
                        }
                        
                        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        
                        // same file name...
                        // so were updating based on audio count...
                        let filName = url.appendingPathComponent("myRcd\(audios.count + 1).m4a")
                        
                        let settings = [
                            
                            AVFormatIDKey : Int(kAudioFormatMPEG4AAC),
                            AVSampleRateKey : 12000,
                            AVNumberOfChannelsKey : 1,
                            AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue
                            
                        ]
                        
                        recorder = try AVAudioRecorder(url: filName, settings: settings)
                        recorder.record()
                        isRecording.toggle()
                    }
                    catch{
                        
                        print(error.localizedDescription)
                    }
                    
                    
                }) {
                    
                    RecordButtonView(isRecording: $isRecording)
                }
                .padding(.vertical, 25)
            }
            .alert(isPresented: $alert, content: {
                
                Alert(title: Text("Error"), message: Text("Enable Acess"))
            })
            .onAppear {
                
                do{
                    
                    // Intializing...
                    
                    session = AVAudioSession.sharedInstance()
                    try session.setCategory(.playAndRecord)
                    
                    // requesting permission
                    // for this we require microphone usage description in info.plist...
                    session.requestRecordPermission { (status) in
                        
                        if !status{
                            
                            // error msg...
                            alert.toggle()
                        }
                        else{
                            
                            // if permission granted means fetching all data...
                            
                            getAudios()
                        }
                    }
                    
                    
                }
                catch{
                    
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getAudios(){
        
        do{
            
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            // fetch all data from document directory...
            
            let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            
            // updated means remove all old data..
            
            audios.removeAll()
            
            for i in result{
                
                audios.append(i)
            }
        }
        catch{
            
            print(error.localizedDescription)
        }
    }
}


struct AudioRecorderView_Previews: PreviewProvider {
    static var previews: some View {
        AudioRecorderView()
    }
}

struct RecordButtonView: View {
    @Binding var isRecording: Bool
    @State private var blinkColor = Color.accentColor
    @State private var blinkSize: CGFloat = 20
    var body: some View {
        ZStack{
            if !isRecording {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 67, height: 67)
                Circle()
                    .stroke(Color.white, lineWidth: 4)
                    .frame(width: 75, height: 75)
            } else {
                Group {
                    Circle()
                        .stroke(blinkColor, lineWidth: 4)
                        .frame(width: 75, height: 75)
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.accentColor)
                        .frame(width: blinkSize, height: blinkSize)
                        .onAppear{
                            withAnimation{
                                blinkColor = .white
                                blinkSize = 18
                            }
                        }
                }
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
            }
        }
    }
}
