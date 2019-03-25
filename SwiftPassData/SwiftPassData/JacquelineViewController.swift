//
//  JacquelineViewController.swift
//  SwiftPassData
//
//  Created by Fu-Chiung HSU on 2019/3/25.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import UIKit

//vc1 to vc2 KVO
class FirstTextInfo: NSObject {
    @objc dynamic var textInfo = String()
    
    override init() {
        self.textInfo = " "
        super.init()
    }
}

//vc2 to vc1 KVO
class SecondTextInfo: NSObject {
    @objc dynamic var textInfo = String()
    
    override init() {
        self.textInfo = " "
        super.init()
    }
}


class JacquelineViewController: UIViewController
// ,secondPageTextDelegate
{
    
    @IBOutlet weak var firstTextField: UITextField!
    
    @IBOutlet weak var pageInfoText: UILabel!
    
    var secondText: String?
    
    //vc1 to vc2 KVO
    @objc var firstTextInfo = FirstTextInfo()
    
    //vc2 to vc1 KVO
    @objc var secondTextInfo = SecondTextInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //vc2 to vc1 notification
//        NotificationCenter.default.addObserver(self, selector: #selector(getTextInfo(data:)), name: NSNotification.Name("secondPageInfo") , object: nil)
        
        //vc2 to vc1 KVO
        addObserver(self, forKeyPath: #keyPath(secondTextInfo.textInfo), options: .new, context: nil)
    
    }
    
    //vc2 to vc1 notification
//    @objc func getTextInfo(data: Notification) {
//        pageInfoText.text = data.userInfo?["text"] as? String
//        print("-----notification-----")
//    }
//

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextPageSegue" {
            let vc = segue.destination as! JQNextPageViewController
            vc.loadViewIfNeeded()
            
            //vc1 to vc2 Property
//            vc.textInfo = firstTextField.text
            
            //vc2 to vc1 delegate
//            vc.delegate = self
            
            //vc1 to vc2 notificaiton
//            NotificationCenter.default.addObserver(vc, selector: #selector(getTextInfo(data:)), name: NSNotification.Name(rawValue: "firstPageInfo"), object: nil)
        }

    }
    
    //vc2 to vc1 delegate
//    func getSecondText(_ vc: JQNextPageViewController, didGet value: String) {
//        secondText = value
//    }
    
    //vc2 to vc1 delegate
//    override func viewWillAppear(_ animated: Bool) {
//        guard  secondText != nil else { return }
//        firstPageText.text = secondText
//    }

    //vc1 to vc2 notification
//    func notificationFirstPage(text: String) {
//        NotificationCenter.default.post(name: Notification.Name("firstPageInfo"), object: nil, userInfo: ["text": text])
//    }
    
    
    @IBAction func nextPage(_ sender: Any) {
        self.performSegue(withIdentifier: "nextPageSegue", sender: nil)
        
        //vc1 to vc2 notification
//        guard let textInfo = firstTextField.text else { return }
//        notificationFirstPage(text: textInfo)
        
    }
    
    //vc2 to vc1 KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(secondTextInfo.textInfo) {
            guard let updateText = change?[.newKey] as? String else { return }
            pageInfoText.text = updateText 
        }
    }
}


