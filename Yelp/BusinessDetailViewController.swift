//
//  BusinessDetailViewController.swift
//  Yelp
//
//  Created by Hugh A. Miles II on 1/31/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessDetailViewController: UIViewController {
    
    var business:Business!
    
    @IBOutlet weak var thumbImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingImgView: UIImageView!
    @IBOutlet weak var reviewCountLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let business = business {
            nameLbl.text = business.name
            ratingImgView.setImageWithURL(business.ratingImageURL!)
            thumbImgView.setImageWithURL(business.imageURL!)
            reviewCountLbl.text = "\(business.reviewCount!) Reviews"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
