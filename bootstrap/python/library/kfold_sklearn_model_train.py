from sklearn.model_selection import StratifiedKFold, ParameterGrid
from tqdm import tqdm
from sklearn import metrics
import numpy as np


def kfold_sklearn_model_train(train_X,
                              train_y,
                              parameters,
                              n_fold,
                              sklearn_model,
                              logger):

    best_auc = 0
    best_param = None

    for params in tqdm(list(ParameterGrid(parameters))):
        logger.info('params: {}'.format(params))

        auc_lst = []
        skf = StratifiedKFold(n_splits=n_fold, shuffle=True, random_state=0)
        for trn_i, val_i in skf.split(train_X, train_y):
            trn_x = train_X[trn_i]
            val_x = train_X[val_i]
            trn_y = train_y[trn_i]
            val_y = train_y[val_i]

            model = sklearn_model(**params)
            model.fit(trn_x, trn_y)

            pred = model.predict_proba(val_x)
            pred = np.array([p[1] for p in pred])

            fpr, tpr, thresholds = metrics.roc_curve(val_y, pred)
            auc = metrics.auc(fpr, tpr)
            logger.info('AUC: {}'.format(auc))

            auc_lst.append(auc)

        auc_avg = sum(auc_lst) / len(auc_lst)
        logger.info('AUC AVG: {}'.format(auc_avg))

        if best_auc < auc_avg:
            best_auc = auc_avg
            best_param = params

    logger.info('best params: {}'.format(best_param))
    logger.info('AUC: {}'.format(best_auc))

    logger.info('train by best parameters')
    model = sklearn_model(**best_param)
    model.fit(train_X, train_y)

    return model
