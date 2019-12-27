//
//  DetailViewController.swift
//  Project1
//
//  Created by Vitor Capretz on 2019-12-26.
//  Copyright © 2019 Vitor Capretz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var imageCount: Int?
    var imageIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let count = imageCount, let index = imageIndex  {
            title = "Picture \(index) of \(count)"
        }
        
//        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
            imageView.contentMode = .scaleAspectFill
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
