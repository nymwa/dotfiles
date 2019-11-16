import os, re, time

def read_net():
	with open('/proc/net/dev') as f:
		lst = f.readlines()
	lst = [[int(x) for x in line.rstrip(' ').split()[1:]] for line in lst if not re.match(r'\s*((Inter)|(face)|(lo))', line)]
	return lst

def get_pair(lst):
	return sum(lst[:8]), sum(lst[8:])

def get_pairs():
	return [get_pair(lst) for lst in read_net()]

def rt():
	lst = get_pairs()
	return sum(x for x,_ in lst), sum(x for _,x in lst)

def style(n):
	if n == 0:
		n = '<fc=#00FFFF>----</fc>'
	elif n < 300:
		n = '<fc=#00FFFF>{:4}</fc>'.format(n)
	elif n < 1000:
		n = '<fc=#FF00FF>{:4}</fc>'.format(n)
	elif n < 30000:
		n = '<fc=#66CCFF>{:3}k</fc>'.format(n//1000)
	elif n < 1000000:
		n = '<fc=#FFFF00>{:3}k</fc>'.format(n//1000)
	elif n < 30000000:
		n = '<fc=#11FF55>{:3}M</fc>'.format(n//1000000)
	elif n < 1000000000:
		n = '<fc=#FFFF33>{:3}M</fc>'.format(n//1000000)
	else:
		n = '<fc=#FF3333>FFFF</fc>'
	return n

path = os.environ['HOME'] + '/.xmobar-network'
old = rt()
time.sleep(1)
while True:
	new = rt()
	with open(path, mode='w') as f:
		print(style(new[0]-old[0])+' '+style(new[1]-old[1]), file=f)
	time.sleep(1)
	old = new

