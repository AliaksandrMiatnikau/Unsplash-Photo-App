
import Foundation

extension String {
    func dateFormatter() -> String {
        let date = Date() 
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let userDate = dateFormatter.string(from: date as Date)
        return userDate
    }
}
extension String {
  func toDate(dateFormat: String) -> Date? {

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat

    let date: Date? = dateFormatter.date(from: self)
    return date
}
}
