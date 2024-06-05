# Python 이미지 사용
FROM python:3.8.10

# 필요한 시스템 라이브러리 설치
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    python3-pip

# 작업 디렉터리 설정
WORKDIR /app

# yolov5 폴더 내의 의존성 파일 복사
COPY yolov5/requirements.txt .

# pip 최신 버전으로 업그레이드 및 필요한 Python 패키지 설치
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 나머지 애플리케이션 파일 복사
COPY . .

# 환경 변수 설정
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# 포트 5000 열기
EXPOSE 5000

# Flask 앱 실행
CMD ["python", "app.py"]
