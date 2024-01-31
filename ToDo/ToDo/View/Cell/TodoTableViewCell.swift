//
//  TodoTableViewCell.swift
//  ToDo
//
//  Created by Joseph on 1/5/24.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var doneSwitch: UISwitch!

    var todo: Todo?
    var todoViewController: TodoViewController?

    // 왼료하면 밑줄
    @IBAction func switchChanged(_ sender: Any) {
        // todo 객체가 존재하는지 확인
        guard var todo = self.todo else { return }

        // todo 객체의 완료 상태 업데이트
        todo.isCompleted = doneSwitch.isOn

        // 완료 상태에 따라 셀의 텍스트에 밑줄을 추가하거나 제거
        if doneSwitch.isOn {
            textLabel?.text = nil
            textLabel?.attributedText = todo.title.strikeThrough()
        } else {
            textLabel?.attributedText = nil
            textLabel?.text = todo.title
        }

        // 업데이트된 데이터를 UserDefaults에 저장
        todoViewController?.saveTodo()

        print(#function)
    }

    func setTask(_ _todo: Todo) {
        todo = _todo
        guard let todo else { return }
        if todo.isCompleted {
            textLabel?.text = nil
            textLabel?.attributedText = todo.title.strikeThrough()
        } else {
            textLabel?.attributedText = nil
            textLabel?.text = todo.title
        }
        doneSwitch.isOn = todo.isCompleted
    }



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
