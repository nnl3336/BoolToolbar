//
//  ContentView.swift
//  BoolToolbar
//
//  Created by Yuki Sasaki on 2025/09/04.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showToolbar = true
    
    var body: some View {
        VStack {
            Toggle("Show Toolbar", isOn: $showToolbar)
                .padding()
            
            Spacer()
            
            BoolToolbar(isVisible: $showToolbar)
                .frame(height: 44) // Toolbar の高さ
        }
    }
}

struct BoolToolbar: UIViewRepresentable {
    @Binding var isVisible: Bool
    
    func makeUIView(context: Context) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        let button1 = UIBarButtonItem(title: "Action1", style: .plain, target: context.coordinator, action: #selector(Coordinator.action1))
        let button2 = UIBarButtonItem(title: "Action2", style: .plain, target: context.coordinator, action: #selector(Coordinator.action2))
        toolbar.items = [button1, UIBarButtonItem.flexibleSpace(), button2]
        
        return toolbar
    }
    
    func updateUIView(_ uiView: UIToolbar, context: Context) {
        // Bool に応じて表示/非表示
        uiView.isHidden = !isVisible
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject {
        @objc func action1() {
            print("Action1 tapped")
        }
        @objc func action2() {
            print("Action2 tapped")
        }
    }
}
