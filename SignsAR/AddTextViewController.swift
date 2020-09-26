//
//  AddTextViewController.swift
//  SignsAR
//
//  Created by Alexey on 27.09.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit
protocol SetText {
    func setText(text: String)
}
class AddTextViewController: UIViewController {
    var delegate: SetText?
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var readyButton: UIButton!
    @IBAction func pressReadyButton(_ sender: Any) {
        let pureText = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if pureText != ""{
            dismiss(animated: true, completion:{
                self.delegate?.setText(text: pureText!)
            })
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    

}
