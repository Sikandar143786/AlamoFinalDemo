//
//  viewAdd.swift
//  AlaDemo
//
//  Created by imac on 12/6/16.
//  Copyright © 2016 akashinfotech. All rights reserved.
//

import UIKit
import Alamofire

class viewAdd: UIViewController {

    var isEdit : Bool = false
    var nextDic = NSDictionary()
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtSname: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        if isEdit == true {
            txtAddress.text = nextDic.object(forKey: "address") as? String
            txtPhone.text = nextDic.object(forKey: "phone") as? String
            txtSname.text = nextDic.object(forKey: "sname") as? String
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnClickAdd(_ sender: Any) {
        
        var parameters: Parameters
        
        var strUrl = ""
        var alertMsg = ""
        if isEdit == true {
            
            let num = nextDic.object(forKey: "sid") as! String
            //let intId = Int(num)
            parameters = [
                            "id" : num,
                            "sname": txtSname.text!,
                           "phone" : txtPhone.text!,
                           "address" : txtAddress.text!]
            
            strUrl = "http://akashinfotechdevelopment.com/php/json/update.php"
            alertMsg = "User Updated"
        }
        else
        {
            parameters = [ "sname": txtSname.text!,
            "phone" : txtPhone.text!,
            "address" : txtAddress.text!]
            
            strUrl = "http://akashinfotechdevelopment.com/php/json/create.php"
            alertMsg = "User Created"
        }
        Alamofire.request(strUrl, method: .post, parameters: parameters ).responseJSON { response in
            switch response.result {
            case .success(let JSON):
                //                    print("Success with JSON: \(JSON)")
                print("Request failed with error: \(response.response?.statusCode)")
                
                let response = JSON as! NSDictionary
                print(response)
                let flagVal = response.object(forKey: "flag") as! String
                
                if flagVal == "1"
                {
                    let alert = UIAlertController(title: "Alamofire", message: alertMsg, preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    let alert = UIAlertController(title: "Alamofire", message: "Error in user  create.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
                
                print(response)
                break
                
            case .failure(let error):
                print("Request failed with error: \(error)")
                
                let alert = UIAlertController(title: "Alamofire", message: "Error in user  create.", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
                break
            }
            }
            .responseString { response in
                print("Response String: \(response.result.value)")
        }
        
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
