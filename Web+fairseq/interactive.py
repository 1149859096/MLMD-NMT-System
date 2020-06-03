#!/usr/bin/env python3 -u
# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

from fairseq_cli.interactive1 import load_model, translate
from flask import Flask, redirect, url_for, \
    request, render_template

app = Flask(__name__)


@app.route('/')
def hello():
    return render_template('source.html')


@app.route('/result/<sentence>/<src_lan>/<tar_lan>')
def result(sentence, src_lan, tar_lan):
    raw_txt = tar_lan + ' ' + sentence
    # 是否选择语言
    if tar_lan == 'no_choice' or src_lan == 'no_choice':  # 未选择源语言或目标语言
        result = '请在下拉框中选择语言'
    # 是否输入句子
    elif sentence == '请在这里输入待翻译的句子':
        result = 'Please enter the sentence to be translated in the left!'
    elif tar_lan.replace('2', '') == src_lan:  # 目标语言和源语言选择相同
        result = sentence
    elif (src_lan == 'de' and tar_lan == '2fr') or (src_lan == 'fr' and tar_lan == '2de'):
        # 以en为载体进行德法和法德之间的翻译
        print("translate into en")
        raw_txt = '2en ' + sentence
        result = translate(tokenizer, bpe, args, task, models, use_cuda, generator, tgt_dict, src_dict, raw_txt)
        print('translate into target')
        raw_txt = tar_lan + ' ' + result
        result = translate(tokenizer, bpe, args, task, models, use_cuda, generator, tgt_dict, src_dict, raw_txt)
    else:
        print("It's here!")
        result = translate(tokenizer, bpe, args, task, models, use_cuda, generator, tgt_dict, src_dict, raw_txt)
    return render_template('target.html', result=result, original=sentence)


@app.route('/translator/', methods=['POST', 'GET'])
def translator():
    original_sen = request.args.get('sentence')
    if original_sen == '':
        original_sen = '请在这里输入待翻译的句子'
    src = request.args.get('src_lan')
    tar = request.args.get('tar_lan')
    return redirect(url_for('result', sentence=original_sen, src_lan=src, tar_lan=tar))


if __name__ == '__main__':
    print("loading model...")
    tokenizer, bpe, args, task, models, use_cuda, generator, tgt_dict, src_dict = load_model('mymodel_high')
    print("over\n\n\n")

    print("running website...")
    app.run(host='127.0.0.1', port=5000, debug=True)
    print("over\n\n\n")