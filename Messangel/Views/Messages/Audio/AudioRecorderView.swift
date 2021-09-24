//
//  AudioRecorderView.swift
//  Messangel
//
//  Created by Saad on 6/15/21.
//

import SwiftUI
import AVKit
import NavigationStack

let numberOfSamples: Int = 30

struct AudioRecorderView: View {
    @State var isRecording = false
    @State var alert = false
    @State var audios : [URL] = []
    @StateObject var stopWatch = StopWatchManager()
    @ObservedObject private var recorder = SoundRecorder(numberOfSamples: numberOfSamples)
    
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
        
        return CGFloat(level * (60 / 25)) // scaled to max at 60 (our height of our bar)
    }
    
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
//                GeometryReader { reader in
                        Image("Audio_Waves")
                            .offset(x: isRecording ? -(UIScreen.main.bounds.size.width+400) : UIScreen.main.bounds.size.width)
                            .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false))
//                }
//                HStack(spacing: 8) {
//                    ForEach(recorder.soundSamples, id: \.self) { level in
//                        BarView(value: self.normalizeSoundLevel(level: level))
//                    }
//                }
                Spacer().frame(height: 100)
                Text("APPUYEZ POUR VOUS ENREGISTRER")
                    .foregroundColor(.white)
                    .font(.system(size: 13))
                    .fontWeight(.semibold)
                Button(action: {
                        if isRecording {
                            stopWatch.stop()
                            recorder.stopRecording()
                            isRecording.toggle()

                            return
                        } else {
                            stopWatch.start()
                        }
                        
                        recorder.startRecording()
                        isRecording.toggle()
                }) {
                    
                    RecordButtonView(isRecording: $isRecording)
                }
                .padding(.vertical, 25)
            }
            .alert(isPresented: $alert, content: {
                
                Alert(title: Text("Error"), message: Text("Enable Acess"))
            })
        }
    }
}


struct AudioRecorderView_Previews: PreviewProvider {
    static var previews: some View {
        AudioRecorderView()
    }
}

struct BarView: View {
    var value: CGFloat

    var body: some View {
        ZStack {
            Capsule()
                .fill(Color(hexadecimal: "D6D5D5"))
                .frame(width: 2.5, height: value)
//                .frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 4) / CGFloat(numberOfSamples), height: value)
        }
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
