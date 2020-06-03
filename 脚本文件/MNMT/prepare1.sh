set -e

tmp=prep/tmp
if [ -d "$tmp" ]; then
    rm -rf $tmp
fi
mkdir -p $tmp

# 连接train, 保存到tmp中
dir1=europarl/prep
dir2=iwslt17/iwslt17.tokenized.de-en
# train.de-en
cat $dir1/train.de-en.de.tok $dir2/train.de.tok > $tmp/train.de-en.de
cat $dir1/train.de-en.en     $dir2/train.en     > $tmp/train.de-en.en
# train.en-de
cat $dir1/train.de-en.en.tok $dir2/train.en.tok > $tmp/train.en-de.en
cat $dir1/train.de-en.de    $dir2/train.de     > $tmp/train.en-de.de
# train.fr-en
cp $dir1/train.fr-en.fr.tok $tmp/train.fr-en.fr
cp $dir1/train.fr-en.en     $tmp/train.fr-en.en
# train.en-fr
cp $dir1/train.fr-en.en.tok $tmp/train.en-fr.en
cp $dir1/train.fr-en.fr     $tmp/train.en-fr.fr


dir=valid/prep
filename=dev2006
ofilename=valid
# valid.de-en
cp $dir/$filename.de-en.de.tok $tmp/$ofilename.de-en.de
cp $dir/$filename.de-en.en     $tmp/$ofilename.de-en.en
# valid.en-de
cp $dir/$filename.de-en.en.tok $tmp/$ofilename.en-de.en
cp $dir/$filename.de-en.de     $tmp/$ofilename.en-de.de
# valid.fr-en
cp $dir/$filename.fr-en.fr.tok $tmp/$ofilename.fr-en.fr
cp $dir/$filename.fr-en.en     $tmp/$ofilename.fr-en.en
# valid.en-fr
cp $dir/$filename.fr-en.en.tok $tmp/$ofilename.en-fr.en
cp $dir/$filename.fr-en.fr     $tmp/$ofilename.en-fr.fr

dir=test/prep
filename=test2006
ofilename=test
# test.de-en
cp $dir/$filename.de-en.de.tok $tmp/$ofilename.de-en.de
cp $dir/$filename.de-en.en     $tmp/$ofilename.de-en.en
# test.en-de
cp $dir/$filename.de-en.en.tok $tmp/$ofilename.en-de.en
cp $dir/$filename.de-en.de     $tmp/$ofilename.en-de.de
# test.fr-en
cp $dir/$filename.fr-en.fr.tok $tmp/$ofilename.fr-en.fr
cp $dir/$filename.fr-en.en     $tmp/$ofilename.fr-en.en
# test.en-fr
cp $dir/$filename.fr-en.en.tok $tmp/$ofilename.en-fr.en
cp $dir/$filename.fr-en.fr     $tmp/$ofilename.en-fr.fr