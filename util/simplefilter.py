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
        $ cd vm; ../util/simplefilter.py ../ ../util/.simplefilter.list | while read line; do vagrant scp $line default:~/MozITP; done
    """
    # setup default value
    current_dir = os.path.curdir
    whitelist = ['*']
    blacklist = ['.git', 'vm', '.idea', 'env', 'env-*']

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
                whitelist = loaded_list.get('whitelist')
                blacklist = loaded_list.get('blacklist')
        else:
            raise Exception('{} is not a file'.format(list_file))

    files = [os.path.join(current_dir, f) for f in os.listdir(current_dir) if os.path.isfile(os.path.join(current_dir, f))]
    dirs = [os.path.join(current_dir, f) for f in os.listdir(current_dir) if os.path.isdir(os.path.join(current_dir, f))]

    # remove the items which are not match the whitelist
    for pattern in whitelist:
        regex = fnmatch.translate(pattern)
        regex_obj = re.compile(regex)
        for dir_name in dirs:
            if not regex_obj.match(os.path.basename(dir_name)):
                dirs.remove(dir_name)
        for file_name in files:
            if not regex_obj.match(os.path.basename(file_name)):
                files.remove(file_name)
    # remove the items which are match the blacklist
    for pattern in blacklist:
        regex = fnmatch.translate(pattern)
        regex_obj = re.compile(regex)
        for dir_name in dirs:
            if regex_obj.match(os.path.basename(dir_name)):
                dirs.remove(dir_name)
        for file_name in files:
            if regex_obj.match(os.path.basename(file_name)):
                files.remove(file_name)

    for item in files:
        print(item)
    for item in dirs:
        print(item)
