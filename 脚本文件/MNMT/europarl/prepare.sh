set -e

# 设置mosesdeocder和subword-nmt的脚本路径

SCRIPTS=/home/wanglaohu/fairseq0.6.0/mosesdecoder/scripts
TOKENIZER=$SCRIPTS/tokenizer/tokenizer.perl
# LC=$SCRIPTS/tokenizer/lowercase.perl
CLEAN=$SCRIPTS/training/clean-corpus-n.perl
NORM_PUNC=$SCRIPTS/tokenizer/normalize-punctuation.perl
BPEROOT=/home/wanglaohu/fairseq0.6.0/subword-nmt-master/subword_nmt

# 需要手动修改
src=de
tgt=en
lang=$src-$tgt
prep=prep
tmp=$prep/tmp
orig=orig

# if [ -d "$prep" ]; then
#     rm -rf $prep
# fi
mkdir -p $tmp $prep

echo "pre-processing training data..."
for l in $src $tgt; do
    f=europarl-v7.$lang.$l

    cat $orig/$f | \
    perl $NORM_PUNC -l $l | \
    perl $TOKENIZER -threads 8 -a -l $l > $prep/train.$lang.$l
    echo ""
done

# 添加tok, 需要手动修改
echo "adding tok to train.$lang.$src..."
cat $prep/train.$lang.$src | \
    sed 's/^/2en /' > $prep/train.$lang.$src.tok

echo "adding tok totrain.$lang.$tgt..."
cat $prep/train.$lang.$tgt | \
    sed 's/^/2de /' > $prep/train.$lang.$tgt.tok