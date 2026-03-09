# Câu hỏi yêu cầu chức năng STAFF (Vesper)

## Đặt bàn (Chờ xác nhận)
- Quy tắc “không đến sau 15 phút” xử lý cọc và trả bàn thế nào?
quá 15p không đén thì tiền cộng  được thu về là note là tiền cộc bàn trở lại trạng thái rãnh
- Khi xác nhận/hủy có yêu cầu nhập ghi chú, lý do, người thực hiện không?đi hủy có lý do và xác nhậnnhận
- Có hiển thị timeline lịch hẹn và lọc theo ca/khu vực/bàn không?
cócó
- Có cho phép đổi giờ/bàn trước khi xác nhận? Quy tắc tránh trùng lịch?
cócó
- Cơ chế tìm khách theo số điện thoại/email/tên cần mức chính xác ra sao?
- Có gửi SMS/Email cho khách khi xác nhận/hủy/đổi lịch không?
- Có hỗ trợ đặt món trước (pre-order) gắn với đặt bàn? Cách tính cọc?
không cầncần
- Danh sách có auto-refresh realtime hay dùng chu kỳ làm mới bao nhiêu giây?
không cầncần
- Phân quyền duyệt/hủy: STAFF, ADMIN; có lưu nhật ký thao tác chi tiết không?
khôngkhông
- Báo cáo đặt bàn theo ngày/tuần/tháng, tỉ lệ no-show, lý do hủy cần định dạng gì?

## Món đang chế biến (Đơn hàng)
- Trạng thái chi tiết cần hỗ trợ: PENDING, PREPARING, READY, SERVED… mức nào?
PENDING, PREPARING, READY, SERVED
- Hiển thị theo khu/bếp/line cook và ưu tiên ra món theo quy tắc nào?
ưu tiên phòng vip 
- Cần thời gian ước tính hoàn thành (ETA) và cảnh báo quá hạn không?
cái nào quá 10p thì báo đỏ lênlên
- Gộp các món giống nhau để tối ưu thao tác bếp có cần thiết không?
cócó
- Quy tắc chuyển trạng thái: ai được chuyển, có yêu cầu xác nhận/scan không?
chưa biueetsbiueets
- Có in phiếu bếp/nhãn món? Yêu cầu ngôn ngữ, khổ giấy?
chưa biétbiét
- Ghi chú dị ứng/ưu tiên VIP hiển thị nổi bật như thế nào?
món của phognf vip dẻ chữ màu vàngvàng
- Cơ chế cập nhật realtime (WebSocket) hay polling? Tần suất?
- Nhật ký thao tác (ai, khi nào, thay đổi gì) cần mức chi tiết nào?
- Thống kê thời gian chế biến trung bình theo món/ca/đầu bếp/đơn?
tạp biểu đồ thời gian ra món 

## Quản lý bàn
- Bố cục sơ đồ: cần kéo-thả hay danh sách theo khu/tầng?
- Trạng thái bàn chi tiết (AVAILABLE, OCCUPIED, CLEANING, MAINTENANCE…) dùng đến đâu?
AVAILABLE, OCCUPIED, CLEANING, MAINTENANCE
- Giữ bàn tạm khi khách vừa vào trong bao lâu? Auto-release?
không biết cái này là gì ko làmlàm
- Gộp/tách/chuyển bàn: quy trình, điều kiện, ảnh hưởng hóa đơn/đơn món?
không cho gop tach bàn nữanữa
- Cảnh báo quá tải (khách > sức chứa) xử lý thế nào? Cho phép vượt?
chỉ có phép hơn 1 ngườingười
- Lọc/sắp xếp bàn theo khu/sức chứa/trạng thái/đặt trước?
nên có cái lọc như nàynày
- Phân quyền thay đổi trạng thái bàn; có yêu cầu xác nhận kép không?
khôngkhông
- Lưu nhật ký thay đổi bàn (từ → đến, ai thực hiện, thời gian) mức chi tiết?
- Báo cáo sử dụng bàn: tỉ lệ sử dụng, thời gian chiếm dụng trung bình, theo ca?
ghi lại tầng suất sử dụng bàn bàng nào có thời gian sử dụgn nhiuef bàn nào được yêu thích thì ghi làm cho nổi bậtbật
- Đồng bộ với đặt bàn/đơn hàng để ngăn xung đột trạng thái?
chức năng này đẻ sausau

## Bảng bếp
- Bố cục theo thứ tự ưu tiên, theo thời gian order hay theo station?
- “Bắn món” theo batch; khóa thao tác sau khi done có cần không?
- Phân quyền: bếp đánh dấu done/ready, phục vụ đánh dấu picked-up?
- Cảnh báo quá hạn (màu/nháy); có snooze/acknowledge cảnh báo?
- Đồng bộ item-level với ghi chú/topping; hiển thị tối ưu trên màn hình bếp?
- Hỗ trợ thiết bị cảm ứng/phím tắt; chế độ TV chữ lớn?
- In nhãn món khi ready? Nội dung nhãn chuẩn gồm những gì?
- Ghi nhận thời điểm bắt đầu/hoàn thành để đo hiệu suất từng station?
- Khôi phục trạng thái khi reload/trục trặc mạng đảm bảo không mất thao tác?
- Tích hợp âm thanh/chuông khi có món ưu tiên/khẩn cấp?

## Thanh toán
- Hình thức: tiền mặt, QR, thẻ, e-wallet; hỗ trợ tách hóa đơn (split bill)?
- Chiết khấu/khuyến mãi/voucher: theo món/hóa đơn; xử lý xung đột rule?
- Phí phục vụ/thuế cấu hình theo %/khung giờ; hiển thị minh bạch?
- Trả trước/đặt cọc và bù trừ lúc thanh toán: quy trình cụ thể?
- Hoàn tiền/điều chỉnh: phê duyệt, nhật ký lý do, hạn mức?
- Điểm thành viên: tích/đổi điểm; làm tròn và hiển thị ra sao?
- Phân quyền: ai được sửa đơn/giảm giá; kiểm soát theo ca?
- Báo cáo theo ca/nhân viên/phương thức; xuất CSV/PDF cần mẫu?
- Kết ca: đối soát tiền mặt, lệch tiền; in biên bản và gửi email?
- In hóa đơn: khổ giấy, ngôn ngữ, QR hóa đơn, chữ ký số (nếu có)?

## Yêu cầu chung
- Đa ngôn ngữ và font/encoding đảm bảo tiếng Việt mọi nơi?
- Realtime: WebSocket hay polling; ngưỡng tải và tối ưu?
- Nhật ký hành động: lưu thời gian sửa/thêm/xóa, người thực hiện, nội dung thay đổi?
- Phân quyền: ADMIN/STAFF và vai trò phụ (host, runner, cashier)?
- Thông báo: tại chỗ, email, SMS; trung tâm thông báo tổng hợp?
- Offline/đứt mạng: trải nghiệm tối thiểu và đồng bộ lại ra sao?
- Accessibility: phím tắt, tương phản cao, cỡ chữ lớn cho bếp?
- In ấn: hỗ trợ máy in hóa đơn/nhãn; cấu hình theo quầy?
- Sao lưu/khôi phục cấu hình (bàn, khu, ca, thuế/phí) và môi trường?
- Bảo mật: session timeout, khóa nhanh màn hình, audit, rate limit?
