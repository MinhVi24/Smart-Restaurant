/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package configs;

/**
 *
 * @author TRUNG TIN
 */



public class GoogleConfig {

    public static final String GOOGLE_CLIENT_ID =
            "819113969220-ng9cco5jvgiugtekfq9aoluj194j2e9f.apps.googleusercontent.com";

    public static final String GOOGLE_CLIENT_SECRET =
            "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";

    // QUAN TRỌNG: phải trỏ về servlet /login-google
    public static final String GOOGLE_REDIRECT_URI =
            "http://localhost:8080/Smart-Restaurant/login-google";

    public static final String GOOGLE_LINK_GET_TOKEN =
            "https://oauth2.googleapis.com/token";

    public static final String GOOGLE_LINK_GET_USER_INFO =
            "https://www.googleapis.com/oauth2/v2/userinfo?access_token=";
}