set -e

# 设置mosesdeocder和subword-nmt的脚本路径
SCRIPTS=../../mosesdecoder/scripts
TOKENIZER=$SCRIPTS/tokenizer/tokenizer.perl
# LC=$SCRIPTS/tokenizer/lowercase.perl
CLEAN=$SCRIPTS/training/clean-corpus-n.perl
NORM_PUNC=$SCRIPTS/tokenizer/normalize-punctuation.perl
BPEROOT=../../subword-nmt-master/subword_nmt

# 需手动修改
src=de
tgt=en
lang=$src-$tgt
orig=orig
prep=prep
tmp=$prep/tmp
filename=test2006

# if [ -d "$prep" ]; then
#     rm -rf $prep
# fi
mkdir -p $tmp $prep

for l in $src $tgt; do
    f=$filename.$l
    o=$filename.$lang.$l

    cat $orig/$f | \
        perl $NORM_PUNC -l $l | \
        perl $TOKENIZER -threads 8 -a -l $l > $prep/$filename.$lang.$l
    echo ""
done

# 需手动修改
echo "adding tok to $src file..."
cat $prep/$filename.$lang.$src | \
    sed 's/^/2en /' > $prep/$filename.$lang.$src.tok
echo "adding tok to $tgt file..."
cat $prep/$filename.$lang.$tgt | \
    sed 's/^/2de /' > $prep/$filename.$lang.$tgt.tok
echo ""