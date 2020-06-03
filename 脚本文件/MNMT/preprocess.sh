src=de  # 源语言
tgt=en  # 目标语言
TEXT=data-done  #存放训练文件的目录
output=data-bin/$TEXT  #结果存放的目录

if [ -d "$output" ]; then
    rm -rf $output
fi

# ../../preprocess.py这个得看你寻访preprocess.sh相对与preprocess.py的位置
# 在存放训练文件的目录里需要有train.en、train.de、valid.en、valid.de、test.en、test.de
python3 ../../preprocess.py --joined-dictionary \
    --source-lang $src --target-lang $tgt \
    --trainpref $TEXT/train  --validpref $TEXT/valid --testpref $TEXT/test \
    --destdir $output \
    --workers 32
