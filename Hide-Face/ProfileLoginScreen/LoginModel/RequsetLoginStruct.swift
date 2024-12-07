//
//  RequsetLoginStruct.swift
//  Hide-Face
//
//  Created by Данила on 23.04.2024.
//

import Foundation

struct LoginRequest: Codable {
    let id: String
    let password: String
}

struct LoginResponse: Decodable {
    let token: String
    let credits: Int
    let history: [HistoryItem]
}

struct ResponseError: Decodable {
    let message: String
}

struct ChangePasswordRequest: Codable {
    let id: String
    let old_password: String
    let new_password: String
}

struct Test: Decodable {
    let id: String
    let old_password: String
    let new_password: String
}

struct RegisterRequest: Codable {
    let id: String
    let password: String
}
