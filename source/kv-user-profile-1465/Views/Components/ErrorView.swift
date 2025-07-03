import SwiftUI

/// View hiển thị thông báo lỗi
struct ErrorView: View {
    /// Lỗi cần hiển thị
    let error: ProfileError
    
    /// Callback khi người dùng nhấn nút thử lại
    var onRetry: (() -> Void)?
    
    /// Callback khi người dùng nhấn nút đóng
    var onDismiss: (() -> Void)?
    
    /// Hiển thị nút thử lại
    var showRetryButton: Bool = true
    
    var body: some View {
        VStack(spacing: 15) {
            // Icon lỗi
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.largeTitle)
                .foregroundColor(.orange)
            
            // Tiêu đề lỗi
            Text(error.errorDescription ?? "Đã xảy ra lỗi")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            // Hướng dẫn khắc phục
            if let recoverySuggestion = error.recoverySuggestion {
                Text(recoverySuggestion)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            // Các nút hành động
            HStack(spacing: 20) {
                // Nút thử lại
                if showRetryButton {
                    Button(action: {
                        onRetry?()
                    }) {
                        Text("Thử lại")
                            .fontWeight(.medium)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                            )
                            .foregroundColor(.white)
                    }
                }
                
                // Nút đóng
                Button(action: {
                    onDismiss?()
                }) {
                    Text("Đóng")
                        .fontWeight(.medium)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                        .foregroundColor(.blue)
                }
            }
            .padding(.top, 10)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        )
        .padding()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Thông báo lỗi: \(error.errorDescription ?? "Đã xảy ra lỗi")")
        .accessibilityHint(error.recoverySuggestion ?? "")
    }
}

// MARK: - Previews

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Lỗi tải ảnh
            ErrorView(error: .imageLoadFailed)
                .previewDisplayName("Lỗi tải ảnh")
            
            // Lỗi email không hợp lệ
            ErrorView(error: .invalidEmail, showRetryButton: false)
                .previewDisplayName("Email không hợp lệ")
            
            // Lỗi mạng
            ErrorView(error: .networkError("Không thể kết nối đến máy chủ"))
                .previewDisplayName("Lỗi mạng")
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
} 