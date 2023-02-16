#!/usr/bin/env python3

import json, subprocess, sys

def get_workspaces(mode):
    workspaces_raw = subprocess.check_output(['i3-msg', '-t', 'get_workspaces'])
    workspaces = sorted(json.loads(workspaces_raw), key=lambda d: d['name'])

    if mode == 'unfocused':
        return [workspace for workspace in workspaces if workspace['focused'] == False]
    elif mode != 'all':
        focused = [workspace for workspace in workspaces if workspace['focused']]

        if mode == 'focused':
            return focused
        elif mode == 'focused-':
            return [workspace for workspace in workspaces if workspace['num'] < focused[0]['num']]
        elif mode == 'focused+':
            return [workspace for workspace in workspaces if workspace['num'] > focused[0]['num']]

    return workspaces

def print_workspaces(mode):
    fg = '<span foreground="#292e42">'
    output = '<txt>{}</txt>'
    if mode == 'focused':
        output += '<txtclick>rofi -modi window -show window</txtclick>'

    workspaces = get_workspaces(mode)
    workspaces_txt = ''

    for workspace in workspaces:
        visible = '<span foreground="#565f89">' if workspace['visible'] else '<span>'
        focused = '<span foreground="#a9b1d6">' if workspace['focused'] else '<span>'
        urgent = '<span foreground="#f7768e">' if workspace['urgent'] else '<span>'
        workspaces_txt += fg + visible + focused + urgent + ' ' \
                + workspace['name'].split(':')[1] + ' </span></span></span></span>'

    print(output.format(workspaces_txt))

if __name__ == '__main__':

    mode = sys.argv[1] if len(sys.argv) > 1 else 'all'

    print_workspaces(mode)
