import Foundation

/// Đại diện cho thông tin người dùng trong ứng dụng
struct User: Identifiable {
    /// ID duy nhất của người dùng
    let id: UUID
    
    /// Tên người dùng hiển thị
    let username: String
    
    /// Địa chỉ email của người dùng
    let email: String
    
    /// URL dẫn đến ảnh đại diện của người dùng (có thể nil)
    let avatarURL: URL?
    
    /// Khởi tạo một người dùng mới với các thông tin cơ bản
    /// - Parameters:
    ///   - id: ID duy nhất (tùy chọn, mặc định tạo một UUID mới)
    ///   - username: Tên người dùng
    ///   - email: Địa chỉ email
    ///   - avatarURL: URL dẫn đến ảnh đại diện (tùy chọn)
    init(id: UUID = UUID(), username: String, email: String, avatarURL: URL? = nil) {
        self.id = id
        self.username = username
        self.email = email
        self.avatarURL = avatarURL
    }
}

/// Extension cung cấp dữ liệu mẫu cho User, hữu ích cho SwiftUI Preview
extension User {
    /// Tạo một người dùng mẫu với dữ liệu giả
    static var sample: User {
        User(
            username: "Nguyen Van A",
            email: "nguyenvana@example.com",
            avatarURL: URL(string: "https://i.pravatar.cc/300")
        )
    }
    
    /// Tạo một mảng người dùng mẫu
    static var samples: [User] {
        [
            User(username: "Nguyen Van A", email: "nguyenvana@example.com", avatarURL: URL(string: "https://i.pravatar.cc/300")),
            User(username: "Tran Thi B", email: "tranthib@example.com", avatarURL: URL(string: "https://i.pravatar.cc/300?img=20")),
            User(username: "Le Van C", email: "levanc@example.com", avatarURL: URL(string: "https://i.pravatar.cc/300?img=30"))
        ]
    }
} 