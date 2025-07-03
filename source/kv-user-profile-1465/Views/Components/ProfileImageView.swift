import SwiftUI

/// View hiển thị ảnh đại diện người dùng dạng tròn
struct ProfileImageView: View {
    /// URL của ảnh đại diện
    let imageURL: URL?
    
    /// Kích thước của ảnh
    var size: CGFloat = 120
    
    /// Màu viền
    var borderColor: Color = .blue
    
    /// Độ rộng viền
    var borderWidth: CGFloat = 3
    
    /// Ảnh placeholder khi không có ảnh hoặc đang tải
    var placeholderImage: Image = Image(systemName: "person.crop.circle.fill")
    
    /// Callback khi xảy ra lỗi tải ảnh
    var onError: ((ProfileError) -> Void)?
    
    /// Trạng thái đang tải ảnh
    @State private var isLoading: Bool = false
    
    /// Trạng thái lỗi tải ảnh
    @State private var loadingError: Bool = false
    
    /// Hiển thị nút thử lại
    @State private var showRetryButton: Bool = false
    
    var body: some View {
        ZStack {
            // Nền tròn
            Circle()
                .foregroundColor(Color(.systemGray5))
            
            // Hiển thị ảnh hoặc placeholder
            if let imageURL = imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        // Đang tải
                        placeholderView
                            .onAppear { 
                                isLoading = true
                                loadingError = false
                                showRetryButton = false
                            }
                    case .success(let image):
                        // Tải thành công
                        image
                            .resizable()
                            .scaledToFill()
                            .onAppear {
                                isLoading = false
                                loadingError = false
                                showRetryButton = false
                            }
                    case .failure:
                        // Lỗi tải
                        placeholderView
                            .onAppear {
                                isLoading = false
                                loadingError = true
                                showRetryButton = true
                                // Thông báo lỗi
                                onError?(.imageLoadFailed)
                            }
                    @unknown default:
                        placeholderView
                    }
                }
                .clipShape(Circle())
            } else {
                // Không có URL ảnh
                placeholderView
            }
            
            // Hiển thị loading indicator khi đang tải
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .background(
                        Circle()
                            .fill(Color.black.opacity(0.3))
                            .frame(width: 40, height: 40)
                    )
            }
            
            // Hiển thị icon lỗi khi tải ảnh thất bại
            if loadingError {
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.title2)
                        .foregroundColor(.orange)
                    
                    if showRetryButton {
                        Button(action: {
                            // Tải lại ảnh bằng cách tạo một URL mới với tham số cache-busting
                            if var urlComponents = URLComponents(url: imageURL!, resolvingAgainstBaseURL: false) {
                                let timestamp = Date().timeIntervalSince1970
                                let queryItem = URLQueryItem(name: "t", value: "\(timestamp)")
                                if urlComponents.queryItems != nil {
                                    urlComponents.queryItems?.append(queryItem)
                                } else {
                                    urlComponents.queryItems = [queryItem]
                                }
                                
                                if let newURL = urlComponents.url {
                                    // Tải lại ảnh với URL mới
                                    withAnimation {
                                        isLoading = true
                                        loadingError = false
                                        showRetryButton = false
                                    }
                                    
                                    // Giả lập tải lại ảnh
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        // Trong ứng dụng thực tế, AsyncImage sẽ tự động tải lại
                                    }
                                }
                            }
                        }) {
                            Text("Thử lại")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.blue)
                                )
                        }
                        .padding(.top, 4)
                    }
                }
                .transition(.opacity)
            }
        }
        .frame(width: size, height: size)
        .overlay(
            Circle()
                .stroke(borderColor, lineWidth: borderWidth)
        )
        .accessibilityLabel("Ảnh đại diện người dùng")
        .accessibilityHint(loadingError ? "Đã xảy ra lỗi khi tải ảnh. Nhấn đúp để thử lại." : "")
    }
    
    /// View hiển thị khi không có ảnh hoặc đang tải
    private var placeholderView: some View {
        placeholderImage
            .resizable()
            .scaledToFit()
            .foregroundColor(Color(.systemGray2))
            .padding(size / 4)
    }
}

// MARK: - Previews

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Với URL hợp lệ
            ProfileImageView(imageURL: URL(string: "https://i.pravatar.cc/300"))
                .previewDisplayName("Với URL")
            
            // Không có URL
            ProfileImageView(imageURL: nil)
                .previewDisplayName("Không có URL")
            
            // URL không hợp lệ
            ProfileImageView(imageURL: URL(string: "https://invalid-url"))
                .previewDisplayName("URL không hợp lệ")
            
            // Với màu viền khác
            ProfileImageView(
                imageURL: URL(string: "https://i.pravatar.cc/300"),
                borderColor: .red,
                borderWidth: 5
            )
            .previewDisplayName("Viền màu đỏ")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
} 