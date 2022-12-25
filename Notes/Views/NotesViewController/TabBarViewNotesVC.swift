//
//  TabBarViewNotesVC.swift
//  Notes
//
//  Created by Dyadichev on 24.12.2022.
//

import UIKit

class TabBarViewNotesVC: UIView {
    
    lazy var newNoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.tintColor = UIColor.systemOrange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public var notesCountLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = "Notes"
        label.textColor = UIColor.systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(newNoteButton)
        addSubview(notesCountLabel)
    }
}

//MARK: - Constraints
extension TabBarViewNotesVC {

    private func setConstraints() {

        let size: CGFloat = 20

        NSLayoutConstraint.activate([
            newNoteButton.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            newNoteButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -size),
            newNoteButton.widthAnchor.constraint(equalToConstant: size),
            newNoteButton.heightAnchor.constraint(equalToConstant: size)
        ])
        NSLayoutConstraint.activate([
            notesCountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            notesCountLabel.topAnchor.constraint(equalTo: topAnchor,constant: 10)
        ])
    }
}
