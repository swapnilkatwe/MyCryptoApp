//
//  PortfolioDataService.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 17/04/24.
//

import Foundation
import CoreData
class PortfolioDataService {
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error while loading coredata \(error)")
            }

            // Get portfolio data at start
            self.getPortfolio()
        }
    }
    
    // MARK: - Public Operations
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinId == coin.id }) {
            if amount > 0 {
                updateEntity(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            addEntity(coin: coin, amount: amount)
        }
    }

    // MARK: - Private Operations
    
    private func getPortfolio() {
        let fetchRequest = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(fetchRequest)
        } catch let error {
            print("Error while fetching Entity: \(error)")
        }
    }

    private func updateEntity(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func addEntity(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinId = coin.id
        entity.amount = amount

        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func saveEntity() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error while saving Entity in coredata\(error)")
        }
    }
    
    private func applyChanges() {
        saveEntity()
        getPortfolio()
    }
}
