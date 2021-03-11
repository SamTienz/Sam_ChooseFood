//
//  PhysiqueVC.swift
//  ChooseFood
//
//  Created by Tien on 2017/8/28.
//  Copyright © 2017年 Tien. All rights reserved.
//

import UIKit
import RealmSwift
class PhysiqueVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var physiqueView: PhysiqueView!
    var receiveUser = ""
    var isselected:[Int] = []
    var cellAccType:[UITableViewCellAccessoryType] = [UITableViewCellAccessoryType](repeating: .none, count: Data().physiqueArray.count)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.physiqueView.physiqueTV.delegate = self
        self.physiqueView.physiqueTV.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data().physiqueArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PhysiqueCell = tableView.dequeueReusableCell(withIdentifier: "physiqueCellID", for: indexPath)as! PhysiqueCell
        cell.physiqueCellLabel.text = Data().physiqueArray[indexPath.row]
        cell.accessoryType = cellAccType[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.physiqueView.physiqueTV.cellForRow(at: indexPath)
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
    @IBAction func OKBtnAction(_ sender: UIButton) { //確認按下
        let realm = try! Realm()
        let realmUser = realm.objects(UserDetail.self).filter("logInID == '\(receiveUser)'").first
        
        realm.beginWrite()

    
//        realm.delete((realmUser?.physiques)!)
        
        for i in isselected{
            let checkedPhysique = physique()
            checkedPhysique.physiqueName = Data().physiqueArray[i] //取得點選體質
                realmUser?.physiques.append(checkedPhysique)
            
        }
    
        try! realm.commitWrite()
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeStoryID") as! UserHomeVC
        self.navigationController?.pushViewController(vc, animated: true)
        vc.receiveUser = self.receiveUser
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
