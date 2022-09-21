//
//  NoteViewController.swift
//  Note_Realm
//
//  Created by Valeriya Trofimova on 14.06.2022.
//

import Foundation
import UIKit

final class NoteViewController: UIViewController {
    
    var note: TaskList?
    
    private lazy var saveBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
    }()
    
    private let noteField: UITextField = {
        let noteField = UITextField()
        noteField.translatesAutoresizingMaskIntoConstraints = false
        noteField.font = UIFont(name: "Helvetica", size: 20)
        return noteField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        configureSaveButton()
        editingNoteField()
        
        noteField.text = note?.note
    }

    // MARK: - setup views
    private func setupViews() {
        
        view.addSubview(noteField)
        
        noteField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 30).isActive = true
        noteField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        noteField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
    }
    
    // MARK: - configure save button
    private func configureSaveButton() {
        navigationItem.rightBarButtonItem = saveBarButtonItem
        saveBarButtonItem.isEnabled = noteField.text == note?.note
    }
    
    // MARK: - action save button
    @objc func didTapSave() {
        
        try! realm.write({
            note?.note = noteField.text ?? ""
        })
        
       navigationController?.popViewController(animated: true)
    }
    
    // MARK: - editing textField
    private func editingNoteField() {
        noteField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        saveBarButtonItem.isEnabled = true
    }
}


