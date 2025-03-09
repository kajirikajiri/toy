# https://github.com/openai/whisper/pull/382#issuecomment-2484044391

from flask import Flask, request, jsonify
# import whisper
import os
import torch  # Add torch import
from transformers import AutoModelForSpeechSeq2Seq, AutoProcessor, pipeline

app = Flask(__name__)
app.config["JSON_AS_ASCII"] = False  # JSON のエンコード時に ASCII エスケープを無効化

#device = "cuda:0" if torch.cuda.is_available() else "cpu"
device = "mps" if torch.backends.mps.is_available() else "cpu" 

@app.route('/health')
def health_check():
    return "OK", 200

@app.route('/transcribe', methods=['POST'])
def transcribe_audio():
    print('transcribe_audio')
    if 'file' not in request.files:
        return jsonify({"error": "No file part"}), 400
    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400
    if file:
        file_path = os.path.join("/tmp", file.filename)
        file.save(file_path)
        torch_dtype = torch.float16 if torch.cuda.is_available() else torch.float32
    
        model_id = "openai/whisper-large-v3-turbo"
        
        model = AutoModelForSpeechSeq2Seq.from_pretrained(
            model_id, torch_dtype=torch_dtype, low_cpu_mem_usage=True, use_safetensors=True
        )
        model.to(device)
        
        processor = AutoProcessor.from_pretrained(model_id)
        
        pipe = pipeline(
            "automatic-speech-recognition",
            model=model,
            tokenizer=processor.tokenizer,
            feature_extractor=processor.feature_extractor,
            torch_dtype=torch_dtype,
            device=device,
        )
        # prompt = """
        # NeoVim,VSCode
        # """
        # prompt_ids = processor.get_prompt_ids(prompt, return_tensors="pt").to(device)
        # result = pipe(file_path, generate_kwargs={"prompt_ids": prompt_ids})
        # result = pipe(file_path, generate_kwargs={"language": "japanese"})
        result = pipe(file_path)
        os.remove(file_path)
        return jsonify({"transcription": result['text']}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4673)