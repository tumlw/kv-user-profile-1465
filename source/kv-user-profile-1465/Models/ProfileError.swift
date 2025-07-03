import Foundation

/// Định nghĩa các loại lỗi có thể xảy ra khi làm việc với hồ sơ người dùng
enum ProfileError: Error, LocalizedError {
    /// Lỗi khi tải hình ảnh đại diện
    case imageLoadFailed
    
    /// Lỗi khi email không hợp lệ
    case invalidEmail
    
    /// Lỗi khi không thể tải dữ liệu người dùng
    case userDataLoadFailed
    
    /// Lỗi khi không thể lưu cài đặt
    case settingsSaveFailed
    
    /// Lỗi khi xảy ra vấn đề về mạng
    case networkError(String)
    
    /// Cung cấp mô tả lỗi thân thiện với người dùng
    var errorDescription: String? {
        switch self {
        case .imageLoadFailed:
            return "Không thể tải ảnh đại diện. Vui lòng thử lại sau."
        case .invalidEmail:
            return "Địa chỉ email không hợp lệ. Vui lòng kiểm tra lại."
        case .userDataLoadFailed:
            return "Không thể tải thông tin người dùng. Vui lòng thử lại sau."
        case .settingsSaveFailed:
            return "Không thể lưu cài đặt. Vui lòng thử lại sau."
        case .networkError(let message):
            return "Lỗi kết nối: \(message)"
        }
    }
    
    /// Cung cấp hướng dẫn khắc phục
    var recoverySuggestion: String? {
        switch self {
        case .imageLoadFailed, .userDataLoadFailed, .networkError:
            return "Kiểm tra kết nối mạng và thử lại. Nếu vấn đề vẫn tiếp diễn, vui lòng liên hệ hỗ trợ."
        case .invalidEmail:
            return "Đảm bảo email được nhập chính xác và có định dạng hợp lệ."
        case .settingsSaveFailed:
            return "Khởi động lại ứng dụng và thử lại. Nếu vấn đề vẫn tiếp diễn, vui lòng liên hệ hỗ trợ."
        }
    }
} 