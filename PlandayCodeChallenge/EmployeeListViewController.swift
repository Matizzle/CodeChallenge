//
//  EmployeeListViewController.swift
//  PlandayCodeChallenge
//
//  Copyright © 2020 Mathias Lolk Andreasen. All rights reserved.

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class EmployeeListViewController: UIViewController {
    
    var tableView = UITableView()
    
    private var isFetching = false
    private var hasPerformedInitialFetch = false
    private let limit = 10
    private var offset = 0
    private let disposeBag = DisposeBag()
    private var employees: BehaviorRelay<[EmployeeViewModel]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        dynamicSetupAndFetch()
        setupTableView()
        setupConstraints()
    }
    
    func dynamicSetupAndFetch() {
        self.employees.bind(to: self.tableView.rx.items(cellIdentifier: "EmployeeCell")) { row, model, cell in
            guard let cell: EmployeeCell = cell as? EmployeeCell else {
                fatalError("failed to bind as an employee cell")
            }
            cell.configure(model)
        }.disposed(by: self.disposeBag)

        self.fetchEmployees()
        hasPerformedInitialFetch = true
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: "EmployeeCell")
        tableView.rowHeight = 80
        
        view.addSubview(tableView)
    }

}

extension EmployeeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            fetchEmployees()
        }
    }
 
}


extension EmployeeListViewController {
    private func fetchEmployees() {
        guard !isFetching else {
            return
        }
        isFetching = true
        
        PlandayAPIClient.fetchListData(limit: limit, offset: offset) { listEmployeesResponseBody, error in
            
            guard error == nil else {
                self.presentAlert(alertTitle: .dataFetchError, alertMessage: .dataFetchError)
                print(error.debugDescription)
                return
            }
            
            guard let listEmployeesResponseBody = listEmployeesResponseBody else {
                self.presentAlert(alertTitle: .requestError, alertMessage: .requestError)
                print(error.debugDescription)
                return
            }
            
            for employee in listEmployeesResponseBody.employees {
                PlandayAPIClient.fetchDataDetails(employeeID: employee.id) { employeeDetailsResponse, error in
                    
                    guard error == nil else {
                        self.presentAlert(alertTitle: .dataFetchError, alertMessage: .dataFetchError)
                        print(error.debugDescription)
                        return
                    }
                    
                    guard let employeeDetailsResponse = employeeDetailsResponse else {
                        self.presentAlert(alertTitle: .requestError, alertMessage: .requestError)
                        print(error.debugDescription)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.offset = self.offset + 1
                        self.employees.accept(self.employees.value + [EmployeeViewModel(employee: employeeDetailsResponse.employee)])
                        
                        self.isFetching = false
                    }
                }
            }
        }
    }
}

extension EmployeeListViewController {
    func presentAlert(alertTitle: AlertTexts.title, alertMessage: AlertTexts.message) {
        let alertController = UIAlertController(title: alertTitle.rawValue, message: alertMessage.rawValue, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension EmployeeListViewController {
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
    }
}
