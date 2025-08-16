import Foundation
import CoreData

extension ImageInformetion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageInformetion> {
        return NSFetchRequest<ImageInformetion>(entityName: "ImageInformetion")
    }

    @NSManaged public var imageName: String?
    @NSManaged public var imageData: String?
    @NSManaged public var favoriteValue: Bool
    @NSManaged public var id: UUID?

}

extension ImageInformetion : Identifiable {

}
extension ImageInformetion {
    var wrapedTitle: String { imageName ?? "" }
    var wrapedImageData: String { imageData ?? "" }
    var wrapedFavoriteList: Bool { favoriteValue }
}
