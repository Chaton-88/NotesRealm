//
//  EntryViewController.swift
//  Note_Realm
//
//  Created by Valeriya Trofimova on 14.06.2022.
//

import Foundation
import UIKit

final class EntryViewController: UIViewController {
    
    private let entryTitleField: UITextField = {
        let titleField = UITextField()
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.borderStyle = .roundedRect
        titleField.placeholder = "Enter notes the topic"
        titleField.becomeFirstResponder()
        return titleField
    }()
    
    private let entryNoteField: UITextView = {
        let noteField = UITextView()
        noteField.translatesAutoresizingMaskIntoConstraints = false
        noteField.font = UIFont(name: "Helvetica", size: 20)
        return noteField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        configureSaveButton()
    }
    
    // MARK: - setup views
    private func setupViews() {
        
        view.addSubview(entryTitleField)
        view.addSubview(entryNoteField)
        
        entryTitleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10).isActive = true
        entryTitleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        entryTitleField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
        entryTitleField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        entryNoteField.topAnchor.constraint(equalTo: entryTitleField.bottomAnchor,constant: 10).isActive = true
        entryNoteField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        entryNoteField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10).isActive = true
        entryNoteField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .zero).isActive = true
    }
    
    // MARK: - configure save button
    private func configureSaveButton() {
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        saveButton.tintColor = .orange
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func didTapSave() {
        guard let text = entryTitleField.text, !text.isEmpty, !entryNoteField.text.isEmpty else { return }
        
        let note = TaskList()
        note.title = text
        note.note = entryNoteField.text
        
        StorageManager.saveObject(note)

        navigationController?.popViewController(animated: true)
    }
}

