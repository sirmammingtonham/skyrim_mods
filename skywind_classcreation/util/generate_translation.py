with open('raw_qa.txt', 'r') as f:
	questions_responses = [[line for line in chunk.split('\n') if line] for chunk in f.read().split('|')]
 
lines = []
for i, qr in enumerate(questions_responses):
    question, combat, magic, stealth = qr
    lines.append(f'$ClassQuiz{i}Q\t{question}')
    lines.append(f'$ClassQuiz{i}C\t{combat}')
    lines.append(f'$ClassQuiz{i}M\t{magic}')
    lines.append(f'$ClassQuiz{i}S\t{stealth}')

with open('temp.txt', 'w+') as f:
    f.write('\n'.join(lines))
