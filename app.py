from flask import Flask, jsonify
import numpy as np
import keras_preprocessing.image as image
import os


app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Hello World!'


if __name__ == '__main__':
    server_port = os.environ.get('PORT', '8080')
    app.run(debug=False, port=server_port, host='0.0.0.0')


@app.route('/getImageArr', methods=['GET'])
def get_image_arr():
    imageFile = image.load_img('imgFil.jpg', target_size=(200, 200))
    imageToArr = image.img_to_array(imageFile)
    imageToArr = np.expand_dims(imageToArr, axis=0)

    return jsonify({'imageArr': imageToArr.tolist()})
