//
//  MainVC.swift
//  ChooseFood
//
//  Created by Tien on 2017/8/27.
//  Copyright © 2017年 Tien. All rights reserved.
//

import UIKit
import RealmSwift
class MainVC: UIViewController {
    @IBOutlet var mainView: MainView!
    override func viewDidLoad() {
        print(Realm.Configuration.defaultConfiguration.fileURL)
        super.viewDidLoad()
        self.mainView.registerBtn.layer.cornerRadius = 5
        self.mainView.logInBtn.layer.cornerRadius = 5
        //print(Data().SymInPhy[0].count)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func registerBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "showRegisterID", sender: nil)
    }
    @IBAction func loginAction(_ sender: Any) {
        let realm = try! Realm()
        let realmId = realm.objects(UserDetail.self).filter("logInID == '\(self.mainView.accountTField.text!)'")
        if self.mainView.accountTField.text == "" || self.mainView.accountTField.text == "登入ＩＤ"{
            let logSucessAlert = UIAlertController.init(title: "Error", message: "請輸入帳號", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "OK", style: .default, handler: {(action:UIAlertAction!) -> Void in
            })
            logSucessAlert.addAction(okAction)
            self.present(logSucessAlert, animated: true, completion: nil)
        }
        else if realmId[0].password == self.mainView.pswTField.text {
            performSegue(withIdentifier: "logInDoneID", sender: nil)
        }
        else{
            let logSucessAlert = UIAlertController.init(title: "失敗", message: "密碼錯誤", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "OK", style: .default, handler: {(action:UIAlertAction!) -> Void in
            })
            logSucessAlert.addAction(okAction)
            self.present(logSucessAlert, animated: true, completion: nil)
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logInDoneID"{
            let target = segue.destination as! UserHomeVC
            target.receiveUser = self.mainView.accountTField.text!
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func acTFEditBegin(_ sender: UITextField) {
        self.mainView.accountTField.text = ""
    }
    @IBAction func pswTFEditBegin(_ sender: UITextField) {
        self.mainView.pswTField.text = ""
        self.mainView.pswTField.isSecureTextEntry = true
    }
    
    

}
