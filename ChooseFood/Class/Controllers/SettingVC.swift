//
//  SettingVC.swift
//  ChooseFood
//
//  Created by Tien on 2017/8/28.
//  Copyright © 2017年 Tien. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    var receiveUser = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func phySetBtnAction(_ sender: Any) {
        performSegue(withIdentifier: "physiqueID", sender: nil)
    }
    @IBAction func symSetBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "symptomID", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "physiqueID"{
            let target = segue.destination as! PhysiqueVC
            target.receiveUser = self.receiveUser
        }
        else if segue.identifier == "symptomID"{
            let target = segue.destination as! SymptomVC
            target.receiveUser = self.receiveUser
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
