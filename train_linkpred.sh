#!/bin/sh

python3 split_data.py \
       -dset resources/physics/data.csv \
       -out physics

for i in 0 1 2 3 4
do
python3 embed.py \
       -dim 10 \
       -lr 0.3 \
       -epochs 150 \
       -negs 50 \
       -burnin 20 \
       -ndproc 4 \
       -manifold poincare \
       -dset resources/physics/train_30.csv \
       -checkpoint results/physics/30.pth \
       -batchsize 10 \
       -eval_each 20 \
       -sparse \
       -train_threads 1

python3 embed.py \
       -dim 10 \
       -lr 0.3 \
       -epochs 150 \
       -negs 50 \
       -burnin 20 \
       -ndproc 4 \
       -manifold euclidean \
       -dset resources/physics/train_30.csv \
       -checkpoint results/physics/eu_30.pth \
       -batchsize 10 \
       -eval_each 20 \
       -sparse \
       -train_threads 1
echo $i
done
