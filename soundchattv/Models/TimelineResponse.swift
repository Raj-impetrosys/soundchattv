////
////  TimelineResponse.swift
////  soundchattv
////
////  Created by RAJKUMAR on 16/05/23.
////
//
//import Alamofire
//import Foundation
//
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let timelineResponse = try? JSONDecoder().decode(TimelineResponse.self, from: jsonData)
//
////
//// To parse values from Alamofire responses:
////
////   Alamofire.request(url).responseTimelineResponse { response in
////     if let timelineResponse = response.result.value {
////       print(timelineResponse)
////     }
////   }
//
//
//struct TimelineResponse: Codable {
//    let status: Int
//    let data: DataClass
//    let message: String
//}
//
////
//// To parse values from Alamofire responses:
////
////   Alamofire.request(url).responseDataClass { response in
////     if let dataClass = response.result.value {
////       ...
////     }
////   }
//
//struct DataClass: Codable {
//    let count: Int
//    let rows: [Timeline]
//}
//
////
//// To parse values from Alamofire responses:
////
////   Alamofire.request(url).responseRow { response in
////     if let row = response.result.value {
////       ...
////     }
////   }
//
//struct Timeline: Codable {
//    let id: Int
//    let postDesc: String
//    let status: Bool
//    let createdAt, updatedAt: String
//    let timelinemedia: [Timelinemedia]
//    let timelinelikes: [Timelinelike]
//    let timelinecomments: [Timelinecomment]
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case postDesc = "post_desc"
//        case status, createdAt, updatedAt, timelinemedia, timelinelikes, timelinecomments
//    }
//}
//
////
//// To parse values from Alamofire responses:
////
////   Alamofire.request(url).responseTimelinecomment { response in
////     if let timelinecomment = response.result.value {
////       ...
////     }
////   }
//
//struct Timelinecomment: Codable {
//    let id: Int
//    let comments: String
//    let status: Bool
//    let commentBy: Int
//    let commentByAdmin: JSONNull?
//    let idTimeline: Int
//    let createdAt, updatedAt: String
//    let timelinereplies: [JSONAny]
//    let user: User
//    let admin: JSONNull?
//
//    enum CodingKeys: String, CodingKey {
//        case id, comments, status
//        case commentBy = "comment_by"
//        case commentByAdmin = "comment_by_admin"
//        case idTimeline = "id_timeline"
//        case createdAt, updatedAt, timelinereplies, user, admin
//    }
//}
//
////
//// To parse values from Alamofire responses:
////
////   Alamofire.request(url).responseUser { response in
////     if let user = response.result.value {
////       ...
////     }
////   }
//
//struct User: Codable {
//    let empty, profilepic, fname: String
//
//    enum CodingKeys: String, CodingKey {
//        case empty = "\"\""
//        case profilepic, fname
//    }
//}
//
////
//// To parse values from Alamofire responses:
////
////   Alamofire.request(url).responseTimelinelike { response in
////     if let timelinelike = response.result.value {
////       ...
////     }
////   }
//
//struct Timelinelike: Codable {
//    let id: Int
//    let likeIcon: String
//    let likeby: Int
//    let likebyAdmin: JSONNull?
//    let idTimeline: Int
//    let createdAt, updatedAt: String
//    let user: User
//    let admin: JSONNull?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case likeIcon = "like_icon"
//        case likeby
//        case likebyAdmin = "likeby_admin"
//        case idTimeline = "id_timeline"
//        case createdAt, updatedAt, user, admin
//    }
//}
//
////
//// To parse values from Alamofire responses:
////
////   Alamofire.request(url).responseTimelinemedia { response in
////     if let timelinemedia = response.result.value {
////       ...
////     }
////   }
//
//struct Timelinemedia: Codable {
//    let id: Int
//    let mediaName, mediaType, mediaExtention, mediaThumbnail: String
//    let status: Bool
//    let idTimeline: Int
//    let createdAt, updatedAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case mediaName = "media_name"
//        case mediaType = "media_type"
//        case mediaExtention = "media_extention"
//        case mediaThumbnail = "media_thumbnail"
//        case status
//        case idTimeline = "id_timeline"
//        case createdAt, updatedAt
//    }
//}
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
////
////extension DataRequest {
////    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
////        return DataResponseSerializer { _, response, data, error in
////            guard error == nil else { return .failure(error!) }
////
////            guard let data = data else {
////                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
////            }
////
////            return Result { try newJSONDecoder().decode(T.self, from: data) }
////        }
////    }
////
////    @discardableResult
////    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
////        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
////    }
////
////
////
////    @discardableResult
////    func responseTimelineResponse(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<TimelineResponse>) -> Void) -> Self {
////        return responseDecodable(queue: queue!, completionHandler: completionHandler)
////    }
////}
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
//
//class JSONCodingKey: CodingKey {
//    let key: String
//
//    required init?(intValue: Int) {
//        return nil
//    }
//
//    required init?(stringValue: String) {
//        key = stringValue
//    }
//
//    var intValue: Int? {
//        return nil
//    }
//
//    var stringValue: String {
//        return key
//    }
//}
//
//class JSONAny: Codable {
//
//    let value: Any
//
//    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
//        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
//        return DecodingError.typeMismatch(JSONAny.self, context)
//    }
//
//    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
//        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
//        return EncodingError.invalidValue(value, context)
//    }
//
//    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
//        if let value = try? container.decode(Bool.self) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self) {
//            return value
//        }
//        if let value = try? container.decode(Double.self) {
//            return value
//        }
//        if let value = try? container.decode(String.self) {
//            return value
//        }
//        if container.decodeNil() {
//            return JSONNull()
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
//        if let value = try? container.decode(Bool.self) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self) {
//            return value
//        }
//        if let value = try? container.decode(Double.self) {
//            return value
//        }
//        if let value = try? container.decode(String.self) {
//            return value
//        }
//        if let value = try? container.decodeNil() {
//            if value {
//                return JSONNull()
//            }
//        }
//        if var container = try? container.nestedUnkeyedContainer() {
//            return try decodeArray(from: &container)
//        }
//        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
//            return try decodeDictionary(from: &container)
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
//        if let value = try? container.decode(Bool.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decode(Double.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decode(String.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decodeNil(forKey: key) {
//            if value {
//                return JSONNull()
//            }
//        }
//        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
//            return try decodeArray(from: &container)
//        }
//        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
//            return try decodeDictionary(from: &container)
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
//        var arr: [Any] = []
//        while !container.isAtEnd {
//            let value = try decode(from: &container)
//            arr.append(value)
//        }
//        return arr
//    }
//
//    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
//        var dict = [String: Any]()
//        for key in container.allKeys {
//            let value = try decode(from: &container, forKey: key)
//            dict[key.stringValue] = value
//        }
//        return dict
//    }
//
//    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
//        for value in array {
//            if let value = value as? Bool {
//                try container.encode(value)
//            } else if let value = value as? Int64 {
//                try container.encode(value)
//            } else if let value = value as? Double {
//                try container.encode(value)
//            } else if let value = value as? String {
//                try container.encode(value)
//            } else if value is JSONNull {
//                try container.encodeNil()
//            } else if let value = value as? [Any] {
//                var container = container.nestedUnkeyedContainer()
//                try encode(to: &container, array: value)
//            } else if let value = value as? [String: Any] {
//                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
//                try encode(to: &container, dictionary: value)
//            } else {
//                throw encodingError(forValue: value, codingPath: container.codingPath)
//            }
//        }
//    }
//
//    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
//        for (key, value) in dictionary {
//            let key = JSONCodingKey(stringValue: key)!
//            if let value = value as? Bool {
//                try container.encode(value, forKey: key)
//            } else if let value = value as? Int64 {
//                try container.encode(value, forKey: key)
//            } else if let value = value as? Double {
//                try container.encode(value, forKey: key)
//            } else if let value = value as? String {
//                try container.encode(value, forKey: key)
//            } else if value is JSONNull {
//                try container.encodeNil(forKey: key)
//            } else if let value = value as? [Any] {
//                var container = container.nestedUnkeyedContainer(forKey: key)
//                try encode(to: &container, array: value)
//            } else if let value = value as? [String: Any] {
//                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
//                try encode(to: &container, dictionary: value)
//            } else {
//                throw encodingError(forValue: value, codingPath: container.codingPath)
//            }
//        }
//    }
//
//    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
//        if let value = value as? Bool {
//            try container.encode(value)
//        } else if let value = value as? Int64 {
//            try container.encode(value)
//        } else if let value = value as? Double {
//            try container.encode(value)
//        } else if let value = value as? String {
//            try container.encode(value)
//        } else if value is JSONNull {
//            try container.encodeNil()
//        } else {
//            throw encodingError(forValue: value, codingPath: container.codingPath)
//        }
//    }
//
//    public required init(from decoder: Decoder) throws {
//        if var arrayContainer = try? decoder.unkeyedContainer() {
//            self.value = try JSONAny.decodeArray(from: &arrayContainer)
//        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
//            self.value = try JSONAny.decodeDictionary(from: &container)
//        } else {
//            let container = try decoder.singleValueContainer()
//            self.value = try JSONAny.decode(from: container)
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        if let arr = self.value as? [Any] {
//            var container = encoder.unkeyedContainer()
//            try JSONAny.encode(to: &container, array: arr)
//        } else if let dict = self.value as? [String: Any] {
//            var container = encoder.container(keyedBy: JSONCodingKey.self)
//            try JSONAny.encode(to: &container, dictionary: dict)
//        } else {
//            var container = encoder.singleValueContainer()
//            try JSONAny.encode(to: &container, value: self.value)
//        }
//    }
//}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let timelineResponse = try? JSONDecoder().decode(TimelineResponse.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseTimelineResponse { response in
//     if let timelineResponse = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

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

struct DataClass: Codable {
    let count: Int
    let rows: [Timeline]
    
    enum CodingKeys: String, CodingKey {
        case count
        case rows = "Row"
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseRow { response in
//     if let row = response.result.value {
//       ...
//     }
//   }

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

struct Timelinecomment: Codable {
    let id: Int
    let comments: String
    let status: Bool
    let commentBy: Int
    let commentByAdmin: JSONNull?
    let idTimeline: Int
    let createdAt, updatedAt: String
    let timelinereplies: [Timelinereply]
    let user: User
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
//
//// MARK: - Encode/decode helpers
//
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
