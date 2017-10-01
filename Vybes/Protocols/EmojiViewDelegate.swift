import Foundation

protocol EmojiViewDelegate {
    func getVyberList() -> [Vyber]?
    func getSelectedVyberIndex() -> Int?
    func reloadData()
}
