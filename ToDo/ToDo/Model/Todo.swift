//
//  Todo.swift
//  ToDo
//
//  Created by Joseph on 12/22/23.
//

import Foundation

// 할 일 데이터 모델 정의
struct Todo: Codable {
    var id: Int
    var title: String
    var isCompleted: Bool
}

// 카테고리와 해당 카테고리에 속하는 할 일 목록을 담는 데이터 모델 정의
struct CategoryWithTask: Codable{
    var category: String
    var tasks: [Todo]
}
