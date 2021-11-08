import json
import logging
import boto3
import botocore
import os
import urllib.request as urllib2
from PIL import Image
from io import BytesIO
import numpy as np
import cv2

def lambda_handler(event, context):
    logger = logging.getLogger()
    logger.setLevel(logging.INFO)
    logger.info('event parameter: {}'.format(event))
    
    uri = event['key']
    file_data = urllib2.urlopen(uri)
    image_string = file_data.read()
    img = Image.open(BytesIO(image_string))
    img = np.asarray(img)[:,:,:3]
    img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)


    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": img_gray.mean()
        }),
    }