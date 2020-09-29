//
//  AppError.swift
//  PursuitInstagramFireBase
//
//  Created by Kary Martinez on 9/28/20.
//  Copyright © 2020 Kary Martinez. All rights reserved.
//

import Foundation
enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}
