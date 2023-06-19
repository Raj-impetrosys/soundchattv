//////
//////  TimelineResponse.swift
//////  soundchattv
//////
//////  Created by RAJKUMAR on 16/05/23.
//////
////
import Foundation
import Alamofire

// MARK: - TimelineResponse
struct TimelineResponse: Codable {
    let status: Int
    let data: DataClass
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

// MARK: - DataClass
struct DataClass: Codable {
    let count: Int
    let rows: [Timeline]
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseRow { response in
//     if let row = response.result.value {
//       ...
//     }
//   }

// MARK: - Row
struct Timeline: Codable {
    let id: Int
    let postDesc: String
    let status: Bool
    let createdAt, updatedAt: String
    let timelinemedia: [Timelinemedia]
    let timelinelikes: [Timelinelike]
    let timelinecomments: [Timelinecomment]

    enum CodingKeys: String, CodingKey {
        case id
        case postDesc = "post_desc"
        case status, createdAt, updatedAt, timelinemedia, timelinelikes, timelinecomments
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseTimelinecomment { response in
//     if let timelinecomment = response.result.value {
//       ...
//     }
//   }

// MARK: - Timelinecomment
struct Timelinecomment: Codable {
    let id: Int
    let comments: String
    let status: Bool
    let commentBy: Int
    let commentByAdmin: JSONNull?
    let idTimeline: Int
    let createdAt, updatedAt: String
    let timelinereplies: [Timelinereply]
    let user: User?
    let admin: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, comments, status
        case commentBy = "comment_by"
        case commentByAdmin = "comment_by_admin"
        case idTimeline = "id_timeline"
        case createdAt, updatedAt, timelinereplies, user, admin
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseTimelinereply { response in
//     if let timelinereply = response.result.value {
//       ...
//     }
//   }

// MARK: - Timelinereply
struct Timelinereply: Codable {
    let id: Int
    let reply: String
    let status: Bool
    let replyBy: Int
    let replyByAdmin: JSONNull?
    let idComment: Int
    let createdAt, updatedAt: String
    let user: User
    let admin: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, reply, status
        case replyBy = "reply_by"
        case replyByAdmin = "reply_by_admin"
        case idComment = "id_comment"
        case createdAt, updatedAt, user, admin
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseUser { response in
//     if let user = response.result.value {
//       ...
//     }
//   }

// MARK: - User
struct User: Codable {
    let empty, profilepic, fname: String

    enum CodingKeys: String, CodingKey {
        case empty = "\"\""
        case profilepic, fname
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseTimelinelike { response in
//     if let timelinelike = response.result.value {
//       ...
//     }
//   }

// MARK: - Timelinelike
struct Timelinelike: Codable {
    let id: Int
    let likeIcon: String
    let likeby: Int
    let likebyAdmin: JSONNull?
    let idTimeline: Int
    let createdAt, updatedAt: String
    let user: User
    let admin: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case likeIcon = "like_icon"
        case likeby
        case likebyAdmin = "likeby_admin"
        case idTimeline = "id_timeline"
        case createdAt, updatedAt, user, admin
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseTimelinemedia { response in
//     if let timelinemedia = response.result.value {
//       ...
//     }
//   }

// MARK: - Timelinemedia
struct Timelinemedia: Codable {
    let id: Int
    let mediaName: String
    let mediaType: String
    let mediaExtention: MediaExtention
    let mediaThumbnail: String?
    let status: Bool
    let idTimeline: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case mediaName = "media_name"
        case mediaType = "media_type"
        case mediaExtention = "media_extention"
        case mediaThumbnail = "media_thumbnail"
        case status
        case idTimeline = "id_timeline"
        case createdAt, updatedAt
    }
}

enum MediaExtention: String, Codable {
    case jpeg = "jpeg"
    case mp4 = "mp4"
    case quicktime = "quicktime"
}

enum MediaType: String, Codable {
    case image = "image"
    case video = "video"
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

//// MARK: - Alamofire response handlers
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
//    func responseTimelineResponse(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<TimelineResponse>) -> Void) -> Self {
//        return responseDecodable(queue: queue, completionHandler: completionHandler)
//    }
//}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
