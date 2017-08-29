//
//  ChatsViewController.swift
//  TestfulApp
//
//  Created by Nick Melnick on 8/28/17.
//  Copyright © 2017 Nick Melnick. All rights reserved.
//

import UIKit
import CoreData

class ChatsViewController: UITableViewController {

    var viewModel: ChatsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
        let nib = UINib(nibName: "ChatsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ChatsCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 95
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let vm = viewModel else {
            return 0
        }
        return vm.numbersOfSection()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else {
            return 0
        }
        return vm.rowsInSection(section)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatsCell", for: indexPath) as! ChatsCell

        let vm = viewModel?.viewModelForRow(atIndexPath: indexPath)
        cell.setup(withViewModel: vm)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ChatsViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
    
}
