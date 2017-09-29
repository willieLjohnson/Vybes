import Foundation

struct Vyber: Codable {
    let name: String
    var vybe: String
    
    mutating func setVybe(_ vybe: String) {
        self.vybe = vybe
    }
}

extension Vyber: CustomStringConvertible {
    var description: String {
        return "Name: \(name)" + " Vybe: \(vybe)"
    }
}

//typealias VyberInformation = (title: String, value: String)
//
//extension Vyber {
//    var tableRepresentation: [VyberInformation] {
//        return [
//            ("Name", name),
//            ("Vybe", vybe)
//        ]
//    }
//}

