<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<footer class="bg-[#0a0a0a] border-t border-primary/20 w-full">

    <!-- PHẦN TRÊN -->
    <div class="w-full px-16 pt-10 pb-6">

        <div class="grid grid-cols-1 md:grid-cols-3 items-start gap-12">

            <!-- Logo -->
            <div class="flex flex-col gap-5">
                <div class="flex items-center gap-4">
                    <div class="w-10 h-10 vesper-logo-motif flex items-center justify-center">
                        <span class="font-serif text-champagne-gold text-xl font-medium">V</span>
                    </div>
                    <h2 class="font-serif text-2xl font-bold tracking-[0.2em] text-champagne-gold uppercase">
                        Vesper
                    </h2>
                </div>

                <p class="text-white/50 text-sm leading-relaxed max-w-xs">
                    Nơi ánh hoàng hôn hội tụ cùng nghệ thuật ẩm thực đương đại. 
                    Vesper mang đến trải nghiệm tinh hoa trong từng khoảnh khắc, 
                    nơi vị giác và cảm xúc được đánh thức.                 </p>
            </div>

            <!-- Thông tin liên hệ -->
            <div class="flex flex-col items-center gap-6">
                <h3 class="text-champagne-gold font-serif text-xs tracking-[0.3em] uppercase">
                    Thông Tin Liên Hệ
                </h3>

                <div class="flex flex-col gap-4 text-white/60 text-sm">

                    <a href="https://maps.google.com/?q=123+Lê+Lợi+Quận+1+HCM"
                       target="_blank"
                       class="flex items-center gap-3 hover:text-primary transition">
                        <span class="material-symbols-outlined text-primary text-lg">
                            location_on
                        </span>
                        <span>123 Lê Lợi, Quận 1, TP. Hồ Chí Minh</span>
                    </a>

                    <a href="tel:+842838228888"
                       class="flex items-center gap-3 hover:text-primary transition">
                        <span class="material-symbols-outlined text-primary text-lg">
                            call
                        </span>
                        <span>+84 28 3822 8888</span>
                    </a>

                    <a href="mailto:concierge@vesper.vn"
                       class="flex items-center gap-3 hover:text-primary transition">
                        <span class="material-symbols-outlined text-primary text-lg">
                            mail
                        </span>
                        <span>concierge@vesper.vn</span>
                    </a>

                </div>
            </div>

            <!-- Giờ mở cửa -->
            <div class="flex flex-col items-end gap-4 text-sm text-white/60">
                <h3 class="text-champagne-gold font-serif text-xs tracking-[0.3em] uppercase">
                    Giờ Mở Cửa
                </h3>

                <div class="text-right space-y-1">
                    <div>Thứ Hai - Thứ Sáu: 17:00 - 23:00</div>
                    <div>Thứ Bảy - Chủ Nhật: 11:00 - 23:30</div>
                </div>
            </div>

        </div>

    </div>

    <!-- BOTTOM FULL WIDTH SÁT ĐÁY -->
    <div class="border-t border-white/10 py-4 text-white/40 text-xs">
        <div class="px-16 flex justify-between items-center">
            <p>© 2024 Vesper Luxury Restaurant. Tinh hoa ẩm thực Việt.</p>

            <div class="flex gap-8">
                <a href="#" class="hover:text-primary transition">
                    Chính sách bảo mật
                </a>
                <a href="#" class="hover:text-primary transition">
                    Điều khoản dịch vụ
                </a>
            </div>
        </div>
    </div>

</footer>