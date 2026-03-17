<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- ===== VESPER AI Chatbot ===== -->
<style>
  /* Floating button */
  #chatbot-toggle {
    position: fixed;
    bottom: 28px;
    right: 28px;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background: linear-gradient(135deg, #d4af35 0%, #b08d1e 100%);
    border: none;
    cursor: pointer;
    box-shadow: 0 8px 32px rgba(212,175,53,0.45);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 9999;
    transition: transform 0.2s, box-shadow 0.2s;
  }
  #chatbot-toggle:hover {
    transform: scale(1.08);
    box-shadow: 0 12px 40px rgba(212,175,53,0.6);
  }
  #chatbot-toggle .chat-icon { display: flex; }
  #chatbot-toggle .close-icon { display: none; }
  #chatbot-toggle.open .chat-icon { display: none; }
  #chatbot-toggle.open .close-icon { display: flex; }

  /* Notification dot */
  #chatbot-badge {
    position: absolute;
    top: 2px;
    right: 2px;
    width: 14px;
    height: 14px;
    background: #ef4444;
    border-radius: 50%;
    border: 2px solid #0b0b0b;
    animation: pulse-badge 2s infinite;
  }
  @keyframes pulse-badge {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.2); }
  }

  /* Chat window */
  #chatbot-window {
    position: fixed;
    bottom: 100px;
    right: 28px;
    width: 380px;
    max-height: 560px;
    background: rgba(17, 16, 12, 0.97);
    border: 1px solid rgba(212,175,53,0.4);
    border-radius: 20px;
    box-shadow: 0 24px 64px rgba(0,0,0,0.8);
    display: flex;
    flex-direction: column;
    z-index: 9998;
    backdrop-filter: blur(16px);
    transform: scale(0.85) translateY(20px);
    opacity: 0;
    pointer-events: none;
    transition: transform 0.25s cubic-bezier(0.34,1.56,0.64,1), opacity 0.2s ease;
    overflow: hidden;
  }
  #chatbot-window.open {
    transform: scale(1) translateY(0);
    opacity: 1;
    pointer-events: all;
  }

  /* Header */
  .cb-header {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 16px 20px;
    background: linear-gradient(135deg, rgba(212,175,53,0.15) 0%, transparent 100%);
    border-bottom: 1px solid rgba(212,175,53,0.2);
    flex-shrink: 0;
  }
  .cb-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: linear-gradient(135deg, #d4af35 0%, #b08d1e 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    flex-shrink: 0;
  }
  .cb-header-info { flex: 1; }
  .cb-header-name {
    font-family: 'Playfair Display', serif;
    font-size: 15px;
    font-weight: 600;
    color: rgba(255,255,255,0.95);
    line-height: 1.2;
  }
  .cb-header-status {
    font-size: 11px;
    color: #28d17c;
    display: flex;
    align-items: center;
    gap: 4px;
    margin-top: 2px;
  }
  .cb-status-dot {
    width: 6px;
    height: 6px;
    background: #28d17c;
    border-radius: 50%;
    animation: blink 2s infinite;
  }
  @keyframes blink {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.3; }
  }

  /* Messages area */
  #cb-messages {
    flex: 1;
    overflow-y: auto;
    padding: 16px;
    display: flex;
    flex-direction: column;
    gap: 12px;
    scrollbar-width: thin;
    scrollbar-color: rgba(212,175,53,0.3) transparent;
  }
  #cb-messages::-webkit-scrollbar { width: 4px; }
  #cb-messages::-webkit-scrollbar-thumb { background: rgba(212,175,53,0.3); border-radius: 2px; }

  /* Message bubbles */
  .cb-msg {
    display: flex;
    gap: 8px;
    animation: msgIn 0.25s ease-out;
  }
  @keyframes msgIn {
    from { opacity: 0; transform: translateY(8px); }
    to { opacity: 1; transform: translateY(0); }
  }
  .cb-msg.user { flex-direction: row-reverse; }
  .cb-msg-avatar {
    width: 28px;
    height: 28px;
    border-radius: 50%;
    background: linear-gradient(135deg, #d4af35, #b08d1e);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    flex-shrink: 0;
    margin-top: 2px;
  }
  .cb-msg.user .cb-msg-avatar {
    background: rgba(255,255,255,0.1);
    border: 1px solid rgba(255,255,255,0.15);
    font-size: 12px;
    color: rgba(255,255,255,0.7);
  }
  .cb-bubble {
    max-width: 78%;
    padding: 10px 14px;
    border-radius: 16px;
    font-size: 13.5px;
    line-height: 1.55;
    white-space: pre-wrap;
    word-break: break-word;
  }
  .cb-msg.bot .cb-bubble {
    background: rgba(255,255,255,0.06);
    border: 1px solid rgba(255,255,255,0.08);
    color: rgba(255,255,255,0.9);
    border-bottom-left-radius: 4px;
  }
  .cb-msg.user .cb-bubble {
    background: linear-gradient(135deg, rgba(212,175,53,0.25), rgba(176,141,30,0.2));
    border: 1px solid rgba(212,175,53,0.3);
    color: rgba(255,255,255,0.95);
    border-bottom-right-radius: 4px;
  }

  /* Typing indicator */
  .cb-typing .cb-bubble {
    display: flex;
    align-items: center;
    gap: 4px;
    padding: 12px 16px;
  }
  .cb-dot {
    width: 7px;
    height: 7px;
    background: rgba(212,175,53,0.7);
    border-radius: 50%;
    animation: typing 1.2s infinite;
  }
  .cb-dot:nth-child(2) { animation-delay: 0.2s; }
  .cb-dot:nth-child(3) { animation-delay: 0.4s; }
  @keyframes typing {
    0%, 60%, 100% { transform: translateY(0); opacity: 0.5; }
    30% { transform: translateY(-6px); opacity: 1; }
  }

  /* Quick replies */
  #cb-quick-replies {
    display: flex;
    flex-wrap: wrap;
    gap: 6px;
    padding: 0 16px 10px;
    flex-shrink: 0;
  }
  .cb-quick-btn {
    padding: 6px 12px;
    border-radius: 999px;
    border: 1px solid rgba(212,175,53,0.35);
    background: rgba(212,175,53,0.08);
    color: #d4af35;
    font-size: 12px;
    cursor: pointer;
    transition: all 0.15s;
    white-space: nowrap;
  }
  .cb-quick-btn:hover {
    background: rgba(212,175,53,0.18);
    border-color: rgba(212,175,53,0.6);
  }

  /* Input area */
  .cb-input-area {
    display: flex;
    gap: 8px;
    padding: 12px 16px;
    border-top: 1px solid rgba(255,255,255,0.07);
    flex-shrink: 0;
  }
  #cb-input {
    flex: 1;
    background: rgba(255,255,255,0.05);
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: 12px;
    padding: 10px 14px;
    color: rgba(255,255,255,0.9);
    font-size: 13.5px;
    font-family: inherit;
    outline: none;
    resize: none;
    max-height: 80px;
    transition: border-color 0.2s;
  }
  #cb-input:focus { border-color: rgba(212,175,53,0.5); }
  #cb-input::placeholder { color: rgba(255,255,255,0.35); }
  #cb-send {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: linear-gradient(135deg, #d4af35, #b08d1e);
    border: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    align-self: flex-end;
    transition: transform 0.15s, opacity 0.15s;
  }
  #cb-send:hover { transform: scale(1.08); }
  #cb-send:disabled { opacity: 0.4; cursor: not-allowed; transform: none; }

  @media (max-width: 480px) {
    #chatbot-window { width: calc(100vw - 32px); right: 16px; bottom: 90px; }
    #chatbot-toggle { right: 16px; bottom: 16px; }
  }
