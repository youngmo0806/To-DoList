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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
