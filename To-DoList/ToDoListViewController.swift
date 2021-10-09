//
//  ToDoListViewController.swift
//  To-DoList
//
//  Created by hklife_mo on 2021/10/06.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    @IBOutlet var editButton: UIBarButtonItem!
    var doneButton: UIBarButtonItem?
    
    var task = [Task]() {
        didSet{
            //데이터 저장
            self.saveTask()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //doneButton 셋팅해준다
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
        
        //데이터 읽어온다
        self.loadTask()
        
    }
    
    @objc func doneButtonAction() {
        //버튼을 바꾼다.
        self.navigationItem.leftBarButtonItem = self.editButton
        //편집모드를 나온다.
        self.tableView.setEditing(false, animated: true)
    }

    @IBAction func editBtnAction(_ sender: UIBarButtonItem) {
        //edit 버튼을 눌렀을때.
        //데이터가 없으면 편집모드에 들어가지 않게 설정 하고
        guard !self.task.isEmpty else { return }
        
        //버튼을 바꾼다.
        self.navigationItem.leftBarButtonItem = self.doneButton
        //편집모드로 들어간다.
        self.tableView.setEditing(true, animated: true)
        
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
    
    func saveTask() {
        //title,done -> UserDefault에 저장하려함 (dictionary) 형태로 셋팅함
        let data = self.task.map {
            [
                "title" : $0.title,
                "done" : $0.done
            ]
        }
        
        let userDefault = UserDefaults.standard
        userDefault.set(data, forKey: "task")
    }
        
    func loadTask() {
        let userDefault = UserDefaults.standard
        
        //읽어온 데이터는 Any type이다. -> 캐스팅을 해주어야 한다.
        guard let data = userDefault.object(forKey: "task") as? [[String:Any]] else { return }
        
        //compactMap - 컨테이너 안에 옵셔널 값이 있다면 그 옵셔널 값을 제외하고 새로운 컨테이너 안에 넘겨 주는데 사용하게 된다.
        self.task = data.compactMap({
            guard let title = $0["title"] as? String else { return nil }
            guard let value = $0["done"] as? Bool else { return nil }
            
            return Task(title: title, done: value)
        })
        
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
        
        if data.done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
        
    //셀을 잡고 이동해서 정렬할수 있게 지원한다.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //셀을 이동한후, 데이터를 저장하여야 한다.
        
        //1. 전체 데이터 배열을 가져온후
        var tasks = self.task
        //2. 선택한 셀 , 이동전 위치를 가져옴
        let newTask = tasks[sourceIndexPath.row]
        
        //3. 전체 데이터에서 이동전 데이터를 삭제함
        tasks.remove(at: sourceIndexPath.row)
        //4. 이동전 위치에 변경될 위치를 insert 함
        tasks.insert(newTask, at: destinationIndexPath.row)
        
        //전체 데이터 전역 변수에, 가공한 전체 데이터를 넣음
        self.task = tasks
    }
    
    //edit mode 일때 우측에 delete 를 보여준다, tableView list에서도 스와이프로 삭제를 지원한다.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //1.전체 데이터에서 선택된 행을 삭제한다.
        self.task.remove(at: indexPath.row)
        
        //2.보여지는 뷰에서도 데이터 셀을 날려야한다.
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        //3. 데이터를 날렸으면 전체 데이터가 남았는지 비었는지 판단하여 버튼을 변경한다.
        if self.task.isEmpty {
            self.doneButtonAction()
        }
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var dataLine = self.task[indexPath.row] //현재로우의 값을 읽어와서
        dataLine.done = !dataLine.done              //선택된 상태 값을 변경하고
        
        self.task[indexPath.row] = dataLine     //변경한 값을 저장하고
        self.tableView.reloadRows(at: [indexPath], with: .automatic) //해당 셀을 새로고침 해놓는다
        
    }

}
