# Quy Tắc Phát Triển Dự Án

## Quy Tắc Cơ Bản

### Tuân Thủ Kế Hoạch Triển Khai
- Luôn tuân theo và thực hiện các nhiệm vụ theo đúng thứ tự trong tài liệu kế hoạch triển khai.
- Không bỏ qua bất kỳ bước nào trong kế hoạch, trừ khi có lý do chính đáng và được ghi chép lại.
- Đánh dấu vào checkbox khi hoàn thành từng nhiệm vụ trong tài liệu kế hoạch.

### Mô Tả Nhiệm Vụ
- Luôn cung cấp mô tả rõ ràng về những gì bạn muốn hoặc cần thực hiện trước khi bắt đầu nhiệm vụ.
- Mô tả nên bao gồm mục tiêu, phương pháp thực hiện và kết quả mong đợi.
- Sử dụng ngôn ngữ rõ ràng, chính xác và dễ hiểu trong các mô tả.

### Tóm Tắt Sau Mỗi Nhiệm Vụ
- Luôn cung cấp bản tóm tắt sau khi hoàn thành mỗi nhiệm vụ.
- Tóm tắt nên bao gồm: những gì đã hoàn thành, những thách thức gặp phải, cách giải quyết, và bài học kinh nghiệm.
- Đánh giá liệu nhiệm vụ có đạt được kết quả mong đợi hay không, nếu không thì giải thích lý do.

## Quy Tắc Mã Nguồn

### Tổ Chức Mã Nguồn
- Tuân thủ mô hình MVVM đã được định nghĩa trong kế hoạch.
- Duy trì cấu trúc thư mục rõ ràng và nhất quán.
- Tách biệt rõ ràng giữa Model, View và ViewModel.

### Coding Style
- Tuân thủ các quy ước đặt tên của Swift (camelCase).
- Sử dụng tên biến có ý nghĩa, dễ hiểu.
- Thêm tài liệu inline cho các logic phức tạp.
- Áp dụng cơ chế xử lý lỗi thích hợp với Result types.

### Quản Lý Trạng Thái
- Sử dụng @State cho trạng thái UI cục bộ.
- Sử dụng @StateObject cho các instance view model.
- Sử dụng @Published trong ObservableObject cho dữ liệu phản ứng.
- Cân nhắc @AppStorage cho lưu trữ cài đặt.

## Quy Trình Làm Việc

### Quản Lý Phiên Bản
- Commit mã nguồn sau khi hoàn thành mỗi nhiệm vụ có ý nghĩa.
- Viết commit message rõ ràng, mô tả những gì đã thay đổi.
- Tạo branch riêng cho mỗi tính năng lớn.

### Đánh Giá Mã Nguồn
- Thực hiện tự đánh giá mã nguồn trước khi đánh dấu nhiệm vụ là hoàn thành.
- Đảm bảo mã nguồn không có cảnh báo khi biên dịch.
- Kiểm tra tính nhất quán và tuân thủ các quy tắc đã định nghĩa.

### Báo Cáo Tiến Độ
- Cập nhật tài liệu kế hoạch triển khai thường xuyên với trạng thái mới nhất.
- Ghi lại bất kỳ sự thay đổi nào so với kế hoạch ban đầu và lý do.
- Đảm bảo tất cả các bên liên quan đều nhận thức được tiến độ hiện tại.

## Lưu Ý Quan Trọng
- Những quy tắc này có thể được cập nhật khi dự án phát triển.
- Mọi thay đổi đối với quy tắc nên được thảo luận và đồng thuận bởi nhóm phát triển.
- Trong trường hợp xung đột, hãy tham khảo tài liệu này làm nguồn thông tin chính thức.
