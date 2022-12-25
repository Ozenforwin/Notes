//
//  Note.swift
//  Notes
//
//  Created by Dyadichev on 22.12.2022.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    // sadasdasdad
    
    static let identifier = String(describing: NotesTableViewCell.self)
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Description"
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(note: Note) {
        titleLabel.text = note.title
        descriptionLabel.text = note.desc
    }
}

extension NotesTableViewCell {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor,constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor,constant: 30),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10)
        ])
    }
}

