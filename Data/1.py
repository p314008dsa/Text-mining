import jieba.posseg as pseg
import pandas as pd

###############################################################
def jieba_tokenizer(text):
    words = pseg.cut(text)
    return '/'.join([
        word for word, flag in words if flag != 'x'])

###############################################################

df_Q2 = pd.read_excel('Q2.xlsx')

result =[]
for i in range(len(df_Q2.iloc[:])):
    seg_text = jieba_tokenizer(df_Q2.iloc[i,7])
    # seg_list = "/".join(seg_text)
    result.append([df_Q2.iloc[i,7],seg_text])

df = pd.DataFrame(data = result, columns=['原新聞敘述','新聞斷詞'])

# print(df)

df.to_excel('/Users/wangyuda/Desktop/文字探勘/Q2_result_1.xlsx')