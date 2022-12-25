//
//  EditNoteViewController.swift
//  Notes
//
//  Created by Dyadichev on 24.12.2022.
//

import UIKit

class EditNoteViewController: UIViewController {
    
    //MARK: - Properties
    
    var note: Note!
    weak var delegate: NotesDelegate?
    
    var myTextView: UITextView = {
        let textView = UITextView()
        textView.contentInset = UIEdgeInsets(top: 10,left: 0,bottom: 0,right: 0)
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.backgroundColor = UIColor.lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    //MARK: - LyfeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTextView.text = note?.text
        print(myTextView.text ?? "Нет текста")
        view.addSubview(myTextView)
//        setConstraints()
        myTextView.frame = view.bounds
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myTextView.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Methods
    
    private func updateNote() {
        
        note.lastUpdated = Date()
        delegate?.refreshNotes()
    }
    
    private func deleteNote() {
        
        delegate?.deleteNote(with: note.id)
    }
}

//MARK: - TextView Delegate

extension EditNoteViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        note?.text = textView.text
        
        if note?.title.isEmpty ?? true {
            deleteNote()
        } else {
            updateNote()
        }
    }
}

//MARK: - Set Constraints

extension EditNoteViewController {
    
    private func setConstraints() {

//        NSLayoutConstraint.activate([
//            myTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            myTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            myTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            myTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
    }
}

