//
//  ListViewController.swift
//  employeeManagement
//
//  Created by Javier González Delmas on 1/2/22.
//

import UIKit

class ListViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var listTableView: UITableView!
    
    
    //Variables
    private var employeeViewModel = ListViewModel()
    private var employee: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "CustomEmloyeeCell")
        listTableView.allowsSelection = true
        employeeList()
    }
    
    
    func employeeList(){
        employeeViewModel.fetchEmployeeList { [weak self] in
            self?.listTableView.dataSource = self
            self?.listTableView.delegate = self
            self?.listTableView.reloadData()
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int{
        return employeeViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        listTableView.deselectRow(at: indexPath, animated: true)
        employee = employeeViewModel.cellForRowAt(indexPath: indexPath)
            
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "EmployeeDetail") as! EmployeeDetailViewController
                
        if let id = employee?.id{
            vc.id = id
        }
        
        self.present(vc,animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath)-> UITableViewCell{
        let cell = listTableView.dequeueReusableCell(withIdentifier: "CustomEmloyeeCell", for: indexPath) as! TableViewCell
        
        employee = employeeViewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValueOf(employee!)
        
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        
        return cell
    }
    
}
