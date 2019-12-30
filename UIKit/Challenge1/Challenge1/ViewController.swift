//
//  ViewController.swift
//  Challenge1
//
//  Created by Vitor Capretz on 2019-12-29.
//  Copyright © 2019 Vitor Capretz. All rights reserved.
//

import UIKit

func formatFlagFileToPrettyName(_ flagName: String) -> String {
    return flagName.replacingOccurrences(of: "flag-", with: "").replacingOccurrences(of: ".png", with: "").uppercased()
}

class ViewController: UITableViewController {
    var flags = [String]()
    
    func loadSortedFlagsFromBundle() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("flag-") {
                flags.append(item)
            }
        }
        
        flags.sort()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSortedFlagsFromBundle()
        
        title = "Country Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        
        cell.textLabel?.text = formatFlagFileToPrettyName(flags[indexPath.row])
        
        func image( _ image: UIImage, withSize newSize: CGSize) -> UIImage {
            UIGraphicsBeginImageContext(newSize)
            image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!.withRenderingMode(.automatic)
        }

        cell.imageView?.image = image(UIImage(named: flags[indexPath.row])!, withSize: CGSize(width: 60, height: 30))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { return }
        
        vc.selectedImage = flags[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

