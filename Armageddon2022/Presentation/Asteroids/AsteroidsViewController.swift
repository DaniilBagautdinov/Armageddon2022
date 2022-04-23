//
//  ViewController.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 22.04.2022.
//

import UIKit

class AsteroidsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var network = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func filterButton(_ sender: Any) {
        
    }
    
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        network.getAsteroids { asteroids in
            print(asteroids.nearEarthObjects?.values)
        }
    }
}

extension AsteroidsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
