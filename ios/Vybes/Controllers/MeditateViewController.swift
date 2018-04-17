//
//  MeditateViewController.swift
//  Vybes
//
//  Created by Willie Johnson on 4/16/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import UIKit

/// View controller used to have a meditation session.
class MeditateViewController: UIViewController {
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var durationPicker: UIDatePicker!
  var timer = Timer()
  var secCounter: TimeInterval = 1
  var isRunning: Bool = false

  override func viewDidLoad() {
    super.viewDidLoad()
    timerLabel.transform = .init(scaleX: 0.001, y: 0.001)
    durationPicker.setValue(UIColor.white, forKey: "textColor")
    // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func pausePlayButtonPressed(_ sender: Any) {
    if !isRunning {
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
      isRunning = true
      UIView.animate(withDuration: 0.2) {
        self.playButton.setImage(#imageLiteral(resourceName: "pause-button"), for: .normal)
      }
    } else {
      timer.invalidate()
      isRunning = false
      UIView.animate(withDuration: 0.2) {
        self.playButton.setImage(#imageLiteral(resourceName: "enter-button"), for: .normal)
      }
    }
    UIView.animate(withDuration: 0.2) {
      self.durationPicker.transform = .init(scaleX: 1, y: 0.001)
      self.durationPicker.isHidden = true
      self.timerLabel.transform = .identity
    }
    secCounter = durationPicker.countDownDuration
  }

  @objc func updateTimer() {
    secCounter -= 1
    timerLabel.text = "\(String(format: "%02.0f", secCounter))"
  }

  @IBAction func cancelButtonPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
