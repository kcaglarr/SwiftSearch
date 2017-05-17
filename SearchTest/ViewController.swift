//
//  ViewController.swift
//  SearchTest
//
//  Created by Kerim on 5/9/17.
//  Copyright © 2017 Kerim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var cities = [String]()
    var citiesFiltered = [String]()
    var searchBarActive:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cities = ["Adana","Adıyaman","Afyon","Ağrı","Amasya","Balıkesir","Bolu","Bilecik","Denizli","Eskişehir","İzmir","İstanbul"]
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(searchBarActive && citiesFiltered.count == 0){
            return 1
        }
        else if(searchBarActive) {
           return self.citiesFiltered.count
        }
        return cities.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        if(searchBarActive && citiesFiltered.count == 0){
            cell.textLabel?.text = "Aradığınız sonuç bulunamadı"
        }
        else if searchBarActive {
            cell.textLabel?.text = citiesFiltered[indexPath.row]
        }
        else{
            cell.textLabel?.text = cities[indexPath.row]
        }
        
        return cell
    }
    
    //Searcbar işlemleri
    
    //Arama işleminin aktif olduğu durum
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBarActive = true
    }
    
    //Arama İşleminin aktif olmadığı durumlar
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBarActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarActive = false
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        searchBarActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        citiesFiltered = cities.filter({ (text) -> Bool in
            let txt : NSString = text as NSString
            let range = txt.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            
            return range.location != NSNotFound
        })
        
        self.tableView.reloadData()
    }
}

