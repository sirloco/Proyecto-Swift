//
//  TableViewController.swift
//  Agotador
//
//  Created by  on 21/02/2020.
//  Copyright © 2020 relar. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    @IBOutlet weak var resultado: UILabel!
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    var tiempo: String = ""
    var distancia: Double = 0

    
    resultado.text = String(format: " %.2f metros en ", distancia) + tiempo
        // Do any additional setup after loading the view.
        movidaLista()
    }


    class tramo: Object {
      @objc dynamic var distancia = 0.0
      @objc dynamic var tiempo = ""
      @objc dynamic var created = Date()
    }
    
    @objc dynamic var listado: Listado!
    

    let realm = try! Realm()
var lista: Results<Listado> = { self.realm.objects(Listado.self) }()

    private func movidaLista() {
      if lista.count == 0 { // 1
        try! realm.write() { // 2
          let defaultCategories =
            ["Birds", "Mammals", "Flora", "Reptiles", "Arachnids" ] // 3
          
          for category in defaultCategories { // 4
            let nuevaLista = Listado()
            nuevaLista.nombre = category
            
            realm.add(nuevaLista)
          }
        }
        
        lista = realm.objects(Listado.self) // 5
      }
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
