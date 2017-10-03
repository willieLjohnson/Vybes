import UIKit

class MoodViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var moodList: [Mood] = [Mood(name: "Anxious", details: "It was a wild time, believe me", date: Date()), Mood(name: "Scared", details: "Spooky day! I can't fall asleep!", date: Date()), Mood(name: "Scared", details: nil, date: Date()), Mood(name: "Scared", details: nil, date: Date()), Mood(name: "Scared", details: nil, date: Date())]
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }
    
    private func formatDate(date: Date) -> String {
        let timeInterval = date.timeIntervalSince1970
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale (identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("EdMMMyyy")
        
        if Calendar.current.startOfDay(for: date).timeIntervalSince1970 == Calendar.current.startOfDay(for: Date()).timeIntervalSince1970 {
            return "Today"
        }
        
        return dateFormatter.string(from: Date(timeIntervalSince1970: timeInterval))
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
        
        if let details = mood.details {
            moodCell.details.text = details
        } else {
            moodCell.details.text = nil
        }
        
        moodCell.date.text = formatDate(date: mood.date)
        
        return moodCell
    }

}

// MARK: Delegate
extension MoodViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showMoodDetailsView", sender: self)
    }
    
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        // get a reference to the second view controller
//        let secondViewController = segue.destination as! SecondViewController
//
//        // set a variable in the second view controller with the data to pass
//        secondViewController.receivedData = "hello"
//    }
//
}



