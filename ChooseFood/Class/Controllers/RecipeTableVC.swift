//
//  RecipeTableVC.swift
//  ChooseFood
//
//  Created by Tien on 2017/8/31.
//  Copyright © 2017年 Tien. All rights reserved.
//

import UIKit

class RecipeTableVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var recipeTView: RecipeTView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recipeTView.recipeTableView.delegate = self
        self.recipeTView.recipeTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:recipeCell = tableView.dequeueReusableCell(withIdentifier: "recipeCellID", for: indexPath) as! recipeCell
        cell.recipeCellLabel.text = "繽紛炒飯"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goRecipeDetail", sender: nil)
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
