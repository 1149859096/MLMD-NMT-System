# MLMD-NMT-System
Multilingual Multi-domain Neural Machine Translation System

其中，Web + fairseq是系统的网页端和fairseq结合的代码
-在该目录的interactive.py中，是网页端flask的后台代码
我将fairseq_cil中的interactive1.py拆分为加载模型和翻译两个接口
需要注意的是，如果你需要使用你自己的模型，请在fairseq_cil/interactive1.py里面修改路径
-该目录的templates是网页的html代码，使用Jinja2模板引擎
·该目录的static是网页的css样式代码

脚本文件中是我处理数据和跑模型代码以及解码的脚本文件。

