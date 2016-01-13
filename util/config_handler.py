#!/usr/bin/env python

import os
import json
import time
import logging

logger = logging.getLogger(__name__)


class ConfigHandler:
    def __init__(self, path):
        """
        Setup the target folder.
        """
        self.path = path
        self._check_if_folder_is_valid()

    def _check_if_folder_is_valid(self):
        if not os.path.exists(self.path):
            logger.debug("[{}] doesn't exist, trying to create it.".format(self.path))
            self._create_folder()
        if not os.path.isdir(self.path):
            raise Exception('[{}] is not a folder.'.format(self.path))
        if not os.access(self.path, os.W_OK):
            raise Exception('Write permission denied on [{}].'.format(self.path))

    def _create_folder(self):
        try:
            os.makedirs(self.path)
        except os.error as e:
            logger.debug('errno: [{}], strerror: [{}], filename: [{}]'.format(e.errno, e.strerror, e.filename))
            raise Exception('Can not create the folder: [{}]'.format(self.path))

    def is_config_exist(self, config_file):
        config_path = os.path.join(self.path, config_file)
        return os.path.exists(config_path)

    def create_config(self, config_file, content_json):
        """
        Create config file if it doesn't exist.
        """
        config_path = os.path.join(self.path, config_file)
        if os.path.exists(config_path):
            raise Exception("[{}] already exist.".format(config_path))
        with open(config_path, 'a') as fw:
            json.dump(content_json, fw)
            logger.debug('Write to config [{}]:\n{}'.format(config_path, content_json))

    def touch_config(self, config_file):
        """
        Touch config file. Return modification time.
        """
        config_path = os.path.join(self.path, config_file)
        if not os.path.exists(config_path):
            self.create_config(config_file, {})
        os.utime(config_path, None)
        return self.get_config_mtime(config_path)

    def get_config_mtime(self, config_file):
        """
        Get the modification time of config file. Return None if file doesn't exist.
        """
        config_path = os.path.join(self.path, config_file)
        if not os.path.exists(config_path):
            return None
        config_mtime = os.path.getmtime(config_path)
        logger.debug('The mtime of [{}] is {}'.format(config_path, time.ctime(config_mtime)))
        return config_mtime

    def load_config(self, config_file):
        """
        Return dict object by loading config_file. Return None if config file does not exist.
        @param config_file: the config file name. the content should be JSON format.
        """
        config_path = os.path.join(self.path, config_file)
        if not os.path.exists(config_path):
            logger.debug("[{}] doesn't exist.".format(config_path))
            return None
        if not os.path.isfile(config_path):
            raise Exception('[{}] is not a file.'.format(config_path))
        if not os.access(config_path, os.R_OK):
            raise Exception('[{}] can not read.'.format(config_path))
        with open(config_path, 'r') as fd:
            config_content = json.load(fd)
            logger.debug('load config [{}]:\n{}'.format(config_path, config_content))
            return config_content
