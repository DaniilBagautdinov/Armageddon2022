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
    
    let key = "Fz2hR1x29iwvxcwEaMnQbkZXQQZnviNsMMRQMUSY"
    
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
        let fetchRequest = AsteroidEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", asteroid.id!)
        do {
            let asteroidsEntity = try viewContext.fetch(fetchRequest)
            if asteroidsEntity.isEmpty {
                let asteroidEntity = AsteroidEntity(context: viewContext)
                asteroidEntity.name = asteroid.name
                asteroidEntity.id = asteroid.id
                asteroidEntity.diameterMax = asteroid.diameterMax
                asteroidEntity.diameterMin = asteroid.diameterMin
                asteroidEntity.missDistanceKilometers = asteroid.missDistanceKilometers
                asteroidEntity.missDistanceLunar = asteroid.missDistanceLunar
                asteroidEntity.isPotentiallyHazardousAsteroid = asteroid.isPotentiallyHazardousAsteroid
                asteroidEntity.date = asteroid.date
                asteroidEntity.isDestroy = false
                
                saveContext()
            }
        } catch {
            print(error)
        }
    }
    
    func addCloseApproachDataEntity(closeApproachData: CloseApprouchData) {
        let fetchRequest = CloseApproachDataEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "closeApprouchDateFull == %@", closeApproachData.closeApprouchDateFull!)
        do {
            let fullInfo = try viewContext.fetch(fetchRequest)
            if fullInfo.isEmpty {
                let closeApproachDataEntity = CloseApproachDataEntity(context: viewContext)
                closeApproachDataEntity.asteroidId = closeApproachData.asteroidId
                closeApproachDataEntity.missDistanceLunar = closeApproachData.missDistanceLunar
                closeApproachDataEntity.missDistanceKilometers = closeApproachData.missDistanceKilometers
                closeApproachDataEntity.closeApprouchDate = closeApproachData.closeApprouchDate
                closeApproachDataEntity.closeApprouchDateFull = closeApproachData.closeApprouchDateFull
                closeApproachDataEntity.kilometersPerSecond = closeApproachData.kilometersPerSecond
                closeApproachDataEntity.orbitingBody = closeApproachData.orbitingBody
                
                saveContext()
            }
        } catch {
            print(error)
        }
    }
    
    func getAllAsteroids() -> [Asteroid] {
        let fetchRequest = AsteroidEntity.fetchRequest()
        var asteroids: [Asteroid] = []
        do {
            let asteroidsEntity = try viewContext.fetch(fetchRequest)
            for asteroidEntity in asteroidsEntity {
                if !asteroidEntity.isDestroy {
                    asteroids.append(Asteroid(name: asteroidEntity.name, id: asteroidEntity.id, date: asteroidEntity.date, diameterMax: asteroidEntity.diameterMax, diameterMin: asteroidEntity.diameterMin, missDistanceKilometers: asteroidEntity.missDistanceKilometers, missDistanceLunar: asteroidEntity.missDistanceLunar, isPotentiallyHazardousAsteroid: asteroidEntity.isPotentiallyHazardousAsteroid))
                }
            }
        } catch {
            print(error)
        }
        return asteroids
    }
    
    func getAllDangerousAsteroids() -> [Asteroid] {
        let fetchRequest = AsteroidEntity.fetchRequest()
        var asteroids: [Asteroid] = []
        do {
            let asteroidsEntity = try viewContext.fetch(fetchRequest)
            for asteroidEntity in asteroidsEntity {
                if asteroidEntity.isPotentiallyHazardousAsteroid && !asteroidEntity.isDestroy{
                    asteroids.append(Asteroid(name: asteroidEntity.name, id: asteroidEntity.id, date: asteroidEntity.date, diameterMax: asteroidEntity.diameterMax, diameterMin: asteroidEntity.diameterMin, missDistanceKilometers: asteroidEntity.missDistanceKilometers, missDistanceLunar: asteroidEntity.missDistanceLunar, isPotentiallyHazardousAsteroid: asteroidEntity.isPotentiallyHazardousAsteroid))
                }
            }
        } catch {
            print(error)
        }
        return asteroids
    }
    
    func getAllDestroyAsteroids() -> [Asteroid] {
        let fetchRequest = AsteroidEntity.fetchRequest()
        var asteroids: [Asteroid] = []
        do {
            let asteroidsEntity = try viewContext.fetch(fetchRequest)
            for asteroidEntity in asteroidsEntity {
                if asteroidEntity.isDestroy{
                    asteroids.append(Asteroid(name: asteroidEntity.name, id: asteroidEntity.id, date: asteroidEntity.date, diameterMax: asteroidEntity.diameterMax, diameterMin: asteroidEntity.diameterMin, missDistanceKilometers: asteroidEntity.missDistanceKilometers, missDistanceLunar: asteroidEntity.missDistanceLunar, isPotentiallyHazardousAsteroid: asteroidEntity.isPotentiallyHazardousAsteroid))
                }
            }
        } catch {
            print(error)
        }
        return asteroids
    }
    
    func getLastAsteroid() -> AsteroidEntity? {
        let fetchRequest = AsteroidEntity.fetchRequest()
        do {
            let asteroidsEntity = try viewContext.fetch(fetchRequest)
            return asteroidsEntity.sorted(by: {$0.date ?? "" < $1.date ?? ""}).last
        } catch {
            print(error)
        }
        return nil
    }
    
    func setAsteroidDestroy(id: String) {
        let fetchRequest = AsteroidEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let asteroidsEntity = try viewContext.fetch(fetchRequest)
            guard let asteroidEntity = asteroidsEntity.first else { return }
            asteroidEntity.isDestroy = true
            saveContext()
        } catch {
            print(error)
        }
    }
    
    func clearDestroyAsteroids() {
        let fetchRequest = AsteroidEntity.fetchRequest()
        do {
            let asteroidsEntity = try viewContext.fetch(fetchRequest)
            for asteroidEntity in asteroidsEntity {
                if asteroidEntity.isDestroy {
                    viewContext.delete(asteroidEntity)
                    saveContext()
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getData(date: Date) {
        DispatchQueue.main.async { [self] in
            let dates = generateDates(date: date)
            guard let url = URL(string: "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(dates[0])&api_key=\(key)") else { return }
            AF.request(url).response { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value!)
                    for date in dates {
                        for asteroid in json["near_earth_objects"][date] {
                            self.addAsteroidEntity(asteroid: Asteroid(name: asteroid.1["name"].stringValue, id: asteroid.1["id"].stringValue, date: date, diameterMax: asteroid.1["estimated_diameter"]["meters"]["estimated_diameter_max"].doubleValue, diameterMin: asteroid.1["estimated_diameter"]["meters"]["estimated_diameter_min"].doubleValue, missDistanceKilometers: asteroid.1["close_approach_data"][0]["miss_distance"]["kilometers"].doubleValue, missDistanceLunar: asteroid.1["close_approach_data"][0]["miss_distance"]["lunar"].doubleValue, isPotentiallyHazardousAsteroid: asteroid.1["is_potentially_hazardous_asteroid"].boolValue))
                        }
                    }
                    print("DONE")
                    //                    print("JSON: \(json)")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getAsteroidInfo(id: String) {
        DispatchQueue.main.async { [self] in
            AF.request("https://api.nasa.gov/neo/rest/v1/neo/\(id)?api_key=\(key)").response { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value!)
                    for asteroidInfo in json["close_approach_data"] {
                        self.addCloseApproachDataEntity(closeApproachData: CloseApprouchData(asteroidId: id, closeApprouchDate: asteroidInfo.1["close_approach_date"].stringValue, closeApprouchDateFull: asteroidInfo.1["close_approach_date_full"].stringValue, orbitingBody: asteroidInfo.1["orbiting_body"].stringValue, kilometersPerSecond: asteroidInfo.1["relative_velocity"]["kilometers_per_second"].doubleValue, missDistanceKilometers: asteroidInfo.1["miss_distance"]["kilometers"].doubleValue, missDistanceLunar: asteroidInfo.1["miss_distance"]["lunar"].doubleValue))
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func generateDates(date: Date) -> [String] {
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

