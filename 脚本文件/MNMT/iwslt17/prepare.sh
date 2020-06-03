set -e

# 设置mosesdeocder和subword-nmt的脚本路径
SCRIPTS=../../mosesdecoder/scripts
TOKENIZER=$SCRIPTS/tokenizer/tokenizer.perl
# LC=$SCRIPTS/tokenizer/lowercase.perl
CLEAN=$SCRIPTS/training/clean-corpus-n.perl
NORM_PUNC=$SCRIPTS/tokenizer/normalize-punctuation.perl
BPEROOT=../../subword-nmt-master/subword_nmt
# BPE_TOKENS=10000

# 需要手动修改
src=de
tgt=en
lang=$src-$tgt
prep=iwslt17.tokenized.$lang
tmp=$prep/tmp
orig=orig

# 每次都会删除一次，在创建
if [ -d "$prep" ]; then
    rm -rf $prep
fi

# 创建所需文件夹
mkdir -p $tmp $prep


# 针对 train.tags.en-de.en 和 train.tags.en-de.de 做去标签处理
# 去掉 <doc </doc> <url> <keyword> <speaker> <talkid> </reviewer> </translator>所在的行
# 将 <title> </title> <description> </description> 去掉, 但保留其所在行
# moses分词处理
echo "pre-processing train data..."
for l in $src $tgt; do
    f=train.tags.$lang.$l
    tok=train.$lang.$l

    cat $orig/$f | \
        grep -v '<url>' | \
        grep -v '<talkid>' | \
        grep -v '<keywords>' | \
        grep -v '<speaker>' | \
        grep -v '<reviewer' | \
        grep -v '<translator' | \
        grep -v '<doc' | \
        grep -v '</doc>' | \
        sed -e 's/<title>//g' | \
        sed -e 's/<\/title>//g' | \
        sed -e 's/<description>//g' | \
        sed -e 's/<\/description>//g' | \
        sed 's/^\s*//g' | \
        sed 's/\s*$//g' | \
    perl $NORM_PUNC -l $l | \
    perl $TOKENIZER -threads 8 -a -l $l > $prep/train.$l
    echo ""
done

# 添加tok, 需要手动修改
echo "adding tok to train.$src..."
cat $prep/train.$src | \
    sed 's/^/2en /' > $prep/train.$src.tok

echo "adding tok to train.$tgt..."
cat $prep/train.$tgt | \
    sed 's/^/2de /' > $prep/train.$tgt.tok