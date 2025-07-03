# Màn Hình Hồ Sơ Người Dùng iOS SwiftUI

Dự án này triển khai một màn hình hồ sơ người dùng sử dụng SwiftUI cho iOS, tuân theo mô hình kiến trúc MVVM (Model-View-ViewModel).

## Yêu Cầu Hệ Thống
- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## Cấu Trúc Dự Án

Dự án được tổ chức theo mô hình MVVM với cấu trúc thư mục sau:

```
kv-user-profile-1465/
├── Models/              # Các mô hình dữ liệu
├── Views/               # Các thành phần giao diện người dùng
│   ├── Core/            # Các view chính của ứng dụng
│   ├── Components/      # Các component UI có thể tái sử dụng
│   └── Profile/         # Các view liên quan đến màn hình hồ sơ
├── ViewModels/          # Các view model quản lý logic nghiệp vụ
├── Utilities/           # Các tiện ích và extensions
├── Resources/           # Tài nguyên (hình ảnh, font, v.v.)
├── Assets.xcassets/     # Catalog tài sản của ứng dụng
├── Preview Content/     # Nội dung xem trước SwiftUI
└── kv_user_profile_1465App.swift  # Điểm vào của ứng dụng
```

## Tính Năng

Màn hình hồ sơ người dùng bao gồm:
- Hiển thị ảnh đại diện người dùng (hình tròn với viền)
- Hiển thị tên người dùng
- Hiển thị email người dùng
- Công tắc bật/tắt thông báo với lưu trữ trạng thái

## Cách Sử Dụng

1. Clone repository này
2. Mở tệp `kv-user-profile-1465.xcodeproj` trong Xcode
3. Chọn thiết bị mục tiêu hoặc simulator
4. Nhấn Run (⌘+R)

## Quản Lý Trạng Thái

Dự án này sử dụng các cơ chế quản lý trạng thái của SwiftUI:
- `@State` cho trạng thái UI cục bộ
- `@StateObject` cho view model
- `@Published` cho dữ liệu phản ứng trong ObservableObject
- `@AppStorage` cho lưu trữ cài đặt người dùng

## Tài Liệu

Tham khảo tài liệu trong thư mục `/docs` để biết thêm chi tiết:
- `todo_plan.md`: Kế hoạch triển khai dự án
- `rule.md`: Các quy tắc phát triển dự án
- `requirements.md`: Yêu cầu của dự án