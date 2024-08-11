import Foundation

struct Person {
    let name: String
    let birthDate: Date?
    let gender: Gender
    
    init(name: String, birthDate: Date? = nil, gender: Gender = .unspecified) {
        self.name = name
        self.birthDate = birthDate
        self.gender = gender
    }
}
