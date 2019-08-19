//
//  MenuViewController.swift
//  WKWebview
//
//  Created by hackeru on 19/08/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    enum MenuCatgorty: Int {
        case health
        case finance
        case sport
        case googleInSafari
    }
    
    var didTapMenu: ((MenuCatgorty)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuCatgorty.init(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.didTapMenu?(menuType)
        }
    }

}
