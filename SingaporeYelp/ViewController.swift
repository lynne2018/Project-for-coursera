//
//  ViewController.swift
//  SingaporeYelp
//
//  Created by Sophia on 22/1/19.
//  Copyright © 2019 Lynne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let APIKey = "2jDwUtjKPPcl0xNJAODA-sOPMa9u_mwSERVNQoUeQWnDChGgTydcn8h3sAHOJA_NS9pe0g482zl2aH_AqIlfRo-WJXFG_k1VdUd7HdYC-F5r_ImWLwzbHm1N95FGXHYx"
    typealias JSONDictionary = [String:Any]
    var res_list:[JSONDictionary] = []
    var shop_list:[JSONDictionary] = []
    var den_list:[JSONDictionary] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let url_base = "https://api.yelp.com/v3/businesses/search?location=Singapore&"
        let url_res = url_base + "term=restaurants"+"&limit=20"
        let url_shop = url_base + "term=shoppings"+"&limit=20"
        let url_den = url_base + "term=dentists"+"&limit=20"
        
        let url = [url_res,url_shop,url_den]
        for i in 0..<url.count{
            var request = URLRequest(url: URL(string: url[i])!)
            request.addValue("bearer \(APIKey)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    return
                }
                do{
                    if let parsejson = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSONDictionary{
                        let businessses = parsejson["businesses"]! as! [JSONDictionary]
                        for business in businessses{
                            if i == 0{
                                self.res_list.append(business)
                            }else if i == 1{
                                self.shop_list.append(business)
                            }else{
                                self.den_list.append(business)
                            }
                        }
                    }
                }
                }.resume()
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ListViewController
        if segue.identifier=="restaurants"{
            var location : [[String : Any]] = []
            for i in 0..<res_list.count{
                dest.list_name.append(res_list[i]["name"]! as! String)
                dest.list_rate.append(res_list[i]["rating"]! as! Double)
                dest.list_imageurl.append(res_list[i]["image_url"]! as! String)
                dest.list_phone.append(res_list[i]["phone"]! as! String)
                location.append(res_list[i]["location"] as! [String : Any])
                let temp = location[i]["display_address"]! as! NSArray
                var str = ""
                for j in 0..<temp.count-1{
                    str = str + (temp[j] as! String ) + " "
                }
                dest.list_location.append(str)
                dest.list_postcode.append(location[i]["zip_code"]! as! String)
                dest.type = "Restaurants"
            }
        }else if segue.identifier=="shoppings"{
            var location : [[String : Any]] = []
            for i in 0..<shop_list.count{
                dest.list_name.append(shop_list[i]["name"]! as! String)
                dest.list_rate.append(shop_list[i]["rating"]! as! Double)
                dest.list_imageurl.append(shop_list[i]["image_url"]! as! String)
                dest.list_phone.append(shop_list[i]["phone"]! as! String)
                location.append(shop_list[i]["location"] as! [String : Any])
                let temp = location[i]["display_address"]! as! NSArray
                var str = ""
                for j in 0..<temp.count-1{
                    str = str + (temp[j] as! String ) + " "
                }
                dest.list_location.append(str)
                dest.list_postcode.append(location[i]["zip_code"]! as! String)
                dest.type = "Shoppings"
            }
            
        }else{
            var location : [[String : Any]] = []
            for i in 0..<den_list.count{
                dest.list_name.append(den_list[i]["name"]! as! String)
                dest.list_rate.append(den_list[i]["rating"]! as! Double)
                dest.list_imageurl.append(den_list[i]["image_url"]! as! String)
                dest.list_phone.append(den_list[i]["phone"]! as! String)
                location.append(den_list[i]["location"] as! [String : Any])
                let temp = location[i]["display_address"]! as! NSArray
                var str = ""
                for j in 0..<temp.count-1{
                    str = str + (temp[j] as! String ) + " "
                }
                dest.list_location.append(str)
                dest.list_postcode.append(location[i]["zip_code"]! as! String)
                dest.type = "Dentists"
            }
        }
    }


}

