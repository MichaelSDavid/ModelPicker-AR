//
//  Model.swift
//  ModelPicker
//
//  Created by Michael David on 2021-07-14.
//

import UIKit
import RealityKit
import Combine

class Model {
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        self.image = UIImage(named: modelName)!
        
        let filename = modelName + ".usdz"
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                // Handle error
                print("DEBUG - unable to load model entity for modelName: \(self.modelName)")
            }, receiveValue: { modelEntity in
                // Get model entity
                self.modelEntity = modelEntity
                print("DEBUG - successfully loaded model eneity for modelName: \(self.modelName)")
            })
    }
}
