//
//  TopViewController.swift
//  Alamofire5_API
//
//  Created by 朱偉綸 on 2021/3/15.
//

import UIKit
import Alamofire

class TopViewController: UIViewController {

    
    let app_id = "775ef7b9e6cc94753db2a7b706e7bb027450a68e"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        response()
    }
    
    
    func response(){
        let api_url = "http://api.e-stat.go.jp/rest/3.0/app/json/getStatsData?appId=\(app_id)&lang=J&statsDataId=0003353750&metaGetFlg=Y&cntGetFlg=N&explanationGetFlg=Y&annotationGetFlg=Y&sectionHeaderFlg=1"
        let url = URL(string: api_url)!
        let urlRequest = URLRequest(url: url)
        AF.request(urlRequest).responseJSON { (response) in
            let result = response.result
            print(result,"test")
            debugPrint(response)
            
            // do stuff with JSON or error
        }
    }
    
    func response2(){
        let api_url = "http://api.e-stat.go.jp/rest/3.0/app/json/getStatsData?appId=\(app_id)&lang=J&statsDataId=0003353750&metaGetFlg=Y&cntGetFlg=N&explanationGetFlg=Y&annotationGetFlg=Y&sectionHeaderFlg=1"
        let url = URL(string: api_url)!
        let urlRequest = URLRequest(url: url)
        
        
    }
    
    
    
    
    
    
    


}

