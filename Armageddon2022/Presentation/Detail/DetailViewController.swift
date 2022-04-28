//
//  DetailViewController.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 28.04.2022.
//

import UIKit

class DetailViewController: UIViewController {
    ///Properties
    var asteroid: Asteroid?
    var distanceInKilometers: Bool?
    var closeApproachData: [CloseApproachData]?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            if ((closeApproachData?.isEmpty) != nil) {
                guard let detailView = view as? DetailView else { return }
                closeApproachData = DataService.shared.getCloseApproachData(id: asteroid?.id ?? "")
                detailView.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Private functions
    
    private func configureView() {
        guard let detailView = view as? DetailView else { return }
        guard let asteroid = asteroid else { return }
        guard let distanceInKilometers = distanceInKilometers else { return }
        navigationController?.navigationBar.topItem?.backButtonTitle = "Назад"
        detailView.tableView.delegate = self
        detailView.tableView.dataSource = self
        navigationItem.title = setName(asteroid: asteroid)
        detailView.diameterLabel.text = "Диаметр: \(Int((asteroid.diameterMax + asteroid.diameterMin)/2)) м"
        detailView.dateLabel.text = setDate(asteroid: asteroid)
        if distanceInKilometers {
            detailView.distanceLabel.text = "на расстояние \(Int(asteroid.missDistanceKilometers).description) км"
        } else {
            detailView.distanceLabel.text = "на расстояние \(Int(asteroid.missDistanceLunar).description) л. орб."
        }
        if asteroid.isPotentiallyHazardousAsteroid {
            detailView.estimationLabel.text = "Оценка: опасен"
        } else {
            detailView.estimationLabel.text = "Оценка: не опасен"
        }
        
        detailView.diameterLabel.setFont()
        detailView.dateLabel.setFont()
        detailView.distanceLabel.setFont()
        detailView.estimationLabel.setFont()
    }
    
    private func setName(asteroid: Asteroid) -> String? {
        var result = ""
        if let index = asteroid.name?.range(of: "(")?.lowerBound {
            result = String(asteroid.name?[index...] ?? "")
        }
        if result.first == "(" {
            result.removeFirst()
            result.removeLast()
        }
        return result
    }
    
    private func setDate(asteroid: Asteroid) -> String{
        var dates = asteroid.date?.split(separator: "-")
        var mounth = ""
        if dates?[2].first == "0" {
            dates?[2].removeFirst()
        }
        switch(dates?[1]) {
        case "01": mounth = "января"
        case "02": mounth = "февраля"
        case "03": mounth = "марта"
        case "04": mounth = "апреля"
        case "05": mounth = "мая"
        case "06": mounth = "июня"
        case "07": mounth = "июля"
        case "08": mounth = "августа"
        case "09": mounth = "сентября"
        case "10": mounth = "октября"
        case "11": mounth = "ноября"
        case "12": mounth = "декабря"
            
        case .none: break
        case .some(_): break
        }
        return "Подлетает \(dates?[2] ?? "") \(mounth) \(dates?[0] ?? "")"
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let closeApproachData = closeApproachData {
            return closeApproachData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as? DetailTableViewCell else { return UITableViewCell()}
        guard let distanceInKilometers = distanceInKilometers else { return UITableViewCell()}
        if let closeApproachData = closeApproachData {
            cell.setData(closeApproachDatum: closeApproachData[indexPath.row], distanceInKilometers: distanceInKilometers)
        }
        cell.selectionStyle = .none
        return cell
    }
}
