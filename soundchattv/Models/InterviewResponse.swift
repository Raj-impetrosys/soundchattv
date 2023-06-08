//
//  InterviewResponse.swift
//  soundchattv
//
//  Created by RAJKUMAR on 22/05/23.
//

import Foundation
import Alamofire

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let interviewsResponse = try? JSONDecoder().decode(InterviewsResponse.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseInterviewsResponse { response in
//     if let interviewsResponse = response.result.value {
//       ...
//     }
//   }


struct InterviewsResponse: Codable {
    let status: Int
    let data: Interviews
    let message: String
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseDataClass { response in
//     if let dataClass = response.result.value {
//       ...
//     }
//   }

struct Interviews: Codable {
    let inStudio, soundSystemCulture, yellowTent, events: [Event]

    enum CodingKeys: String, CodingKey {
        case inStudio = "IN-STUDIO"
        case soundSystemCulture = "SOUND SYSTEM CULTURE"
        case yellowTent = "YELLOW-TENT"
        case events = "EVENTS"
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseEvent { response in
//     if let event = response.result.value {
//       ...
//     }
//   }

struct Event: Codable {
    let id: Int
    let postAuthor, postContent: JSONNull?
    let postTitle, postExcerpt: String
    let postName, guid, menuOrder, postType: JSONNull?
    let featureImg: String
    let featureImgMobile: JSONNull?
    let tvposter: String?
    let videoURL: String
    let videoType: VideoType
    let contentType: ContentType
    let interviewType: String
    let postDate: String?
    let status: Bool
    let createdAt, updatedAt: String

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
        case featureImgMobile = "feature_img_mobile"
        case tvposter
        case videoURL = "video_url"
        case videoType = "video_type"
        case contentType = "content_type"
        case interviewType = "interview_type"
        case postDate = "post_date"
        case status, createdAt, updatedAt
    }
}

//enum ContentType: String, Codable {
//    case freeContent = "free_content"
//}

enum InterviewType: String, Codable {
    case events = "EVENTS"
    case inStudio = "IN-STUDIO"
    case soundSystemCulture = "SOUND SYSTEM CULTURE"
    case yellowTent = "YELLOW-TENT"
}

enum VideoType: String, Codable {
    case vimeo = "VIMEO"
    case youtube = "YOUTUBE"
}


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
//    func responseInterviewsResponse(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<InterviewsResponse>) -> Void) -> Self {
//        return responseDecodable(queue: queue, completionHandler: completionHandler)
//    }
//}
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
