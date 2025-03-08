from flask import Flask, request, jsonify
import whisper
import os

app = Flask(__name__)
app.config["JSON_AS_ASCII"] = False  # JSON のエンコード時に ASCII エスケープを無効化

DEVICE = "cpu"
model = whisper.load_model("base", device=DEVICE)

@app.route('/health')
def health_check():
    return "OK", 200

@app.route('/transcribe', methods=['POST'])
def transcribe_audio():
    if 'file' not in request.files:
        return jsonify({"error": "No file part"}), 400
    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400
    if file:
        file_path = os.path.join("/tmp", file.filename)
        file.save(file_path)
        result = model.transcribe(file_path)
        os.remove(file_path)
        return jsonify({"transcription": result['text']}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4673)