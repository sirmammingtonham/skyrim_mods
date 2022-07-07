import json
with open('../ui/BirthsignData.json', 'r') as f:
	data = json.load(f)

# remove stuff we dont need
for key, value in data.items():
    del value['description']
    del value['class']
    for ability in value['abilities']:
        del ability['name']
        del ability['description']

with open('temp.txt', 'w+') as f:
    s = json.dumps(data, separators=(',', ':'))
    f.write(s.replace('"', '\\"'))
