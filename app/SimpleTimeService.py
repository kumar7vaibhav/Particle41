from flask import Flask, jsonify, request
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def get_time_and_ip():
    current_time = datetime.now().isoformat()
    visitor_ip = request.remote_addr
    
    return jsonify({
        "timestamp": current_time,
        "ip": visitor_ip
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)