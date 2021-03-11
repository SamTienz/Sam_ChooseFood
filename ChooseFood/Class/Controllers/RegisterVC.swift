//
//  RegisterVC.swift
//  ChooseFood
//
//  Created by Tien on 2017/8/27.
//  Copyright © 2017年 Tien. All rights reserved.
//

import UIKit
import RealmSwift
class RegisterVC: UIViewController {
    
    @IBOutlet var registerView: RegisterView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func okBtnAction(_ sender: UIButton) {
        if self.registerView.userNameTF.text == "" || self.registerView.userNameTF.text == "使用者名稱"{
            let aswNotAlertController = UIAlertController.init(title: "提示", message: "請輸入使用者名稱", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "確認", style: .default, handler: {(action:UIAlertAction) -> Void in})
            aswNotAlertController.addAction(okAction)
            self.present(aswNotAlertController,animated: true,completion: nil)
            self.registerView.pswCheckTF.text = "確認密碼"
        }else if self.registerView.logInIDTF.text == "" || self.registerView.logInIDTF.text == "登入ＩＤ"{
            let aswNotAlertController = UIAlertController.init(title: "提示", message: "請輸入登入ＩＤ", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "確認", style: .default, handler: {(action:UIAlertAction) -> Void in})
            aswNotAlertController.addAction(okAction)
            self.present(aswNotAlertController,animated: true,completion: nil)
            self.registerView.pswCheckTF.text = "確認密碼"
        }else if self.registerView.passwordTF.text == "" || self.registerView.passwordTF.text == "密碼"{
            let aswNotAlertController = UIAlertController.init(title: "提示", message: "請輸入密碼", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "確認", style: .default, handler: {(action:UIAlertAction) -> Void in})
            aswNotAlertController.addAction(okAction)
            self.present(aswNotAlertController,animated: true,completion: nil)
            self.registerView.pswCheckTF.text = "確認密碼"
        }
        else if self.registerView.passwordTF.text == self.registerView.pswCheckTF.text{
            let realm = try! Realm()
            let register = UserDetail()
            register.userName = self.registerView.userNameTF.text!
            register.logInID  = self.registerView.logInIDTF.text!
            register.password = self.registerView.passwordTF.text!
            
            try! realm.write {
                realm.add(register, update: true)
            }
            let aswNotAlertController = UIAlertController.init(title: "提示", message: "註冊成功！！！", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "確認", style: .default, handler: {(action:UIAlertAction) -> Void in
                self.performSegue(withIdentifier: "registerDoneID", sender: nil)
            })
            aswNotAlertController.addAction(okAction)
            self.present(aswNotAlertController, animated: true, completion: nil)
        }
        else {
            let aswNotAlertController = UIAlertController.init(title: "提示", message: "密碼與確認密碼不同", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "確認", style: .default, handler: {(action:UIAlertAction) -> Void in})
            aswNotAlertController.addAction(okAction)
            self.present(aswNotAlertController,animated: true,completion: nil)
            self.registerView.pswCheckTF.text = "確認密碼"
        }
    }
    @IBAction func nameEditBegin(_ sender: UITextField) {
        self.registerView.userNameTF.text=""
    }
    @IBAction func idEditBegin(_ sender: UITextField) {
        self.registerView.logInIDTF.text=""
    }
    @IBAction func pswEditBegin(_ sender: UITextField) {
        self.registerView.passwordTF.text=""
        self.registerView.passwordTF.isSecureTextEntry = true
    }
    @IBAction func pswChEditBegin(_ sender: UITextField) {
        self.registerView.pswCheckTF.text=""
        self.registerView.pswCheckTF.isSecureTextEntry = true
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
