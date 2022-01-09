//
//  ViewController.swift
//  SecondCodingDojo-Team1
//
//  Created by Mustafa Gülden on 9.01.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController{
    var romanDictionary = [String:Int]()
    var numberValue = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
    var romanNumeral = [
          "M",
          "CM",
          "D",
          "CD",
          "C",
          "XC",
          "L",
          "XL",
          "X",
          "IX",
          "V",
          "IV",
          "I"
        ]
    
    
    @IBOutlet weak var romanInput: UITextField!
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in 1...4999{
            var val = i
            var countForRoman : [(rom: String, num: Int)] = []

            for (index, number) in numberValue.enumerated() {
                let x = val / number
                if x > 0 {
                    countForRoman.append((romanNumeral[index], x))
                    val = val - x * number
                }
            }
            var romanString = ""
            for pairs in countForRoman {
                let iter = pairs.num
                for _ in 1 ... iter { romanString += pairs.rom }
            }
            romanDictionary[romanString] = i
        }
    }
    	
    @IBAction func resultButton(_ sender: Any) {
        if romanDictionary.keys.contains(romanInput.text!) {
            let input = romanInput.text!
            resultLabel.text = String(romanDictionary[input]!)
        } else {
            resultLabel.text = "Please enter an appropriate roman number between 1 - 4999."
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPair = NSEntityDescription.insertNewObject(forEntityName: "Pairs", into: context)
        
        if let number = Int(resultLabel.text!) {
            newPair.setValue(number, forKey: "number")
        }
        newPair.setValue(romanInput.text!, forKey: "romanNumber")
        
        do {
            try context.save()
            print("success")
        } catch {
            print("error")
        }
        
        
    }
    
    @IBAction func favoritesButton(_ sender: Any) {
        performSegue(withIdentifier: "toFavorites", sender: nil)
    }


    }