</style>

<!-- Toggle Button -->
<button id="chatbot-toggle" aria-label="Mở trợ lý AI">
  <span id="chatbot-badge"></span>
  <span class="chat-icon">
    <svg width="26" height="26" viewBox="0 0 24 24" fill="none">
      <path d="M20 2H4C2.9 2 2 2.9 2 4V22L6 18H20C21.1 18 22 17.1 22 16V4C22 2.9 21.1 2 20 2Z" fill="#18140c"/>
      <circle cx="8" cy="11" r="1.2" fill="#18140c"/>
      <circle cx="12" cy="11" r="1.2" fill="#18140c"/>
      <circle cx="16" cy="11" r="1.2" fill="#18140c"/>
    </svg>
  </span>
  <span class="close-icon">
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none">
      <path d="M18 6L6 18M6 6L18 18" stroke="#18140c" stroke-width="2.5" stroke-linecap="round"/>
    </svg>
  </span>
</button>

<!-- Chat Window -->
<div id="chatbot-window" role="dialog" aria-label="VESPER AI Assistant">
  <!-- Header -->
  <div class="cb-header">
    <div class="cb-avatar">🍽️</div>
    <div class="cb-header-info">
      <div class="cb-header-name">VESPER Assistant</div>
      <div class="cb-header-status">
        <span class="cb-status-dot"></span>
        Sẵn sàng phục vụ
      </div>
    </div>
  </div>

  <!-- Messages -->
  <div id="cb-messages"></div>

  <!-- Quick Replies -->
  <div id="cb-quick-replies">
    <button class="cb-quick-btn" onclick="sendQuick('Thực đơn hôm nay có gì?')">🍽️ Thực đơn</button>
    <button class="cb-quick-btn" onclick="sendQuick('Gợi ý món cho 2 người')">👫 Gợi ý món</button>
    <button class="cb-quick-btn" onclick="sendQuick('Đặt bàn như thế nào?')">📅 Đặt bàn</button>
    <button class="cb-quick-btn" onclick="sendQuick('Đồ uống có gì?')">🍷 Đồ uống</button>
    <button class="cb-quick-btn" onclick="sendQuick('Giá cả thế nào?')">💰 Giá cả</button>
  </div>

  <!-- Input -->
  <div class="cb-input-area">
    <textarea id="cb-input" placeholder="Nhắn tin với VESPER..." rows="1"></textarea>
    <button id="cb-send" aria-label="Gửi">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
        <path d="M22 2L11 13M22 2L15 22L11 13M22 2L2 9L11 13" stroke="#18140c" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
    </button>
  </div>
