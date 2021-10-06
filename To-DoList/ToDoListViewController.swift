//
//  ToDoListViewController.swift
//  To-DoList
//
//  Created by hklife_mo on 2021/10/06.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var task = [Task]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func editBtnAction(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func addBtnAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "할일 등록", message: "", preferredStyle: .alert)
        let addBtn = UIAlertAction(title: "등록", style: .default) { [weak self] _ in
            
            guard let title = alert.textFields?[0].text else { return }
            let data = Task(title: title, done: false)
            self?.task.append(data)
            
            self?.tableView.reloadData()
        }
        
        let cancelBtn = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(addBtn)
        alert.addAction(cancelBtn)
        alert.addTextField { textField in
            textField.placeholder = "할일을 등록해주세요."
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //저장할 함수 구현할 차례 입니다~~~
    
    
    
    
    
    
    
     // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.task.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let data = self.task[indexPath.row]
        
        cell.textLabel?.text = data.title

        return cell
    }

}
