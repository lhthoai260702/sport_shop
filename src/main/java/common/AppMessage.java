package common;

public enum AppMessage {
    // Định nghĩa các loại lỗi: TÊN_GỢI_NHỚ(Mã_URL, Nội_dung_hiển_thị, Loại_CSS)

    // Lỗi đăng nhập
    INVALID_CREDENTIALS("err1", "Tên đăng nhập hoặc mật khẩu không đúng.", "error"),
    NOT_LOGGED_IN("err2", "Vui lòng đăng nhập để tiếp tục.", "warning"),

    // Lỗi tạo sản phẩm
    DUPLICATE_ID("err3", "Mã hàng hóa đã tồn tại. Vui lòng thử lại.", "error"),
    INVALID_UNIT_PRIC_1("err4", "Đơn giá không được để trống.", "error"),
    INVALID_UNIT_PRICE_2("err5", "Giá bán không hợp lệ. Vui lòng nhập số dương.", "error"),
    INVALID_STOCK_QUANTITY_1("err6", "Số lượng tồn kho không được để trống.", "error"),
    INVALID_STOCK_QUANTITY_2("err7", "Số lượng tồn kho không hợp lệ. Vui lòng nhập số dương.", "error"),
    INVALID_PRODUCT_NAME("err8", "Tên hàng hóa không được để trống.", "error"),
    INVALID_CATEGORY("err9", "Danh mục không được để trống.", "error"),

    // Fallback cho các lỗi không xác định
    UNKNOWN_ERROR("err99", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại.", "error"),

    // thành công
    DELETE_SUCCESS("success1", "Xóa sản phẩm thành công!", "success"),
    CREATE_SUCCESS("success2", "Tạo sản phẩm thành công!", "success"),
    UPDATE_SUCCESS("success3", "Cập nhật sản phẩm thành công!", "success");

    private final String code;
    private final String message;
    private final String type;

    // Constructor
    AppMessage(String code, String message, String type) {
        this.code = code;
        this.message = message;
        this.type = type;
    }

    public static AppMessage fromCode(String code) {
        if (code == null || code.trim().isEmpty())
            return null;

        for (AppMessage msg : AppMessage.values()) {
            if (msg.getCode().equals(code)) {
                return msg;
            }
        }
        return UNKNOWN_ERROR;
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
