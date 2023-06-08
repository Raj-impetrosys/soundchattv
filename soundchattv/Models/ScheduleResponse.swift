//
//  ScheduleResponse.swift
//  soundchattv
//
//  Created by RAJKUMAR on 17/05/23.
//

import Foundation
import Alamofire

struct ScheduleResponse: Codable {
    let status: Int
    let data: [Schedule]
    let message: String
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseDatum { response in
//     if let datum = response.result.value {
//       ...
//     }
//   }

struct Schedule: Codable {
    let id: Int
    let postAuthor, postContent, postTitle, postExcerpt: String
    let postName: String
    let guid: String
    let menuOrder, postType: String
    let featureImg: String
    let contentType: ContentType
    let shows: [Show]
    let createdAt, updatedAt: String
    let scheduleperdays: [Scheduleperday]

    enum CodingKeys: String, CodingKey {
        case id
        case postAuthor = "post_author"
        case postContent = "post_content"
        case postTitle = "post_title"
        case postExcerpt = "post_excerpt"
        case postName = "post_name"
        case guid
        case menuOrder = "menu_order"
        case postType = "post_type"
        case featureImg = "feature_img"
        case contentType = "content_type"
        case shows, createdAt, updatedAt, scheduleperdays
    }
}

enum ContentType: String, Codable {
    case freeContent = "free_content"
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseScheduleperday { response in
//     if let scheduleperday = response.result.value {
//       ...
//     }
//   }

struct Scheduleperday: Codable {
    let showID: Int
    let showName: String
    let hostDesc, tvposter: String?
    let showImage, showStartDate, showEndDate: String
    let showAudioURL: String
    let showDescription: String
    let dayID: Int
    let contentType: ContentType
    let status: Bool
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case showID = "show_id"
        case showName = "show_name"
        case hostDesc = "host_desc"
        case tvposter
        case showImage = "show_image"
        case showStartDate = "show_start_date"
        case showEndDate = "show_end_date"
        case showAudioURL = "show_audio_url"
        case showDescription = "show_description"
        case dayID = "day_id"
        case contentType = "content_type"
        case status, createdAt, updatedAt
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseShow { response in
//     if let show = response.result.value {
//       ...
//     }
//   }

struct Show: Codable {
    let showID, showName: String
    let showImage: String?
    let showEndDate: String
    let showAudioURL: String
    let showStartDate, showDescription: String

    enum CodingKeys: String, CodingKey {
        case showID = "show_id"
        case showName = "show_name"
        case showImage = "show_image"
        case showEndDate = "show_end_date"
        case showAudioURL = "show_audio_url"
        case showStartDate = "show_start_date"
        case showDescription = "show_description"
    }
}
//
//func newJSONDecoder() -> JSONDecoder {
//    let decoder = JSONDecoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        decoder.dateDecodingStrategy = .iso8601
//    }
//    return decoder
//}
//
//func newJSONEncoder() -> JSONEncoder {
//    let encoder = JSONEncoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        encoder.dateEncodingStrategy = .iso8601
//    }
//    return encoder
//}
//
//extension DataRequest {
//    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
//        return DataResponseSerializer { _, response, data, error in
//            guard error == nil else { return .failure(error!) }
//
//            guard let data = data else {
//                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
//            }
//
//            return Result { try newJSONDecoder().decode(T.self, from: data) }
//        }
//    }
//
//    @discardableResult
//    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
//        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
//    }
//
//    @discardableResult
//    func responseScheduleResponse(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<ScheduleResponse>) -> Void) -> Self {
//        return responseDecodable(queue: queue, completionHandler: completionHandler)
//    }
//}
