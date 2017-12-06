//
//  ViewController.swift
//  Pixabay
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var imageTableView: UITableView!
    
    var Pictures = [PixImage]() {
        didSet {
            self.imageTableView.reloadData()
        }
    }
    
    var searchTerm = "" {
        didSet {
            loadPix(named: searchTerm)
        }
    }
    
    func loadPix(named str: String) {
        let setPix = {(onlinePix: [PixImage]) in
            self.Pictures = onlinePix
        }
        let printErrors = {(error: AppError) in
            print(error)
        }
        PixAPIClient.manager.getPix(named: str, completionHandler: setPix, errorHandler: printErrors)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageTableView.dataSource = self
        self.searchBar.delegate = self
        self.imageTableView.delegate = self
     
    }


}

extension ImageViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.imageTableView.dequeueReusableCell(withIdentifier: "Image Cell", for: indexPath) as! ImageTableViewCell
        cell.pictureImageView.image = nil
        let thisImage = Pictures[indexPath.row]
        cell.nameLabel.text = thisImage.tags
        if let imageURL = thisImage.previewURL {
            let getImage: (UIImage) -> Void = {(onlineImage: UIImage) in
                cell.pictureImageView.image = onlineImage
                cell.setNeedsLayout()
            }
            
  ImageAPIClient.manager.getImage(from: imageURL, completionHandler: getImage, errorHandler: {print($0)})
            return cell
            
        }
    
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationDVC = segue.destination as? ImageDetailedViewController {
            let selectedRow = imageTableView.indexPathForSelectedRow?.row
           let selectedImage = Pictures[selectedRow!]
            destinationDVC.myPic = selectedImage
            
            
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = (searchBar.text?.components(separatedBy: " ").joined(separator: "%20"))!
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchText
    }
    
}













