//
//  LocalFileManager.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 15/04/24.
//

import Foundation
import SwiftUI

/*
  Using file manager in this app to store images rather than cache.
  Reason is images are not going to change or url in this app so using fileManager also will work
  For changing images friquently for url, we can use cache logic
*/
class LocalFileManager {
    static let instance = LocalFileManager()
    
    // Prevent external code from creating new instances of the class
    private init() { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        // Create folder
        createFolderIfNeeded(folderName: folderName)
        
        // Get path for image
        guard let data = image.pngData(),
              let url = getUrlForImage(imageName: imageName, folderName: folderName) else { return }

        // Save/write Image to path
        do {
            try data.write(to: url)
        } catch (let error) {
            print("Error while saving image\(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getUrlForImage(imageName: imageName, folderName: folderName),
        FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        return UIImage(contentsOfFile: url.path(percentEncoded: true))
    }

    private func createFolderIfNeeded(folderName: String) {
        guard let url = getUrlForFolder(name: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                
            } catch {
                print("error while creating folder: \(folderName), error: \(error)")
            }
        }
    }
    
    private func getUrlForFolder(name: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appending(path: name)
    }
    
    private func getUrlForImage(imageName: String, folderName: String) -> URL? {
        guard let folderUrl = getUrlForFolder(name: folderName) else { return nil }
        return folderUrl.appending(path: imageName + ".png")
    }
}
