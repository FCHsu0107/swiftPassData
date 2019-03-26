//
//  YHSecondViewController.swift
//  SwiftPassData
//
//  Created by Huang YenHan on 2019/3/25.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import UIKit

protocol PassDataDelegateSecond: class {
    
    func manager(_ vc: ViewController, didGet: String)
    
}


class YHSecondViewController: UIViewController, PassDataDelegateSecond {
    
    
    func manager(_ vc: ViewController, didGet: String) {
        pageSecondLabel.text = didGet
    }
    

    @IBOutlet weak var pageSecondTextField: UITextField!
    
    @IBOutlet weak var pageSecondLabel: UILabel!
    
    @IBOutlet weak var pageSecondBtn: UIButton!
    
    weak var delegate: PassDataDelegate?
    var text: String?
    var contentKVO: YHText?
    var observation: NSKeyValueObservation?
    var firstVC: ViewController?
    var closureFromVC1: (() -> Void)?
    
    
    @IBAction func pageSecondBtnPressed(_ sender: UIButton) {
        
        // delegate
//        delegate?.manager(self, didGet: pageSecondTextField.text ?? "")
        
        // KVO
        contentKVO?.text = pageSecondTextField.text ?? ""
        
        // Notification
//        sendMessageToPageOne(text: pageSecondTextField.text ?? "")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    func sendMessageToPageOne (text: String){
        NotificationCenter.default.post(name: NSNotification.Name.yH, object: nil, userInfo: ["text": text])
    }
    
    @objc private func gotMessage(noti: Notification){
        
        pageSecondLabel?.text = noti.userInfo?["text"] as? String
        
        
    }

    private func closurePassText(_ handler: (String) -> Void) {
        
        let text = pageSecondTextField.text ?? ""
        
        handler(text)
    }
    
    deinit {
        print("vc2 is killed")
    }

}
