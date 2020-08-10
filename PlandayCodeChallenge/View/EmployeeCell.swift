//
//  EmployeeCell.swift
//  PlandayCodeChallenge
//
//  Copyright © 2020 Mathias Lolk Andreasen. All rights reserved.

import UIKit

class EmployeeCell: UITableViewCell {
    
    var firstNameLabel = UILabel()
    var lastNameLabel = UILabel()
    var genderLabel = UILabel()
    var departmentsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        configureFirstNameLabel()
        configureLastNameLabel()
        configureGenderLabel()
        configureDepartmentsLabel()
        
        addSubview(firstNameLabel)
        addSubview(lastNameLabel)
        addSubview(genderLabel)
        addSubview(departmentsLabel)
    }
    
    func configureFirstNameLabel() {
        firstNameLabel.numberOfLines = 0
        firstNameLabel.font = .systemFont(ofSize: 18)
        firstNameLabel.textAlignment = .left
        
    }
    
    func configureLastNameLabel() {
        lastNameLabel.numberOfLines = 0
        lastNameLabel.font = .systemFont(ofSize: 20)
        lastNameLabel.textAlignment = .left
    }
    
    func configureGenderLabel() {
        genderLabel.numberOfLines = 0
        genderLabel.font = .systemFont(ofSize: 16)
        genderLabel.textAlignment = .right
    }
    
    func configureDepartmentsLabel() {
        departmentsLabel.numberOfLines = 0
        departmentsLabel.font = .systemFont(ofSize: 12)
        departmentsLabel.textAlignment = .right
    }
    
}

extension EmployeeCell {
  public func configure(_ viewModel: EmployeeViewModel) {
    firstNameLabel.text = viewModel.firstName
    lastNameLabel.text = viewModel.lastName
    genderLabel.text = viewModel.gender.rawValue
    departmentsLabel.text = viewModel.departments.description
  }
}

extension EmployeeCell {
    func setupConstraints() {
        firstNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(10)
        }
        
        lastNameLabel.snp.makeConstraints { make in
            make.top.equalTo(firstNameLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        departmentsLabel.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
        }
        
    }
}
