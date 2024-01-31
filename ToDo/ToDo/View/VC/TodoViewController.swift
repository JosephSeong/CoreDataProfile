//
//  TodoViewController.swift
//  ToDo
//
//  Created by Joseph on 12/20/23.
//

import UIKit

class TodoViewController: UIViewController {

    //var todos: [Todo] = []
    var categoryWithTasks: [CategoryWithTask] = []

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

    // UserDefaults에 Todos 저장
    func saveTodo() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(categoryWithTasks) {
            UserDefaults.standard.set(encodedData, forKey: "todos")
            print("userdefaults에 데이터 저장")
        } else {
            print("저장 실패")
        }
    }


    // UserDefaults에서 Todos 불러오기
    func loadTodo() {
        if let savedData = UserDefaults.standard.data(forKey: "todos"),
           // 가져온 데이터를 CategoryWithTasks 객체의 배열로 디코딩(실패하면 nil)
           let loadedCategoryWithTasks = try? JSONDecoder().decode([CategoryWithTask].self, from: savedData) {
            // 디코딩된 할 일 목록을 현재의 categoryWithTasks 배열에 할당
            categoryWithTasks = loadedCategoryWithTasks
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
        cell.setTask(task)

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


    // MARK: - 카테고리 수정
    // 섹션 헤더 탭 시 카테고리 수정
//    func tableView(_ tableView: UITableView, didSelectHeaderInSection section: Int) {
//        let currentCategory = categoryWithTasks[section].category
//
//        var categoryTextField = UITextField()
//
//        let categoryAlert = UIAlertController(title: "카테고리 수정", message: "새로운 카테고리 이름을 입력하세요.", preferredStyle: .alert)
//        categoryAlert.addTextField { (textField) in
//            categoryTextField = textField
//            categoryTextField.placeholder = "새로운 카테고리"
//            categoryTextField.text = currentCategory
//        }
//        let categorySave = UIAlertAction(title: "확인", style: .default) { (action) in
//            guard let newCategory = categoryTextField.text, !newCategory.isEmpty else { return }
//
//            // 카테고리 이름 업데이트 및 테이블 뷰 리로드
//            self.categoryWithTasks[section].category = newCategory
//            self.TodoTable.reloadSections(IndexSet(integer: section), with: .automatic)
//
//            // 업데이트된 카테고리를 UserDefaults에 저장
//            self.saveTodo()
//        }
//        categoryAlert.addAction(categorySave)
//
//        present(categoryAlert, animated: true, completion: nil)
//
//        // 헤더 터치 시 선택 상태 취소
//        tableView.deselectRow(at: IndexPath(row: 0, section: section), animated: true)
//    }
}

