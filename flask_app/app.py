from flask import Flask, render_template, request, jsonify
import subprocess

app = Flask(__name__)

# Store the default background color
background_color = "#fff0ff"

# Route to render index.html at the root URL
@app.route('/')
def index():
    return render_template('index.html', background_color=background_color)

# Endpoint to change the background color
@app.route('/api/web/background', methods=['POST'])
def change_background():
    global background_color
    color = request.json.get('color')
    if color:
        background_color = color # '#'+"{0:06x}".format(int(color[1:], 16))
        if color[0] != '#':
            return jsonify({"error": f"Something went wrong"}), 500
        return jsonify({"message": f"Background color changed to {color}"}), 200
    else:
        return jsonify({"error": "Color not provided"}), 400

# API endpoint to change system time
@app.route('/api/system/time', methods=['POST'])
def set_time():
    data = request.json
    new_time = data.get('time')
    if new_time:
        # Execute command to set system time (requires elevated privileges)
        try:
            subprocess.run(['date', '-s', new_time])
            return jsonify({"message": f"System time set to {new_time}"}), 200
        except Exception as e:
            return jsonify({"error": str(e)}), 500
    else:
        return jsonify({"error": "Time not provided"}), 400

# API endpoint to read the current system time
@app.route('/api/system/time', methods=['GET'])
def get_time():
    try:
        result = subprocess.run(['date', '+%Y-%m-%d %H:%M:%S'], capture_output=True, text=True)
        current_time = result.stdout.strip()
        return jsonify({"current_time": current_time}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# API endpoint to read the content of secret.txt
@app.route('/api/file/secret', methods=['GET'])
def read_secret():
    try:
        with open('resources/secret.txt', 'r') as file:
            content = file.read()
        return jsonify({"content": content}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
