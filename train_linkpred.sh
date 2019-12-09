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
       -dset resources/physics/train_"$i".csv \
       -checkpoint results/physics/"$i".pth \
       -batchsize 10 \
       -eval_each 20 \
       -sparse \
       -train_threads 2

python3 embed.py \
       -dim 10 \
       -lr 0.3 \
       -epochs 150 \
       -negs 50 \
       -burnin 20 \
       -ndproc 4 \
       -manifold euclidean \
       -dset resources/physics/train_"$i".csv \
       -checkpoint results/physics/eu_"$i"}.pth \
       -batchsize 10 \
       -eval_each 20 \
       -sparse \
       -train_threads 2
echo $i
done