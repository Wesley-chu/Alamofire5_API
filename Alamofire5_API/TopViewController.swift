//
//  TopViewController.swift
//  Alamofire5_API
//
//  Created by 朱偉綸 on 2021/3/15.
//

import UIKit
import Alamofire
import PromiseKit

class TopViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var rateTv: UITableView!
    
    var rateItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        rateTv.delegate = self
        rateTv.dataSource = self
        
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            self.getRate()
        })
        //getRate2()
    }
    
    func getRate(){
        firstly {
            APIManager.shared.callForItem(request: Router.getRate, queue: .main)
        }.done { [self] data in

            if let getDate = data["datetime"] as? String {
                dateLb.text = getDate
            }
            
            if let getRate = data["rate"] as? Item{
                var arr = [String]()
                getRate.keys.sorted(by: {$0 < $1})
                    .map {
                        if let value = getRate[$0]{
                            if let value = value {
                                arr.append("\($0)       \(value)")
                            }
                        }
                    }
                rateItems = arr
                rateTv.reloadData()
            }
        }.catch { error in
            print(error)
        }
    }
    
    func getRate2(){
        APIManager.shared.call(request: Router.getRate, queue: .main) { [self] res in
            switch res {
            case .success(let item):
                if let getDate = item["datetime"] as? String {
                    dateLb.text = getDate
                }
                
                if let getRate = item["rate"] as? Item{
                    var arr = [String]()
                    getRate.keys.sorted(by: {$0 < $1})
                        .map {
                            if let value = getRate[$0]{
                                if let value = value {
                                    arr.append("\($0)       \(value)")
                                }
                            }
                        }
                    rateItems = arr
                    rateTv.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rateItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = rateItems[indexPath.row]
        
        return cell
    }
    
    
    
    


}

