//
//  MainViewController.swift
//  SingaporeYelp
//
//  Created by Sophia on 22/1/19.
//  Copyright © 2019 Lynne. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    let business =
        [["name": "Sungei Road Laksa","image_url": "https://s3-media1.fl.yelpcdn.com/bphoto/Mc9krS4DdaygtoeHDpbO2g/o.jpg","rating": 4.5,"location": ["address1":"27 Jalan Berseh","address2": "#01-100, Jin Shui Kopitiam","address3": "","city": "Singapore","zip_code": "200027"],"phone": ""],
         ["name": "Hokkaido Ramen Santouka",
                "image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/OMwe1DFAL5onX-DrCT404A/o.jpg",
                "rating": 4.5,
                "location": [
                    "address1": "6 Eu Tong Sen St",
                    "address2": "#02-76",
                    "address3": "",
                    "city": "Singapore",
                    "zip_code": "059817"],
                "phone": "+6562240668"],
              ["name": "Hokkaido Ramen Santouka",
                                         "image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/OMwe1DFAL5onX-DrCT404A/o.jpg",
                                         "rating": 4.5,
                                         "location": [
                                            "address1": "6 Eu Tong Sen St",
                                            "address2": "#02-76",
                                            "address3": "",
                                            "city": "Singapore",
                                            "zip_code": "059817"],
                                         "phone": "+6562240668"],
              ["name": "Hokkaido Ramen Santouka",
                                                                  "image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/OMwe1DFAL5onX-DrCT404A/o.jpg",
                                                                  "rating": 4.5,
                                                                  "location": [
                                                                    "address1": "6 Eu Tong Sen St",
                                                                    "address2": "#02-76",
                                                                    "address3": "",
                                                                    "city": "Singapore",
                                                                    "zip_code": "059817"],
                                                                  "phone": "+6562240668"],
              ["name": "Hokkaido Ramen Santouka","image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/OMwe1DFAL5onX-DrCT404A/o.jpg","rating": 4.5,"location": ["address1": "6 Eu Tong Sen St","address2": "#02-76","address3": "","city": "Singapore","zip_code": "059817"],"phone": "+6562240668"], ["name": "Hokkaido Ramen Santouka","image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/OMwe1DFAL5onX-DrCT404A/o.jpg","rating": 4.5,"location": ["address1": "6 Eu Tong Sen St","address2": "#02-76","address3": "","city": "Singapore","zip_code": "059817"],"phone": "+6562240668"], ["name": "Hokkaido Ramen Santouka","image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/OMwe1DFAL5onX-DrCT404A/o.jpg","rating": 4.5,"location": ["address1": "6 Eu Tong Sen St","address2": "#02-76","address3": "","city": "Singapore","zip_code": "059817"],"phone": "+6562240668"], ["name": "Hokkaido Ramen Santouka","image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/OMwe1DFAL5onX-DrCT404A/o.jpg","rating": 4.5,"location": ["address1": "6 Eu Tong Sen St","address2": "#02-76","address3": "","city": "Singapore","zip_code": "059817"],"phone": "+6562240668"], ["name": "Hokkaido Ramen Santouka","image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/OMwe1DFAL5onX-DrCT404A/o.jpg","rating": 4.5,"location": ["address1": "6 Eu Tong Sen St","address2": "#02-76","address3": "","city": "Singapore","zip_code": "059817"],"phone": "+6562240668"], ["name": "Hokkaido Ramen Santouka","image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/OMwe1DFAL5onX-DrCT404A/o.jpg","rating": 4.5,"location": ["address1": "6 Eu Tong Sen St","address2": "#02-76","address3": "","city": "Singapore","zip_code": "059817"],"phone": "+6562240668"]
        ]
    var location : [[String : Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ListViewController
        if segue.identifier=="restaurants"{
            for i in 0..<business.count{
                dest.list_name.append(business[i]["name"]! as! String)
                dest.list_rate.append(business[i]["rating"]! as! Double)
                dest.list_imageurl.append(business[i]["image_url"]! as! String)
                dest.list_phone.append(business[i]["phone"]! as! String)
//                var location = (business[i]["location"]["address1"])!+(business[i]["location"]["address2"])!+(business[i]["location"]["address3"])! as! String
//                dest.list_location.append(location)
                location.append(business[i]["location"] as! [String : Any])
                let temp = (location[i]["address1"]! as! String)+""+(location[i]["address2"]! as! String)+" "+(location[i]["address3"]! as! String)+","+(location[i]["city"]! as! String)+","+(location[i]["zip_code"]! as! String)
                dest.list_location.append(temp)
            }
        }else if segue.identifier=="shoppings"{
            print("shop")
        }else{
            print("dentist")
        }
    }
}
