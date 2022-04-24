//
//  NetworkService.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 23.04.2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

final class DataService {
    
    static let shared = DataService()
    
    let key = "IQh2wd2JtJHXoUijtmbcuP1AphUOsmTkUgiE4b7O"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Armageddon2022")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    lazy var viewContext = persistentContainer.viewContext
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addAsteroidEntity(asteroid: Asteroid) {
        let asteroidEntity = AsteroidEntity(context: viewContext)
        asteroidEntity.name = asteroid.name
        asteroidEntity.id = asteroid.id
        asteroidEntity.diameterMax = asteroid.diameterMax
        asteroidEntity.diameterMin = asteroid.diameterMin
        asteroidEntity.missDistance = asteroid.missDistance
        asteroidEntity.isPotentiallyHazardousAsteroid = asteroid.isPotentiallyHazardousAsteroid
        asteroidEntity.date = asteroid.date
        
        saveContext()
    }
    
    func getAllAsteroids() -> [Asteroid] {
        let fetchRequest = AsteroidEntity.fetchRequest()
        var asteroids: [Asteroid] = []
        do {
            let asteroidsEntity = try viewContext.fetch(fetchRequest)
            for asteroidEntity in asteroidsEntity {
                asteroids.append(Asteroid(name: asteroidEntity.name, id: asteroidEntity.id, date: asteroidEntity.date, diameterMax: asteroidEntity.diameterMax, diameterMin: asteroidEntity.diameterMin, missDistance: asteroidEntity.missDistance, isPotentiallyHazardousAsteroid: asteroidEntity.isPotentiallyHazardousAsteroid))
            }
        } catch {
            print(error)
        }
        return asteroids
    }
        
    func getData(date: Date) {
        let operationQueue = OperationQueue()
        operationQueue.addOperation { [self] in
            let dates = generateDates(date: date)
            guard let url = URL(string: "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(dates[0])&api_key=\(key)") else { return }
            AF.request(url).response { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value!)
                    for date in dates {
                        for asteroid in json["near_earth_objects"][date] {
                            self.addAsteroidEntity(asteroid: Asteroid(name: asteroid.1["name"].stringValue, id: asteroid.1["id"].stringValue, date: date, diameterMax: asteroid.1["estimated_diameter"]["meters"]["estimated_diameter_max"].doubleValue, diameterMin: asteroid.1["estimated_diameter"]["meters"]["estimated_diameter_min"].doubleValue, missDistance: asteroid.1["close_approach_data"][0]["miss_distance"]["kilometers"].doubleValue, isPotentiallyHazardousAsteroid: asteroid.1["is_potentially_hazardous_asteroid"].boolValue))

                        }
                    }
//                    print("JSON: \(json)")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func generateDates(date: Date) -> [String] {
        var result: [String] = []
        var date = date
        let calendar = Calendar.current
        var yearString = ""
        var mounthString = ""
        var dayString = ""
        var count = 0
        while count < 8 {
            let year = calendar.component(.year, from: date)
            let mounth = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            yearString = year.description
            if (mounth < 10 ) {
                mounthString = "0\(mounth)"
            } else {
                mounthString = mounth.description
            }
            if (day < 10 ) {
                dayString = "0\(day)"
            } else {
                dayString = day.description
            }
            result.append(yearString + "-" + mounthString + "-" + dayString)
            count += 1
            date += 86400
        }
            
        return result
    }
}
