from my_utils import get_logger

DIR = './result/'


def main():
    logger = get_logger(DIR)
    logger.info('start')
    logger.info('end')


if __name__ == '__main__':
    main()
