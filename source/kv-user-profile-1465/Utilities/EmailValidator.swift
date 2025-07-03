import Foundation

/// Utility struct cung cấp chức năng xác thực email
struct EmailValidator {
    /// Kiểm tra xem một chuỗi có phải là địa chỉ email hợp lệ hay không
    /// - Parameter email: Chuỗi cần kiểm tra
    /// - Returns: true nếu email hợp lệ, false nếu không
    static func isValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    /// Kiểm tra xem một chuỗi có phải là địa chỉ email hợp lệ hay không
    /// - Parameter email: Chuỗi cần kiểm tra
    /// - Returns: Kết quả xác thực dưới dạng Result
    static func validate(_ email: String) -> Result<String, ProfileError> {
        if isValid(email) {
            return .success(email)
        } else {
            return .failure(.invalidEmail)
        }
    }
} 