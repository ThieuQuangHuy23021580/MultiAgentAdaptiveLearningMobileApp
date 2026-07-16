# Flutter Mobile API Guide

Tài liệu này dành cho Flutter mobile gọi backend FastAPI của project `MultiAgentsBACKEND`.

## 1. Backend Base URL

Backend chạy mặc định ở port `8000`.

Chọn `baseUrl` theo môi trường chạy app Flutter:

| Môi trường Flutter | Base URL |
| --- | --- |
| Android Emulator | `http://10.0.2.2:8000` |
| iOS Simulator | `http://127.0.0.1:8000` |
| Thiết bị thật cùng Wi-Fi | `http://<IP-may-tinh>:8000` |

Ví dụ thiết bị thật:

```dart
const apiBaseUrl = 'http://192.168.1.10:8000';
```

Không dùng URL này trong Flutter:

```text
http://0.0.0.0:8000
```

`0.0.0.0` chỉ dùng cho backend để lắng nghe kết nối từ bên ngoài.

## 2. Chạy Backend Cho Mobile Gọi Được

Chạy backend từ đúng thư mục root project:

```powershell
cd D:\MOBILE\FLUTTER\MultiAgentsBACKEND
.\.venv\Scripts\uvicorn.exe backend.main:app --host 0.0.0.0 --port 8000 --reload
```

Backend đang dùng database path tương đối:

```env
DATABASE_URL=sqlite:///database/adaptive_learning.db
```

Vì vậy nếu chạy server từ sai thư mục, backend có thể đọc nhầm hoặc tạo database khác.

## 3. Cấu Hình HTTP Cho Flutter Mobile

Backend hiện dùng HTTP, chưa phải HTTPS.

### Android

Nếu Android app không gọi được HTTP, bật cleartext traffic trong:

```text
android/app/src/main/AndroidManifest.xml
```

Trong thẻ `<application>` thêm:

```xml
<application
    android:usesCleartextTraffic="true">
```

Nếu đã có nhiều thuộc tính trong `<application>`, chỉ thêm `android:usesCleartextTraffic="true"`.

### iOS

Nếu iOS app không gọi được HTTP, thêm App Transport Security exception trong:

```text
ios/Runner/Info.plist
```

Thêm trong dict chính:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

Chỉ dùng cấu hình này cho development. Production nên dùng HTTPS.

## 4. Package Flutter

Thêm package `http`:

```yaml
dependencies:
  http: ^1.2.0
```

Sau đó chạy:

```powershell
flutter pub get
```

## 5. Dữ Liệu Cần Có Trước Khi Test Chat

Endpoint gửi chat cần DB có sẵn:

- User có `id` trùng với `user_id`.
- Session có `id` trùng với `session_id`.
- Agent có `name` trùng với `agent`.

Dữ liệu test hiện có thể dùng:

```dart
const testUserId = '1';
const testSessionId = 'session-test-1';
const testAgent = 'mentor';
```

Nếu thiếu session, API trả:

```json
{
  "detail": "Session not found."
}
```

Nếu thiếu agent, API trả:

```json
{
  "detail": "Agent not found."
}
```

## 6. API Summary

| Method | Path | Mục đích |
| --- | --- | --- |
| `GET` | `/health` | Kiểm tra backend đang chạy. |
| `GET` | `/chat/agents` | Lấy danh sách agents. |
| `POST` | `/chat/send` | Gửi message, gọi agent, lưu DB, trả response. |
| `GET` | `/chat/history/{session_id}` | Lấy lịch sử chat từ DB. |

## 7. Response Models

### AgentInfo

```dart
class AgentInfo {
  AgentInfo({
    required this.id,
    required this.name,
    required this.isActive,
    this.description,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final String? description;
  final String? avatarUrl;
  final bool isActive;

  factory AgentInfo.fromJson(Map<String, dynamic> json) {
    return AgentInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      isActive: json['is_active'] as bool,
    );
  }
}
```