</div>

<script>
(function() {
  const toggle = document.getElementById('chatbot-toggle');
  const win    = document.getElementById('chatbot-window');
  const msgs   = document.getElementById('cb-messages');
  const input  = document.getElementById('cb-input');
  const send   = document.getElementById('cb-send');
  const badge  = document.getElementById('chatbot-badge');
  const ctx    = '${pageContext.request.contextPath}';

  // Conversation history for context
  let history = [];
  let isOpen  = false;
  let greeted = false;

  // Toggle chat window
  toggle.addEventListener('click', function() {
    isOpen = !isOpen;
    toggle.classList.toggle('open', isOpen);
    win.classList.toggle('open', isOpen);
    if (isOpen) {
      badge.style.display = 'none';
      if (!greeted) {
        greeted = true;
        setTimeout(function() {
          addBotMessage('Xin chào! Tôi là trợ lý AI của nhà hàng VESPER 🍽️\n\nTôi có thể giúp bạn:\n• Tư vấn món ăn & đồ uống\n• Gợi ý theo sở thích & ngân sách\n• Hướng dẫn đặt bàn\n\nBạn muốn thưởng thức gì hôm nay? 😊');
        }, 300);
      }
      setTimeout(function() { input.focus(); }, 350);
    }
  });

  // Send on Enter (Shift+Enter for newline)
  input.addEventListener('keydown', function(e) {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  });

  // Auto-resize textarea
  input.addEventListener('input', function() {
    this.style.height = 'auto';
    this.style.height = Math.min(this.scrollHeight, 80) + 'px';
  });

  send.addEventListener('click', sendMessage);

  function sendQuick(text) {
    input.value = text;
    sendMessage();
  }
  window.sendQuick = sendQuick;

  function sendMessage() {
    const text = input.value.trim();
    if (!text || send.disabled) return;

    addUserMessage(text);
    input.value = '';
    input.style.height = 'auto';

    // Hide quick replies after first message
    document.getElementById('cb-quick-replies').style.display = 'none';

    // Add to history
    history.push({ role: 'user', content: text });

    // Show typing
    const typingEl = addTyping();
    send.disabled = true;

    // Call backend
    fetch(ctx + '/api/chat', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        message: text,
        history: JSON.stringify(history.slice(-8)) // last 8 messages for context
      })
    })
    .then(function(r) { return r.json(); })
    .then(function(data) {
      typingEl.remove();
      send.disabled = false;
      if (data.reply) {
        addBotMessage(data.reply);
        history.push({ role: 'assistant', content: data.reply });
        // Keep history manageable
        if (history.length > 20) history = history.slice(-16);
      } else {
        addBotMessage('Xin lỗi, tôi gặp sự cố kỹ thuật. Vui lòng thử lại sau nhé! 🙏');
      }
    })
    .catch(function() {
      typingEl.remove();
      send.disabled = false;
      addBotMessage('Kết nối bị gián đoạn. Vui lòng kiểm tra mạng và thử lại! 📶');
    });
  }

  function addUserMessage(text) {
    const div = document.createElement('div');
    div.className = 'cb-msg user';
    div.innerHTML =
      '<div class="cb-msg-avatar">👤</div>' +
      '<div class="cb-bubble">' + escHtml(text) + '</div>';
    msgs.appendChild(div);
    scrollBottom();
  }

  function addBotMessage(text) {
    const div = document.createElement('div');
    div.className = 'cb-msg bot';
    div.innerHTML =
      '<div class="cb-msg-avatar">🍽️</div>' +
      '<div class="cb-bubble">' + escHtml(text) + '</div>';
    msgs.appendChild(div);
    scrollBottom();
  }

  function addTyping() {
    const div = document.createElement('div');
    div.className = 'cb-msg bot cb-typing';
    div.innerHTML =
      '<div class="cb-msg-avatar">🍽️</div>' +
      '<div class="cb-bubble"><span class="cb-dot"></span><span class="cb-dot"></span><span class="cb-dot"></span></div>';
    msgs.appendChild(div);
    scrollBottom();
    return div;
  }

  function scrollBottom() {
    msgs.scrollTop = msgs.scrollHeight;
  }

  function escHtml(s) {
    return s
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/\n/g, '<br>');
  }

  // Show badge after 3s to attract attention
  setTimeout(function() {
    if (!isOpen) badge.style.display = 'block';
  }, 3000);
})();
</script>
