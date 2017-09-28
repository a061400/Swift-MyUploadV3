//
//  ViewController.swift
//  MyUploadV3
//
//  Created by 謝尚霖 on 2017/9/27.
//  Copyright © 2017年 謝尚霖. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBAction func upload(_ sender: Any) {
        let image = UIImage(named: "pic007.jpg")
        let imgData = UIImageJPEGRepresentation(image!, 1)
        
        let args:[String:String] = ["username":"brad"]
        
        
        Alamofire.upload(multipartFormData: {mdata in
            // 此處處理上傳資料
            mdata.append(imgData!, withName: "upload", fileName: "pic007.jpg", mimeType: "image/jpeg")
            
            // 此處將參數加上來
            for (key,value) in args {
                mdata.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: "http://10.2.24.168/iii05.php") {
            (result) in
            // 回來
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("\(progress.fractionCompleted)")
                })
            default:
                print("--")
            }
            
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("http://10.2.24.168/iii06.php").response {
            (response) in
            
            //            print("Request: \(response.request!)")
            //            print("Response: \(response.response!)")
            //
            //            if let _ = response.error {
            //                print("Error: \(response.error)")
            //            }
            
            let data = response.data
            let result = String(data: data!, encoding: String.Encoding.utf8)
            print("result: \(result!)")
            
        }
        
        
    }
    
}
