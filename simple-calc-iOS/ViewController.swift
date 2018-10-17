//
//  ViewController.swift
//  simple-calc-iOS
//
//  Created by Raymond Lee on 10/15/18.
//  Copyright © 2018 rayjaelee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var answerText = ""

    @IBOutlet weak var lblEquation: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    
    @IBAction func btnNonEqual(_ sender: UIButton) {
        if sender.tag < 0 {
            switch sender.tag {
            case -1:
                answerText += " + "
            case -2:
                answerText += " - "
            case -3:
                answerText += " * "
            case -4:
                answerText += " / "
            case -5:
                answerText += " % "
            case -6:
                lblEquation.text = answerText + " FACT "
                answerText = displayMod(num: Int(lblAnswer.text!)!)
            case -7:
                answerText += " AVG "
            case -8:
                answerText += " COUNT "
            default:
                answerText += " "
            }
            
        } else {
            if sender.tag >= 10 {
                answerText = ""
            } else {
                answerText += String(sender.tag)
            }
        }
        lblAnswer.text = answerText
    }
    
    func checkExtended(target: [String.SubSequence]?) -> String {
        for item in target! {
            if item == "AVG" {
                return "AVG"
            } else if item == "COUNT" {
                return "COUNT"
            }
        }
        return ""
    }
    
    @IBAction func btnEqual(_ sender: Any) {
        //store the equation on the equation label
        lblEquation.text = lblAnswer.text
        
        //calculate the equation
        let inputEquation = lblAnswer.text
        
        let inputBreakDown = inputEquation?.split(separator: " ")
        
        let extended = checkExtended(target: inputBreakDown)
        
        var answer = 0
        
        if extended == "AVG" {
            var total = 0
            let avgBreakDown = inputBreakDown!.filter { $0 != "AVG" }
            
            for num in avgBreakDown {
                total += Int(num)!
            }
            
            answer = total / avgBreakDown.count
            
        } else if extended == "COUNT" {
            for item in inputBreakDown! {
                if item == "COUNT" {
                    answer += 1
                }
            }
            answer += 1
        } else {
            let x = Int(inputBreakDown![0])
            let y = Int(inputBreakDown![2])
            
            for item in inputBreakDown! {
                switch item {
                case "+":
                    answer = x! + y!
                case "-":
                    answer = x! - y!
                case "*":
                    answer = x! * y!
                case "/":
                    answer = x! / y!
                case "%":
                    answer = x! % y!
                default:
                    break
                }
            }
        }
        
        lblAnswer.text = String(answer)
        
    }
    
    func displayMod(num: Int) -> String {
        var displayAnswer = 1
        
        for i in 1...num {
            displayAnswer = displayAnswer * i
        }
        
        return String(displayAnswer)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

