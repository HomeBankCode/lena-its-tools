import re
import sys
import os
from pydub import AudioSegment


tsv_file = sys.argv[1]
audio = sys.argv[2]
with open(tsv_file) as f:
	data = f.readlines()
f.close()

l = []
p = re.compile("Segment")
for m in p.finditer(data[-1]):
    l.append(m.start())
d = data[-1]
ans = []


index = 0
if len(data) < 11:
	for i in range(len(l)-1):
		d_t = d[l[i]:l[i+1]]
		m = re.findall(r'endTime=\"PT([0-9]+\.[0-9]+)?S\"',d_t)
		m1 = re.findall(r'spkr=\"CHN\"',d_t)
		m2 = re.findall(r'startTime=\"PT([0-9]+\.[0-9]+)S\"',d_t)
		if len(m) != 0:
			if m1 != []:
				index += 1
				ans.append([m1,m2[0],m[0]])
				t1 = float(m2[0])*100000
				t2 = float(m[0])*100000
				#print(t1,t2,"!!!!!!!!!")
				newAudio = AudioSegment.from_wav(audio)
				newAudio = newAudio[t1:t2]
				newAudio.export("staticfiles/{}_{}_{}_{}.wav".format(audio[:-4],index,m2[0],m[0]), format("wav"),bitrate="192k")
else:
	for i in data:
		m1 = re.findall(r'spkr=\"CHN\"',i)
		m2 = re.findall(r'startTime=\"PT([0-9]+\.[0-9]+)S\"',i)		
		m = re.findall(r'endTime=\"PT([0-9]+\.[0-9]+)?S\"',i)
		if (m1 != []) & (m != []) & (m2 != []):
			index += 1
			t1 = float(m2[0])*100000
			t2 = float(m[0])*100000			
			newAudio = AudioSegment.from_wav(audio)
			newAudio = newAudio[t1:t2]
                        #save segments in the static files directory
			newAudio.export("staticfiles/{}_{}_{}_{}.wav".format(audio[:-4],index,m2[0],m[0]), format("wav"),bitrate="192k")

		


