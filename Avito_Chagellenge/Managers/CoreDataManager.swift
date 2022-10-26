//
//  CoreDataManager.swift
//  Avito_Chagellenge
//
//  Created by Asf on 26.10.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AvitoData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
    
    func save() {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    
    func addEmployees(_ employee: Employee) {
        let context = persistentContainer.viewContext
        context.perform {
            let employe = AvitoEntity(context: context)
            employe.name = employee.name
            employe.phoneNumber = employee.phoneNumber
            employe.skills = employee.skills
        }
        save()
    }
    
    
    func allEmployees() -> [Employee] {
        let context = persistentContainer.viewContext
        let requestResult: NSFetchRequest<AvitoEntity> = AvitoEntity.fetchRequest()
       
        let employ = try? context.fetch(requestResult)
        print(employ?.map({ Employee(avito: $0) }) ?? [])
        return employ?.map({ Employee(avito: $0) }) ?? []
    }
    
    
    func deleteAll(_ entity: String) {
           let context = persistentContainer.viewContext
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
           fetchRequest.returnsObjectsAsFaults = false
           do {
               let results = try context.fetch(fetchRequest)
               for employee in results {
                   guard let employee = employee as? NSManagedObject else {continue}
                   context.delete(employee)
               }
           } catch let error {
               print("Detele all data in \(entity) error :", error)
           }
       }
    
}

