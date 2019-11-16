import os, re, time

def read_stat():
	with open('/proc/stat') as f:
		lst = f.readlines()
	lst = [[int(x) for x in line.rstrip().split()[1:]] for line in lst if re.match(r'cpu[0-9]+', line)]
	return lst

def get_pair(lst):
	return sum(lst), lst[3]

def get_pairs():
	return [get_pair(lst) for lst in read_stat()]

def ratio(nt, ni, ot, oi):
	t, i = nt - ot, ni - oi
	return int((t-i) * 10 / t + 0.5)

def style(n):
	if n < 2:
		n = '<fc=#00FFFF>{}</fc>'.format(n)
	elif n < 3:
		n = '<fc=#FF00FF>{}</fc>'.format(n)
	elif n < 5:
		n = '<fc=#66CCFF>{}</fc>'.format(n)
	elif n < 7:
		n = '<fc=#FFFF00>{}</fc>'.format(n)
	elif n < 8:
		n = '<fc=#11FF55>{}</fc>'.format(n)
	elif n < 10:
		n = '<fc=#FFFF33>{}</fc>'.format(n)
	else:
		n = '<fc=#FF0000>F</fc>'
	return n
    
path = os.environ['HOME'] + '/.xmobar-cpu'
old = get_pairs()
time.sleep(1)
while True:
	new = get_pairs()
	lst = [style(ratio(nt, ni, ot, oi)) for (nt, ni), (ot, oi) in zip(new, old)]
	with open(path, mode='w') as f:
		print(' '.join(lst), file=f)
	time.sleep(1)
	old = new

