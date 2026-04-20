package common;

public enum AppMessage {
    // Định nghĩa các loại lỗi: TÊN_GỢI_NHỚ(Mã_URL, Nội_dung_hiển_thị, Loại_CSS)

    // Lỗi đăng nhập
    INVALID_CREDENTIALS("err1", "Tên đăng nhập hoặc mật khẩu không đúng.", "error"),
    NOT_LOGGED_IN("err2", "Vui lòng đăng nhập để tiếp tục.", "warning"),

    // Fallback cho các lỗi không xác định
    UNKNOWN_ERROR("err99", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại.", "error");

    private final String code;
    private final String message;
    private final String type;

    // Constructor
    AppMessage(String code, String message, String type) {
        this.code = code;
        this.message = message;
        this.type = type;
    }

    // Hàm cực kỳ quan trọng: Tìm đối tượng Enum dựa vào mã "err1", "err2" trên URL
    public static AppMessage fromCode(String code) {
        if (code == null || code.trim().isEmpty())
            return null;

        for (AppMessage msg : AppMessage.values()) {
            if (msg.getCode().equals(code)) {
                return msg;
            }
        }
        return UNKNOWN_ERROR; // Nếu trên URL truyền mã bậy bạ (ví dụ: ?error=abc), trả về lỗi mặc định
    }

    // Getters
    public String getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public String getType() {
        return type;
    }
}
