//
//  JacquelineViewController.swift
//  SwiftPassData
//
//  Created by Fu-Chiung HSU on 2019/3/25.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import UIKit

//KVO
class TextInfo: NSObject {
    @objc dynamic var textInfo = String()
}

//delegate

class JacquelineViewController: UIViewController {

    @IBOutlet weak var firstTextField: UITextField!
    
    @IBOutlet weak var fitstPageText: UILabel!
    
    //1. Property
    var nextPageTextInfo: String?

    //KVO
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //1. Property
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextPageSegue" {
            if let vc = segue.destination as? JQNextPageViewController {
                vc.textInfo = firstTextField.text
            }
        }
    }
    
    @IBAction func nextPage(_ sender: Any) {
    //1. Property
       self.performSegue(withIdentifier: "nextPageSegue", sender: nil)

    }
}
