import SwiftUI

/// View hiển thị công tắc bật/tắt thông báo
struct NotificationToggleView: View {
    /// Binding trạng thái bật/tắt thông báo
    @Binding var isEnabled: Bool
    
    /// Mô tả về công tắc
    var description: String = "Thông báo"
    
    /// Callback được gọi khi trạng thái thay đổi
    var onToggleChanged: ((Bool) -> Void)?
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                // Icon thông báo
                Image(systemName: isEnabled ? "bell.fill" : "bell.slash")
                    .font(.title2)
                    .foregroundColor(isEnabled ? .blue : .gray)
                    .frame(width: 30)
                    .accessibilityHidden(true)
                
                // Mô tả
                Text(description)
                    .font(.headline)
                
                Spacer()
                
                // Công tắc bật/tắt với phản hồi haptic
                Toggle("", isOn: $isEnabled)
                    .labelsHidden()
                    .onChange(of: isEnabled) { newValue in
                        // Tạo phản hồi haptic
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                        
                        // Gọi callback nếu có
                        onToggleChanged?(newValue)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
            }
            
            // Hiển thị trạng thái hiện tại
            Text(isEnabled ? "Đã bật thông báo" : "Đã tắt thông báo")
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(description): \(isEnabled ? "Đã bật" : "Đã tắt")")
        .accessibilityHint("Nhấn đúp để \(isEnabled ? "tắt" : "bật") thông báo")
    }
}

// MARK: - Previews

struct NotificationToggleView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var isNotificationEnabled: Bool = false
        @State private var isSecondNotificationEnabled: Bool = true
        
        var body: some View {
            VStack(spacing: 20) {
                // Trạng thái đã tắt
                NotificationToggleView(isEnabled: $isNotificationEnabled)
                    .previewDisplayName("Thông báo đã tắt")
                
                // Trạng thái đã bật với mô tả tùy chỉnh
                NotificationToggleView(
                    isEnabled: $isSecondNotificationEnabled,
                    description: "Thông báo cập nhật"
                )
                .previewDisplayName("Thông báo đã bật")
            }
            .padding()
            .previewLayout(.sizeThatFits)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
} 