//
//  JQNextPageViewController.swift
//  SwiftPassData
//
//  Created by Fu-Chiung HSU on 2019/3/25.
//  Copyright © 2019 HuangYenHan. All rights reserved.
//

import UIKit

class JQNextPageViewController: UIViewController {

    @IBOutlet weak var nextPageTextField: UITextField!
    
    @IBOutlet weak var nextPageText: UILabel!
    
    
    //1. Property
    var textInfo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. Property
        nextPageText.text = textInfo
    }
    

    @IBAction func backBtnAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }


}
