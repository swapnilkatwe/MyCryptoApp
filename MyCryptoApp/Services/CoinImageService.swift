//
//  CoinImageService.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 15/04/24.
//

import Foundation
import Combine
import SwiftUI

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    
    private let folderName = "coin_image"
    private let imageName: String
    
    private var imageSubscription: AnyCancellable?

    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }

    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            // Retriving Image from the folder
            image = savedImage
            print("Image is retrived from folder!")
        } else {
            downloadCoinImage()
            print("Downloading image")
        }
    }

    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription =
        NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in

                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                
                // Cancel substription
                self.imageSubscription?.cancel()
                
                // Saveing Image in folder
                self.fileManager.saveImage(image: downloadedImage, imageName: imageName, folderName: self.folderName)
            })
    }
}
