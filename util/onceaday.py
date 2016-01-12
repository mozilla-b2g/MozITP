#!/usr/bin/env python

import os
import sys
import time
import hashlib
import logging

from config_handler import ConfigHandler
from logging_policy import LOGGING_POLICY

logger = logging.getLogger(__name__)


if __name__ == '__main__':
    """
    Usage: ./onceaday.py "[command]"
    ex:
        $ ./onceaday.py "echo hello"
        $ ./onceaday.py "echo \"arg1 arg2 arg3\""
    """

    logging_config = LOGGING_POLICY['default']
    logging.basicConfig(level=logging_config['level'], format=logging_config['format'])

    ONE_DAY = 24 * 60 * 60
    CONFIG_PATH = os.path.expanduser('~/.MozITP/')
    # get command
    if len(sys.argv) < 2:
        exit(0)
    else:
        logger.debug('argv: {}'.format(sys.argv))
        command = sys.argv[1]
        logger.debug('Command: {}'.format(command))

        hash_obj = hashlib.sha256()
        hash_obj.update(command)
        hash_code = hash_obj.hexdigest()
        logger.debug('Hash file: ' + os.path.join(CONFIG_PATH, hash_code))

        ch = ConfigHandler(CONFIG_PATH)
        if ch.is_config_exist(hash_code):
            now = time.time()
            config_mtime = ch.get_config_mtime(hash_code)
            diff_time = now - config_mtime
            logger.info('Now: {}, Latest: {}, Diff: {}'.format(now, config_mtime, diff_time))
            if diff_time > ONE_DAY:
                logger.info('Run: {}'.format(command))
                os.system(command)
                logger.info('origin m-time {}'.format(config_mtime))
                config_mtime = ch.touch_config(hash_code)
                logger.info('new m-time {}'.format(config_mtime))
            else:
                logger.info('Skip: {}'.format(command))
        else:
            logger.info('Run: {}'.format(command))
            os.system(command)
            config_mtime = ch.touch_config(hash_code)
            logger.info('Create time {}'.format(config_mtime))
