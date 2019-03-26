//
//  JQNextPageViewController.swift
//  SwiftPassData
//
//  Created by Fu-Chiung HSU on 2019/3/25.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import UIKit

//vc2 to vc1 delegate
protocol secondPageTextDelegate: AnyObject {
    func getSecondText(_ vc: JQNextPageViewController, didGet value: String)
}

class JQNextPageViewController: UIViewController {
    
    @IBOutlet weak var nextPageTextField: UITextField!
    
    @IBOutlet weak var pageInfoText: UILabel!
    
    //vc2 to vc1 delegate
//    weak var delegate: secondPageTextDelegate?
    
    //vc1 to vc2 Property
    var textInfo: String?
    
    //vc2 to vc1 KVO
    @objc dynamic var secondPageTitle = String()
    
    //vc2 to vc1 closure
    var onSave: ((_ data: String ) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //vc1 to vc2 Property
//        nextPageText.text = textInfo
        
    }
    

    @IBAction func backBtnAction(_ sender: Any) {

        guard let textInfo = nextPageTextField.text else { return }
        print(textInfo)
        
        //vc2 to vc1 delegate
//        self.delegate?.getSecondText(self, didGet: textInfo)
        
        //vc2 to vc1 notification
//        notificationSecondPage(text: textInfo)
        
        //vc2 to vc1 KVO
//        secondPageTitle = textInfo
        
        //vc2 to vc1 Closure
        onSave?(textInfo)
        
        //popView
        navigationController?.popViewController(animated: true)
    }

    //vc2 to vc1 notification
//    func notificationSecondPage(text: String){
//        NotificationCenter.default.post(name: Notification.Name("secondPageInfo"), object: nil, userInfo: ["text": text])
//    }
    
    //vc2 to vc1 notification
//    @objc func getTextInfo(data: Notification) {
//        pageInfoText.text = data.userInfo?["text"] as? String
//    }
    
    //vc1 to vc2 KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "firstPageTitle" {
            guard let updateText = change?[.newKey] as? String else { return }
            pageInfoText.text = updateText
            
            guard let vc = object as? JacquelineViewController else {return}
            vc.removeObserver(self, forKeyPath: "firstPageTitle")
        }
    }


}
