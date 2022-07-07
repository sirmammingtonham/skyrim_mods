import json
with open('../ui/BirthsignData.json', 'r') as f:
	data = json.load(f)

with open('temp.txt', 'w+') as f:
    s = json.dumps(data, separators=(',', ':'))
    f.write(s.replace('"', '\\"'))
