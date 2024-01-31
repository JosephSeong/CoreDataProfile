//
//  Cat.swift
//  ToDo
//
//  Created by Joseph on 1/12/24.
//

import Foundation

struct Cat: Decodable {
    var id: String
    var url: String
    var width: Int
    var height: Int


    // 외부 표현의 응답이 swift case와 맞지 않으면 이런 방식으로
//    enum CodingKeys: String, CodingKey {
//        case id = "ID", case url = "URL"
//    }
}
