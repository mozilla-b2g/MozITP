#!/usr/bin/env python

import os
import re
import sys
import json
import fnmatch


if __name__ == '__main__':
    """
    Usage: ./simplefilter.py [start_path] [filter_list_file]
    ex:
        $ cd vm; ./util/simplefilter.py ./ ./util/.simplefilter.list | while read line; do vagrant scp $line default:~/MozITP; done
    """
    # setup default value
    current_dir = os.path.curdir
    file_whitelist = ['*.sh']
    file_blacklist = []
    folder_whitelist = ['*']
    folder_blacklist = ['.git', 'vm', '.idea', 'env', 'env-*']

    # get start path from arg1
    if len(sys.argv) > 1:
        if os.path.isdir(sys.argv[1]):
            current_dir = os.path.relpath(sys.argv[1])
        else:
            raise Exception('{} is not a folder'.format(sys.argv[1]))

    # get filter file from arg2
    if len(sys.argv) > 2:
        list_file = os.path.relpath(sys.argv[2])
        if os.path.isfile(list_file):
            with open(list_file) as f:
                loaded_list = json.load(f)
                # load file pattern
                file_pattern = loaded_list.get('file')
                file_whitelist = file_pattern.get('whitelist')
                file_blacklist = file_pattern.get('blacklist')
                # load folder pattern
                folder_pattern = loaded_list.get('folder')
                folder_whitelist = folder_pattern.get('whitelist')
                folder_blacklist = folder_pattern.get('blacklist')
        else:
            raise Exception('{} is not a file'.format(list_file))

    files = [os.path.join(current_dir, f) for f in os.listdir(current_dir) if os.path.isfile(os.path.join(current_dir, f))]
    dirs = [os.path.join(current_dir, f) for f in os.listdir(current_dir) if os.path.isdir(os.path.join(current_dir, f))]

    # file part, remove the items which are not match the whitelist
    for pattern in file_whitelist:
        regex = fnmatch.translate(pattern)
        regex_obj = re.compile(regex)
        files = [f for f in files if regex_obj.match(os.path.basename(f))]
    # remove the items which are match the blacklist
    for pattern in file_blacklist:
        regex = fnmatch.translate(pattern)
        regex_obj = re.compile(regex)
        files = [f for f in files if not regex_obj.match(os.path.basename(f))]

    # folder part, remove the items which are not match the whitelist
    for pattern in folder_whitelist:
        regex = fnmatch.translate(pattern)
        regex_obj = re.compile(regex)
        dirs = [d for d in dirs if regex_obj.match(os.path.basename(d))]
    # remove the items which are match the blacklist
    for pattern in folder_blacklist:
        regex = fnmatch.translate(pattern)
        regex_obj = re.compile(regex)
        dirs = [d for d in dirs if not regex_obj.match(os.path.basename(d))]

    for item in files:
        print(item)
    for item in dirs:
        print(item)
