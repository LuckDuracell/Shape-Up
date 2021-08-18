//
//  Persistance.swift
//  Persistance
//
//  Created by Luke Drushell on 8/15/21.
//

import Foundation
import SwiftUI
import CoreData

struct User: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
        return "User"
    }
    var name: String
    var gender: Int
    var height: Double
    var weight: Double
    var age: Int
    var birthday: Date
}

struct Goals: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
        return "Goals"
    }
    var waterIntake: Double
    var sleepHours: Double
    var workoutTime: Double
}

struct DaysGoals: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
        return "DaysGoals"
    }
    var waterIntake: Double
    var sleepHours: Double
    var workoutTime: Double
    var date: Date
}

struct Habit: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
        return "Habit"
    }
    var info: String
    var title: String
}

protocol LocalFilesStorable: Codable {
    static var fileName: String { get }
}

extension LocalFilesStorable {
    static var localStorageURL: URL {
        guard let documentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Can NOT access file in Documents.")
        }
        
        return documentDirectory
            .appendingPathComponent(self.fileName)
            .appendingPathExtension("json")
    }
}

extension LocalFilesStorable {
    static func loadFromFile() -> [Self] {
        do {
            let fileWrapper = try FileWrapper(url: Self.localStorageURL, options: .immediate)
            guard let data = fileWrapper.regularFileContents else {
                throw NSError()
            }
            return try JSONDecoder().decode([Self].self, from: data)
            
        } catch _ {
            print("Could not load \(Self.self) the model uses an empty collection (NO DATA).")
            return []
        }
    }
}

extension LocalFilesStorable {
    static func saveToFile(_ collection: Self) {
        do {
            let data = try JSONEncoder().encode(collection)
            let jsonFileWrapper = FileWrapper(regularFileWithContents: data)
            try jsonFileWrapper.write(to: self.localStorageURL, options: .atomic, originalContentsURL: nil)
        } catch _ {
            print("Could not save \(Self.self)s to file named: \(self.localStorageURL.description)")
        }
    }
}

protocol LocalFileStorable: Codable {
    static var fileName: String { get }
}

extension LocalFileStorable {
    static var localStorageURL: URL {
        guard let documentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Can NOT access file in Documents.")
        }
        
        return documentDirectory
            .appendingPathComponent(self.fileName)
            .appendingPathExtension("json")
    }
}

extension LocalFileStorable {
    static func loadFromFile() -> [Self] {
        do {
            let fileWrapper = try FileWrapper(url: Self.localStorageURL, options: .immediate)
            guard let data = fileWrapper.regularFileContents else {
                throw NSError()
            }
            return try JSONDecoder().decode([Self].self, from: data)
            
        } catch _ {
            print("Could not load \(Self.self) the model uses an empty collection (NO DATA).")
            return []
        }
    }
}

extension LocalFileStorable {
    static func saveToFile(_ collection: [Self]) {
        do {
            let data = try JSONEncoder().encode(collection)
            let jsonFileWrapper = FileWrapper(regularFileWithContents: data)
            try jsonFileWrapper.write(to: self.localStorageURL, options: .atomic, originalContentsURL: nil)
        } catch _ {
            print("Could not save \(Self.self)s to file named: \(self.localStorageURL.description)")
        }
    }
}

extension Array where Element: LocalFileStorable {
    ///Saves an array of LocalFileStorables to a file in Documents
    func saveToFile() {
        Element.saveToFile(self)
    }
}
