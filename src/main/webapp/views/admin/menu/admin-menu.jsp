<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html class="dark" lang="vi"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Quản lí Thực đơn - Vesper</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
        <link href="https://fonts.googleapis.com" rel="preconnect"/>
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&amp;family=Inter:wght@300;400;500;600&amp;family=Material+Icons+Round&amp;display=swap" rel="stylesheet"/>
        <style type="text/tailwindcss">
            @layer base {
                body {
                    font-family: 'Inter', sans-serif;
                }
            }
            @layer components {
                .font-display {
                    font-family: 'Playfair Display', serif;
                }
                .glass-card {
                    background: rgba(22, 22, 22, 0.7);
                    backdrop-filter: blur(10px);
                    border: 1px solid rgba(212, 175, 55, 0.1);
                }
                .sidebar-active {
                    background: linear-gradient(90deg, rgba(212, 175, 55, 0.15) 0%, rgba(212, 175, 55, 0) 100%);
                    border-left: 3px solid #D4AF37;
                }
            }
            :root {
                --primary: #D4AF37;
                --background-dark: #0D0D0D;
                --card-dark: #161616;
            }
            ::-webkit-scrollbar {
                width: 6px;
            }
            ::-webkit-scrollbar-track {
                background: #0D0D0D;
            }
            ::-webkit-scrollbar-thumb {
                background: #333;
                border-radius: 10px;
            }
            ::-webkit-scrollbar-thumb:hover {
                background: #D4AF37;
            }
        </style>
        <script>
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            primary: "#D4AF37",
                            "background-light": "#F8F5F0",
                            "background-dark": "#0D0D0D",
                            "card-dark": "#161616",
                            "accent-gold": "#D4AF37",
                            "accent-red": "#FF4D4D",
                        },
                        fontFamily: {
                            display: ["Playfair Display", "serif"],
                            sans: ["Inter", "sans-serif"],
                        },
                        borderRadius: {
                            DEFAULT: "12px",
                        },
                    },
                },
            };
        </script>
    </head>
    <body class="bg-background-light dark:bg-background-dark text-slate-800 dark:text-stone-300 min-h-screen flex">
           <jsp:include page="/views/admin/includes/sidebar.jsp" />

        <main class="flex-1 overflow-y-auto bg-stone-50 dark:bg-background-dark p-8">
            <header class="mb-10 flex justify-between items-center">
                <div>
                    <h2 class="text-5xl font-display font-bold text-stone-900 dark:text-stone-100 tracking-tight">Quản lí Thực đơn Thượng Hạng</h2>
                    <div class="flex items-center gap-2 mt-3 text-stone-500 dark:text-stone-400 text-sm">
                        <span class="w-2 h-2 rounded-full bg-green-500 shadow-[0_0_8px_rgba(34,197,94,0.6)]"></span>
                        Vesper Executive Suite
                    </div>
                </div>
                <div class="flex items-center gap-4">
                    <div class="relative">
                        <input type="text" placeholder="Tìm kiếm món ăn, danh mục..." class="w-80 px-4 py-3 pl-10 bg-white dark:bg-card-dark border border-stone-200 dark:border-stone-800 rounded-xl text-sm focus:outline-none focus:border-primary">
                        <span class="material-icons-round absolute left-3 top-3 text-stone-400 text-xl">search</span>
                    </div>
                    <button onclick="openAddModal()" class="flex items-center gap-2 px-6 py-3 bg-primary text-black font-bold rounded-xl hover:shadow-lg hover:shadow-primary/20 transition-all">
                        <span class="material-icons-round">add</span>
                        Thêm Món Mới
                    </button>
                </div>
            </header>
            
            <!-- Tabs -->
            <div class="mb-8 flex gap-2 border-b border-stone-200 dark:border-stone-800">
                <button onclick="filterCategory('all')" class="tab-btn active px-6 py-3 font-medium text-sm border-b-2 border-primary text-primary">Tất cả</button>
                <button onclick="filterCategory('khai-vi')" class="tab-btn px-6 py-3 font-medium text-sm border-b-2 border-transparent text-stone-500 hover:text-primary">Khai vị</button>
                <button onclick="filterCategory('mon-chinh')" class="tab-btn px-6 py-3 font-medium text-sm border-b-2 border-transparent text-stone-500 hover:text-primary">Món chính</button>
                <button onclick="filterCategory('mon-phu')" class="tab-btn px-6 py-3 font-medium text-sm border-b-2 border-transparent text-stone-500 hover:text-primary">Món phụ</button>
                <button onclick="filterCategory('trang-mieng')" class="tab-btn px-6 py-3 font-medium text-sm border-b-2 border-transparent text-stone-500 hover:text-primary">Tráng miệng</button>
                <button onclick="filterCategory('do-uong')" class="tab-btn px-6 py-3 font-medium text-sm border-b-2 border-transparent text-stone-500 hover:text-primary">Đồ uống</button>
            </div>

            <!-- Menu Items Table -->
            <div class="glass-card bg-white dark:bg-card-dark rounded-3xl overflow-hidden">
                <table class="w-full">
                    <thead class="bg-stone-50 dark:bg-stone-900/50 border-b border-stone-200 dark:border-stone-800">
                        <tr>
                            <th class="px-6 py-4 text-left text-xs font-bold uppercase tracking-wider text-stone-500">Hình ảnh</th>
                            <th class="px-6 py-4 text-left text-xs font-bold uppercase tracking-wider text-stone-500">Tên món ăn</th>
                            <th class="px-6 py-4 text-left text-xs font-bold uppercase tracking-wider text-stone-500">Danh mục</th>
                            <th class="px-6 py-4 text-left text-xs font-bold uppercase tracking-wider text-stone-500">Giá bán (VNĐ)</th>
                            <th class="px-6 py-4 text-center text-xs font-bold uppercase tracking-wider text-stone-500">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody id="menuTableBody" class="divide-y divide-stone-200 dark:divide-stone-800">
                        <!-- Sample Data -->
                        <tr class="hover:bg-stone-50 dark:hover:bg-stone-900/30 transition-colors cursor-pointer" onclick="openEditModal('1')">
                            <td class="px-6 py-4">
                                <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Foie Gras" class="w-16 h-16 rounded-lg object-cover">
                            </td>
                            <td class="px-6 py-4">
                                <div>
                                    <p class="font-display font-bold text-lg dark:text-stone-100">Foie Gras Poêlé</p>
                                    <p class="text-xs text-stone-500">Mã: APP-001</p>
                                </div>
                            </td>
                            <td class="px-6 py-4">
                                <span class="px-3 py-1 bg-blue-500/10 text-blue-500 rounded-full text-xs font-bold border border-blue-500/20">KHAI VỊ</span>
                            </td>
                            <td class="px-6 py-4">
                                <p class="font-display font-bold text-lg text-primary">850.000</p>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <button onclick="event.stopPropagation(); openEditModal('1')" class="text-primary hover:text-primary/80">
                                    <span class="material-icons-round">edit</span>
                                </button>
                            </td>
                        </tr>
                        <tr class="hover:bg-stone-50 dark:hover:bg-stone-900/30 transition-colors cursor-pointer" onclick="openEditModal('2')">
                            <td class="px-6 py-4">
                                <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Wagyu A5" class="w-16 h-16 rounded-lg object-cover">
                            </td>
                            <td class="px-6 py-4">
                                <div>
                                    <p class="font-display font-bold text-lg dark:text-stone-100">Wagyu A5 Kagoshima</p>
                                    <p class="text-xs text-stone-500">Mã: MAIN-001</p>
                                </div>
                            </td>
                            <td class="px-6 py-4">
                                <span class="px-3 py-1 bg-red-500/10 text-red-500 rounded-full text-xs font-bold border border-red-500/20">MÓN CHÍNH</span>
                            </td>
                            <td class="px-6 py-4">
                                <p class="font-display font-bold text-lg text-primary">4.500.000</p>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <button onclick="event.stopPropagation(); openEditModal('2')" class="text-primary hover:text-primary/80">
                                    <span class="material-icons-round">edit</span>
                                </button>
                            </td>
                        </tr>
                        <tr class="hover:bg-stone-50 dark:hover:bg-stone-900/30 transition-colors cursor-pointer" onclick="openEditModal('3')">
                            <td class="px-6 py-4">
                                <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Truffle Fries" class="w-16 h-16 rounded-lg object-cover">
                            </td>
                            <td class="px-6 py-4">
                                <div>
                                    <p class="font-display font-bold text-lg dark:text-stone-100">Truffle Parmesan Fries</p>
                                    <p class="text-xs text-stone-500">Mã: SIDE-003</p>
                                </div>
                            </td>
                            <td class="px-6 py-4">
                                <span class="px-3 py-1 bg-green-500/10 text-green-500 rounded-full text-xs font-bold border border-green-500/20">MÓN PHỤ</span>
                            </td>
                            <td class="px-6 py-4">
                                <p class="font-display font-bold text-lg text-primary">280.000</p>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <button onclick="event.stopPropagation(); openEditModal('3')" class="text-primary hover:text-primary/80">
                                    <span class="material-icons-round">edit</span>
                                </button>
                            </td>
                        </tr>
                        <tr class="hover:bg-stone-50 dark:hover:bg-stone-900/30 transition-colors cursor-pointer" onclick="openEditModal('4')">
                            <td class="px-6 py-4">
                                <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Crème Brûlée" class="w-16 h-16 rounded-lg object-cover">
                            </td>
                            <td class="px-6 py-4">
                                <div>
                                    <p class="font-display font-bold text-lg dark:text-stone-100">Crème Brûlée Vanille</p>
                                    <p class="text-xs text-stone-500">Mã: DES-012</p>
                                </div>
                            </td>
                            <td class="px-6 py-4">
                                <span class="px-3 py-1 bg-purple-500/10 text-purple-500 rounded-full text-xs font-bold border border-purple-500/20">TRÁNG MIỆNG</span>
                            </td>
                            <td class="px-6 py-4">
                                <p class="font-display font-bold text-lg text-primary">320.000</p>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <button onclick="event.stopPropagation(); openEditModal('4')" class="text-primary hover:text-primary/80">
                                    <span class="material-icons-round">edit</span>
                                </button>
                            </td>
                        </tr>
                        <tr class="hover:bg-stone-50 dark:hover:bg-stone-900/30 transition-colors cursor-pointer" onclick="openEditModal('5')">
                            <td class="px-6 py-4">
                                <img src="${pageContext.request.contextPath}/assets/images/pizza.jpg" alt="Champagne" class="w-16 h-16 rounded-lg object-cover">
                            </td>
                            <td class="px-6 py-4">
                                <div>
                                    <p class="font-display font-bold text-lg dark:text-stone-100">Dom Pérignon 2012</p>
                                    <p class="text-xs text-stone-500">Mã: BEV-088</p>
                                </div>
                            </td>
                            <td class="px-6 py-4">
                                <span class="px-3 py-1 bg-amber-500/10 text-amber-500 rounded-full text-xs font-bold border border-amber-500/20">ĐỒ UỐNG</span>
                            </td>
                            <td class="px-6 py-4">
                                <p class="font-display font-bold text-lg text-primary">18.500.000</p>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <button onclick="event.stopPropagation(); openEditModal('5')" class="text-primary hover:text-primary/80">
                                    <span class="material-icons-round">edit</span>
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Edit Modal -->
            <div id="editModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm hidden items-center justify-center z-50" onclick="closeModal()">
                <div class="bg-white dark:bg-card-dark rounded-3xl p-8 max-w-2xl w-full mx-4 shadow-2xl" onclick="event.stopPropagation()">
                    <div class="flex justify-between items-center mb-6">
                        <h3 class="text-3xl font-display font-bold dark:text-stone-100" style="font-style: italic; color: #D4AF37;">Chỉnh sửa nhanh</h3>
                        <button onclick="closeModal()" class="text-stone-400 hover:text-stone-600">
                            <span class="material-icons-round text-3xl">close</span>
                        </button>
                    </div>
                    
                    <div class="space-y-6">
                        <!-- Image Upload -->
                        <div>
                            <label class="block text-xs font-bold uppercase tracking-wider text-stone-500 mb-2">Hình ảnh món ăn</label>
                            <div class="relative border-2 border-dashed border-stone-300 dark:border-stone-700 rounded-xl p-8 text-center hover:border-primary transition-colors cursor-pointer">
                                <input type="file" class="absolute inset-0 opacity-0 cursor-pointer" accept="image/*">
                                <span class="material-icons-round text-primary text-5xl mb-2">image</span>
                                <p class="text-sm text-stone-500">Click để thay đổi ảnh</p>
                            </div>
                        </div>

                        <!-- Name -->
                        <div>
                            <label class="block text-xs font-bold uppercase tracking-wider text-stone-500 mb-2">Tên món ăn</label>
                            <input type="text" value="Wagyu A5 Kagoshima" class="w-full px-4 py-3 bg-stone-50 dark:bg-stone-900 border border-stone-200 dark:border-stone-800 rounded-xl focus:outline-none focus:border-primary">
                        </div>

                        <!-- Description -->
                        <div>
                            <label class="block text-xs font-bold uppercase tracking-wider text-stone-500 mb-2">Mô tả thơ ca</label>
                            <textarea rows="3" class="w-full px-4 py-3 bg-stone-50 dark:bg-stone-900 border border-stone-200 dark:border-stone-800 rounded-xl focus:outline-none focus:border-primary">Bản giao hưởng hương vị từ vùng đất Kagoshima, lớp vân mỡ tinh khiết tan chảy như sương sớm trên đầu lưỡi...</textarea>
                        </div>

                        <!-- Price -->
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-xs font-bold uppercase tracking-wider text-stone-500 mb-2">Giá niêm yết</label>
                                <div class="relative">
                                    <input type="text" value="4.500.000" class="w-full px-4 py-3 bg-stone-50 dark:bg-stone-900 border border-stone-200 dark:border-stone-800 rounded-xl focus:outline-none focus:border-primary">
                                    <span class="absolute right-4 top-3 text-stone-500 text-sm">VNĐ</span>
                                </div>
                            </div>
                            <div>
                                <label class="block text-xs font-bold uppercase tracking-wider text-stone-500 mb-2">Giá gốc (BOM)</label>
                                <div class="relative">
                                    <input type="text" value="1.260.000" class="w-full px-4 py-3 bg-stone-50 dark:bg-stone-900 border border-stone-200 dark:border-stone-800 rounded-xl focus:outline-none focus:border-primary">
                                    <span class="absolute right-4 top-3 text-stone-500 text-sm">VNĐ</span>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="flex gap-4 pt-4">
                            <button onclick="saveChanges()" class="flex-1 py-3 bg-primary text-black font-bold rounded-xl hover:shadow-lg hover:shadow-primary/20 transition-all">
                                Lưu thay đổi
                            </button>
                            <button onclick="closeModal()" class="px-6 py-3 border border-stone-200 dark:border-stone-800 rounded-xl hover:bg-stone-50 dark:hover:bg-stone-900 transition-all">
                                <span class="material-icons-round">more_vert</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                function filterCategory(category) {
                    // Remove active class from all tabs
                    document.querySelectorAll('.tab-btn').forEach(btn => {
                        btn.classList.remove('active', 'border-primary', 'text-primary');
                        btn.classList.add('border-transparent', 'text-stone-500');
                    });
                    
                    // Add active class to clicked tab
                    event.target.classList.add('active', 'border-primary', 'text-primary');
                    event.target.classList.remove('border-transparent', 'text-stone-500');
                    
                    console.log('Filter by category:', category);
                    // TODO: Add filtering logic
                }

                function openEditModal(id) {
                    document.getElementById('editModal').classList.remove('hidden');
                    document.getElementById('editModal').classList.add('flex');
                    console.log('Edit item:', id);
                }

                function openAddModal() {
                    document.getElementById('editModal').classList.remove('hidden');
                    document.getElementById('editModal').classList.add('flex');
                    console.log('Add new item');
                }

                function closeModal() {
                    document.getElementById('editModal').classList.add('hidden');
                    document.getElementById('editModal').classList.remove('flex');
                }

                function saveChanges() {
                    console.log('Saving changes...');
                    // TODO: Add save logic
                    closeModal();
                }
            </script>
        </main>
    </body>
</html>
