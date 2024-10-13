//
//  FavoriteMovieDataSource.swift
//  MangomMovie
//
//  Created by Jinyoung Yoo on 10/13/24.
//

import Foundation
import RealmSwift

protocol FavoriteMovieDataSource {
    func createFavoriteMovie(_ movie: CompactMedia) -> Bool
    func fetchFavoriteMovieList() -> [(FavoriteMovieDTO, String)]
    func deleteFavoriteMovie(movieID: Int)
}

final class DefaultFavoriteMovieDataSource: FavoriteMovieDataSource {
    
    private let realm = try! Realm()
    
    init() {
        print(realm.configuration.fileURL ?? "")
    }
    
    func createFavoriteMovie(_ movie: CompactMedia) -> Bool {
        // Realm에 이미 존재하면 false 반환
        if let movie = realm.object(ofType: FavoriteMovieDTO.self, forPrimaryKey: movie.id) {
            return false
        }
        
        add(movie)
        // Image Data를 받아와야함....
        //saveImageToDocument(imageData: , movieID: )
        return true
    }
    
    func fetchFavoriteMovieList() -> [(FavoriteMovieDTO, String)] {
        return realm.objects(FavoriteMovieDTO.self).map {
            ($0, loadImageFilePath(movieID: $0.id) ?? "")
        }
    }
    
    func deleteFavoriteMovie(movieID: Int) {
        delete(movieID)
        removeImageFromDocument(movieID: movieID)
    }
    
}

extension DefaultFavoriteMovieDataSource {
    private func add(_ movie: CompactMedia) {
        do {
            let new = FavoriteMovieDTO(id: movie.id, title: movie.title)
            
            try realm.write {
                realm.add(new)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func delete(_ id: Int) {
        do {
            try realm.write {
                if let willDeleteMovie = realm.object(ofType: FavoriteMovieDTO.self, forPrimaryKey: id) {
                    realm.delete(willDeleteMovie)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension DefaultFavoriteMovieDataSource {
    
    private func saveImageToDocument(imageData: Data, movieID: Int) {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent("\(movieID).jpg")
        
        do {
            try imageData.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }
    
    private func removeImageFromDocument(movieID: Int) {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent("\(movieID).jpg")
        let filePath: String
        
        if #available(iOS 16.0, *) {
            filePath = fileURL.path()
        } else {
            filePath = fileURL.path
        }
        
        if FileManager.default.fileExists(atPath: filePath) {
            
            do {
                try FileManager.default.removeItem(atPath: filePath)
            } catch {
                print("file remove error", error)
            }
            
        } else {
            print("file no exist")
        }
        
    }

    private func loadImageFilePath(movieID: Int) -> String? {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }
        let fileURL = documentDirectory.appendingPathComponent("\(movieID).jpg")
        let filePath: String
        
        if #available(iOS 16.0, *) {
            filePath = fileURL.path()
        } else {
            filePath = fileURL.path
        }
        
        if FileManager.default.fileExists(atPath: filePath) {
            return filePath
        } else {
            return nil
        }
    }
}
