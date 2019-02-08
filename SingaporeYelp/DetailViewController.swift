//
//  DetailViewController.swift
//  SingaporeYelp
//
//  Created by Sophia on 22/1/19.
//  Copyright © 2019 Lynne. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var list_name : [String] = []
    var list_imageurl : [String] = []
    var list_location : [String] = []
    var list_phone : [String] = []
    var list_rate : [Double] = []
    var list_postcode : [String] = []
    var flag : Int = 0
    
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var locTextView: UITextView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBAction func backtolist(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBOutlet weak var directionBtn: UIButton!
    
    @IBOutlet weak var phoneBtn: UIButton!
    
    @IBAction func callNow(_ sender: Any) {
        if list_phone[flag] != ""{
//            let alertController = UIAlertController(title: "Call now?", message: nil, preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            let callAction = UIAlertAction(title: "Yes", style: .default) { (action) in
//                UIApplication.shared.openURL(URL(string: "tel://\(self.list_phone[self.flag])")!)
//            }
//            alertController.addAction(cancelAction)
//            alertController.addAction(callAction)
//            self.present(alertController, animated: true, completion: nil)
//            let options = [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: true]
//            UIApplication.shared.open(URL(string: "tel://\(self.list_phone[self.flag])")!, options: options, completionHandler: nil)
            UIApplication.shared.openURL(URL(string: "tel://\(self.list_phone[self.flag])")!)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.nameTextView.text = list_name[flag]
        self.locTextView.text = list_location[flag]
        self.phoneLabel.text = list_phone[flag]
        self.rateLabel.text = String(list_rate[flag])
        self.nameTextView.isEditable = false
        self.locTextView.isEditable = false
        if list_imageurl[flag] == ""{
            self.picView?.image = UIImage(named: "noimage")
        }else{
            let data = try? Data(contentsOf: URL(string: list_imageurl[flag])!)
            self.picView.image = UIImage(data: data!)
        }
        self.directionBtn.layer.cornerRadius = 10
        self.directionBtn.clipsToBounds = true
        self.phoneBtn.layer.cornerRadius = 10
        self.phoneBtn.clipsToBounds = true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! LocationViewController
        
        if segue.identifier == "getdirection"{
            dest.list_postcode = list_location[flag]
            dest.name = list_name[flag]
        }
    }
    
}
