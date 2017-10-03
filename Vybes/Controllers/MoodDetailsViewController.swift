import UIKit

class MoodDetailsViewController: UIViewController {
    
    @IBOutlet var popupDetailsView: UIView!
    @IBOutlet weak var finishEditingButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    var scrollView: UIScrollView! {
        return self.textView
    }
    
    var oldContentInset = UIEdgeInsets.zero
    var oldIndicatorInset = UIEdgeInsets.zero
    var oldOffset = CGPoint.zero
    
    enum KeyboardState {
        case unknown
        case entering
        case exiting
    }
    
    var recievedData = [String: String?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        popupDetailsView.layer.cornerRadius = 15
        popupDetailsView.layer.masksToBounds = true
        
        textView.text = recievedData["details"] ?? ""
        dateLabel.text = recievedData["date"]!
        moodLabel.text = recievedData["mood"]!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
    }

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissViewController(_ sender: Any) {
        self.isEditing = false
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishEditing(_ sender: Any) {
        textView.endEditing(true)
    }
}

extension MoodDetailsViewController: UITextViewDelegate {
    func keyboardState(for keyboardInfo:[AnyHashable:Any], in view:UIView?) -> (KeyboardState, CGRect?) {
        var oldRect = keyboardInfo[UIKeyboardFrameBeginUserInfoKey] as! CGRect
        var rect = keyboardInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
        
        var keyboardState : KeyboardState = .unknown
        var newRect: CGRect? = nil
        
        if let view = view {
            let coord = UIScreen.main.coordinateSpace
            
            oldRect = coord.convert(oldRect, to:view)
            rect = coord.convert(rect, to:view)
            newRect = rect
            
            if !oldRect.intersects(view.bounds) && rect.intersects(view.bounds) {
                keyboardState = .entering
            }
            
            if oldRect.intersects(view.bounds) && !rect.intersects(view.bounds) {
                keyboardState = .exiting
            }
        }
        
        return (keyboardState, newRect)
    }
    
    @objc func keyboardShow(_ notification: Notification) {
        let keyboardInfo = notification.userInfo!
        
        let (state, rect) = keyboardState(for: keyboardInfo, in: self.scrollView)
        
        if state == .entering {
            self.oldContentInset = self.scrollView.contentInset
            self.oldIndicatorInset = self.scrollView.scrollIndicatorInsets
            self.oldOffset = self.scrollView.contentOffset
            
            finishEditingButton.isHidden = false
        }

        if let newRect = rect {
            let height = newRect.intersection(self.scrollView.bounds).height
            self.scrollView.contentInset.bottom = height
            self.scrollView.scrollIndicatorInsets.bottom = height
        }
    }
    
    @objc func keyboardHide(_ notification:Notification) {
        let keyboardInfo = notification.userInfo!
        let (state, _) = keyboardState(for: keyboardInfo, in:self.scrollView)
        
        if state == .exiting {
            self.scrollView.scrollIndicatorInsets = self.oldIndicatorInset
            self.scrollView.contentInset = self.oldContentInset
            
            finishEditingButton.isHidden = true
        }
    }
}
