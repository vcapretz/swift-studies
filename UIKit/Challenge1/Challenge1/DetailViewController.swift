//
//  DetailViewController.swift
//  Challenge1
//
//  Created by Vitor Capretz on 2019-12-29.
//  Copyright © 2019 Vitor Capretz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        title = formatFlagFileToPrettyName(selectedImage ?? "Flag")
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
            imageView.contentMode = .scaleAspectFit
        }
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 1) else {
            print("Failed to load image...")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, selectedImage ?? "Country flag"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }

}
