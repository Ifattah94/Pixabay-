//
//  ImageDetailedViewController.swift
//  Pixabay
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ImageDetailedViewController: UIViewController {

    var myPic: PixImage!
    
    
    
    
    @IBOutlet weak var bigImage: UIImageView!
    
    
    @IBOutlet weak var tagsLabel: UILabel!
    
    
    @IBOutlet weak var userLabel: UILabel!
    
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        let myPost = FieldBook(image_link: myPic.webformatURL!, student_name: "Iram")
        
        FieldBookAPIClient.manager.postImg(fieldbookpost: myPost, completionHandler: {print($0)}, errorHandler: {print($0)})
        
        
        
    }
    
    
    
    
    func setLabelsAndImage() {
        tagsLabel.text = myPic.tags
        userLabel.text = myPic.user
        if let bigImageUrl = myPic.webformatURL {
            let getImage: (UIImage) -> Void = {(onlineImage: UIImage) in
                self.bigImage.image = onlineImage
            }
            ImageAPIClient.manager.getImage(from: bigImageUrl, completionHandler: getImage, errorHandler: {print($0)})
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelsAndImage()

      
    }



}
