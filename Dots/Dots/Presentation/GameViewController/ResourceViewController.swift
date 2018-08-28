//
//  ResourceViewController.swift
//  Dots
//
//  Created by Giovani Nascimento Pereira on 28/08/18.
//  Copyright © 2018 Giovani Nascimento Pereira. All rights reserved.
//

import UIKit

class ResourceViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.clipsToBounds = true
        self.view.layer.cornerRadius = 10
    }
}

extension ResourceViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return PlayerResources.allResources.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Defense Items" : "Attack"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resourceCell")
            as? ResourceTableViewCell else { return UITableViewCell() }
        cell.resources = PlayerResources.allResources[indexPath.section]
        return cell
    }
    
}
