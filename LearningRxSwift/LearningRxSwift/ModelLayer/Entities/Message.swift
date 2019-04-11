import Foundation
//import Outlaw

// Deserializable
class Message: Decodable {

    var id: Int
    var body: String
    var title: String
    var userId: Int

    init(id: Int, body: String, title: String, userId: Int) {
        self.id = id
        self.body = body
        self.title = title
        self.userId = userId
    }

    required init(object: [String: Any]) throws {
        id = object["id"] as! Int
        body = object["body"] as! String
        title = object["title"] as! String
        userId = object["userId"] as! Int
    }
}
