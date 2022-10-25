//
//  CompanyCell.swift
//  Avito_Chagellenge
//
//  Created by Asf on 24.10.2022.
//

import UIKit

class EmployeeCell: UITableViewCell {

    static let identifier = "EmployeeCell"
    
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let skillsLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(skillsLabel)
        contentView.addSubview(numberLabel)
        
        
        applyContraints()
    }
    
    
    private func applyContraints() {
        
        
        let nameLabelContraints = [
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        let skillsLabelContraints = [
            skillsLabel.centerXAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 100),
            skillsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let numberLabelContraints = [
            numberLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -90),
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        
        
        NSLayoutConstraint.activate(nameLabelContraints)
        NSLayoutConstraint.activate(skillsLabelContraints)
        NSLayoutConstraint.activate(numberLabelContraints)
    }
    
    
    public func configure(with model: AvitoViewModel) {
        nameLabel.text = model.name
        skillsLabel.text = model.skills.joined(separator: " ")
        numberLabel.text = model.number
    }
   
    required init?(coder: NSCoder) {
        fatalError()
    }
}

