import Foundation
import UIKit

struct PersonFollowingViewModel {
    let name: String
    let birthDate: String?
    let profileImage: UIImage?
    var isFollowing: Bool
    
    init(with person: Person) {
        //self.init(person.name, person.birthDate?.description, person.gender)
        name = person.name
        birthDate = "20 Sep 2000"
        profileImage = UIImage(systemName: "person.fill")
        isFollowing = false
    }
}
