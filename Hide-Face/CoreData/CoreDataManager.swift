//
//  CoreDataManager.swift
//  Hide-Face
//
//  Created by Данила on 17.04.2024.
//

import CoreData
import UIKit
import UniformTypeIdentifiers
import CoreServices

// MARK: - CRUD
public final class CoreDataManagerMain: NSObject {

    public static let shared = CoreDataManagerMain()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    public func fileExists(id: String) -> Bool {
        let fetchRequest: NSFetchRequest<CoreDataModel> = CoreDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let files = try context.fetch(fetchRequest)
            return !files.isEmpty
        } catch {
            print("Failed to fetch files: \(error)")
            return false
        }
    }

    
    public func createFile(date: String, data: Data, type1: String, type2: String, type3: String, type4: String, type5: String) {
        let uuid = UUID().uuidString
        DispatchQueue.main.async {
            if !self.fileExists(id: uuid) {
                guard let fileEntityDescription = NSEntityDescription.entity(forEntityName: "HistoryRequest", in: self.context) else { return }
                let file = CoreDataModel(entity: fileEntityDescription, insertInto: self.context)
                file.data = data
                file.date = date
                file.type1 = type1
                file.type2 = type2
                file.type3 = type3
                file.type4 = type4
                file.type5 = type5
                file.id = uuid
                file.isoDate = self.getIsoDate(from: Date())
                self.appDelegate.saveContext()
            }
        }
    }
    
    public func fetchFiles() -> [CoreDataModel] {
        
        let fetchRequest = NSFetchRequest<CoreDataModel>(entityName: "HistoryRequest")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let files = try? context.fetch(fetchRequest)
        return files ?? []
    }

    
    public func deleteFileX(with id: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryRequest")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        guard let files = try? context.fetch(fetchRequest) as? [CoreDataModel],
              let file = files.first else { return }
        DispatchQueue.main.async {
            self.context.delete(file)
            self.appDelegate.saveContext()
            print("File deleted")
        }
    }
    
    public func getTemporaryURL(for data: Data, withExtension extensions: String) -> URL? {
        let tempDir = NSTemporaryDirectory()
        let fileName = UUID().uuidString
        let fileURL = URL(fileURLWithPath: tempDir).appendingPathComponent(fileName).appendingPathExtension(extensions)
        
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Error writing data to temporary url: \(error)")
            return nil
        }
    }
    
    public func deleteTemporaryFile(at url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Error removing temporary file: \(error)")
        }
    }
}

private extension CoreDataManagerMain {
    
    func getIsoDate(from date: Date) -> String {
        if false {
            print(date)
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
}
