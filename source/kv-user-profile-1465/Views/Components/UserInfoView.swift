import SwiftUI

/// View hiển thị thông tin cơ bản của người dùng (tên và email)
struct UserInfoView: View {
    /// Tên người dùng
    let username: String
    
    /// Email người dùng
    let email: String
    
    /// Xác định nếu email hợp lệ hay không
    let isEmailValid: Bool
    
    /// Khởi tạo với các thông tin người dùng
    /// - Parameters:
    ///   - username: Tên người dùng
    ///   - email: Địa chỉ email
    ///   - isEmailValid: Trạng thái hợp lệ của email (mặc định là true)
    init(username: String, email: String, isEmailValid: Bool = true) {
        self.username = username
        self.email = email
        self.isEmailValid = isEmailValid
    }
    
    /// Khởi tạo từ model User
    /// - Parameter user: Model người dùng
    init(user: User, isEmailValid: Bool = true) {
        self.username = user.username
        self.email = user.email
        self.isEmailValid = isEmailValid
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Hiển thị tên người dùng
            Text(username)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .lineLimit(1)
                .accessibilityLabel("Tên người dùng: \(username)")
            
            // Hiển thị email với trạng thái hợp lệ
            HStack(spacing: 5) {
                Text(email)
                    .font(.subheadline)
                    .foregroundColor(isEmailValid ? .secondary : .red)
                    .lineLimit(1)
                
                // Hiển thị icon cảnh báo nếu email không hợp lệ
                if !isEmailValid {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            .accessibilityLabel("Email: \(email)\(isEmailValid ? "" : ", không hợp lệ")")
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Previews

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Với email hợp lệ
            UserInfoView(
                username: "Nguyễn Văn A",
                email: "nguyenvana@example.com"
            )
            .previewDisplayName("Email hợp lệ")
            
            // Với email không hợp lệ
            UserInfoView(
                username: "Trần Thị B",
                email: "email_khong_hop_le",
                isEmailValid: false
            )
            .previewDisplayName("Email không hợp lệ")
            
            // Từ model User
            UserInfoView(user: User.sample)
                .previewDisplayName("Từ model User")
            
            // Tên dài, email dài
            UserInfoView(
                username: "Tên người dùng rất dài để kiểm tra hiển thị trên nhiều dòng",
                email: "email.rat.dai.de.kiem.tra.hien.thi@example.com"
            )
            .previewDisplayName("Tên và email dài")
            .frame(width: 300)
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
} 