### ChatMessage

```dart
class ChatMessage {
  ChatMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.createdAt,
    this.senderUserId,
    this.senderAgentId,
  });

  final String id;
  final String role;
  final String content;
  final String createdAt;
  final String? senderUserId;
  final String? senderAgentId;

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      role: json['role'] as String,
      content: json['content'] as String,
      createdAt: json['created_at'] as String,
      senderUserId: json['sender_user_id'] as String?,
      senderAgentId: json['sender_agent_id'] as String?,
    );
  }
}
```

### ChatResponse

```dart
class ChatResponse {
  ChatResponse({
    required this.success,
    required this.message,
    required this.sessionId,
    required this.agent,
    required this.response,
    required this.metadata,
  });

  final bool success;
  final String message;
  final String sessionId;
  final String agent;
  final String response;
  final Map<String, dynamic> metadata;

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      sessionId: json['session_id'] as String,
      agent: json['agent'] as String,
      response: json['response'] as String,
      metadata: Map<String, dynamic>.from(json['metadata'] as Map),
    );
  }
}
```

## 8. Flutter ApiService

Tạo file ví dụ:

```text
lib/services/api_service.dart
```

Code:

```dart
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiException implements Exception {
  ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiService {
  ApiService({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String baseUrl;
  final http.Client _client;

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Future<Map<String, dynamic>> health() async {
    final response = await _client.get(
      _uri('/health'),
      headers: {'Accept': 'application/json'},
    );

    return _decodeObject(response);
  }

  Future<List<AgentInfo>> getAgents() async {
    final response = await _client.get(
      _uri('/chat/agents'),
      headers: {'Accept': 'application/json'},
    );

    final data = _decodeList(response);

    return data
        .map((item) => AgentInfo.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<ChatResponse> sendMessage({
    required String sessionId,
    required String userId,
    required String content,
    String agent = 'mentor',
  }) async {
    final response = await _client.post(
      _uri('/chat/send'),
      headers: _headers,
      body: jsonEncode({
        'session_id': sessionId,
        'user_id': userId,
        'content': content,
        'agent': agent,
      }),
    );

    final data = _decodeObject(response);

    return ChatResponse.fromJson(data);
  }

  Future<List<ChatMessage>> getHistory(String sessionId) async {
    final response = await _client.get(
      _uri('/chat/history/$sessionId'),
      headers: {'Accept': 'application/json'},
    );

    final data = _decodeList(response);

    return data
        .map((item) => ChatMessage.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> _decodeObject(http.Response response) {
    final data = jsonDecode(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = data is Map<String, dynamic>
          ? data['detail']?.toString() ?? response.body
          : response.body;

      throw ApiException(message, statusCode: response.statusCode);
    }

    return data as Map<String, dynamic>;
  }

  List<dynamic> _decodeList(http.Response response) {
    final data = jsonDecode(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = data is Map<String, dynamic>
          ? data['detail']?.toString() ?? response.body
          : response.body;

      throw ApiException(message, statusCode: response.statusCode);
    }

    return data as List<dynamic>;
  }
}
```

Nếu đặt các model trong file riêng, nhớ import model vào `api_service.dart`.

## 9. Cách Khởi Tạo ApiService

Android Emulator:

```dart
final api = ApiService(baseUrl: 'http://10.0.2.2:8000');
```

iOS Simulator:

```dart
final api = ApiService(baseUrl: 'http://127.0.0.1:8000');
```

Điện thoại thật cùng Wi-Fi:

```dart
final api = ApiService(baseUrl: 'http://192.168.1.10:8000');
```

## 10. Test Flow Trong Flutter

Ví dụ gọi thử trong button hoặc trong màn hình debug:

```dart
Future<void> testApi(ApiService api) async {
  final health = await api.health();
  print('Health: $health');

  final agents = await api.getAgents();
  print('Agents: ${agents.map((agent) => agent.name).toList()}');

  final chat = await api.sendMessage(
    sessionId: 'session-test-1',
    userId: '1',
    content: 'Test Flutter mobile gọi backend agent',
    agent: 'mentor',
  );
  print('Agent response: ${chat.response}');

  final history = await api.getHistory('session-test-1');
  print('History length: ${history.length}');
}
```

