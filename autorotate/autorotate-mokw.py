#!/usr/bin/env python
from time import sleep
from os import path as op
import sys
from subprocess import check_call, check_output
from glob import glob
import re

def bdopen(fname):
    basedir = "/sys/bus/iio/devices/iio:device0/"
    return open(op.join(basedir, fname))

def read(fname):
    return bdopen(fname).read()

devices = check_output(['xinput', '--list', '--name-only']).splitlines()

screen = re.findall("id=[0-9]*",[i for i in map(str,check_output(['xinput','--list']).splitlines()) if 'TouchScreen' in i and 'pointer' in i][0])[0][3:]

scale = float(read('in_accel_scale'))

g = 7.0  # (m^2 / s) sensibility, gravity trigger

STATES = [
    {'rot': 'normal',   'coord': '1 0 0 0 1 0 0 0 1',   'check': lambda x, y: x <= -g},
    {'rot': 'inverted', 'coord': '-1 0 1 0 -1 1 0 0 1', 'check': lambda x, y: x >= g},
    {'rot': 'left',     'coord': '0 -1 1 1 0 0 0 0 1',  'check': lambda x, y: y >= g},
    {'rot': 'right',    'coord': '0 1 0 -1 0 1 0 0 1',  'check': lambda x, y: y <= -g},
]

def rotate(state):
    s = STATES[state]
    check_call(['xrandr', '-o', s['rot']])
    check_call(['xinput', 'set-prop', screen, 'Coordinate Transformation Matrix'] + s['coord'].split())

def read_accel(fp):
    fp.seek(0)
    return float(fp.read()) * scale

if __name__ == '__main__':
    accel_x = bdopen('in_accel_x_raw')
    accel_y = bdopen('in_accel_y_raw')
    current_state = None
    while True:
        x = read_accel(accel_x)
        y = read_accel(accel_y)
        for i in range(4):
            if i == current_state:
                continue
            if STATES[i]['check'](x, y):
                current_state = i
                rotate(i)
                break
        sleep(1)
