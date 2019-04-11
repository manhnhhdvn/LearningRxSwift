import Foundation
//import Outlaw

struct PhotoDescriptionEntity: Decodable {
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?

    init(albumId: Int?, id: Int?, title: String?, url: String?, thumbnailUrl: String?) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}
