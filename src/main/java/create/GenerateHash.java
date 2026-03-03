/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package create;

/**
 *
 * @author TRUNG TIN
 */
import org.mindrot.jbcrypt.BCrypt;

public class GenerateHash {
    public static void main(String[] args) {
        String password = "admin123";  // Đổi mật khẩu tại đây
        String hash = BCrypt.hashpw(password, BCrypt.gensalt());
        System.out.println("Hash: " + hash);
        // Copy hash này vào SQL INSERT ở trên
    }
}

