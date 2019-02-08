//
//  ListViewController.swift
//  SingaporeYelp
//
//  Created by Sophia on 22/1/19.
//  Copyright © 2019 Lynne. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var listTable: UITableView!
    
    var type : String = ""
    var list_name : [String] = []
    var list_imageurl : [String] = []
    var list_location : [String] = []
    var list_phone : [String] = []
    var list_rate : [Double] = []
    var list_postcode : [String] = []
    var flag : Int = 0
    
    @IBAction func backtomain(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBOutlet weak var titleLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listTable.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        listTable.delegate = self
        listTable.dataSource = self
        titleLabel.isEditable = false
        self.titleLabel.text = self.type
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list_name.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.nameTextView?.text = list_name[indexPath.row]
        cell.ratingLabel?.text = String(list_rate[indexPath.row])
        if list_imageurl[indexPath.row] != ""{
//            cell.imageView?.image = UIImage(named: "noimage")
//            cell.imageView?.contentMode = .scaleToFill
//        }else{
            let data = try? Data(contentsOf: URL(string: list_imageurl[indexPath.row])!)
            cell.imagView.image = UIImage(data: data!)
            cell.imageView?.contentMode = .scaleToFill
        }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        flag = indexPath.row
        self.performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! DetailViewController
        
        if segue.identifier == "toDetail"{
            dest.list_name = list_name
            dest.list_imageurl = list_imageurl
            dest.list_rate = list_rate
            dest.list_location = list_location
            dest.list_phone = list_phone
            dest.list_postcode = list_postcode
            dest.flag = flag
        }
    }
    
}
