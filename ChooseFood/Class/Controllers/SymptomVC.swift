//
//  SymptomVC.swift
//  ChooseFood
//
//  Created by Tien on 2017/8/29.
//  Copyright © 2017年 Tien. All rights reserved.
//

import UIKit
import RealmSwift
class SymptomVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var isselected:[Int] = []
//    var selectIndex = [Int]()
    var cellAccType = [UITableViewCellAccessoryType](repeating: .none, count: Data().symptomArray.count)
    @IBOutlet var symptomView: SymptomView!
    var receiveUser = ""
    override func viewDidLoad() {
        super.viewDidLoad()        // Do any additional setup after loading the view.
        self.symptomView.symptomTV.dataSource = self
        self.symptomView.symptomTV.delegate = self
//        print(cellAccType)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data().symptomArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SymptomCell = tableView.dequeueReusableCell(withIdentifier: "SymptomCellID", for: indexPath) as! SymptomCell
        cell.symptomLable.text = Data().symptomArray[indexPath.row]
        cell.accessoryType = cellAccType[indexPath.row]
//        if selectIndex.contains(indexPath.row){
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let index = selectIndex.index(of: indexPath.row){
//            selectIndex.remove(at: index)
//        }else{
//            selectIndex.append(indexPath.row)
//        }
//        self.symptomView.symptomTV.reloadData()
        let cell = self.symptomView.symptomTV.cellForRow(at: indexPath)
    
        if cellAccType[indexPath.row] == .checkmark{
            cellAccType[indexPath.row] = .none
            cell?.accessoryType = cellAccType[indexPath.row]
            isselected.remove(at: isselected.index(of: indexPath.row)!)
        }else{
            cellAccType[indexPath.row] = .checkmark
            cell?.accessoryType = cellAccType[indexPath.row]
            isselected.append(indexPath.row)
        }
    }
    @IBAction func okBtnAction(_ sender: UIButton) {
        let realm = try! Realm()
        let realmUser = realm.objects(UserDetail.self).filter("logInID == '\(receiveUser)'")
//        try! realm.write {
//            realm.delete((realmUser.first?.symptoms)!)
//        }
        for i in isselected{
            let checkedSymptom = symptom()
            checkedSymptom.symptomName = Data().symptomArray[i]
            try! realm.write {
                realmUser.first?.symptoms.append(checkedSymptom)
            }
            
        }
        let mainStory:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = mainStory.instantiateViewController(withIdentifier: "HomeStoryID") as! UserHomeVC
        self.navigationController?.pushViewController(vc, animated: true)
        vc.receiveUser = self.receiveUser
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
