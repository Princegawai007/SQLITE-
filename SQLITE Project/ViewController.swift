//
//  ViewController.swift
//  SQLITE Project
//
//  Created by Prince's Mac on 30/07/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var personTableView: UITableView!
    var db: DBHelper = DBHelper()
    var persons: [Person] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        personTableView.dataSource = self
        personTableView.delegate = self
        insert()
        readFromDatabase()
    }
    func insert() {
        db.insertData(id: 1, name: "Vaibhav", age: 30)
        db.insertData(id: 2, name: "Sakshi", age: 21)
    }
    func readFromDatabase(){
        persons = db.read()
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.personTableView.dequeueReusableCell(withIdentifier: "BasicCell")
        cell?.textLabel?.text = "Id : " + "--" + String(persons[indexPath.row].id)
        return cell!
    }
}
extension ViewController: UITableViewDelegate{
}

