import json
with open('../ui/BirthsignData.json', 'r') as f:
	data = json.load(f)
lines = []
for sign in data:
    lines.append(f"${sign}_DESC\t{data[sign]['description']}")
    for i, ability in enumerate(data[sign]["abilities"]):
        lines.append(f"${sign}_AB{i}_NAME\t{ability['name']}")
        lines.append(f"${sign}_AB{i}_DESC\t{ability['description']}")

with open('temp.txt', 'w+') as f:
    f.write('\n'.join(lines))
