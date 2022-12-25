//
//  ViewController.swift
//  Notes
//
//  Created by Dyadichev on 21.12.2022.
//

import UIKit

protocol NotesDelegate: AnyObject {
    func refreshNotes()
    func deleteNote(with id: UUID)
}

class NotesViewController: UIViewController {
    
    let viewTabBar = TabBarViewNotesVC()
    
    //MARK: - Properties
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchController = UISearchController()
    
    private var allNotes: [Note] = [] {
        
        didSet {
            viewTabBar.notesCountLabel.text = "\(allNotes.count) \(allNotes.count == 1 ? "Note" : "Notes")"
            filteredNotes = allNotes
        }
    }
    
    private var filteredNotes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Заметки"
        
        viewTabBar.newNoteButton.addTarget(self, action: #selector(createNewNoteClicked), for: .touchUpInside)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        setupViews()
        setupDelegate()
        configureTableView()
        configureSearchController()
        setConstraints()
    }

    override func viewDidLayoutSubviews() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupDelegate() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViews() {
        view.addSubview(viewTabBar)
        view.addSubview(searchController.searchBar)
        view.addSubview(tableView)
    }
    
    private func configureTableView() {
        
        tableView.backgroundColor = UIColor.systemGray6
        tableView.contentInset = .init(top: 0, left: 0, bottom: 30, right: 0)
        tableView.rowHeight = 60
        tableView.register(NotesTableViewCell.self,
                           forCellReuseIdentifier: NotesTableViewCell.identifier)
    }
    
    private func configureSearchController() {
        
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
    }
    
    private func indexForNote(id: UUID, in list: [Note]) -> IndexPath {
        let row = Int(list.firstIndex(where: { $0.id == id }) ?? 0)
        return IndexPath(row: row, section: 0)
    }
    
    @objc public func createNewNoteClicked(_ sender: UIButton) {
        
        goToEditNote(createNote())
    }
    
    private func goToEditNote(_ note: Note) {
        let vc = EditNoteViewController()
        vc.note = note
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK:- Methods to implement
    private func createNote() -> Note {
        let note = Note()
        
        // TODO Save note in database
        
        // Update table
        allNotes.insert(note, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        
        return note
    }
    
    private func fetchNotesFromStorage() {
        // TODO Get all saved notes
        print("Fetching all notes")
    }
    
    private func deleteNoteFromStorage(_ note: Note) {
        // TODO delete the note
        print("Deleting note")
        
        // Update the list
        deleteNote(with: note.id)
    }
    
    private func searchNotesFromStorage(_ text: String) {
        print("Searching notes")
    }
}

//MARK: - Table View Data Source

extension NotesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.identifier) as! NotesTableViewCell
        cell.layer.cornerRadius = 20
        cell.setup(note: filteredNotes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToEditNote(filteredNotes[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteNoteFromStorage(filteredNotes[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}

//MARK: - Search Controller Delegate

extension NotesViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search("")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        searchNotesFromStorage(query)
    }
    
    func search(_ query: String) {
        if query.count >= 1 {
            filteredNotes = allNotes.filter { $0.text.lowercased().contains(query.lowercased()) }
        } else{
            filteredNotes = allNotes
        }
        tableView.reloadData()
    }
}

//MARK: - Notes Delegate

extension NotesViewController: NotesDelegate {
    
    func refreshNotes() {
        allNotes = allNotes.sorted { $0.lastUpdated > $1.lastUpdated }
        tableView.reloadData()
    }
    
    func deleteNote(with id: UUID) {
        let indexPath = indexForNote(id: id, in: filteredNotes)
        filteredNotes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        // just so that it doesn't come back when we search from the array
        allNotes.remove(at: indexForNote(id: id, in: allNotes).row)
    }
}

//MARK: - Constraints
extension NotesViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: viewTabBar.topAnchor)
        ])
        NSLayoutConstraint.activate([
            viewTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewTabBar.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
