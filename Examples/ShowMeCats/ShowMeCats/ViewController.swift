//
//  ViewController.swift
//  ShowMeCats
//
//  Created by Abhijeet Mishra on 28/04/20.
//  Copyright © 2020 Abhijeet Mishra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedCats = [IndexPath]()
    
    var catImages:[String]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var jsonResponse:[[String: Any]]? {
        didSet {
            var tempImages = [String]()
            if let jsonResponse = jsonResponse {
                for catJSON in jsonResponse {
                    if let url = catJSON["url"] as? String  {
                        tempImages.append(url)
                    }
                }
            }
            catImages = tempImages
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let defaultSession = URLSession(configuration: .default)
        let dataTask = defaultSession.dataTask(with: URL(string: "https://api.thecatapi.com/v1/images/search?limit=15")!) { (data, _, _) in
            do {
                self.jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String : Any]]
            }
            catch {
                print("Error while fetching images")
            }
        }
        dataTask.resume()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catImages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let catTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: CatTableViewCell.self)) as? CatTableViewCell else {
            return UITableViewCell()
        }
        catTableViewCell.catImageURL = catImages?[indexPath.row]
        catTableViewCell.indexPath = indexPath
        catTableViewCell.accessoryType = selectedCats.contains(indexPath) ? .checkmark : .none
        return catTableViewCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedCats.contains(indexPath) {
            selectedCats = selectedCats.filter { $0.row != indexPath.row }
        }
        else {
            selectedCats.append(indexPath)
        }
       //here's where the auto scroll happens!
        tableView.makeSelectedCellVisible(for: indexPath)
        updateCellAtIndexPath(for: indexPath)
    }
    func updateCellAtIndexPath(for indexPath: IndexPath) {
        guard let catTableViewCell = tableView.cellForRow(at: indexPath) as? CatTableViewCell else {
            return
        }
        catTableViewCell.accessoryType = selectedCats.contains(indexPath) ? .checkmark : .none
    }
}

class CatTableViewCell: UITableViewCell {
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var indexPath: IndexPath?
    var catImageURL:String? {
        didSet {
            activityIndicatorView.startAnimating()
            if catImageView != nil {
                catImageView.image = nil
                DispatchQueue.global(qos: .background).async {
                    URLSession.shared.dataTask(with: URL(string: self.catImageURL!)!, completionHandler: { (data, _, error) in
                                       DispatchQueue.main.async {
                                           self.activityIndicatorView.stopAnimating()
                                           let image = data != nil ? UIImage(data: data!) : nil
                                           self.catImageView.image = image
                                       }
                                   }).resume()
                }
            }
        }
    }
}

