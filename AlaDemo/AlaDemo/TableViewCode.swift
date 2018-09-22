//
//  TableViewCode.swift
//  AlaDemo
//
//  Created by Akash InfoTech on 22/11/16.
//  Copyright © 2016 akashinfotech. All rights reserved.
//

import UIKit

import Alamofire

class TableViewCode: UIViewController , UITableViewDataSource,UITableViewDelegate {

    var arrFeeds = NSMutableArray()
    
    @IBOutlet weak var tvFeedData: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tvFeedData.delegate = self
        tvFeedData.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated) // No need for semicolon
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        getUserList()
        
    }
    
    @IBAction func btnClickAdd(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "viewAdd") as! viewAdd
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    func getUserList()
    {
    
        Alamofire.request("http://akashinfotechdevelopment.com/php/json/read.php").responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                let jsonData = JSON as! NSDictionary
                self.arrFeeds = (jsonData.object(forKey: "student") as! NSArray).mutableCopy() as! NSMutableArray
                self.tvFeedData.reloadData()
                
            }
        }
    }
    func DeleteUser(userId : String)
    {
       
        let parameters: Parameters = [
            "id": userId]
    
        Alamofire.request("http://akashinfotechdevelopment.com/php/json/delete.php", method: .post, parameters: parameters ).responseJSON { response in
            switch response.result {
            case .success(let JSON):
                //                    print("Success with JSON: \(JSON)")
                print("Request failed with error: \(response.response?.statusCode)")
                
                let response = JSON as! NSDictionary
                
                let flagVal = response.object(forKey: "flag") as! String
                
                if flagVal == "1"
                {
                    self.getUserList()
                    let alert = UIAlertController(title: "Alamofire", message: "User is Deleted.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }
                else
                {
                    let alert = UIAlertController(title: "Alamofire", message: "Error in user  delete.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
                
                print(response)
                break
                
            case .failure(let error):
                print("Request failed with error: \(error)")
                
                let alert = UIAlertController(title: "Alamofire", message: "Error in user  delete.", preferredStyle: UIAlertControllerStyle.alert)
                
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
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFeeds.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = tvFeedData.dequeueReusableCell(withIdentifier: "customCell") as! customCell
        
        cell.selectionStyle = .none;
        
        let dic = arrFeeds[indexPath.row] as! NSDictionary
        cell.lblDetail.text = NSString(format : "Surname : %@\nPhone : %@\nAddress : %@",dic.object(forKey: "sname") as! String,dic.object(forKey: "phone") as! String,dic.object(forKey: "address") as! String) as String
        //        [cell setDataForNewsFeed:arrFeeds[indexPath.row]];
        
        
        // set the text from the data model
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "viewAdd") as! viewAdd
        nextVC.nextDic = arrFeeds[indexPath.row] as! NSDictionary
        nextVC.isEdit = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let dic = arrFeeds[indexPath.row] as! NSDictionary
            
            
            self.arrFeeds.remove(dic)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tvFeedData.reloadData()
            
            let sid = dic.object(forKey: "sid") as! String
            DeleteUser(userId: sid)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnClcikAdd(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "viewAdd") as! viewAdd
        
        self.navigationController?.pushViewController(nextVC, animated: true)
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
