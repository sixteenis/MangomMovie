//
//  FavoriteMovieDataSource.swift
//  MangomMovie
//
//  Created by Jinyoung Yoo on 10/13/24.
//

import Foundation
import RealmSwift
import Kingfisher

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
        guard let url = URL(string: APIKey.baseURL + movie.imagePath) else { return false }
        self.downloadImage(from: url) { [weak self] data in
            guard let self, let imageData = data else {
                print("이미지 저장 실패 ㅠ")
                return
            }
            self.saveImageToDocument(imageData: imageData, movieID: movie.id)
        }
//            guard let imageData = try? Data(contentsOf: url) else { return }
//            
//        
//        self.saveImageToDocument(imageData: imageData, movieID: movie.id)
        
        
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
    // 비동기적으로 이미지를 다운로드하는 함수
    private func downloadImage(from url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                print("Invalid response or no data")
                completion(nil)
                return
            }
            
            completion(data)
        }.resume()
    }
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
