//
//  PHasset to UIImage.swift
//  SecuraGallery
//
//  Created by  aleksandr on 3.12.22.
//

import UIKit
import OpalImagePicker
import Photos

extension PHAsset {
    func getAssetThumbnail() -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: self, targetSize: CGSize(width: self.pixelWidth, height: self.pixelHeight), contentMode: .aspectFit, options: option, resultHandler: {(result, info) -> Void in
            thumbnail = result!
        })
        return thumbnail
    }
}
