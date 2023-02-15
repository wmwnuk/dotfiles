#!/usr/bin/env python3

import json, subprocess

workspaces_raw = subprocess.check_output(['i3-msg', '-t', 'get_workspaces'])

workspaces = json.loads(workspaces_raw);

output = '<txt>'

for workspace in workspaces:
    visible = '<span foreground="#565f89">' if workspace['visible'] else '<span>'
    focused = '<span foreground="#a9b1d6">' if workspace['focused'] else '<span>'
    urgent = '<span foreground="#f7768e">' if workspace['urgent'] else '<span>'
    output += '<span foreground="#414868">' + visible + focused + urgent + ' ' \
            + workspace['name'].split(':')[1] + ' </span></span></span></span>'

output += '</txt>'

print(output)
