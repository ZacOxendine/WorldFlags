//
//  DetailViewController.swift
//  WorldFlags
//
//  Created by Zachary Oxendine on 6/8/20.
//  Copyright © 2020 Zachary Oxendine. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var cellNameSelected: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self,
                                                            action: #selector(shareTapped))
        
        // load .png file with border
        if let pngToLoad = cellNameSelected {
            imageView.image = UIImage(named: pngToLoad)
            imageView.layer.borderColor = UIColor.gray.cgColor
            imageView.layer.borderWidth = 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    // right bar button item
    @objc func shareTapped() {
        guard let pngSelected = imageView.image?.pngData() else {
            print("Error: Image Not Found")
            return
        }
        
        let activityVC = UIActivityViewController(activityItems: [pngSelected, cellNameSelected!],
                                                  applicationActivities: [])
        
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityVC, animated: true)
    }
}
