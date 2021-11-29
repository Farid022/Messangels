//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX

struct FuneralTypeView: View {
    private var funeralTypes = [FuneralType.burial, FuneralType.crematization]
    @State private var valid = false
    @State private var selectedFuneral = FuneralType.none
    @State private var showNote = false
    @State private var note = ""
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FuneralChoiceBaseView(note: true, showNote: $showNote, menuTitle: "Choix funéraires", title: "Quel rite souhaitez-vous ?", valid: $valid, destination: selectedFuneral == .burial ? AnyView(FuneralPlaceView(funeralType: selectedFuneral)) : AnyView(FuneralCoffinMaterial(funeralType: selectedFuneral))) {
                HStack {
                    ForEach(funeralTypes, id: \.self) { type in
                        FuneralTypeCard(text: type == .burial ? "Inhumation" : "Crématisation", selected: .constant(selectedFuneral == type))
                            .onTapGesture {
                                selectedFuneral = type
                            }
                    }
                }
            }
            .onChange(of: selectedFuneral) { value in
                valid = selectedFuneral != .none
            }
        }
    }
}



struct FuneralTypeCard: View {
    var text: String
    @Binding var selected: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 22)
            .foregroundColor(.white)
            .frame(width: 160, height: 160)
            .normalShadow()
            .overlay(
                VStack {
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
                        .padding(.horizontal)
                }
            )
    }
}

struct FuneralNote: View {
    @Binding var showNote: Bool
    @Binding var note:String
    @State var expandedNote = false
    
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
                        TextView("", text: $note)
                            .isFirstResponder(true)
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
    }
}
