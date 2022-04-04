//
//  GuardianFormBaseView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI
import NavigationStack

struct WishesFlowBaseView<Content: View, VM>: View where VM: CUViewModel {
    @ObservedObject var viewModel: VM
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var showExitAlert = false
    @Binding var valid: Bool
    @Binding var noteText: String
    @Binding var showNote: Bool
    private var tab: Int
    private var stepNumber: Double
    private var totalSteps: Double
    private var title: String
    private var menuTitle: String
    private var note: Bool
    private var addToList: Bool
    private let content: Content
    private var destination: AnyView
    private var popToParent: Bool
    private var parentId: String
    var isCustomAction: Bool
    var customAction: () -> Void = {}
    
    init(tab: Int = 0, stepNumber: Double, totalSteps: Double, isCustomAction: Bool = false, customAction: @escaping () -> Void = {}, popToParent: Bool = false, parentId: String = TabBarView.id, addToList: Bool = false, noteText: Binding<String> = .constant(""), note: Bool = false, showNote: Binding<Bool> = .constant(false), menuTitle: String, title: String, valid: Binding<Bool>, destination: AnyView = AnyView(EmptyView()), exitAction: @escaping () -> Void = {}, viewModel: VM, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._valid = valid
        self.destination = destination
        self.title = title
        self.menuTitle = menuTitle
        self.note = note
        self._showNote = showNote
        self.addToList = addToList
        self.parentId = parentId
        self.popToParent = popToParent
        self.isCustomAction = isCustomAction
        self.customAction = customAction
        self._noteText = noteText
        self.stepNumber = stepNumber
        self.totalSteps = totalSteps
        self.tab = tab
        self.viewModel = viewModel
    }
    
    fileprivate func setProgress() {
        WishesViewModel.setProgress(Int((stepNumber/totalSteps)*100.0), tab: self.tab) { _ in
            navigationModel.popContent(TabBarView.id)
        }
    }
    
    var body: some View {
        ZStack {
            NavigationStackView(title) {
                ZStack(alignment:.top) {
                    GeometryReader { proxy in
                        Color.accentColor
                            .frame(height: proxy.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    }
                    VStack(spacing: 20) {
                        NavigationTitleView(stepNumber: stepNumber, totalSteps: totalSteps, menuTitle: menuTitle, confirmExit: tab > 0, showExitAlert: $showExitAlert)
                        if addToList {
                            Spacer()
                            Text(title)
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                            Button(action: {
                                navigationModel.pushContent(title) {
                                    destination
                                }
                            }, label: {
                                Image("ic_add_btn")
                            })
                            Spacer()
                        }
                        else {
                            FlowBaseTitleView(title: title)
                            content
                            Spacer()
                            HStack {
                                if note {
                                    FlowNoteButtonView(showNote: $showNote, note: $noteText)
                                }
                                Spacer()
                                FlowNextButtonView(valid: $valid, title: title, destination: destination, popToParent: popToParent, parentId: parentId, customAction: customAction, isCustomAction: isCustomAction)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .textFieldStyle(MyTextFieldStyle())
            }
            if showExitAlert {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                    .overlay(MyAlert(title: "Quitter \(self.menuTitle)", message: "Vos modifications ne seront pas enregistrées.", ok: "Oui", cancel: "Non", action: {
                        if self.viewModel.updateRecord {
                            self.viewModel.update(id: self.viewModel.recordId) { success in
                                if success {
                                    if self.viewModel.progress < 100 {
                                        setProgress()
                                    } else {
                                        navigationModel.popContent(TabBarView.id)
                                    }
                                }
                            }
                        } else {
                            self.viewModel.create { success in
                                if success {
                                    setProgress()
                                }
                            }
                        }

                    }, showAlert: $showExitAlert))
            }
        }
    }
}
