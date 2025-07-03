# Quản Lý Trạng Thái Trong Ứng Dụng Hồ Sơ Người Dùng

Tài liệu này mô tả chi tiết cách quản lý trạng thái trong ứng dụng Hồ Sơ Người Dùng sử dụng SwiftUI và mô hình MVVM.

## Tổng Quan

Ứng dụng sử dụng các cơ chế quản lý trạng thái của SwiftUI để đảm bảo UI luôn phản ánh chính xác dữ liệu và trạng thái hiện tại. Các cơ chế chính được sử dụng bao gồm:

- `@State`: Quản lý trạng thái cục bộ trong view
- `@StateObject`: Quản lý đối tượng ViewModel
- `@Published`: Phát hiện thay đổi trong ViewModel
- `@Binding`: Chia sẻ trạng thái giữa các view
- `@AppStorage`: Lưu trữ trạng thái giữa các lần khởi động ứng dụng

## Biến Trạng Thái Trong ProfileView

### Biến @State

| Biến | Kiểu | Mục Đích | Chuyển Đổi Trạng Thái | Lưu Trữ |
|------|------|----------|------------------------|---------|
| `showAlert` | `Bool` | Điều khiển hiển thị alert | Thay đổi khi người dùng tương tác với toggle thông báo | Không lưu trữ |
| `alertTitle` | `String` | Tiêu đề của alert | Cập nhật trước khi hiển thị alert | Không lưu trữ |
| `alertMessage` | `String` | Nội dung của alert | Cập nhật trước khi hiển thị alert | Không lưu trữ |
| `showErrorView` | `Bool` | Điều khiển hiển thị ErrorView | Thay đổi khi xảy ra lỗi hoặc khi người dùng đóng ErrorView | Không lưu trữ |
| `currentError` | `ProfileError?` | Lỗi hiện tại cần hiển thị | Cập nhật khi xảy ra lỗi | Không lưu trữ |

### Biến @StateObject

| Biến | Kiểu | Mục Đích | Chuyển Đổi Trạng Thái | Lưu Trữ |
|------|------|----------|------------------------|---------|
| `viewModel` | `ProfileViewModel` | Quản lý dữ liệu và logic | Thay đổi khi dữ liệu người dùng hoặc cài đặt thay đổi | Một phần được lưu trữ thông qua UserDefaults và AppStorage |

## Biến Trạng Thái Trong ProfileViewModel

### Biến @Published

| Biến | Kiểu | Mục Đích | Chuyển Đổi Trạng Thái | Lưu Trữ |
|------|------|----------|------------------------|---------|
| `user` | `User?` | Dữ liệu người dùng hiện tại | Cập nhật khi tải dữ liệu người dùng | Không lưu trữ |
| `isLoading` | `Bool` | Trạng thái đang tải dữ liệu | Thay đổi khi bắt đầu/kết thúc tải dữ liệu | Không lưu trữ |
| `error` | `ProfileError?` | Lỗi hiện tại trong ViewModel | Cập nhật khi xảy ra lỗi | Không lưu trữ |
| `isNotificationEnabled` | `Bool` | Trạng thái bật/tắt thông báo | Thay đổi khi người dùng tương tác với toggle | Lưu trữ trong UserDefaults |

## Biến Trạng Thái Trong Components

### ProfileImageView

| Biến | Kiểu | Mục Đích | Chuyển Đổi Trạng Thái | Lưu Trữ |
|------|------|----------|------------------------|---------|
| `isLoading` | `Bool` | Trạng thái đang tải ảnh | Thay đổi khi bắt đầu/kết thúc tải ảnh | Không lưu trữ |
| `loadingError` | `Bool` | Trạng thái lỗi tải ảnh | Cập nhật khi tải ảnh thất bại | Không lưu trữ |
| `showRetryButton` | `Bool` | Hiển thị nút thử lại | Cập nhật khi tải ảnh thất bại | Không lưu trữ |

### NotificationToggleView

| Biến | Kiểu | Mục Đích | Chuyển Đổi Trạng Thái | Lưu Trữ |
|------|------|----------|------------------------|---------|
| `isEnabled` | `Binding<Bool>` | Trạng thái bật/tắt thông báo | Thay đổi khi người dùng tương tác với toggle | Lưu trữ trong ViewModel |

## Lưu Trữ Trạng Thái

### UserDefaults

Ứng dụng sử dụng UserDefaults để lưu trữ cài đặt thông báo giữa các lần khởi động. Khóa được sử dụng là:

```swift
private let notificationSettingKey = "isNotificationEnabled"
```

### AppStorage

Ứng dụng cũng sử dụng @AppStorage để lưu trữ cài đặt thông báo, cung cấp cách truy cập trực tiếp từ SwiftUI. Khóa được sử dụng là:

```swift
private static let notificationKey = "user_notification_enabled"
```

## Luồng Dữ Liệu

1. **Khởi tạo**:
   - ProfileView tạo một StateObject của ProfileViewModel
   - ProfileViewModel khôi phục cài đặt thông báo từ UserDefaults
   - ProfileViewModel tải dữ liệu người dùng mẫu

2. **Tương tác người dùng**:
   - Khi người dùng tương tác với NotificationToggleView, trạng thái isEnabled thay đổi
   - Thay đổi được truyền đến ProfileViewModel thông qua Binding
   - ProfileViewModel lưu trạng thái mới vào UserDefaults và AppStorage

3. **Xử lý lỗi**:
   - Khi xảy ra lỗi (ví dụ: tải ảnh thất bại), ProfileImageView gọi callback onError
   - ProfileView cập nhật currentError và hiển thị ErrorView
   - Người dùng có thể thử lại hoặc đóng ErrorView

4. **Đồng bộ trạng thái**:
   - Khi ProfileView xuất hiện, nó gọi syncNotificationSettings() để đảm bảo UserDefaults và AppStorage có cùng giá trị

## Cơ Chế Khôi Phục Trạng Thái

Ứng dụng triển khai cơ chế khôi phục trạng thái để đảm bảo UI phản ánh chính xác trạng thái được lưu trữ:

1. Khi ProfileViewModel được khởi tạo, nó khôi phục cài đặt thông báo từ UserDefaults
2. Khi ProfileView xuất hiện, nó gọi syncNotificationSettings() để đồng bộ trạng thái
3. Nếu có sự khác biệt giữa UserDefaults và AppStorage, AppStorage được cập nhật để phù hợp với UserDefaults

## Tối Ưu Hiệu Năng

Để tối ưu hiệu năng quản lý trạng thái, ứng dụng áp dụng các nguyên tắc sau:

1. Sử dụng @State chỉ cho trạng thái cục bộ trong view
2. Sử dụng @StateObject để đảm bảo ViewModel tồn tại trong vòng đời của view
3. Sử dụng @Published chỉ cho các thuộc tính cần kích hoạt cập nhật UI
4. Tránh cập nhật trạng thái không cần thiết để giảm thiểu việc vẽ lại UI

## Kết Luận

Cách tiếp cận quản lý trạng thái trong ứng dụng Hồ Sơ Người Dùng tuân theo các nguyên tắc tốt nhất của SwiftUI và mô hình MVVM. Bằng cách tách biệt rõ ràng giữa dữ liệu, logic và UI, ứng dụng dễ dàng mở rộng và bảo trì. 