import Foundation

struct Vyber {
    let name: String
    var vybe: String
    var delegate: VyberDelegate?
    
    mutating func setVybe(_ vybe: String) {
        self.vybe = vybe
    }
    
    mutating func setVybeToDelegate() {
        if let vybe = delegate?.getSelectedVybe() {
            self.vybe = vybe
        } else {
            print("ERROR: Failed to communicate with delegate")
        }
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

