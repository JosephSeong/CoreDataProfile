//
//  TodoViewController.swift
//  ToDo
//
//  Created by Joseph on 12/20/23.
//

import UIKit
import CoreData

class TodoViewController: UIViewController {

    var categoryWithTasks: [CategoryWithTask] = []
    //var tasks: [Task] = []


    @IBOutlet weak var TodoTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 테이블뷰의 델리게이트와 데이터 소스 설정
        TodoTable.delegate = self
        TodoTable.dataSource = self

        // UserDefaults에서 Todos 불러오기
        loadTodo()
        TodoTable.reloadData()
    }

    // MARK: - 추가
    @IBAction func addButton(_ sender: Any) {
        var textField = UITextField()

        let alert = UIAlertController(title: "할 일 추가하기", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default) { (cancel) in }
        let save = UIAlertAction(title: "추가", style: .default) { (save) in
            // 입력된 텍스트로 새로운 할 일 생성
            guard let newTitle = textField.text, !newTitle.isEmpty else { return }
            //let newTodo = Todo(id: self.todos.count, title: newTitle, isCompleted: false)

            // 카테고리 입력 받기
            var categoryTextField = UITextField()
            let categoryAlert = UIAlertController(title: "카테고리 입력", message: "할 일의 카테고리를 입력하세요.", preferredStyle: .alert)
            categoryAlert.addTextField { (textField) in
                categoryTextField = textField
                categoryTextField.placeholder = "카테고리"
            }
            let categorySave = UIAlertAction(title: "확인", style: .default) { (action) in
                guard let category = categoryTextField.text, !category.isEmpty else { return }

                // 카테고리가 이미 존재하는지 확인
                if let existingCategoryIndex = self.categoryWithTasks.firstIndex(where: { $0.category == category }) {
                    // 기존 카테고리에 새로운 할 일 추가
                    let newTodo = Todo(id: self.categoryWithTasks[existingCategoryIndex].tasks.count, title: newTitle, isCompleted: false)
                    self.categoryWithTasks[existingCategoryIndex].tasks.append(newTodo)
                } else {
                    // 새로운 카테고리를 만들고 할 일을 추가
                    let newTodo = Todo(id: 0, title: newTitle, isCompleted: false)
                    let newCategoryWithTasks = CategoryWithTask(category: category, tasks: [newTodo])
                    self.categoryWithTasks.append(newCategoryWithTasks)
                }

                self.TodoTable.reloadData()
                self.saveTodo()
            }
            categoryAlert.addAction(categorySave)
            self.present(categoryAlert, animated: true, completion: nil)
        }

        alert.addTextField { (text) in
            textField = text
            textField.placeholder = "할 일 추가하기"
        }

        // 액션 추가
        alert.addAction(cancel)
        alert.addAction(save)

        // 알림창 표시
        present(alert, animated: true, completion: nil)
    }

    // save
    func saveTodo() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        for categoryWithTask in categoryWithTasks {
            for task in categoryWithTask.tasks {
                let taskData = CoreTodo(context: context)
                taskData.id = UUID()
                taskData.title = task.title
                taskData.createDate = Date()
                taskData.modifyDate = Date()
                taskData.isCompleted = task.isCompleted
                //taskData.category = categoryWithTask.category
            }
        }

        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }

    // load
    func loadTodo() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do {
            let tasks = try context.fetch(CoreTodo.fetchRequest()) as! [CoreTodo]

            var convertedTasks: [CategoryWithTask] = []

//            for task in tasks {
//                if let existingCategoryIndex = convertedTasks.firstIndex(where: { $0.category == task.category }) {
//                    convertedTasks[existingCategoryIndex].tasks.append(Todo(id: Int(task.id), title: task.title ?? "", isCompleted: task.isCompleted))
//                } else {
//                    let newCategoryWithTasks = CategoryWithTask(category: task.category ?? "", tasks: [Todo(id: Int(task.id), title: task.title ?? "", isCompleted: task.isCompleted)])
//                    convertedTasks.append(newCategoryWithTasks)
//                }
//            }

            categoryWithTasks = convertedTasks
        } catch {
            print("Error fetching tasks: \(error)")
        }
    }
}



// MARK: - extension
extension TodoViewController: UITableViewDelegate, UITableViewDataSource {

    // Section의 수를 결정하는 메서드
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryWithTasks.count
    }

    // Section Header에 나타날 글자를 설정하는 메서드
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoryWithTasks[section].category
    }

    // 테이블뷰 셀 개수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryWithTasks[section].tasks.count
    }

    // 테이블뷰 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todocell", for: indexPath) as! TodoTableViewCell
        let task = categoryWithTasks[indexPath.section].tasks[indexPath.row]
        cell.todoViewController = self // TodoViewController에 대한 참조 설정
        //cell.setTask(task)

        return cell
    }

    // MARK: - 삭제
    // 테이블뷰 셀 스와이프 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            // 해당 Section에 속한 카테고리 선택
            let category = categoryWithTasks[indexPath.section].category
            // 해당 Section에 속하는 할 일들만 필터링
            categoryWithTasks[indexPath.section].tasks.remove(at: indexPath.row)

            // 선택된 셀의 할 일 삭제 및 테이블뷰 갱신
            TodoTable.deleteRows(at: [indexPath], with: .fade)

            // 변경된 할 일 목록을 categoryWithTasks 배열에 업데이트하고 UserDefaults에 저장
            saveTodo()

            // 디버깅
            print("\(indexPath.row)번 인덱스의 작업이 삭제")
            print("업데이트된 categoryWithTasks 배열: \(categoryWithTasks)")
        }
    }

    // MARK: - 할 일 수정
    // 테이블뷰 셀 선택 시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 셀의 할 일을 가져옴
        let selectedTask = categoryWithTasks[indexPath.section].tasks[indexPath.row]

        var textField = UITextField()

        let alert = UIAlertController(title: "할 일 수정하기", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default) { (cancel) in }
        let save = UIAlertAction(title: "수정", style: .default) { (save) in
            // 입력된 텍스트로 할 일 수정
            guard let updatedTitle = textField.text, !updatedTitle.isEmpty else { return }

            // 수정된 할 일을 배열에 업데이트하고 테이블뷰 갱신
            self.categoryWithTasks[indexPath.section].tasks[indexPath.row].title = updatedTitle
            self.TodoTable.reloadRows(at: [indexPath], with: .fade)

            // UserDefaults에 저장
            self.saveTodo()
        }

        alert.addTextField { (text) in
            textField = text
            textField.text = selectedTask.title
        }

        // 액션 추가
        alert.addAction(cancel)
        alert.addAction(save)

        // 알림창 표시
        present(alert, animated: true, completion: nil)

        // 선택 상태 취소
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

