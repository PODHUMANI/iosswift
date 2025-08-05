extension BookList {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookList> {
        return NSFetchRequest<BookList>(entityName: "BookList")
    }

    @NSManaged public var authorName: String?
    @NSManaged public var bookName: String?
    @NSManaged public var departmant: Int32
    @NSManaged public var edition: String?
    @NSManaged public var id: UUID?
}
