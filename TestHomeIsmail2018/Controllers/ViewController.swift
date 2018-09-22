//
//  ViewController.swift
//  TestHomeIsmail2018
//
//  Created by Ismail on 9/22/18.
//  Copyright © 2018 Ismail. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var carsArray : [CarObject] = []
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Cars list"
        tableView.registerCell(id: "CarDetailsTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160
        tableView.delegate = self
        tableView.dataSource = self
        self.getCars()
        print(self.carsArray)
    }
    func getCars()  {
        if let path = Bundle.main.path(forResource: "locations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let placemarks = jsonResult["placemarks"] as? [Dictionary<String, AnyObject>] {
                    self.carsArray.removeAll()
                    for car in placemarks {
                        let object = CarObject.init(dictionary: car)
                        self.carsArray.append(object)
                    }
                    self
                }
            } catch {
                // handle error
            }
        }
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarDetailsTableViewCell = tableView.dequeueTVCell()
        cell.initCell(carObject: self.carsArray[indexPath.row])
        cell.view_bg.setRounded(12)
        
        return cell
    }
    
    
    
    
}

