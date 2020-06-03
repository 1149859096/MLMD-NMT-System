set -e

# 设置mosesdeocder和subword-nmt的脚本路径
SCRIPTS=/home/wanglaohu/fairseq0.6.0/mosesdecoder/scripts
TOKENIZER=$SCRIPTS/tokenizer/tokenizer.perl
# LC=$SCRIPTS/tokenizer/lowercase.perl
CLEAN=$SCRIPTS/training/clean-corpus-n.perl
BPEROOT=/home/wanglaohu/fairseq0.6.0/subword-nmt-master/subword_nmt
BPE_TOKENS=32000

# src=src
# tgt=tgt

# # cat train.src and train.tgt
target=prep
# TRAIN=$target/tmp/train.$src-$tgt
BPE_CODE=$target/code
# rm -rf $TRAIN
# echo "cat train.src and train.tgt"
# for l in $src $tgt; do
#     cat $target/tmp/train.$src >> $TRAIN
# done
# echo ""

# # learn-bpe
# echo "learn_bpe.py on ${TRAIN}..."
# python $BPEROOT/learn_bpe.py -s $BPE_TOKENS < $TRAIN > $BPE_CODE
# echo ""


# apply_bpe
lang1=de-en
lang2=en-de
lang3=fr-en
lang4=en-fr
for pre in train valid test; do
    for pair in $lang1 $lang2 $lang3 $lang4; do
        l=(${pair//-/ })
        for l in ${l[@]}; do
            f=$pre.$pair.$l
            echo "apply_bpe.py to ${f}..."
            python $BPEROOT/apply_bpe.py -c $BPE_CODE < $target/tmp/$f > $target/$f
        done
    done
done
echo ""