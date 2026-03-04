# HƯỚNG DẪN CẤU HÌNH THANH TOÁN QR CODE

## 🏦 Cấu hình thông tin ngân hàng

Mở file: `src/main/webapp/views/custumer/checkout/checkout.jsp`

Tìm đến dòng 15-20 và thay đổi thông tin:

```javascript
const BANK_CONFIG = {
    bankId: 'VCB',              // Mã ngân hàng của bạn
    accountNo: '1234567890',     // Số tài khoản của bạn
    accountName: 'MAISON DOR',   // Tên chủ tài khoản (VIẾT HOA, KHÔNG DẤU)
    template: 'compact'          // Giữ nguyên
};
```

## 📋 Danh sách mã ngân hàng (bankId)

| Ngân hàng | Mã (bankId) |
|-----------|-------------|
| Vietcombank | VCB |
| Techcombank | TCB |
| MB Bank | MB |
| ACB | ACB |
| VPBank | VPB |
| TPBank | TPB |
| Sacombank | STB |
| VIB | VIB |
| MSB | MSB |
| BIDV | BIDV |
| Agribank | AGRIBANK |
| VietinBank | CTG |
| HDBank | HDB |
| SHB | SHB |
| OCB | OCB |
| SeABank | SEAB |
| VietCapitalBank | VCCB |
| SCB | SCB |
| LienVietPostBank | LPB |
| BacABank | BAB |
| PVcomBank | PVCB |
| Oceanbank | OCEANBANK |
| NCB | NCB |
| ShinhanBank | SHBVN |
| ABBANK | ABB |
| VietABank | VAB |
| NamABank | NAB |
| PGBank | PGB |
| VietBank | VIETBANK |
| BaoVietBank | BVB |
| GPBank | GPB |
| DongABank | DAB |
| Eximbank | EIB |
| Saigonbank | SGB |
| KienLongBank | KLB |
| VRB | VRB |

## 🎯 Ví dụ cấu hình thực tế

### Ví dụ 1: Vietcombank
```javascript
const BANK_CONFIG = {
    bankId: 'VCB',
    accountNo: '0123456789',
    accountName: 'NGUYEN VAN A',
    template: 'compact'
};
```

### Ví dụ 2: Techcombank
```javascript
const BANK_CONFIG = {
    bankId: 'TCB',
    accountNo: '19036512345678',
    accountName: 'TRAN THI B',
    template: 'compact'
};
```

### Ví dụ 3: MB Bank
```javascript
const BANK_CONFIG = {
    bankId: 'MB',
    accountNo: '0123456789012',
    accountName: 'LE VAN C',
    template: 'compact'
};
```

## ✅ Cách hoạt động

1. **Khách hàng chọn mức cọc** (30%, 50%, hoặc 100%)
2. **Hệ thống tự động tạo mã QR** với:
   - Số tiền chính xác
   - Nội dung chuyển khoản: "Dat ban MD[timestamp]"
   - Thông tin tài khoản của bạn
3. **Khách quét QR bằng app ngân hàng** → Thanh toán
4. **Khách nhấn "Xác Nhận Đặt Bàn"** → Hoàn tất

## 🔧 Kiểm tra QR Code

Sau khi cấu hình, test bằng cách:

1. Chạy ứng dụng
2. Đặt bàn → Chọn món → Checkout
3. Chọn mức cọc → QR code sẽ hiển thị
4. Quét bằng app ngân hàng để kiểm tra thông tin

## 📱 QR Code API

Hệ thống sử dụng **VietQR API** (img.vietqr.io) - miễn phí, không cần đăng ký.

Format URL:
```
https://img.vietqr.io/image/{BANK_ID}-{ACCOUNT_NO}-compact.png
  ?amount={AMOUNT}
  &addInfo={DESCRIPTION}
  &accountName={ACCOUNT_NAME}
```

## 🎨 Tùy chỉnh template

Có 3 template:

- `compact` - Gọn nhẹ (khuyên dùng)
- `print` - Đầy đủ thông tin
- `qr_only` - Chỉ mã QR

Thay đổi trong `BANK_CONFIG.template`

## ⚠️ Lưu ý quan trọng

1. **accountName** phải VIẾT HOA, KHÔNG DẤU
   - ✅ Đúng: `NGUYEN VAN A`
   - ❌ Sai: `Nguyễn Văn A`

2. **accountNo** phải chính xác 100%
   - Kiểm tra kỹ số tài khoản

3. **bankId** phải đúng mã ngân hàng
   - Xem bảng danh sách ở trên

## 🔐 Bảo mật

- Thông tin ngân hàng chỉ hiển thị trên frontend
- Không lưu thông tin thanh toán nhạy cảm
- Mã giao dịch unique cho mỗi đơn: `MD{timestamp}`

## 📞 Hỗ trợ

Nếu QR không hiển thị:
1. Kiểm tra kết nối internet
2. Kiểm tra thông tin BANK_CONFIG
3. Xem console log để debug
4. Hệ thống có fallback QR nếu API lỗi

---

**Chúc bạn cấu hình thành công! 🎉**
