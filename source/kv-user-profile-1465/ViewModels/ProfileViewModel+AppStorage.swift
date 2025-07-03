import Foundation
import SwiftUI

/// Extension cung cấp hỗ trợ AppStorage cho ProfileViewModel
extension ProfileViewModel {
    /// Lớp bọc (wrapper) để sử dụng @AppStorage trong SwiftUI
    class NotificationSettings: ObservableObject {
        /// Khóa lưu trữ cài đặt thông báo
        private static let notificationKey = "user_notification_enabled"
        
        /// Trạng thái bật/tắt thông báo, được lưu trữ bằng @AppStorage
        @AppStorage(notificationKey) var isEnabled: Bool = false
        
        /// Singleton instance
        static let shared = NotificationSettings()
        
        private init() {}
    }
    
    /// Khôi phục cài đặt thông báo từ AppStorage
    func restoreNotificationSettingFromAppStorage() {
        self.isNotificationEnabled = NotificationSettings.shared.isEnabled
    }
    
    /// Lưu cài đặt thông báo vào AppStorage
    func saveNotificationSettingToAppStorage() {
        NotificationSettings.shared.isEnabled = self.isNotificationEnabled
    }
    
    /// Đồng bộ cài đặt thông báo giữa UserDefaults và AppStorage
    func syncNotificationSettings() {
        // Đảm bảo UserDefaults và AppStorage có cùng giá trị
        if NotificationSettings.shared.isEnabled != self.isNotificationEnabled {
            NotificationSettings.shared.isEnabled = self.isNotificationEnabled
        }
    }
} 