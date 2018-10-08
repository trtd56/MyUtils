import os
import sys
from logging import StreamHandler, DEBUG, Formatter, FileHandler, getLogger

LOG_STR = '%(asctime)s %(name)s %(lineno)d [%(levelname)s][%(funcName)s] %(message)s '


def get_logger(outdir):
    file_name = sys.argv[0]

    os.makedirs(outdir, exist_ok=True)

    logger = getLogger(__name__)
    log_fmt = Formatter(LOG_STR)
    handler = StreamHandler()
    handler.setLevel('INFO')
    handler.setFormatter(log_fmt)
    logger.addHandler(handler)

    handler = FileHandler('{0}/{1}.log'.format(outdir, file_name), 'a')
    handler.setLevel(DEBUG)
    handler.setFormatter(log_fmt)
    logger.setLevel(DEBUG)
    logger.addHandler(handler)

    return logger
