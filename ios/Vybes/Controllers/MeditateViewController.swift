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
  @IBOutlet weak var stopButton: UIButton!
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var durationPicker: UIDatePicker!
  var timer = Timer()
  var secCounter: TimeInterval = 0
  var isRunning: Bool = false {
    willSet {
      if newValue {
        startTimer()
      } else {
        pauseTimer()
      }
    }
  }
  let heavyImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
  let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)

  override func viewDidLoad() {
    super.viewDidLoad()
    timerLabel.transform = .init(scaleX: 0.001, y: 0.001)
    durationPicker.setValue(UIColor.white, forKey: "textColor")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func pausePlayButtonPressed(_ sender: Any) {
    playButton.animateTap()
    /// Toggle isRunning
    isRunning = !isRunning
    guard secCounter == 0, !durationPicker.isHidden else { return }
    secCounter = durationPicker.countDownDuration
    timerLabel.text = secCounter.stringFormatted()
    /// Animate duration picker and timer label.
    UIView.animate(withDuration: 0.2, animations: ({
      self.timerLabel.isHidden = false
      self.durationPicker.transform = .init(scaleX: 1, y: 0.01)
      self.timerLabel.transform = .identity
    }), completion: ({ _ in
      self.durationPicker.isHidden = true
    }))
  }

  @objc func updateTimer() {
    lightImpactFeedbackGenerator.prepare()
    secCounter -= 1
    guard secCounter > 0 else {
      heavyImpactFeedbackGenerator.prepare()
      stopTimer()
      return
    }
    timerLabel.animateTap(duration: 0.4)
    timerLabel.text = secCounter.stringFormatted()
    lightImpactFeedbackGenerator.impactOccurred()
  }

  @IBAction func stopButtonPressed(_ sender: Any) {
    stopButton.animateTap()
    guard secCounter > 0 else {
      dismiss(animated: true, completion: nil)
      return
    }
    stopTimer()
  }
}

// MARK: - Helper methods
private extension MeditateViewController {
  /// Initalizes the timer and plays button animations.
  func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    /// Animate stop and play buttons.
    UIView.animate(withDuration: 0.2) {
      self.playButton.setImage(#imageLiteral(resourceName: "pause-button"), for: .normal)
      self.stopButton.setImage(#imageLiteral(resourceName: "stop-button"), for: .normal)
    }
  }

  /// Invalidates the timer and plays button animations.
  func pauseTimer() {
    timer.invalidate()
    UIView.animate(withDuration: 0.2) {
      self.playButton.setImage(#imageLiteral(resourceName: "play-button"), for: .normal)
    }
  }

  /// Stops the timer.
  func stopTimer() {
    secCounter = 0
    isRunning = false
    /// Animate duration picker and timer label.
    UIView.animate(withDuration: 0.2, animations: ({ [unowned self] in
      self.durationPicker.isHidden = false
      self.durationPicker.transform = .identity
      self.timerLabel.transform = .init(scaleX: 1, y: 0.01)
      self.stopButton.setImage(#imageLiteral(resourceName: "enter-button"), for: .normal)
      self.heavyImpactFeedbackGenerator.impactOccurred()
    }), completion: ({ _ in
      self.timerLabel.isHidden = true
    }))
  }
}
