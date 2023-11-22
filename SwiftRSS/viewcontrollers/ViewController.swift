//
//  ViewController.swift
//  SwiftRSS
//
//  Created by Angelos Staboulis on 20/11/23.
//

import UIKit
import SWXMLHash
import Foundation
import SwiftUI
import SafetyKit
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var viewModel = RSSViewModel()
    var list:[RSSModel] = []{
        didSet{
            tableView.reloadData()
        }
    }
    @IBOutlet weak var btnShowList: UIButton!
    @IBOutlet weak var txtFeedURL: UITextField!
    @IBAction func btnShowList(_ sender: Any) {
        fillArrayWithValues()
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewController()
        // Do any additional setup after loading the view.
    }


}

extension ViewController{
    func fillArrayWithValues(){
        Task{
            if list.count > 0 {
                list.removeAll()
                list.append(contentsOf:await viewModel.showRSS(rssString:txtFeedURL.text!))
            }else{
                list.append(contentsOf:await viewModel.showRSS(rssString:txtFeedURL.text!))
            }
        }
    }
    func initialViewController(){
        btnShowList.layer.cornerRadius = 15
        btnShowList.backgroundColor = UIColor.systemBlue
        btnShowList.setTitle("ShowList", for: .normal)
        btnShowList.setTitleColor(UIColor.white, for: .normal)
        self.navigationItem.title = "SwiftRSS Demo"
        tableView.register(UINib(nibName: "RSSCell", bundle:nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    func loadValuesInCell(indexPath:IndexPath)->UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RSSCell
        if indexPath.row < list.count{
            cell.lblTitle.numberOfLines = 0
            cell.lblTitle.text = list[indexPath.row].title
            cell.lblPubDate.text = String(describing:list[indexPath.row].pubDate.dropLast(5))
            cell.CmdLink.setTitle("Ανάγνωση Αρθρου", for: .normal)
            cell.CmdLink.tag = indexPath.row
            cell.CmdLink.addTarget(self, action: #selector(openArticle(button:)), for: .touchDown)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      return loadValuesInCell(indexPath: indexPath)
    }
    @objc func openArticle(button:UIButton){
        UIApplication.shared.openURL(URL(string: list[button.tag].link)!)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
}
