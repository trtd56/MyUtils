from my_utils import get_logger
# import my_debug

DIR = './tmp_result/'


def main():
    logger = get_logger(DIR)

    logger.info('--- start ---')

    logger.info('--- end ---')


if __name__ == '__main__':
    main()
