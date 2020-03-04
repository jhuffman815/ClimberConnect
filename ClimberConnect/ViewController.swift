//
//  ViewController.swift
//  ClimberConnect
//
//  Created by Jewell Huffman on 3/2/20.
//  Copyright © 2020 Jewell Huffman. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating {
    var members = [Member]()
    var filteredMembers = [Member]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find a member"
        search.searchResultsUpdater = self
        navigationItem.searchController = search
       
        DispatchQueue.global().async {
            do {
                let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let downloadedMembers = try decoder.decode([Member].self, from: data)
                
                DispatchQueue.main.async {
                    self.members = downloadedMembers
                    self.filteredMembers = downloadedMembers
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
        return filteredMembers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let member = filteredMembers[indexPath.row]
        
        cell.textLabel?.text = member.name
        cell.detailTextLabel?.text = member.friends.map { $0.name }.joined(separator: ", ")
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 0 {
            filteredMembers = members.filter {
                $0.name.contains(text)
                || $0.company.contains(text)
                || $0.address.contains(text)
            }
        } else {
            filteredMembers = members
        }
        
        tableView.reloadData()
    }
}

