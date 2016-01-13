import logging

LOGGING_POLICY = {
    'default': {
        'level': logging.INFO,
        'format': '%(levelname)s: %(message)s'
    },
    'verbose': {
        'level': logging.DEBUG,
        'format': '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    },
    'no_logs': {
        'level': logging.CRITICAL,
        'format': '%(message)s'
    }
}
