dir=prep
targert=data_done
if [ -d "$targert" ]; then
    rm -rf $target
fi
mkdir -p $targert

cp $dir/code $targert/code

# train.src
cat $dir/train.de-en.de $dir/train.en-de.en $dir/train.fr-en.fr $dir/train.en-fr.en > $targert/train.src
# train.tgt
cat $dir/train.de-en.en $dir/train.en-de.de $dir/train.fr-en.en $dir/train.en-fr.fr > $targert/train.tgt
# train.bert.src
cat $dir/train.de-en.bert.de $dir/train.en-de.bert.en $dir/train.fr-en.bert.fr $dir/train.en-fr.bert.en > $targert/train.bert.src

# test.src
cat $dir/test.de-en.de $dir/test.en-de.en $dir/test.fr-en.fr $dir/test.en-fr.en > $targert/test.src
# test.tgt
cat $dir/test.de-en.en $dir/test.en-de.de $dir/test.fr-en.en $dir/test.en-fr.fr > $targert/test.tgt
# test.bert.src
cat $dir/test.de-en.bert.de $dir/test.en-de.bert.en $dir/test.fr-en.bert.fr $dir/test.en-fr.bert.en > $targert/test.bert.src

# valid.src
cat $dir/valid.de-en.de $dir/valid.en-de.en $dir/valid.fr-en.fr $dir/valid.en-fr.en > $targert/valid.src
# valid.tgt
cat $dir/valid.de-en.en $dir/valid.en-de.de $dir/valid.fr-en.en $dir/valid.en-fr.fr > $targert/valid.tgt
# valid.bert.src
cat $dir/valid.de-en.bert.de $dir/valid.en-de.bert.en $dir/valid.fr-en.bert.fr $dir/valid.en-fr.bert.en > $targert/valid.bert.src