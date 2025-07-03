import Foundation
import SwiftUI
import Combine

/// ViewModel quản lý dữ liệu và logic cho màn hình hồ sơ người dùng
class ProfileViewModel: ObservableObject {
    // MARK: - Published Properties
    
    /// Dữ liệu người dùng hiện tại
    @Published var user: User?
    
    /// Trạng thái đang tải dữ liệu
    @Published var isLoading: Bool = false
    
    /// Thông báo lỗi hiện tại (nếu có)
    @Published var error: ProfileError?
    
    /// Trạng thái bật/tắt thông báo
    @Published var isNotificationEnabled: Bool {
        didSet {
            saveNotificationSetting()
        }
    }
    
    // MARK: - Private Properties
    
    /// Khóa lưu trữ cài đặt thông báo trong UserDefaults
    private let notificationSettingKey = "isNotificationEnabled"
    
    /// Bộ hủy cho các subscription
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    
    init() {
        // Khôi phục cài đặt thông báo từ UserDefaults
        self.isNotificationEnabled = UserDefaults.standard.bool(forKey: notificationSettingKey)
        
        // Mặc định tải dữ liệu người dùng mẫu (trong ứng dụng thực tế, bạn sẽ tải từ API hoặc cơ sở dữ liệu)
        loadUser()
    }
    
    // MARK: - Public Methods
    
    /// Tải thông tin người dùng
    /// Trong ứng dụng thực tế, phương thức này sẽ gọi API hoặc truy vấn cơ sở dữ liệu
    func loadUser() {
        isLoading = true
        error = nil
        
        // Mô phỏng mạng delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            // Trong ứng dụng thực tế, đây sẽ là kết quả từ API
            self.user = User.sample
            self.isLoading = false
        }
    }
    
    /// Xác thực email của người dùng
    /// - Parameter email: Email cần xác thực
    /// - Returns: Kết quả xác thực
    func validateUserEmail() -> Result<String, ProfileError> {
        guard let email = user?.email else {
            return .failure(.userDataLoadFailed)
        }
        
        return EmailValidator.validate(email)
    }
    
    /// Cập nhật cài đặt thông báo
    /// - Parameter enabled: Trạng thái bật/tắt mới
    func updateNotificationSetting(enabled: Bool) {
        isNotificationEnabled = enabled
    }
    
    // MARK: - Private Methods
    
    /// Lưu cài đặt thông báo vào UserDefaults
    private func saveNotificationSetting() {
        UserDefaults.standard.set(isNotificationEnabled, forKey: notificationSettingKey)
    }
}

// MARK: - Preview Helpers

extension ProfileViewModel {
    /// Tạo một instance ViewModel với dữ liệu mẫu cho SwiftUI Preview
    static var preview: ProfileViewModel {
        let viewModel = ProfileViewModel()
        viewModel.user = User.sample
        return viewModel
    }
} 