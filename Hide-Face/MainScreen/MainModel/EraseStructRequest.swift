//
//  EraseStructRequest.swift
//  Hide-Face
//
//  Created by Данила on 23.04.2024.
//

import Foundation

struct EraseFacesRequest: Codable {
    let sessionID: String
    let content: String
    let contentFormat: String
    let algorithm: String
    let erasionType: String
    let quality: Int32?
    let addWatermark: Bool?
    let onDemoPage: Bool?
    
    enum CodingKeys: String, CodingKey {
        case sessionID = "session_id"
        case content
        case contentFormat = "content_format"
        case algorithm
        case erasionType = "erasion_type"
        case quality
        case addWatermark = "add_watermark"
        case onDemoPage = "on_demopage"
    }
}


struct HistoryItem: Decodable {
    let id: Int
    let extra_pixels: Int
    let datetime: String
    let erasion_type: Int
    let video_encoding_quality: Int
    let algorithm: Int
    let add_watermark: Int
}

struct GetJob: Decodable {
    let data: Data
}
