//
//  tableViewController.swift
//  SecondCodingDojo-Team1
//
//  Created by Mustafa Gülden on 9.01.2022.
//

import UIKit
import CoreData

class tableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var numberArray = [Int]()
    var romanNumberArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
        
    }
    
    func getData() {
        
        numberArray.removeAll(keepingCapacity: false)
        romanNumberArray.removeAll(keepingCapacity: false)
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pairs")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let number = result.value(forKey: "number") as? Int {
                        self.numberArray.append(number)
                    }
                    if let romanNumber = result.value(forKey: "romanNumber") as? String {
                        self.romanNumberArray.append(romanNumber)
                    }
                    
                    self.tableView.reloadData()
                }
            }
        } catch {
            print("error")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(numberArray[indexPath.row]) + ":" + romanNumberArray[indexPath.row]
        return cell
    }

}
