//
//  TimerView.swift
//  MarumainApp
//
//  Created by 栗須星舞 on 2020/12/22.
//

import UIKit

protocol TimerViewDelegate {
    func endTimer()
}

class TimerView: UIView {

    @IBOutlet weak var countDwonLabel: UILabel!
    
    @IBOutlet weak var marumainImageView: UIImageView!
    
    var timer = Timer()
    
    var timerCount = 10
    
    var delegate: TimerViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.nibInit()
    }
    
    fileprivate func nibInit() {
        guard let view = UINib(nibName: "TimerView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)
    }
    
    @IBAction func startButtonDidTapped(_ sender: Any) {
        switch !timer.isValid {
        case true:
            startTimer()
        default:
            break
        }
    }
    
    @IBAction func stopButtonDidTapped(_ sender: Any) {
        pause()
    }
    
    @IBAction func resetButtonDidTapped(_ sender: Any) {
        timer.invalidate()
        timerCount = 10
        countDwonLabel.text = String(timerCount)
        marumainImageView.image = UIImage(named: "marumain")
    }
    
    func startTimer() {
        if timerCount != 0 {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
    }
    
    func pause() {
        timer.invalidate()
    }
    
    @objc func timerAction() {
        timerCount -= 1
        countDwonLabel.text = String(timerCount)
        
        switch timerCount {
        case 8:
            let rect = CGRect(x: 0, y: 0, width: self.marumainImageView.bounds.width * 1.2, height: self.marumainImageView.bounds.height * 1.2)
            marumainImageView.bounds = rect
        case 6:
            let rect = CGRect(x: 0, y: 0, width: self.marumainImageView.bounds.width * 1.5, height: self.marumainImageView.bounds.height * 1.5)
            marumainImageView.bounds = rect
        case 4:
            let rect = CGRect(x: 0, y: 0, width: self.marumainImageView.bounds.width * 2, height: self.marumainImageView.bounds.height * 2)
            marumainImageView.bounds = rect
        case 2:
            let rect = CGRect(x: 0, y: 0, width: self.marumainImageView.bounds.width * 2.5, height: self.marumainImageView.bounds.height * 2.5)
            marumainImageView.bounds = rect
        default:
            break
        }
        
        if timerCount == 0 {
            self.delegate?.endTimer()
            timer.invalidate()
            timerCount = 0
            countDwonLabel.text = "タイムアップ！！！"
            marumainImageView.image = UIImage(named: "kazan")
        }
    }
}
