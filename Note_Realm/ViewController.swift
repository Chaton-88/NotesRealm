//
//  ViewController.swift
//  Note_Realm
//
//  Created by Valeriya Trofimova on 14.06.2022.
//

import Foundation
import UIKit
import RealmSwift

final class ViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    private let cellId = "cellId"
    
    var items: Results<TaskList>!
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .done, target: self, action: #selector(addBarButtonTapped))
        button.tintColor = .orange
        return button
    }()
    
    private let noNotesLabel = UILabel(text: "No Notes Yet",
                                       font: UIFont.systemFont(ofSize: 18, weight: .regular),
                                       textAlignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "Notes"
        view.backgroundColor = .white
        
        view.addSubview(noNotesLabel)
        tableView.reloadData()
        
        items = realm.objects(TaskList.self)
        
        setupTableView()
        configureNavigationBar()
        setupSubView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - navigationItem action
    @objc private func addBarButtonTapped() {
        let vc = EntryViewController()
        vc.title = "New note"
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - setup views
    private func setupTableView() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupSubView() {
        noNotesLabel.translatesAutoresizingMaskIntoConstraints = false
        noNotesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noNotesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: - configure navigation bar
    private func configureNavigationBar() {
        
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard items.isEmpty else { return items.count }
        tableView.isHidden = true
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.note
       
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let note: TaskList
        note = items[indexPath.row]
        
        let vc = NoteViewController()
        vc.note = note
        vc.title = note.title
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let editingRow = items[indexPath.row]
            StorageManager.deleteObject(editingRow)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

