package model.bo;

import model.dao.CheckLoginDAO;

public class CheckLoginBO {
    CheckLoginDAO checkLoginDAO = new CheckLoginDAO();

    public int getAccountRole(String tenDangNhap, String matKhau) {
        // 0: Tài khoản không hợp lệ, 1: Admin, 2: User
        return checkLoginDAO.getAccountRole(tenDangNhap, matKhau);
    }

}
