import UIKit

class MoodViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var moodList: [Mood]?
    
    var dataForSegue = [String: String?]()
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        
        moodList = [
            Mood(name: "Happy", details: "It was a wild time, believe me", date: Date()),
            Mood(name: "Scared", details: "Spooky day! I can't fall asleep!", date: Date()),
            Mood(name: "Scared", details: nil, date: Date()),
            Mood(name: "Scared", details: nil, date: Date()),
            Mood(name: "Scared", details: nil, date: Date())
        ]
        
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
        if let moodList = moodList {
            return moodList.count
        } else {
            print("ERROR: MOODLIST IS NIL")
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moodCell = tableView.dequeueReusableCell(withIdentifier: "MoodCell", for: indexPath) as! MoodCell
        
        if let moodList = moodList {
            let mood = moodList[indexPath.row]
            
            moodCell.name.text = mood.name
            moodCell.background.image = UIImage(named: "dog")
            
            if let details = mood.details {
                moodCell.details.text = details
            } else {
                moodCell.details.text = nil
            }
            
            moodCell.date.text = formatDate(date: mood.date)
        } else {
            print("ERROR: MOODLIST NIL")
            return UITableViewCell()
        }
        return moodCell
    }
}

// MARK: Delegate
extension MoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let moodList = moodList {
            let mood = moodList[indexPath.row]
            
            dataForSegue = ["mood": mood.name, "date": formatDate(date: mood.date), "details": mood.details]
            
            self.performSegue(withIdentifier: "showMoodDetailsView", sender: self)
        } else {
            print("ERROR: MOODLIST NIL")
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MoodDetailsViewController
        destination.recievedData = dataForSegue
    }
}



