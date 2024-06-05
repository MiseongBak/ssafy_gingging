from flask import Flask, request
from flask_cors import CORS

# 입력 이미지 저장 관련
from werkzeug.utils import secure_filename

from garbage_classification import *

import boto3
from PIL import Image
import io

import xml.etree.ElementTree as elemTree


app = Flask(__name__)
# 보안관련
CORS(app)

#Parse XML
tree = elemTree.parse('keys.xml')
s3_access_id = tree.find('string[@name="s3_access_id"]').text 
s3_secret_key = tree.find('string[@name="s3_secret_key"]').text


# rest 요청 처리부
@app.route('/predict', methods=["POST"])
def predict():
   if request.method == 'POST':
      
      # s3 불러오는 부분

      s3_url = request.form['url'] # 변경하기
      print("s3 url: ", s3_url)

      s3_image_name = s3_url[46:]
      print("s3 이미지 이름: ", s3_image_name)

      # AWS S3 클라이언트 설정
      s3 = boto3.client('s3', aws_access_key_id=s3_access_id, aws_secret_access_key=s3_secret_key)

      # S3에서 이미지 파일 가져오기
      def load_image_from_s3(bucket, key):
         # 버킷과 키를 사용하여 S3 객체의 바이트 데이터 가져오기
         response = s3.get_object(Bucket=bucket, Key=key)
         image_data = response['Body'].read()

         # 바이트 데이터를 이미지 객체로 변환
         img = Image.open(io.BytesIO(image_data))
         return img

      # 함수 사용 예
      bucket_name = 'ggbro'
      image_key = s3_image_name  # S3 내의 이미지 경로
      s3_img = load_image_from_s3(bucket_name, image_key)

      # 이미지 확인 (예: 이미지 보기 또는 처리)
      # s3_img.show()
      # ori_img3 = cv2.imread(image_path)


      s3_img.save("./"+ secure_filename("image")+".jpg")

      image_path = "./"+ secure_filename("image")+".jpg"


      class_idx, class_name, detected_count = classify_garbage(image_path)
      
      print("인덱스: ", class_idx)
      print("종류: " + class_name)
      print("검출 개수: " + str(detected_count))

      message = {
         "type": class_name
      }

      return message

if __name__ == '__main__':  
   app.run('0.0.0.0',port=5000,debug=True)