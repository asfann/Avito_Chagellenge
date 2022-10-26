//
//  ViewController.swift
//  Avito_Chagellenge
//
//  Created by Asf on 23.10.2022.
//

import UIKit



class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    private var company: Company?
     var employees: [Employee] = []
   
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(EmployeeCell.self, forCellReuseIdentifier: EmployeeCell.identifier)
        return table
    }()
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        tableView.dataSource = self
        tableView.delegate = self
        getCompanyName()
        getEmployees()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3600) {
            CoreDataManager.shared.deleteAll("AvitoEntity")
            self.getEmployees()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.identifier, for: indexPath) as? EmployeeCell else {
            return UITableViewCell()
        }
        let employee = self.employees.sorted(by: { $0.name! < $1.name! })[indexPath.row]
        cell.configure(with: AvitoViewModel(name: employee.name!, skills: employee.skills!, number: employee.phoneNumber!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func getCompanyName() {
        APICaller.share.getCompanyName { [weak self] result in
            switch result {
            case .success(let company):
                self?.company = company
                DispatchQueue.main.async {
                    self?.title = self?.company?.name
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    
    private func getEmployees() {
        APICaller.share.getEmployees { [weak self] result in
            switch result {
            case .success(let employees):
                self?.employees = employees
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                for employee in employees {
                    CoreDataManager.shared.addEmployees(employee)
                }
                CoreDataManager.shared.allEmployees()
            case .failure(_):
                DispatchQueue.main.async {
                    let dialogMessage = UIAlertController(title: "Oops", message: "You have no internet connection", preferredStyle: .alert);                    self?.present(dialogMessage, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

  
}
