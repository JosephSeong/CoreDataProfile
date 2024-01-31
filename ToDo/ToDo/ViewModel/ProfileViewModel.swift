//
//  ProfileViewModel.swift
//  ToDo
//
//  Created by Joseph on 1/31/24.
//

import Foundation

class ProfileViewModel {

    var userProfile: UserProfile?

    var userName: String {
        return userProfile?.userName ?? ""
    }

    var userAge: String {
        return "\(userProfile?.userAge ?? 0)"
    }

    func fetchUserProfile(completion: @escaping () -> Void) {
        let fetchedUserProfile = UserProfile(userName: "seong", userAge: 25)
        self.userProfile = fetchedUserProfile
        completion()
    }
}
