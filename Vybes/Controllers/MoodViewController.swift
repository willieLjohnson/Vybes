import UIKit

class MoodViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var moodList: [Mood] = [Mood(name: "Anxious"), Mood(name: "Scared"), Mood(name: "Scared"), Mood(name: "Scared"), Mood(name: "Scared")]
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }
}

// MARK: Data Source
extension MoodViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moodCell = tableView.dequeueReusableCell(withIdentifier: "MoodCell", for: indexPath) as! MoodCell
        
        let mood = moodList[indexPath.row]
        
        moodCell.name.text = mood.name
        moodCell.background.image = UIImage(named: "dog")
        
        return moodCell
    }
}

// MARK: Delegate
extension MoodViewController: UITableViewDelegate {
    
}



