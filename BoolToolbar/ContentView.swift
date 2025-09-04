//
//  ContentView.swift
//  BoolToolbar
//
//  Created by Yuki Sasaki on 2025/09/04.
//

import SwiftUI
import CoreData

// 3. SwiftUI で使う
struct ContentView: View {
    
    var body: some View {
            BoolToolbarView()
                .edgesIgnoringSafeArea(.bottom)
    }
}

// 1. SwiftUI から UIViewController を表示する
struct BoolToolbarView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ToolbarViewController {
        let vc = ToolbarViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ToolbarViewController, context: Context) {
    }
}

class ToolbarViewController: UIViewController {

    private var showToolbar = true {
        didSet {
            setToolbar(type: showToolbar ? .normal : .edit)
        }
    }

    enum ToolbarType {
        case normal
        case edit
        case custom
    }
    
    private let toolbar = UIToolbar()
    private var currentType: ToolbarType = .normal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupToolbar()
        setupToggle() // UISwitch でトグル
        setToolbar(type: .normal)
    }
    
    //***
    
    private func setupToolbar() {
        view.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupToggle() {
        let toggleSwitch = UISwitch()
        toggleSwitch.isOn = showToolbar
        toggleSwitch.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toggleSwitch)
        
        let label = UILabel()
        label.text = "Show Toolbar"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            toggleSwitch.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10),
            toggleSwitch.centerYAnchor.constraint(equalTo: label.centerYAnchor)
        ])
    }
    
    @objc private func switchChanged(_ sender: UISwitch) {
        showToolbar = sender.isOn
        
        print("Switch changed:", showToolbar)
        
        //setToolbar(type: showToolbar ? .normal : .edit)
    }


    
    // MARK: - Enum に応じて toolbar を切り替える
    func setToolbar(type: ToolbarType) {
        currentType = type
        
        switch type {
        case .normal:
            // toggle に従って表示/非表示
            toolbar.items = [
                UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped)),
                UIBarButtonItem.flexibleSpace(),
                UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteTapped))
            ]
            toolbar.isHidden = !showToolbar // toolbar.isHidden = false
            
        case .edit:
            // toggle に関係なく常に表示
            toolbar.items = [
                UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped)),
                UIBarButtonItem.flexibleSpace(),
                UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTapped))
            ]
            toolbar.isHidden = false
            
        case .custom:
            toolbar.items = []
            toolbar.isHidden = true
        }
    }

    
    // MARK: - Toolbar Actions
    @objc private func addTapped() { print("Add tapped") }
    @objc private func deleteTapped() { print("Delete tapped") }
    @objc private func cancelTapped() { print("Cancel tapped") }
    @objc private func saveTapped() { print("Save tapped") }
}
