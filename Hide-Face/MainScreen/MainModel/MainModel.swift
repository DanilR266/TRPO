//
//  MainModel.swift
//  Hide-Face
//
//  Created by Данила on 12.01.2024.
//

import Foundation


class MainModel {
    
    let pickersData = [["Face Align + Yolov5l-Face (многоугольники, точно)".localize(), "Yolov5l-Face (прямоугольники, точно)".localize(), "Face Align + SFD (многоугольники, точно)".localize(), "MTCNN (прямоугольники)".localize(), "RetinaFace + ResNet50 (прямоугольники, точно)".localize(), "RetinaFace + MobileNet (прямоугольники, быстро)".localize(), "DLIB (многоугольники)".localize(), "DLIB (прямоугольники)".localize(), "Face Align + BlazeFace (многоугольники, быстро)".localize(), "Yolov5n-Face (прямоугольники, быстро)".localize(), "Несколько алгоритмов вместе (прямоугольники, очень точно)".localize()],
                       ["Размытие".localize(), "Черный квадрат".localize(), "Средний цвет".localize()],
                       Array(16...32).map { String($0)},
                       Array(0...100).map { String($0)},
                       ["С надписью".localize(), "Без надписи".localize()]]
    
    func getWidthForImage(heightDefault: CGFloat, heightImage: CGFloat) -> CGFloat {
        print(heightImage, heightDefault)
        return heightDefault * (heightDefault / heightImage)
    }
}