Kỳ vọng:

- `health()` trả `status = ok`.
- `getAgents()` có agent `mentor`.
- `sendMessage()` trả `ChatResponse`.
- `getHistory()` trả ít nhất 2 message: một `user`, một `agent`.

## 11. API Details

### GET /health

Response:

```json
{
  "status": "ok",
  "message": "Adaptive Learning Multi-Agent API is running."
}
```

### GET /chat/agents

Response:

```json
[
  {
    "id": "1",
    "name": "mentor",
    "description": "AI Mentor giúp hướng dẫn học tập, giải đáp thắc mắc và lập kế hoạch học tập.",
    "avatar_url": "https://www.magnific.com/free-photos-vectors/agent-avatar",
    "is_active": true
  }
]
```

### POST /chat/send

Request body:

```json
{
  "session_id": "session-test-1",
  "user_id": "1",
  "content": "Xin chào, hãy giúp tôi học Python.",
  "agent": "mentor"
}
```

Response:

```json
{
  "success": true,
  "message": "Success",
  "session_id": "session-test-1",
  "agent": "mentor",
  "response": "Nội dung phản hồi từ agent...",
  "metadata": {}
}
```

### GET /chat/history/{session_id}

Ví dụ:

```text
GET /chat/history/session-test-1
```

Response:

```json
[
  {
    "id": "message-id-1",
    "role": "user",
    "content": "Xin chào, hãy giúp tôi học Python.",
    "created_at": "2026-07-17T10:00:00+00:00",
    "sender_user_id": "1",
    "sender_agent_id": null
  },
  {
    "id": "message-id-2",
    "role": "agent",
    "content": "Nội dung phản hồi từ agent...",
    "created_at": "2026-07-17T10:00:05+00:00",
    "sender_user_id": null,
    "sender_agent_id": "1"
  }
]
```

Nếu session chưa có message:

```json
[]
```

## 12. Debug Khi Flutter Không Nhận Dữ Liệu

### Android Emulator không gọi được API

Kiểm tra đang dùng:

```dart
http://10.0.2.2:8000
```

Không dùng:

```dart
http://127.0.0.1:8000
```

Với Android Emulator, `127.0.0.1` là emulator, không phải máy tính đang chạy backend.

### Điện thoại thật không gọi được API

Kiểm tra:

- Điện thoại và máy tính cùng Wi-Fi.
- Backend chạy bằng `--host 0.0.0.0`.
- Flutter gọi đúng IP máy tính, ví dụ `http://192.168.1.10:8000`.
- Firewall Windows không chặn port `8000`.

Lấy IP máy tính bằng PowerShell:

```powershell
ipconfig
```

Tìm dòng `IPv4 Address`.

### `/chat/history/session-test-1` trả `[]`

Nguyên nhân thường gặp:

- Chưa gọi thành công `/chat/send`.
- Gọi sai `sessionId`.
- Backend đọc nhầm database do chạy từ sai thư mục.
- Agent/provider lỗi trước khi backend commit message.

### `/chat/send` trả 404

Nếu lỗi:

```json
{
  "detail": "Session not found."
}
```

Kiểm tra `session_id` có tồn tại trong bảng `sessions`.

Nếu lỗi:

```json
{
  "detail": "Agent not found."
}
```

Kiểm tra `agent` gửi lên có tồn tại trong bảng `agents.name`.

### `/chat/send` trả 500

Nguyên nhân thường gặp:

- API key/provider AI lỗi.
- Agent orchestration lỗi.
- Backend log trong terminal sẽ có traceback chi tiết.

Khi `/chat/send` lỗi trước khi hoàn tất, dữ liệu có thể chưa được lưu vào bảng `messages`.
