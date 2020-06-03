MODEL_DIR=checkpoints/data-done  # checkpoints所在的文件夹
DIC_DIR=data-bin/data-done  # preprocess.py的结果所在的文件夹
BPE_DIR=data-done  # BPE学习得到的code所在的文件夹

fairseq-interactive \
    --path $MODEL_DIR/checkpoint_best.pt $DIC_DIR \
    --beam 5 \
    --tokenizer moses \
    --bpe subword_nmt --bpe-codes $BPE_DIR/code