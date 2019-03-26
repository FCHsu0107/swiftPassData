//
//  ViewController.swift
//  SwiftPassData
//
//  Created by Huang YenHan on 2019/3/25.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import UIKit

protocol PassDataDelegate: class {
    
    func manager(_ vc: YHSecondViewController, didGet: String)
    
}


extension NSNotification.Name {
    
    static var yH = NSNotification.Name("toPageOneMessage")
    
    static var yH2 = NSNotification.Name("toPageSecondMessage")

}


class YHText: NSObject {
    
    @objc dynamic var text: String
    override init() {
        text = ""
        super.init()
    }
 
}

class ViewController: UIViewController, PassDataDelegate {
    
    

    func manager(_ vc: YHSecondViewController, didGet: String) {
        pageOneLabel.text = didGet
    }
    
    
    @IBOutlet weak var pageOneTextField: UITextField!
    @IBOutlet weak var pageOneLabel: UILabel!
    @IBOutlet weak var pageOneBtn: UIButton!
    let content = YHText()
    let content2 = YHText()
    var observation: NSKeyValueObservation?
    var secondVC: YHSecondViewController?
    weak var delegate: PassDataDelegateSecond?
    
    @IBAction func pageOneBtnPressed(_ sender: UIButton) {
        
        
        
        performSegue(withIdentifier: "toSecondPage", sender: self)
        
//        sendMessageToPageSecond(text: pageOneTextField.text ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // closure
//        secondVC?.closurePassText({ (text) in
//            pageOneLabel.text = text
//        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // KVO: vc1
        observation = content.observe(\.text, options: .new) {
            [weak self] content, change in

            self?.pageOneLabel.text = change.newValue
        }
        

        

        // Notification: 註冊 vc1 監聽
//        NotificationCenter.default.addObserver(self, selector: #selector(gotMessage(noti:)), name: NSNotification.Name.yH
//, object: nil)

    }
    
    @objc private func gotMessage(noti: Notification){
        pageOneLabel.text = noti.userInfo?["text"] as? String
    }
    
    func sendMessageToPageSecond (text: String){
        NotificationCenter.default.post(name: NSNotification.Name.yH2, object: nil, userInfo: ["text": text])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toSecondPage" {
            let vc = segue.destination as! YHSecondViewController
            vc.loadViewIfNeeded()
            
            // delegate
            vc.delegate = self
            
            // closure
//            secondVC = vc
            
            // property
//            vc.pageSecondLabel.text = pageOneTextField.text
            
            // KVO: 註冊 vc2 觀察者
            vc.observation = content2.observe(\.text, options: .new) {
                [weak vc] content, change in

                vc?.pageSecondLabel.text = change.newValue
            }

            content2.text = pageOneTextField.text ?? ""

            vc.contentKVO = content
            
            // Notification 註冊 vc2 監聽
            NotificationCenter.default.addObserver(vc, selector: #selector(gotMessage(noti:)), name: NSNotification.Name.yH2
                , object: nil)

            
        }
    }
    
    @IBAction func unwindToPageOne(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    
    
    @IBAction func presentBtnPressed(_ sender: UIButton) {
        
        let myStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let secondVC = myStoryBoard.instantiateViewController(withIdentifier: "secondPage") as? YHSecondViewController else {
            return
        }
        secondVC.loadViewIfNeeded()
        secondVC.firstVC = self
        // property:
        
//        secondVC.pageSecondLabel.text = pageOneTextField.text
        
        // closure:
       
        secondVC.closureFromVC1 = {
            secondVC.pageSecondLabel.text = self.pageOneTextField.text
        }
        
        secondVC.closureFromVC1?()
        // delegate:
        
//        self.delegate = secondVC
//
//        delegate?.manager(self, didGet: pageOneTextField.text ?? "")
        
        
        present(secondVC, animated:true, completion:nil)
        
    }
    
    
}

