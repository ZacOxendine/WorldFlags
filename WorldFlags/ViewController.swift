//
//  ViewController.swift
//  WorldFlags
//
//  Created by Zachary Oxendine on 6/7/20.
//  Copyright © 2020 Zachary Oxendine. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pngNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "World Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.rowHeight = 110
        
        let fileManager = FileManager.default
        let resourcePath = Bundle.main.resourcePath!
        let resourceNames = try! fileManager.contentsOfDirectory(atPath: resourcePath)
        
        // .png resource names
        for resourceName in resourceNames {
            if resourceName.hasSuffix(".png") {
                // remove .png extension, store in alphabetized array
                let pngName = resourceName.replacingOccurrences(of: ".png", with: "")
                pngNames.append(pngName)
                pngNames.sort()
            }
        }
    }
    
    // update number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pngNames.count
    }
    
    // update properties of cell in each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.imageView?.image = UIImage(named: pngNames[indexPath.row])
        cell.imageView?.layer.borderColor = UIColor.gray.cgColor
        cell.imageView?.layer.borderWidth = 1
        cell.textLabel?.text = pngNames[indexPath.row]
        
        return cell
    }
    
    // update selected row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailVC.title = pngNames[indexPath.row]
            detailVC.cellNameSelected = pngNames[indexPath.row]
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
