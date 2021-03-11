//
//  UserHomeVC.swift
//  ChooseFood
//
//  Created by Tien on 2017/8/27.
//  Copyright © 2017年 Tien. All rights reserved.
//

import UIKit
import RealmSwift
class UserHomeVC: UIViewController {
    @IBOutlet var userHomeView: UserHomeView!
    var receiveUser = ""
    var physiArr:[Int] = []
    var symArr:[Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        let realmUser = realm.objects(UserDetail.self).filter("logInID == '\(receiveUser)'").first!
        if realmUser.physiques.count == 0 && realmUser.symptoms.count == 0{
            self.userHomeView.homeViewTextV.text = "您尚未設定個人資料"
        }else if realmUser.physiques.count != 0{
            self.userHomeView.homeViewTextV.text.removeAll()
            self.userHomeView.homeViewTextV.text.append("你的體質為:")
            var addstring = ""                          //被加字串
            for i in 0..<realmUser.physiques.count{
                addstring = "\(realmUser.physiques[i].physiqueName)"
                self.userHomeView.homeViewTextV.text.append("\n\(addstring)")//字串插入
                for j in 0..<Data().physiqueArray.count{
                    if addstring == Data().physiqueArray[j]{ //取得體質index
                        physiArr.append(j)
                    }
                }
                
            }
            self.userHomeView.homeViewTextV.text.append("=============================\n可能要注意的作息有:\n\n")
            for j in 0..<physiArr.count{
                self.userHomeView.homeViewTextV.text.append("\(Data().allergyArray[j])\n\n")
            }
            self.userHomeView.homeViewTextV.text.append("=============================\n\n該怎麼吃呢？\n\n")
            for j in 0..<physiArr.count{
                self.userHomeView.homeViewTextV.text.append("\(Data().howtoeat[j])\n\n")
            }
            self.userHomeView.homeViewTextV.text.append("=============================")
        }
        else{
            self.userHomeView.homeViewTextV.text.removeAll()
            self.userHomeView.homeViewTextV.text.append("你的體質為:")
            var addstring = ""
            var checkPhysique:[Int] = []
            for i in 0..<realmUser.symptoms.count{
                for j in 0..<Data().symptomArray.count{
                    if realmUser.symptoms[i].symptomName == Data().symptomArray[j]{
                        checkPhysique.append(j)//取得所有症狀的Index
                    }
                }
            }
            var counterArr:[Int] = []
            var counter = 0
            for x in 0..<Data().SymInPhy.count{   //算出症狀在各體質有幾個
                counter = 0
                for i in 0..<Data().SymInPhy[x].count{
                    for j in 0..<checkPhysique.count{
                        if checkPhysique[j] == Data().SymInPhy[x][i]{
                            counter += 1
                        }
                    }
                }
                counterArr.append(counter)
            }
            for i in 0..<counterArr.count{
                if counterArr[i] > Data().SymInPhy[i].count/3{
                    addstring = Data().physiqueArray[i]
                    self.userHomeView.homeViewTextV.text.append("\n\(addstring)")
                    physiArr.append(i)
                }
            }
            self.userHomeView.homeViewTextV.text.append("=============================\n可能要注意的作息有:\n\n")
            for j in 0..<physiArr.count{
                self.userHomeView.homeViewTextV.text.append("\(Data().allergyArray[j])\n\n")
            }
            self.userHomeView.homeViewTextV.text.append("=============================\n\n該怎麼吃呢？\n\n")
            for j in 0..<physiArr.count{
                self.userHomeView.homeViewTextV.text.append("\(Data().howtoeat[j])\n\n")
            }
            self.userHomeView.homeViewTextV.text.append("=============================")
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func changeDataBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "changeDataID", sender: nil)
        let realm = try! Realm()
        let realmUser = realm.objects(UserDetail.self).filter("logInID == '\(receiveUser)'").first!
        try! realm.write {
            realm.delete(realmUser.symptoms)
            realm.delete(realmUser.physiques)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeDataID"{
            let target = segue.destination as! SettingVC
            target.receiveUser = self.receiveUser
        }
    }
    @IBAction func recipeBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "recipeID", sender: nil)
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
