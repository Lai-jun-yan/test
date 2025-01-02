import dash
from dash import dcc, html
from dash.dependencies import Input, Output

# 初始化 Dash 应用
app = dash.Dash(__name__)

# 定义应用布局
app.layout = html.Div([
    html.H1("陳冠瑜喜歡陳冠瑜！"),
    dcc.Input(id='input-box', type='text', placeholder='输入一些内容'),
    html.Button('提交', id='button'),
    html.Div(id='output')
])

# 回调函数，用于更新输出
@app.callback(
    Output('output', 'children'),
    [Input('button', 'n_clicks')],
    [dash.dependencies.State('input-box', 'value')]
)
def update_output(n_clicks, value):
    if n_clicks:
        return f"您输入的是：{value}"
    return "请输入内容并点击提交！"

# 运行服务器
if __name__ == '__main__':
    app.run_server(debug=True)
