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
    
    /// Trạng thái đang tải ảnh
    @State private var isLoading: Bool = false
    
    /// Trạng thái lỗi tải ảnh
    @State private var loadingError: Bool = false
    
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
                            .onAppear { isLoading = true }
                    case .success(let image):
                        // Tải thành công
                        image
                            .resizable()
                            .scaledToFill()
                            .onAppear {
                                isLoading = false
                                loadingError = false
                            }
                    case .failure:
                        // Lỗi tải
                        placeholderView
                            .onAppear {
                                isLoading = false
                                loadingError = true
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
        }
        .frame(width: size, height: size)
        .overlay(
            Circle()
                .stroke(borderColor, lineWidth: borderWidth)
        )
        .accessibilityLabel("Ảnh đại diện người dùng")
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