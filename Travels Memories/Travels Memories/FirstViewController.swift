//
//  FirstViewController.swift
//  Travels Memories
//
//  Created by Emircan saglam on 7.07.2022.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,UISearchBarDelegate{
    
    let context = appDelegate.persistentContainer.viewContext
    var coreDataList = [BigData]()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround() 
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getAllData()
        tableView.reloadData()
    }
    
    func getAllData() {
        do {
            coreDataList = try context.fetch(BigData.fetchRequest())
        }catch {
            print("error")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        
        if segue.identifier == "toDetail" {
            let chosenVC = segue.destination as! DetailViewController
            chosenVC.detailData = coreDataList[index!]
        }
        
        if segue.identifier == "toUpdate" {
            let chosenVc = segue.destination as! UpdateViewController
            chosenVc.updateData = coreDataList[index!]
        }
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, boolValue in
            let data = self.coreDataList[indexPath.row]
            self.context.delete(data)
            appDelegate.saveContext()
            self.getAllData()
            self.tableView.reloadData()
            
        }
        let updateAction = UIContextualAction(style: .normal, title: "Update") { contextualAction, view, boolValue in
            self.performSegue(withIdentifier: "toUpdate", sender: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction,updateAction])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FirstTableViewCell
        let minData = coreDataList[indexPath.row]
        cell.dateLabel.text = minData.place
        
        cell.imageViewCell.image = UIImage(data: minData.image!)
        
        
        
        
        return cell
    }
    func makeSearch(place: String) {
        let fetchRequest:NSFetchRequest<BigData> = BigData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "place CONTAINS %@", place)
        
        
        do {
            coreDataList = try context.fetch(fetchRequest)
        } catch  {
            print(error)
        }
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Arama Sonuç : \(searchText)")
        
        if searchText == "" {
            getAllData()
        }else{
            makeSearch(place: searchText)
        }
        
        tableView.reloadData()
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
   

}



extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
