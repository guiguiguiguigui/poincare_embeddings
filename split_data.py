import pandas, argparse, os
from sklearn.model_selection import KFold, train_test_split

def parse_graph(inpath, outpath, save = True):
    df = pandas.DataFrame(columns=['id1', 'id2'])
    with open(inpath, 'r') as f:
        line = f.readline()
        cnt = 1
        while line:
            df.loc[cnt] = line.strip().split("\t")
            line = f.readline()
            cnt += 1
    df['weight'] = 1
    if save:
        df.to_csv(os.path.join(outpath, 'data.csv'), index=False)
    return df

def main():
    parser = argparse.ArgumentParser(description='Train Hyperbolic Embeddings')
    parser.add_argument('-dset', type=str, required=True,
                        help='Dataset identifier')
    parser.add_argument('-out', type=str, required=True,
                        help='out path')
    opt = parser.parse_args()

    df = parse_graph(opt.dset,  "resources/" + opt.out)
    idx = KFold(n_splits = 5, shuffle = True).split(df) #5-way split

    count = 0

    train_csv = "resources/" + opt.out + "/train_{}.csv"
    test_csv = "resources/" + opt.out + "/test_{}.csv"

    for train_index, test_index in idx:
        df.iloc[train_index].to_csv(train_csv.format(count), index=False)
        df.iloc[test_index].to_csv(test_csv.format(count), index=False)
        count += 1


if __name__ == '__main__':
    main()
