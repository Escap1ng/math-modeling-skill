---
name: "math-modeling-helper"
description: "数学建模竞赛全流程辅助：赛题分析、算法优选、代码实现、论文润色。用户提交赛题或提出建模需求时触发。"
---

# 数学建模竞赛辅助技能

## 核心定位

专为数学建模国赛（高教社杯）设计，覆盖**赛题理解 → 模型构建 → 算法实现 → 论文输出**全流程。

**核心风格**：学术语态、逻辑严谨、创新性强、结果可验证

***

## 工作流（强制执行）

### 阶段零：环境预检（前置检查）

**在开始建模前，必须检查以下环境依赖是否可用**：

1. **编译环境**：
   - 检查 `xelatex` 是否可用（用于生成PDF）
   - 若不可用，提示安装 TeX Live 或 MiKTeX
2. **Python依赖**：
   - 检查 `python-docx`（用于 Word 版式后处理微调）
   - 检查 `PyMuPDF`（用于读取PDF数据）
   - 检查 `openpyxl`（用于读取 .xlsx 数据）；若赛题附件含旧版 `.xls` 文件，另需 `xlrd`（openpyxl 不支持 .xls 二进制格式），缺失时安装 `pip install xlrd`
   - 若缺失，自动执行 `pip install python-docx pymupdf openpyxl`
3. **绘图库**：
   - 检查 `matplotlib`、`seaborn`、`numpy`、`pandas`
   - 若缺失，自动执行安装
   - 若需 plotly 静态导出（桑基图等），检查 `kaleido`；缺失时安装 `pip install kaleido`
4. **Word 转换工具**：
   - 检查 `pandoc` 是否可用（LaTeX→Word 转换必需，公式自动转 OMML 原生数学格式）
   - 若缺失，提示安装 pandoc（`winget install pandoc` 或官网下载），并提醒其为系统级安装、非 pip 可装
   - 可选：`graphviz`（复杂架构图，见第4章流程图规范）

**输出**：环境状态报告（哪些可用、哪些已自动安装、哪些需用户手动处理）

### 阶段一：赛题分析与背景调研

**不输出给用户**，仅作为建模依据：

1. **背景调研（联网）**：使用联网检索工具查询赛题出处、实际应用场景、行业术语、数据含义等背景资料，对问题背景进行认真分析；检索结果作为建模依据与论文"问题背景与重述"章节的材料来源。
2. **问题本质**：核心问题是什么？属于哪类问题（优化/预测/评价/分类/微分方程）？
3. **已知条件**：可用数据、约束条件（资源/时间/物理）
4. **输出目标**：每个子问题需要什么形式的结果（数值/曲线/方案/排序）
5. **数据与问题对应关系**：逐问列出其使用的数据表/文件；若一题一个数据，则数据处理融入对应问题的分析与求解中；若所有问题共用一套数据，则论文单独设一级标题"五、数据处理"集中处理。

### 阶段二：工作目录创建

```bash
第X题_赛题简称/
└── answer/         # 所有建模产出统一存放于 answer 文件夹下
    ├── code/           # Python代码（按问题编号：q1_*.py, q2_*.py；含 plot_style.py 统一样式模块）
    ├── figures/
    │   ├── final/      # 交付图（语义命名：fig{图号}_{题型}_{内容}.png/pdf，≥300 DPI，须被论文 .tex 引用）
    │   └── tmp/        # 调试图（与正式版同品质 300 DPI；交付/打包前整体删除）
    └── paper/          # 论文（paper.tex + paper.pdf + paper.docx）
```

### 阶段三：算法选择（内部推理，不输出）

**不输出给用户**，仅在内部完成并择优：

1. **候选算法生成**：针对每个小问，结合问题类型、数据规模、约束条件，从算法库中筛选 2–3 种可行算法。
2. **内部比对**：从求解精度、计算复杂度、鲁棒性、可解释性、实现可行性五个维度，对候选算法进行量化或定性评估。
3. **择优决策**：选择综合质量更优的算法作为本问的求解方案，直接进入阶段四的代码实现与论文写作。

**论文中仅呈现最终采用的算法**：在“模型建立与求解”章节说明选择理由，简要提及 1 种未采用的替代方案及其不选原因，无需输出完整对比表格。

**要求**：

- **算法选型核心原则：拟合性优先于高级性**——首选与问题结构、数据规模、约束条件最匹配的算法（保证可求解、结果可靠、可解释），再在匹配基础上考虑创新性；禁止为炫技强行引入与问题不适配的高深算法，导致求解困难或结论不可信
- 至少 1 个候选算法具有明显创新性（可引入交叉学科方法）
- 最终方案的数学描述使用学术语态，公式独立呈现
- 形成逻辑闭环，控制字数

### 阶段四：代码实现

**技术栈（按用途分类，无先后优先级，按题目需要选用）**：

- 基础数值与可视化：numpy, scipy, pandas, matplotlib, seaborn
- 优化建模：pulp, cvxpy, scipy.optimize
- 机器学习：scikit-learn, xgboost
- 数据读取：PyMuPDF（PDF）、openpyxl（.xlsx）、pandas

**代码规范**：

- 完整可运行，保存至 `code/` 文件夹
- 使用 numpy 向量化操作
- 关键参数通过注释说明
- 输出清晰的结果摘要
- 可视化保存至 `figures/final/`，学术风格，≥300 DPI，样式与配色遵循第 4 章可视化规范，建议使用统一样式模块 `code/plot_style.py`（见第 4 章）

### 阶段五：论文输出

**输出物（必须同时生成 PDF 与 Word）**：

- `.tex` 源文件 + `.pdf` 成品论文
- `.docx` Word 文档
- 存放至 `paper/` 文件夹
- 图片路径使用相对路径 `../figures/final/fig2_surface_obj.png`（语义命名，见阶段二目录规范）

**生成命令（PDF 与 Word 均需执行）**：

```bash
# 1. 生成 PDF
cd paper
xelatex -interaction=nonstopmode paper.tex
xelatex -interaction=nonstopmode paper.tex

# 2. 生成 Word（pandoc 将 LaTeX 转为 .docx，公式自动转为 Word 原生数学格式 OMML）
pandoc paper.tex -o paper.docx
# 若公式/表格版式需进一步微调，再用 python-docx 后处理（禁止用文本模拟公式）
```

**技术栈**：

- LaTeX：xelatex 编译
- Word：pandoc 从 LaTeX 转换生成 .docx（公式自动转为 OMML，见上方生成命令）
- Word 版式微调：python-docx 补充页眉留空/页码/字体（公式勿用 python-docx 手工插入）

### 阶段六：论文评分与优化（强制执行）

论文生成后，**必须**按百分制评分体系进行量化评估。低于 85 分须针对性优化后重新评分，**≥85 分方可最终输出**。

**评分流程**：

1. 逐项打分并记录扣分理由
2. 汇总总分，判定是否达标
3. 若 $S < 85$：列出具体扣分项 -> 针对性修改 -> 重新评分
4. 若 $S \geq 85$：输出最终论文，附评分表

**熔断机制**（防止无限循环）：

- 最大优化轮次：**3 轮**
- 若 3 轮后仍未达标（$S < 85$）：输出当前版本论文，附评分表与剩余扣分项说明，明确标注"未达 85 分标准，需人工复核"
- 每轮优化必须有明确改进动作，禁止无实质性修改的空转

***

## 核心能力

### 1. 算法库（精选高频+前沿）

#### 基础数值方法（建模计算地基）

**方程与最优化基础**：二分法、牛顿迭代法、割线法、梯度下降法、共轭梯度法、单纯形法（LP求解）、内点法（LP/QP）
**数值积分与线性代数**：梯形法则、辛普森法则、高斯消元法、LU分解、最小二乘拟合（线性回归基础）
**插值方法**：拉格朗日插值、牛顿插值、三次样条插值（数据补全/曲线拟合）

#### 经典优化（获奖论文高频）

**精确求解**：

- 0-1整数规划、非线性规划、动态规划、分支定界法、线性规划（LP）、匈牙利算法（指派问题）
- 目标规划（多目标妥协方案）、运输问题（表上作业法/最小元素法）、二次规划（QP）、拉格朗日松弛
- 博弈论（零和博弈、纳什均衡、演化博弈）：竞争/合作决策类问题

**启发式优化**：

- 遗传算法（GA）：自适应交叉变异、精英保留
- 模拟退火（SA）：多起点退火、自适应冷却
- 粒子群（PSO）：混沌初始化、动态惯性权重
- 禁忌搜索（TS）：禁忌表记忆、邻域搜索增强

#### 图论与网络优化（路径/网络类问题首选）

**最短路径**：Dijkstra（单源非负权）、Floyd（多源）、Bellman-Ford（含负权）
**网络结构**：最小生成树（Prim/Kruskal）、最大流（Ford-Fulkerson/Dinic）、最小费用最大流
**组合难题**：旅行商问题TSP（精确：动态规划/分支定界；近似：2-opt、最近邻+GA改进）、车辆路径问题VRP、二分图匹配
**适用场景**：交通调度、物流配送、选址布线、通信路由、社交网络分析
**结构算法**：拓扑排序（DAG）、关键路径法（CPM/PERT，项目排程）、欧拉回路/哈密顿回路判断

#### 前沿智能优化（创新方案）

**群体智能**：

- 差分进化（DE）：自适应变异、多向量扰动
- 蚁群算法（ACO）：信息素动态调节
- 灰狼优化（GWO）：层次化领导机制
- 鲸鱼优化（WOA）：气泡网捕食、收缩包围
- 人工蜂群（ABC）：雇佣/观察/侦察蜂分工

**新兴元启发式**：
- 麻雀搜索（SSA）、蜣螂优化（DBO）、金豺优化（GJO）、白鲸优化（BWO）

#### 机器学习与深度学习

**监督学习**：XGBoost、SVM、随机森林、LightGBM、CatBoost、KNN
**深度学习**：Transformer、CNN、RNN/LSTM、自编码器（AE/VAE）、注意力机制（PINN、GNN见前沿创新方法）
**强化学习**：DQN、PPO、SAC、TD3

#### 统计与数据分析

**假设检验**：Z/t/卡方检验、Spearman/Kendall相关性、方差分析（ANOVA）、Shapiro-Wilk正态性检验
**回归插值**：多元回归、样条插值、响应面法（RSM）、高斯过程回归（GPR）、岭回归/Lasso
**降维聚类**：PCA、t-SNE、K-means/DBSCAN、UMAP、层次聚类、高斯混合模型（GMM）
**时间序列**：ARIMA、LSTM/GRU、Prophet、指数平滑（Holt-Winters）、VAR
**小样本预测（国赛高频）**：灰色预测GM(1,1)（少数据、贫信息场景首选，可作基线对比）、马尔可夫链预测（状态转移类问题）、组合预测（多模型加权/最优组合）
**分类与判别**：判别分析（Fisher判别）、逻辑回归、朴素贝叶斯
**数据挖掘**：关联规则挖掘（Apriori）
**统计推断**：极大似然估计（MLE）、EM算法（含隐变量模型）、贝叶斯估计/贝叶斯更新
**回归补充**：多项式回归、逐步回归
**分类补充**：决策树（ID3/C4.5/CART，可作集成基学习器）

#### 综合评价与多属性决策（评价/排序类问题首选）

**TOPSIS（逼近理想解排序法，首选）**：与熵权法搭配为熵权-TOPSIS，获奖论文高频，适用于"对多个方案/对象综合评价并排序"类问题
**权重确定**：熵权法（客观权重）、CRITIC权重法（客观权重）、层次分析法 AHP（主观权重）
**综合评价**：灰色关联分析、模糊综合评价
**效率评价**：数据包络分析（DEA）
**决策分析**：期望值决策法、决策树分析（含敏感性分支）、成本效益分析

#### 物理与工程建模

**运动动力学**：运动学模型、拉格朗日力学、有限元分析、刚体动力学
**微分方程数值解（A题必备）**：欧拉法、龙格-库塔法（RK4，scipy.integrate.solve_ivp）、有限差分法（PDE离散化）、SIR/SEIR传染病模型、稳定性分析（平衡点+相图）
**仿真计算**：事件驱动仿真、蒙特卡洛仿真、DES、元胞自动机（CA）、多智能体仿真（ABM）、排队论
**信号处理**：FFT、小波变换、EMD、卡尔曼滤波、Hilbert-Huang变换（HHT）

#### 前沿创新方法

**数据+物理双驱动**：PINN、算子学习（DeepONet/FNO）、数字孪生
**可解释AI**：符号回归、SHAP/LIME、因果推断（双重差分DID、因果图）
**多目标优化**：NSGA-II/III、鲁棒优化、贝叶斯优化、MOEA/D
**图与网络**：GNN、复杂网络分析、图注意力网络（GAT）、社区发现（Louvain）

***

### 2. 代码实现规范

#### 遗传算法（GA）

```python
# 关键参数为启发式算法文献的经验常用范围；须按问题规模与解空间特点调整，并在论文中说明取值依据
POP_SIZE = 120          # 种群规模：100-200
MAX_GEN = 150           # 最大迭代：100-200
CROSS_RATE = 0.85       # 交叉率：0.8-0.9
MUT_RATE = 0.05         # 变异率：0.01-0.15（连续优化常用低端，组合优化可用高端）
ELITE_RATE = 0.08       # 精英保留：5%-10%
```

**必须包含**：

- 智能初始化策略
- 自适应变异
- 重启机制
- 精英保留

**输出要求**：

- 迭代收敛曲线图
- 最优解决策变量表
- 与基准方案对比（提升百分比）

#### 模拟退火（SA）

```python
T0 = 1000               # 初始温度
T_MIN = 1e-8            # 终止温度
COOLING_RATE = 0.95     # 冷却系数：0.9-0.99
ITER_PER_TEMP = 100     # 每温度迭代次数
```

#### 0-1整数规划

```python
import pulp

prob = pulp.LpProblem("Problem_Name", pulp.LpMaximize)
x1 = pulp.LpVariable("x1", cat='Binary')
x2 = pulp.LpVariable("x2", cat='Binary')
# 目标函数示例：最大化利润
prob += profit_per_unit * x1 + profit_per_unit2 * x2
# 约束条件示例
prob += cost_per_unit * x1 + cost_per_unit2 * x2 <= budget
prob.solve()
```

#### 数据读取模块

```python
import os
import fitz  # PyMuPDF
import openpyxl
import pandas as pd

def load_data(file_path):
    """统一数据加载入口"""
    ext = os.path.splitext(file_path)[1].lower()
    if ext == '.pdf':
        return read_pdf(file_path)
    elif ext in ('.xlsx', '.xls'):
        return read_excel(file_path)
    else:
        raise ValueError(f"不支持的数据格式: {ext}")

def read_pdf(file_path):
    """使用 PyMuPDF 读取 PDF 文本"""
    doc = fitz.open(file_path)
    text = ""
    for page in doc:
        text += page.get_text()
    doc.close()
    return text

def read_excel(file_path):
    """使用 pandas 读取 Excel：openpyxl 仅支持 .xlsx/.xlsm，旧版 .xls 必须用 xlrd 引擎"""
    ext = os.path.splitext(file_path)[1].lower()
    if ext == '.xls':
        return pd.read_excel(file_path, engine='xlrd')   # 需 pip install xlrd
    return pd.read_excel(file_path, engine='openpyxl')
```

#### Word 文档后处理模块（python-docx，用于 pandoc 转换后的版式微调）

> ⚠️ **角色定位（重要）**：Word 文档由 **pandoc 从 paper.tex 转换生成**（见阶段五生成命令），公式已自动转为 OMML 原生数学格式。下方 python-docx 脚本**仅用于 pandoc 转换后的版式微调**（页眉留空、页码页脚、中文字体、三线表核对），**不得用它从头生成全文或手工插入公式**，否则 Word 中将丢失全部数学公式。

```python
from docx import Document
from docx.shared import Pt, Cm
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_CELL_VERTICAL_ALIGNMENT
from docx.oxml.ns import qn
from docx.oxml import OxmlElement


def set_cjk_font(run, font_name='宋体', size=Pt(12), bold=False):
    """统一设置中西文字体与字号（先设西文名确保 rPr/rFonts 存在，再设中文名）"""
    run.font.name = font_name
    run._element.rPr.rFonts.set(qn('w:eastAsia'), font_name)
    run.font.size = size
    run.bold = bold


def set_three_line_table(table):
    """设置三线表样式：顶线粗、底线粗、表头下线细，无竖线"""
    tbl = table._tbl
    tblPr = tbl.tblPr
    if tblPr is None:
        tblPr = OxmlElement('w:tblPr')
        tbl.insert(0, tblPr)
    # 删除默认边框
    borders = OxmlElement('w:tblBorders')
    for edge in ('top', 'bottom', 'left', 'right', 'insideV', 'insideH'):
        elem = OxmlElement(f'w:{edge}')
        elem.set(qn('w:val'), 'none')
        elem.set(qn('w:sz'), '0')
        elem.set(qn('w:space'), '0')
        elem.set(qn('w:color'), '000000')
        borders.append(elem)
    # 顶线（粗 1.5pt）
    top = borders.find(qn('w:top'))
    top.set(qn('w:val'), 'single')
    top.set(qn('w:sz'), '12')
    # 底线（粗 1.5pt）
    bottom = borders.find(qn('w:bottom'))
    bottom.set(qn('w:val'), 'single')
    bottom.set(qn('w:sz'), '12')
    tblPr.append(borders)
    # 表头行底部加细线（0.5pt）
    if len(table.rows) > 1:
        for cell in table.rows[0].cells:
            tcPr = cell._tc.get_or_add_tcPr()
            cell_borders = OxmlElement('w:tcBorders')
            btm = OxmlElement('w:bottom')
            btm.set(qn('w:val'), 'single')
            btm.set(qn('w:sz'), '4')
            btm.set(qn('w:space'), '0')
            btm.set(qn('w:color'), '000000')
            cell_borders.append(btm)
            tcPr.append(cell_borders)


def set_cell_center(cell, text=None, font_name='宋体', font_size=Pt(12)):
    """设置单元格文字上下左右居中（text=None 时仅调整既有内容样式，不重建内容）"""
    if text is not None:
        cell.text = ''
    p = cell.paragraphs[0]
    p.alignment = WD_ALIGN_PARAGRAPH.CENTER  # 水平居中
    if text is None:
        for r in p.runs:
            set_cjk_font(r, font_name, font_size)
    else:
        run = p.add_run(text)
        set_cjk_font(run, font_name, font_size)
    cell.vertical_alignment = WD_CELL_VERTICAL_ALIGNMENT.CENTER  # 垂直居中


def restyle_word_paper(doc_path='../paper/paper.docx'):
    """pandoc 转换后的版式微调：仅调整既有内容的样式（页边距/页眉页脚/字体/三线表），
    禁止 add_paragraph/add_table 新增或重建任何内容，否则会在 pandoc 文档后追加重复全文"""
    doc = Document(doc_path)  # 读取 pandoc 转换结果

    # ---- 页面设置：A4，四边2.5cm；页眉留空；页脚居中页码 ----
    for section in doc.sections:
        section.page_width = Cm(21.0)
        section.page_height = Cm(29.7)
        section.top_margin = Cm(2.5)
        section.bottom_margin = Cm(2.5)
        section.left_margin = Cm(2.5)
        section.right_margin = Cm(2.5)
        # 页眉必须留空（匿名规范）
        for p in section.header.paragraphs:
            p.text = ''
        # 页脚：居中页码（插入 PAGE 域，Word 打开时自动更新）
        footer = section.footer
        footer.is_linked_to_previous = False
        fp = footer.paragraphs[0] if footer.paragraphs else footer.add_paragraph()
        fp.text = ''
        fp.alignment = WD_ALIGN_PARAGRAPH.CENTER
        run = fp.add_run()
        fld_begin = OxmlElement('w:fldChar')
        fld_begin.set(qn('w:fldCharType'), 'begin')
        instr = OxmlElement('w:instrText')
        instr.set(qn('xml:space'), 'preserve')
        instr.text = 'PAGE'
        fld_end = OxmlElement('w:fldChar')
        fld_end.set(qn('w:fldCharType'), 'end')
        for el in (fld_begin, instr, fld_end):
            run._element.append(el)

    # ---- 遍历既有段落，按样式/内容特征微调（不新增任何段落） ----
    for para in doc.paragraphs:
        text = para.text.strip()
        if not text:
            continue
        style_name = para.style.name if para.style is not None else ''
        if style_name.startswith('Title'):            # 论文题目：三号黑体居中
            para.alignment = WD_ALIGN_PARAGRAPH.CENTER
            for r in para.runs:
                set_cjk_font(r, '黑体', Pt(16), bold=True)
        elif style_name.startswith('Heading 1'):      # 一级标题：四号黑体居中
            para.alignment = WD_ALIGN_PARAGRAPH.CENTER
            for r in para.runs:
                set_cjk_font(r, '黑体', Pt(14), bold=True)
        elif text.startswith('摘要'):                  # 摘要标签段：四号黑体
            for r in para.runs:
                set_cjk_font(r, '黑体', Pt(14), bold=True)
        else:                                          # 正文：小四宋体，1倍行距，首行缩进2字符
            para.paragraph_format.line_spacing = 1
            para.paragraph_format.first_line_indent = Cm(0.85)
            for r in para.runs:
                set_cjk_font(r, '宋体', Pt(12))
    
    # ---- 既有表格统一三线表样式 + 单元格文字居中（不新建表格） ----
    for table in doc.tables:
        set_three_line_table(table)
        for row in table.rows:
            for cell in row.cells:
                cell.vertical_alignment = WD_CELL_VERTICAL_ALIGNMENT.CENTER
                for p in cell.paragraphs:
                    p.alignment = WD_ALIGN_PARAGRAPH.CENTER

    # 保存（覆盖写回 pandoc 结果）
    doc.save(doc_path)
    print(f'Word 版式微调完成：{doc_path}')

# 执行微调（在 code/ 目录下运行，读写 ../paper/paper.docx）
restyle_word_paper()
```

**Word文档格式要点**：

- 中文字体设置：`run._element.rPr.rFonts.set(qn('w:eastAsia'), '字体名')`
- 西文字体：Times New Roman（默认或显式设置）
- 行距：1倍（`paragraph_format.line_spacing = 1`）
- 首行缩进：2字符（约0.85cm）
- **分页沿用 pandoc 结果**：后处理禁止 `add_paragraph`/`add_table`/`add_page_break` 新增任何内容，仅调整既有样式
- **页眉必须留空**：禁止任何页眉文字、线条或图片
- **页码页脚居中**：从第一页（摘要页）开始编号（摘要页为第1页），全文连续
- **匿名要求**：摘要页、正文、附录任何位置禁止出现参赛者姓名、学校、赛区、队号、指导教师等信息
- **公式必须为 Word 原生数学格式（OMML）**：居中、可在 Word 公式编辑器中编辑；**禁止用普通文本或图片模拟公式**
- **检测量公式（R²/MAE/RMSE/MAPE）全文只出现一次完整定义**，后续仅引用指标名+数值
- **已知限制**：pandoc 对 ctex/xelatex 专用宏包解析有限，转换前需用 pandoc 支持的等价写法或轻量预处理（如临时替换 ctex 为 CJK 包），转换后必须核对并修正中文字体/字号与三线表，再执行第7章"PDF 与 Word 格式一致性检查"

***

### 3. 论文写作规范

#### 论文结构（必须遵循）

| 章节                | 内容要求                                | 分页要求                        |
| ----------------- | ----------------------------------- | --------------------------- |
| **标题**            | 20-30字，突出方法+对象+问题类型                 | 与摘要、关键词**同页**               |
| **摘要**            | 800-1000字，必须含具体数值和误差分析              | 与标题、关键词**同页**               |
| **关键词**           | 3-5个，分号分隔                           | 与标题、摘要**同页**，关键词后`\newpage` |
| **一、问题背景与重述**    | 背景（联网调研所得，引用文献）+ 逐问重述              | 正文第1页                       |
| **二、问题分析**        | 整体思路（**必须插入问题分析图**：流程图/技术路线/系统架构图，规范见第4章"流程图专项规范"）+ 逐问分析 + 数据与问题对应关系分析 | 正文续                         |
| **三、模型假设**        | 三线表：编号 \| 假设内容 \| 合理性说明（4-6条），表题在**上方** | 正文续                         |
| **四、符号说明**        | 表格：符号 \| 含义 \| 单位                   | 正文续                         |
| **五、数据处理**（共用一套数据时设） | 数据完整性/有效性检验、缺失与异常处理、可视化             | 正文续                         |
| **五/六、模型建立与求解**   | 无数据处理时为第五章、有数据处理时为第六章；二级标题固定为"问题X模型的建立与求解" | 正文续                         |
| **六/七、模型的评价、改进与推广** | 优点 → 缺点 → 改进方向 → 推广（章节号随上文顺延类推）      | 正文续                         |
| **参考文献**          | GB/T 7714格式，5-8篇，至少2篇近5年、1篇英文       | **`\newpage`** **另起一页**     |
| **附录**            | 附录A 支撑材料清单 + 附录B 核心代码               | **`\newpage`** **另起一页**     |

**章节编号规则（强制执行）**：

- 前四个一级标题**固定**为：一、问题背景与重述 → 二、问题分析 → 三、模型假设 → 四、符号说明。
- 若所有问题共用一套数据，则设"五、数据处理"集中处理，"模型建立与求解"顺延为第六章，后续章节（模型的评价、改进与推广等）依次类推；若一题一个数据，则数据处理融入对应问题的分析与求解，不单独设章。
- "模型建立与求解"章节的二级标题**固定**为"问题一模型的建立与求解""问题二模型的建立与求解"……以此类推。
- 每问的建立与求解一般包含模型建立、模型求解、模型评估等必要部分，以题目为准，特殊情况无需严格遵照。

#### 标题命名风格

**推荐组合**：方法名 + 研究对象 + 问题类型

**示例**：

- 基于遗传算法的无人机烟幕弹投放策略优化研究
- 基于物理信息神经网络与数据驱动的流场重建研究
- 面向现代防护体系的多无人机协同干扰策略建模与求解

#### 摘要格式规范（必须遵守）

**摘要页设置（分页规则：题目+摘要+关键词必须同页）**：

- **题目、摘要、关键词必须放在同一页**（`\maketitle`后直接接摘要，关键词后接`\newpage`开始正文）
- 摘要页边距与正文一致（四边2.5cm），使用统一`\geometry`
- **禁止**使用`\begin{abstract}...\end{abstract}`环境（article类中会产生额外上下间距，且缩进与正文不一致）
- 改用手动格式：`\noindent{\heiti\fontsize{14}{18}\selectfont 摘要：}\par\setlength{\parindent}{2em}\normalsize`
- 首行缩进2字符，字号小四（`\normalsize`），行距1倍，与正文完全一致
- **摘要字数控制在800-1000字**，确保题目+摘要+关键词全部在一页内
- 标题后间距`\vspace{0.3cm}`，关键词前间距`\vspace{0.2cm}`
- **关键词后必须`\newpage`**，正文从第2页开始编号

**内容要求**：

- 必须包含**具体数值结果**（精确到小数点后2-4位）
- 必须体现问题间的**递进关系**
- 方法名称与正文完全一致
- 关键词3-5个，分号分隔

#### 摘要写作模板

```
[首句] 本文针对[赛题名称]问题，综合运用[方法A]、[方法B]和[方法C]，
建立了[模型名称]模型，对[核心研究对象]进行了深入研究。主要工作如下：

针对问题一，本文基于[假设条件]，构建了[模型类型]模型。以[决策变量]
为决策变量，目标函数为[目标描述]；约束条件包括[约束1]、[约束2]等限制。
本文利用[求解算法]进行求解。结果表明：[关键结果，必须包含具体数值]。

针对问题二，在问题一的基础上，本文进一步综合考虑[新因素]，建立了
[改进模型名称]模型。通过[分析手段]，发现[核心规律/结论]。
计算得出[关键指标]为[具体数值]，相较于问题一提升了[X%]。

针对问题三，考虑到[实际因素/动态变化]，我们构建了[动态/多目标/仿真]
模型。利用[算法名称]进行迭代寻优，得到了最优方案为[方案描述]，
此时总成本/效率为[具体数值]。

本文构建的[模型/方案]具备普适性，适用于[推广场景]，具有现实意义。
```

**关键要求**：

- 每个问题必须给出**具体数值结果**
- 必须包含**误差/不确定度分析**
- 必须体现问题间的**递进关系**

#### 模型建立规范（三步法）

1. **Step 1 - 决策变量定义**：明确定义所有决策变量及取值范围
2. **Step 2 - 目标函数构建**：最小化成本/最大化效率，公式独立呈现
3. **Step 3 - 约束条件确定**：逐条列出，注明物理意义

最后给出**完整数学模型**（目标函数 + 全部约束条件）。

完成模型建立后须进行**模型评估**（含模型检验、误差分析、稳健性讨论）。上述三步法与模型评估为一般框架，**以题目为准**，特殊情况无需严格遵照。

#### 公式使用规范（核心必插 / 推导从简 / 检测量去重）

**(1) 公式使用三原则**

1. **核心公式必须插入**：模型的目标函数、关键约束、核心状态方程、关键求解变换必须作为**独立编号公式**插入（`\begin{equation}`），并在正文以"式（N）"引用；核心公式缺失按重大缺项处理
2. **推导从简**：禁止逐步骤展开推导过程；中间步骤用文字过渡（"将式（N）代入式（M）并经整理可得式（K）"），只呈现起止公式，防止论文变成公式堆
3. **检测量公式仅首次定义**：R²、MAE、RMSE、MAPE 等评价指标公式在**首次出现处定义一次**（编号或行内给出），后续引用一律只写指标名 + 数值（如"R²=0.985"），**不再重复列出公式**

**(2) 公式密度与版面**

- 公式宜精不宜多：核心公式全覆盖，非核心内容一律行内式（$...$）或文字化
- 独立公式必须居中 + 右侧编号；行内公式不编号、不独立成行
- 每问公式组织顺序：问题 → 决策变量 → 目标函数 → 关键约束 → 关键求解式，按出现顺序编号引用

**(3) 编号与引用**

- 公式编号连续，按出现顺序自动编号（equation/align）
- 正文首次引用必须写"式（N）"，后续可简写"式（N）"或"该式"
- 无编号的 `$$...$$`/`\[...\]` 仅用于装饰性说明，**禁止用于核心公式**

#### 模型求解规范

每问的求解以**融会贯通的中文叙述**呈现，论文正文中**禁止机械使用（1）（2）（3）分条语言**，须按中文书写习惯自然行文；各环节的引导语与句式示例、问题回答明确性与问题间承上启下要求见下方『正文语言表述规范』。求解过程一般按以下环节组织，各环节以连贯段落和引导语衔接：

- **数据预处理**：进行数据完整性检验（缺失值检测）与有效性检验（异常值检测），辅以分布图、区间检验图等可视化手段，并在文字中说明处理结果。
- **算法选择与设计**：说明选择该算法的理由（对比至少1种替代方案），如采用约束分析、剪枝等搜索空间压缩策略须一并描述，给出算法流程图并列出关键参数表。
- **求解结果**：用表格呈现核心结果，与前一问对比并说明提升百分比，配以文字解读关键数值。
- **结果验证**（按问题类型选用，禁止套用固定流程）：优化类问题用替代算法（或精确法）互验、绘制迭代收敛曲线图并作参数敏感性分析；预测类问题用留出法/时序交叉验证并报告 MAE/RMSE/R² 等误差指标；评价类问题作权重扰动鲁棒性检验并与替代评价方法对比；微分方程类问题与解析解/极限情形对比，并作守恒量校验与步长收敛性验证。
- **结果可视化与分析**：插入结果分析图，对图中数据特征与变化趋势进行物理解释。
- **模型检验与误差分析**：按需进行统计检验（残差正态性、异方差性），给出检测量指标（MAE、RMSE、MAPE、R² 至少2项），与基准方法或文献结果对比并说明改进百分比，简要讨论模型对参数扰动的稳健性。

**图表描述要求（强制执行）**：论文中对每张图、每个表必须用至少一段话进行清晰仔细的描述，说明图中数据特征、变化趋势及由图表得出的结论，禁止图表孤立出现；图表解读句式模板见下方『正文语言表述规范』(7)。

#### 优秀论文核心特征

**1. 数据预处理必须包含**（所有题型适用）：

- 数据完整性检验（缺失值）
- 数据有效性检验（异常值/离群值）
- 可视化分布图

**2. 结果验证必须与问题类型匹配**（禁止套用固定流程，参见模型求解规范"结果验证"环节）：

- 优化类：迭代收敛曲线 + 替代算法互验 + 敏感性分析
- 预测类：留出验证 + 误差指标（MAE/RMSE/R²）
- 评价类：权重/数据扰动鲁棒性 + 评价方法对比
- 微分方程类：解析解/极限情形对比 + 守恒量校验 + 步长收敛性

**3. 方法论闭环**：所选算法与模型结构适配、求解结果直接回应问题所问、验证手段与问题类型匹配，三者相互印证，禁止堆砌与问题无关的方法。

#### 模型评价规范

**优点（3条，突出创新）**：

1. "采用了XX方法，有效解决了XX难题"
2. "模型经过多维度验证，结果可靠"
3. "算法复杂度低/计算效率高/扩展性好"

**缺点（2条，客观但非致命）**：

1. 客观陈述局限性
2. 数据/计算方面的不足

- **禁止写致命缺陷**

**推广（1段）**：
"本模型可推广应用于[类似场景1]、[类似场景2]等领域，只需调整[某参数/某约束]即可适配。"

#### 正文语言表述规范（正文全环节句式引导）

> 正文语言需参考 IEEE 等顶刊与优质数模（国赛获奖）论文的表达习惯：**对问题的表述与回答清晰明确、语言自然合理**。本规范提供全环节句式引导，并强制回答明确性、问题间承上启下与去 AI 化。

**(1) 总体原则（7条）**

1. **问题—回应结构**：每问/每节先清晰陈述"要解决什么问题"，再给出"如何回答"，正文自始至终围绕问题展开，禁止开篇即堆砌方法
2. **回答必须明确**：每问结尾必须有结论段，直接回答该问（最优方案 + 关键数值 + 是否满足要求），禁止含糊收尾
3. **以段落行文替代分条**：禁止（1）（2）（3）机械分条，用连贯段落 + 引导语（"首先…随后…最后…"）自然行文
4. **问题间必须衔接**：每个问题之间必须有一句承上启下（含上问结论或下问任务），禁止各问孤立成章
5. **用具体数值支撑，杜绝空泛**：禁止"很明显""大量""效果很好"等无依据表述，一律以表格/图中的具体数值与指标（MAE、RMSE、R²、提升百分比）佐证
6. **客观学术语态**：以"本文""该模型""求解结果显示"为主语，慎用第一人称主观表述（"我觉得""我们想"）
7. **去 AI 化**：消除模板腔、套话、过渡词滥用与过度工整结构，保留真实学术写作的详略与个性

**(2) 问题引入与重述句式**（第二章与各问开头）

- 陈述任务："本题要求在给定的…条件下，为…确定最优的…方案，并对…进行评价"
- 分解问题："该问题可拆解为…三个子问题：其一…；其二…；其三…"

**(3) 模型建立环节句式**

- 引入："为刻画…的动态特征/资源约束，本文引入/构建…模型"
- 变量定义："记 x_ij 为…，其可行取值范围为…"
- 目标函数："以最小化总成本/最大化总效益为目标，目标函数可写为…"
- 约束："约束条件包括资源上限、供需平衡与连续性约束三类，分别刻画…"
- 模型解释："该模型的核心在于将…问题转化为…，其物理意义是…"

**(4) 求解环节句式**

- 算法选型理由："考虑到问题规模达…、精确算法难以在时限内收敛，本文选用…启发式算法，并采用约束分析/剪枝等策略压缩搜索空间（如适用）"
- 步骤引导："求解分三步进行：首先…；随后…；最后…"
- 收敛说明："由图X可见，算法在第…代后趋于稳定，表明…"

**(5) 结果分析与解读句式**

- 呈现结果："由表X可知，方案…的…指标达到…，较基准方案提升/下降…%"
- 趋势解读："如图X所示，…随…呈现先增后减的趋势，原因在于…与…的权衡"
- 对比分析："与基准方法相比，…在…上平均改善…，这主要得益于…"

**(6) 误差分析与检验句式**

- 指标给出："模型的 MAE=…、RMSE=…、R²=…，拟合精度良好"
- 检验结论："残差近似服从零均值正态分布，且无明显异方差，验证了模型假设的合理性"
- 稳健性："在参数扰动 ±10% 的范围内，结果变化不超过…，说明模型对参数不敏感"

**(7) 图表描述句式**

- 结构模板："图X展示了…。总体呈…趋势：当…时，…；当…时，…。结合表X可知…，由此可得…结论"

**(8) 评价、改进与推广句式**

- 优点："该模型以…统一刻画…，兼具…与…优势，并经过…多维验证"
- 局限（客观非致命）："受限于数据规模/单次实验，模型在…情形下精度有所下降"
- 改进："后续可引入…或…，以进一步提升…"
- 推广："该框架不依赖具体业务参数，调整…后可直接迁移至…等场景"

**(9) 问题回答明确性句式（强制）**

- 结论段开头："综合以上求解与检验，本问确定的最优方案为…，对应…值为…"
- 达标判断："该方案满足题目全部约束，…指标…优于题目阈值…，可作为最终决策依据"
- 需求回应："针对题目要求输出的…，本文给出的结果为…"
- 明确比对："与方案…相比，本方案…提升…%，且计算代价…，综合优势明显"
- 限制性结论（真实不确定时）："在…范围内…成立；超出该范围其适用性尚待验证"
- **含糊词禁用清单**：禁止无依据使用"一定程度上""或许""大概""可能有所改善""有望"；确属不确定性时必须给出区间或条件

**(10) 问题间承上启下句式（强制）**

- 每个问题之间必须有一句承上启下，置于**下问开头**（优先）或**上问结尾**；衔接句须携带信息量（含上问结论或下问任务实质），**禁止纯形式衔接**（如"接下来解决问题二"）
- 递进衔接（最常用）："问题二在问题一…的基础上，进一步引入…，以考察…"
- 关联衔接："问题一确定了…的最优配置，问题二将其推广至…动态场景"
- 方法衔接："问题一验证了…方法的有效性，问题二沿用该求解框架并扩展…"
- 数据/对象衔接："问题一与问题二基于同一数据基础，问题二将分析视角转向…"

**(11) 去 AI 化要求**

**AI 写作痕迹识别清单**：

- ❌ 模板腔开头："随着…的快速发展""在当今社会""众所周知"（背景章空泛开头）
- ❌ 过渡词滥用："首先…其次…最后…""综上所述""值得注意的是""总而言之"高频堆砌
- ❌ 结构过度工整：每段机械"总-分-总"、排比句过度、各问篇幅与深度雷同
- ❌ 泛化升华："对未来发展具有重要指导意义""为…提供了有力支撑"等无信息量套话
- ❌ 语气单一无详略：所有问题同等对待，缺乏真人写作的侧重与个性

**去 AI 改写规则**：

1. 章节开头直入主题：以事实/数据/文献切入，禁"随着…发展"
2. 过渡句携带信息量（呼应 (10)：衔接句含上问结论或下问任务）
3. 详略得当：重点问题详细展开（建模+求解+验证），次要环节从简（一段带过）
4. 结论个性化：结合本题具体数值与情境，禁通用升华套话
5. 自查流程：全文检索禁用词表（"随着…的发展""综上所述""值得注意的是""首先其次最后""具有重要意义""众所周知"），命中即改写

**(12) 常用过渡与衔接语库**（按功能分类）

- 承接：在此基础上、进一步、同时、进而
- 转折：然而、但需指出、需要权衡的是、与之相对
- 因果：由于…、因此、由此可知、这归因于
- 递进：更一般地、另一方面、此外
- 总结：综合以上分析、总体而言、概括来说（全文限量使用，替代高频"综上所述"）
- 数据引导：如表X所示、由图X可见、从表X可以看出

**(13) 负面清单**（与正面句式对应）

- ❌ 机械分条（（1）（2）（3））行文
- ❌ 无依据空泛词：很明显、显而易见、大量、效果很好（须改为具体数值）
- ❌ 含糊收尾：一定程度上、有望、大概（每问必须给出明确结论段）
- ❌ 纯形式衔接：问题间无承上启下、或衔接句不含实质信息
- ❌ AI 痕迹：模板腔开头、套话升华、过渡词滥用、结构过度工整
- ❌ 口语化主观：我们想、我觉得、其实、搞定了
- ❌ 结论无因果：只给结果不给"由…可知"
- ❌ 图表孤立：图/表前后无文字过渡

***

### 4. 可视化规范

#### 强制要求

- **每道小题至少1张彩色图**（建议2-3张）
- **第二章问题分析必须插入问题分析图**：至少1张流程图/技术路线/系统架构图，展示整体解决思路（绘制规范详见第 4 章"流程图专项规范"）
- **全文图片数量**：建议全文6张以上，保底不低于4张；同一小问有必要时可多插入几张（如多组对比、多阶段结果）
- **插入位置合适**：图片须紧邻其对应分析文字就近插入（图题在图下方），随分析段落"边叙述边配图"或"先分析后配图"，**禁止**把所有图片集中堆放在章节末尾或文末；每张图前后必须有文字引导与解读，禁止图表孤立出现
- **图型跟随数据结构，匹配时优先高端效果**：图表类型由数据结构与表达目标决定；数据适用时优先采用三维曲面图、热力图、等高线图、网络/关系图、平行坐标图等高级优质图表提升表现力（详见下方推荐图表类型表）；基础图型（折线/柱状/饼）仍是表达主力，禁止为视觉效果强行升级图型（如收敛曲线强改三维曲面）
- **组合图规范**：双轴图（同一主题的多量纲指标同图，如左右轴分别表示数值与占比/速率）**可以使用**；**禁止将多张不相干图硬凑成组合图**——多子图组合仅限同主题的关联子图（如拟合图+残差图、多方法对比），每个子图须在正文中分别解读
- **图内文字防重叠**：图例不遮挡数据（frameon=False 或指定位置）；坐标轴标签过长时旋转/换行；数据点标注自动避让（offset/bbox/adjustText）；密集数据仅标注关键点，禁止文字互相重叠遮挡
- **拟合结果必须可视化**：拟合曲线 vs 原始数据
- **误差分析必须可视化**：残差图、误差分布图
- **所有图表必须具备出版级质量**：分辨率≥300 DPI，矢量格式优先；密度类图（大规模散点/hexbin/3D曲面）可降至 200 DPI，线条/柱状类优先矢量 PDF（分级策略见 plot_style.py 说明）
- **预览与正式版同品质**：调试/预览图（含 `figures/tmp/`、示范图）与交付图同一品质——一律 `savefig.dpi=300` 保存（密度类图可按分级策略降至 200），禁止生成低分辨率预览图

#### 推荐图表类型

| 图表类型            | 适用场景           | 视觉效果  | 推荐库                 |
| --------------- | -------------- | ----- | ------------------- |
| 三维曲面图           | 多参数优化、地形可视化    | ★★★★★ | matplotlib / plotly |
| 热力图             | 相关性矩阵、参数分析     | ★★★★★ | seaborn / plotly    |
| 等高线图            | 优化可行域、Pareto前沿 | ★★★★  | matplotlib          |
| Pareto前沿图        | 多目标优化Pareto解集呈现         | ★★★★  | matplotlib（见模板5代码） |
| 动态演化图           | 时序仿真、迭代收敛      | ★★★★  | matplotlib / plotly |
| 相图/矢量场图         | 动力系统稳定性分析、传染病模型相轨迹（A题必备） | ★★★★ | matplotlib（streamplot/quiver） |
| 小提琴图+箱线图叠加      | 数据分布、多组对比      | ★★★★★ | seaborn             |
| 拟合对比图（含置信带）     | 模型拟合效果         | ★★★★  | matplotlib          |
| 误差带图            | 置信区间、不确定性      | ★★★★  | matplotlib          |
| 雷达图             | 多指标综合评价对比      | ★★★★  | matplotlib          |
| 桑基图             | 流量分配、资源流转      | ★★★★  | plotly              |
| 联合分布图           | 多变量相关性分析       | ★★★★★ | seaborn / plotly    |
| 脊线图（Ridge Plot） | 多组分布对比（优雅）     | ★★★★★ | matplotlib          |
| 双轴/组合图          | 多量纲指标同图展示（同一主题双轴可用，禁不相干图组合） | ★★★★  | matplotlib          |
| 折线图              | 性能对比、耗时/准确率变化曲线 | ★★★★ | matplotlib          |
| 分组柱状图            | 多方案指标对比           | ★★★★ | matplotlib          |
| 箱线图              | 误差/耗时分布、稳定性实验   | ★★★★ | matplotlib / seaborn |
| 饼图（≤5类）          | 模块占比、资源分配（慎用）   | ★★★  | matplotlib          |
| 条形图              | 长类别名对比（替代柱状图）   | ★★★  | matplotlib          |
| 流程图/系统架构图       | 第二章问题分析图、开发流程、技术路线 | ★★★★ | matplotlib（详见"流程图专项规范"） |
| 网络/关系图          | 系统拓扑、社交网络、实体关联     | ★★★★ | networkx / matplotlib |
| 气泡图              | 三维信息（x, y, 气泡大小）对比   | ★★★★ | matplotlib          |
| 平行坐标图           | 高维数据多指标对比            | ★★★★ | matplotlib / plotly |
| 旭日图              | 多层占比层级结构             | ★★★★ | plotly / matplotlib |
| 3D散点/3D柱状图      | 三维特征空间分布              | ★★★★ | matplotlib          |
| 地图热力图           | 空间地理分布                | ★★★★ | folium / geopandas  |
| 瀑布图              | 累计增减分解                | ★★★  | matplotlib          |
| 蜂群图/点带图        | 分布 + 个体细节              | ★★★★ | seaborn             |
| 矩阵散点图           | 多变量两两关系               | ★★★★ | seaborn             |
| 堆叠面积图           | 多序列占比随时间变化           | ★★★★ | matplotlib / plotly |
| 甘特图              | 任务排程、关键路径结果展示          | ★★★★ | matplotlib（broken_barh/barh） |
| 龙卷风图            | 参数敏感性分析（单因素扰动影响排序）   | ★★★★ | matplotlib          |

> 基础图型（折线/柱状/箱线/饼/条形）的逐项绘制规范与代码模板见下文「基础图型绘制规范与代码模板」。

#### 高级图表配色要点

- **散点/气泡图**：普通点主色A α0.6（重叠加深体现密度）；离群点/关键解用赭橙 `#DD8452` + 炭墨黑细描边并放大；气泡大小→颜色越深（不透明度随尺寸升高）；叠加拟合线用绛红虚线（冷暖对比）
- **雷达图**：填充主色A α0.2（极淡不遮网格）；轮廓主色A 2pt 实线；对比模型绛红虚线、填充 α0.1；网格线极淡灰 `#E0E0E0`
- **桑基图**：节点用主色A/绛红/苔绿实心；连线（流量）半透明 0.4-0.6 且**颜色继承起始节点**，便于追踪流量归属
- **地图热力图**：底图极简（仅海岸线/省界浅灰）；数据层单色顺序色系（主色A 浅蓝→深蓝）；**禁红绿配色**（色盲不友好）
- **平行坐标图**：样本**降采样（≤60 条/类）防线条过密**；透明度 0.3-0.5；按类别着主色A/绛红/苔绿；图例置于图外防重叠

#### 现代学术配色方案（必须使用）

**统一配色逻辑（顶会风格学术低饱和色板）**：

- **原则**：采用 seaborn deep 学术色板——顶会论文与数模国赛获奖论文常见的低饱和方案；蓝-橙冷暖为主轴、紫/青为辅，中低饱和、黑白打印有层次。
- **角色分工**：定性系列色 `LINE_PALETTE`（学术蓝/绛红/苔绿/岩石灰）；强调色 `COLOR_ACCENT` 绛红（中位线/误差/负向）；中性色 `COLOR_ROCK`（离群点/次要线）；墨色 `COLOR_INK`（文字/轴线/浅底图内文字）；顺序色图 `SURFACE_CMAP` 学术蓝单色渐变；发散色图 `DIVERGENT_CMAP` 蓝→灰白→绛红（亮中心，打印友好）。
- **冗余编码**：折线图须线型+标记冗余；柱状图柱顶数值标注；保障色盲与黑白打印场景可辨。

**核心原则**：配色需兼顾**区分度、色盲友好、印刷一致性、黑白打印有层次**；采用学术低饱和色调，避免高饱和原色。色板常量（`COLOR_*`/`LINE_PALETTE`/`SURFACE_CMAP`/`DIVERGENT_CMAP`）的唯一定义见下方 `code/plot_style.py`，禁止在脚本中另行定义。

> **统一封装**：以上色板/纹理/标准尺寸已统一封装于 `code/plot_style.py`（见下），正式出图一律 `from plot_style import ...` 引用，避免多处定义漂移。

> **双色板分工（统一口径，防止硬编码漂移）**：多系列/多方法对比一律用 `LINE_PALETTE`（学术蓝/绛红/苔绿/岩石灰）；单一主题内部的子分组区分（分组柱状图组内、饼图扇区）用其降饱和衍生色板（`['#7F99C5', '#D38083', '#B7CAE4', '#E5BFC0']`，见「基础图型绘制规范」），两套不在同一图内混用；模板代码禁止在这两套之外硬编码颜色（历史漂移教训：模板代码曾误重复绛红）。

**禁用配色**：

- ❌ 纯黑 `#000000`（一律用炭墨黑 `#2F353B`，更柔和高级）
- ❌ 纯红 `#FF0000` + 纯绿 `#00FF00` 组合（色盲不友好）
- ❌ `rainbow` / `jet` 色图（感知不均匀，学术禁用）
- ❌ 超过6种高饱和色同时出现

**纹理编码（可选，非默认）**：

- 基础图表（分组柱状/饼/条形）**不默认添加斜线/圆点纹理**，靠学术低饱和配色 + 灰阶明暗区分
- 多组年份对比等场景确需区分时，可用透明度或纹理（横线 `---`、竖线 `|||`）
- 若使用纹理：柱体/扇区 `edgecolor` 统一岩石灰 `#8E9AAF`、`linewidth=0.8`（纹理序列常量 `HATCH_SEQUENCE` 见 plot_style.py）

#### 全局视觉统一（全文图表强制）

- **主色一致**：全文所有图表主色统一——图1 用蓝色代表"模型A"，图5 中"模型A"必须仍是蓝色（跨图图例一致性）
- **字体**：图表内西文/数字用 Arial 或 Times New Roman、中文 SimHei，字号 8-10pt（比正文略小但清晰）
- **去噪**：删除无意义背景色/过粗边框/阴影；去上右 spine；留白是高级感的来源

#### 统一绘图工具模块（强制统一使用，code/plot_style.py）

> 绘图样式初始化全部收敛于此模块，所有绘图脚本 `import` 即可复用，避免每脚本重复粘贴样式代码；集中管理色板、colormap、纹理、两档标准尺寸与统一保存入口（自动 300DPI、防裁切、保存后关闭 figure 防内存累积）。

```python
# code/plot_style.py —— 统一样式模块（保存至 code/，绘图脚本 from plot_style import * 复用）
import os
import warnings
import matplotlib
matplotlib.use('Agg')   # 非交互后端：无 GUI 开销，批量出图稳定（交互调试时删除本行）
import matplotlib.pyplot as plt
import seaborn as sns
from matplotlib import font_manager

# ===== Master Palette（学术低饱和，与第 4 章配色方案一致；禁纯黑 #000000） =====
COLOR_MAIN    = '#4C72B0'   # 主色A 学术蓝：核心数据/模型结果
COLOR_ACCENT  = '#C44E52'   # 辅色B 绛红：对比/误差/负面
COLOR_SAGE    = '#55A868'   # 辅色C 苔绿：辅助/正向
COLOR_MUSTARD = '#DD8452'   # 辅色D 赭橙：强调/极值
COLOR_ROCK    = '#8E9AAF'   # 中性色E 岩石灰：基准/背景
COLOR_INK     = '#2F353B'   # 深色F 炭墨黑：文字/轴线/边框
LINE_PALETTE = [COLOR_MAIN, COLOR_ACCENT, COLOR_SAGE, COLOR_ROCK]
FILL_ALPHA = 0.2
HATCH_SEQUENCE = ['', '---', '|||']   # 可选纹理：无/横线/竖线（基础图表不默认斜线圆点）
from matplotlib.colors import LinearSegmentedColormap
SURFACE_CMAP   = LinearSegmentedColormap.from_list('academic_seq',
    ['#2F4B7C', '#4C72B0', '#8E9AAF', '#E9EFF7'])   # 波谷深蓝→波峰极浅蓝灰（3D曲面单色渐变，"石膏雕塑感"）
DIVERGENT_CMAP = LinearSegmentedColormap.from_list('academic_div',
    ['#4C72B0', '#F5F5F5', '#C44E52'])              # 负蓝→中心灰白→正红（热力图发散学术低饱和）
FIG_FULL = (6.3, 4.0)   # 整版宽图（A4 版心 16cm ≈ 6.3in）
FIG_TALL = (6.3, 5.5)   # 双子图竖版（拟合+残差等）

# ===== 中文字体检测回退（缺字体环境避免静默输出方框） =====
def pick_cjk_font(candidates=('SimHei', 'Microsoft YaHei', 'Noto Sans CJK SC', 'WenQuanYi Micro Hei')):
    installed = {f.name for f in font_manager.fontManager.ttflist}
    for name in candidates:
        if name in installed:
            return name
    warnings.warn('未找到任何中文字体，图中中文将显示为方框！请安装 SimHei 或 Noto Sans CJK。')
    return 'sans-serif'

def apply_style():
    # font 必须用字体族别名 'sans-serif'：硬编码具体字体名（如 'SimHei'）会使 font.family
    # 固定为该字体，字体缺失时直接回退 DejaVu Sans，跳过 font.sans-serif 回退列表，
    # 导致 pick_cjk_font 的检测回退机制失效（缺字体环境中文显示方框）
    sns.set_theme(style='ticks', palette=LINE_PALETTE, font='sans-serif', font_scale=1.1,
                  rc={'axes.axisbelow': True, 'axes.edgecolor': COLOR_INK,
                      'axes.labelcolor': COLOR_INK, 'axes.spines.top': False,
                      'axes.spines.right': False, 'xtick.color': COLOR_INK,
                      'ytick.color': COLOR_INK, 'figure.frameon': False})
    plt.rcParams.update({          # 覆盖顺序：set_theme 在前，微调在后
        'font.sans-serif': [pick_cjk_font()],
        'axes.unicode_minus': False,
        'figure.dpi': 100,         # 仅影响屏幕交互渲染速度；存图一律 savefig.dpi，与正式版同品质
        'savefig.dpi': 300,        # 输出出版级分辨率（预览与正式同品质）
        'font.size': 11,
        'axes.linewidth': 1.2,
    })

def save_fig(fig, path, vector=False, close=True, dpi=300):
    """统一保存入口：默认位图 300DPI + 防裁切（PNG 无损压缩，体积约降 10–30%）；
    可选同步导出 PDF 矢量版；默认保存后关闭释放内存（close 后 figure 不可再编辑）"""
    # 目录自愈：figures/final 等输出目录不存在时自动创建，避免 FileNotFoundError
    parent = os.path.dirname(path)
    if parent:
        os.makedirs(parent, exist_ok=True)
    fig.savefig(path, dpi=dpi, bbox_inches='tight', pad_inches=0.1,
                pil_kwargs={'optimize': True} if path.rsplit('.', 1)[-1].lower()
                in ('png', 'jpg', 'jpeg', 'gif', 'webp', 'tif', 'tiff') else None)
    if vector:
        fig.savefig(path.rsplit('.', 1)[0] + '.pdf', bbox_inches='tight')
    if close:
        plt.close(fig)
# 分级 DPI 说明：线条/柱状类优先 vector=True（PDF 矢量，体积小）；位图密度类
# （hexbin/大规模散点/3D曲面）可传 dpi=200；仅精细细节图（热力图小格标注）保持 300

apply_style()   # import 即完成一次性初始化
```

各绘图脚本收敛为两行：

```python
from plot_style import save_fig, LINE_PALETTE, FIG_FULL, HATCH_SEQUENCE
fig, ax = plt.subplots(figsize=FIG_FULL)
# ... 绘图逻辑 ...
save_fig(fig, '../figures/final/fig2_perf_q1.png', vector=True)
```

#### 高频图表代码模板

> **函数化建议**：正式项目中可将每个模板封装为参数化函数（仅暴露数据/标签/路径参数），统一放入 `code/plot_templates.py` 复用，避免逐次复制改造；样式初始化统一复用 `code/plot_style.py`（见上），模板内勿重复设置 rcParams（参考上方统一绘图工具模块的组织方式）。

**模板1：三维曲面图（带渐变光照效果）**

```python
from plot_style import SURFACE_CMAP   # 单色渐变"石膏雕塑感"：高度仅以明度体现（禁 jet/rainbow）

fig = plt.figure(figsize=(8, 6))
ax = fig.add_subplot(111, projection='3d')

# 大数据自适应采样：网格≥80行时按步长降采样，显著提速（小网格自动取 1 = 全分辨率）
stride = max(1, np.asarray(X).shape[0] // 80)
surf = ax.plot_surface(X, Y, Z,
    cmap=SURFACE_CMAP,
    alpha=0.95,
    edgecolor='none',
    antialiased=True,
    rstride=stride, cstride=stride
)
ax.contourf(X, Y, Z, zdir='z', offset=Z.min(), cmap=SURFACE_CMAP, alpha=0.5)  # 底部投影

# pad≥0.15、labelpad≥12 防 colorbar/轴标签与曲面重叠
fig.colorbar(surf, ax=ax, shrink=0.6, pad=0.15, label='目标函数值')
ax.set_xlabel('参数α', labelpad=12)
ax.set_ylabel('参数β', labelpad=12)
ax.zaxis.set_rotate_label(False)   # 禁止 z 标签旋转，避免"目标值"与曲面交叠
ax.set_zlabel('目标值', labelpad=18)  # 加大 labelpad，z 标签远离曲面
ax.view_init(elev=25, azim=135)   # 最佳视角
ax.set_title('三维曲面图', pad=16)
plt.savefig('../figures/final/fig_3d_surface.png', dpi=300, bbox_inches='tight')
```

**模板2：热力图（带数值标注 + 遮罩上三角）**

```python
from plot_style import DIVERGENT_CMAP   # 发散学术低饱和：负蓝 → 中心灰白 → 正红（禁 jet/rainbow）

fig, ax = plt.subplots(figsize=(7, 6))
mask = np.triu(np.ones_like(corr_matrix, dtype=bool), k=1)  # 遮罩上三角（不含对角线），更简洁

sns.heatmap(corr_matrix, mask=mask,
    annot=True, fmt='.2f',
    cmap=DIVERGENT_CMAP,
    center=0,                 # 以0为中心
    vmin=-1, vmax=1,
    square=True,
    linewidths=0.5,
    linecolor='white',
    annot_kws={'fontsize': 8, 'family': 'Consolas'},   # 等宽字体，数字清晰
    cbar_kws={'shrink': 0.8, 'label': '相关系数'},
    ax=ax
)
ax.set_title('参数相关性矩阵', fontsize=14, fontweight='bold', pad=15)
plt.savefig('../figures/final/fig_heatmap.png', dpi=300, bbox_inches='tight')
```

**模板3：拟合对比图（含置信带 + 残差子图）**

```python
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(8, 7),
    gridspec_kw={'height_ratios': [3, 1], 'hspace': 0.05})

# 上图：拟合曲线 + 置信带
ax1.scatter(x_data, y_data, s=20, c='#4C72B0', alpha=0.6,
            edgecolors='white', linewidth=0.5, label='观测值', zorder=3)
ax1.plot(x_fit, y_fit, color='#C44E52', linewidth=2, label='拟合曲线', zorder=4)
ax1.fill_between(x_fit, y_lower, y_upper,
    color='#C44E52', alpha=0.2, label='95% 置信区间', zorder=2)
ax1.legend(frameon=False, loc='best')
ax1.set_ylabel('因变量 $y$')

# 下图：残差图
residuals = y_data - y_pred
ax2.scatter(x_data, residuals, s=15, c='#55A868', alpha=0.7,
            edgecolors='white', linewidth=0.3)
ax2.axhline(y=0, color='#C44E52', linewidth=1.2, linestyle='--', alpha=0.7)
ax2.fill_between(x_data, -2*np.std(residuals), 2*np.std(residuals),
    color='#C44E52', alpha=0.08)
ax2.set_xlabel('自变量 $x$')
ax2.set_ylabel('残差')

plt.savefig('../figures/final/fig_fitting.png', dpi=300, bbox_inches='tight')
```

**模板4：迭代收敛曲线（种群适应度 + 最优/均值适应度）**

```python
fig, ax1 = plt.subplots(figsize=(8, 5))

# 所有种群适应度（散点背景）：>1万点时子采样 + rasterized，兼顾渲染速度与矢量文件体积
sub = slice(None, None, 2)   # 每隔1代采样；点数极大时可改为 None, None, 5
ax1.scatter(generations[sub], all_fitness[sub], s=5, c='#4C72B0', alpha=0.15,
            label='种群个体', rasterized=True)
# 最优适应度（主线）
ax1.plot(generations, best_fitness, color='#C44E52', linewidth=2.5,
         label='最优适应度', zorder=5)
# 均值适应度
ax1.plot(generations, mean_fitness, color='#55A868', linewidth=1.5,
         linestyle='--', label='均值适应度', alpha=0.8)

ax1.set_xlabel('迭代代数', fontsize=12)
ax1.set_ylabel('适应度值', fontsize=12, color='#2F353B')
ax1.legend(frameon=False, loc='upper right')
ax1.grid(True, alpha=0.3, linestyle=':', linewidth=0.8)

plt.savefig('../figures/final/fig_convergence.png', dpi=300, bbox_inches='tight')
```

**模板5：Pareto前沿图（多目标优化）**

```python
fig, ax = plt.subplots(figsize=(7, 6))

# 所有解（灰色背景）
ax.scatter(obj1_all, obj2_all, s=15, c='#8E9AAF', alpha=0.3,
           edgecolors='none', label='所有解（候选解）', zorder=2)
# Pareto最优前沿
pareto_sorted = sorted(zip(obj1_pareto, obj2_pareto))
ax.plot([p[0] for p in pareto_sorted], [p[1] for p in pareto_sorted],
    color='#C44E52', linewidth=2, marker='o', markersize=6,
    markerfacecolor='white', markeredgewidth=1.5,
    label='Pareto前沿', zorder=4)

ax.set_xlabel('目标 $f_1$', fontsize=12)
ax.set_ylabel('目标 $f_2$', fontsize=12)
ax.legend(frameon=True, fancybox=True, framealpha=0.8, loc='best')
ax.grid(True, alpha=0.2, linestyle=':', linewidth=0.8)
plt.savefig('../figures/final/fig_pareto.png', dpi=300, bbox_inches='tight')
```

#### 基础图型绘制规范与代码模板（折线/柱状/箱线/饼/条形）

> 高频基础图型的逐项规范，与上方配色及 plot_style.py 统一样式模块配套；强调黑白打印/色盲场景的明暗区分（纹理仅多组年份等场景可选）。热力图低饱和变体见下方注意事项。

**折线图（性能对比、耗时、准确率变化曲线）**

- X/Y 轴**完整标注物理含义 + 单位**（如：检测文件数量、耗时 (ms)）
- 网格**仅保留横向浅灰细虚线**，纵向网格删除，减少视觉杂乱
- 性能对比类**坐标轴起点从 0 开始**（避免视觉误导）
- **主次层级**：主线（本文模型）主色A 2.5pt 实线；对比线（基准/其他模型）岩石灰或苔绿 1.5pt 虚线/点划线；标记点白心；置信带用线条色 0.2 透明度填充
- 同图曲线 ≤5 条，超过建议分图；禁用粗艳丽线条、大面积填充渐变

```python
fig, ax = plt.subplots(figsize=(6.3, 4.0))
x = np.array([100, 200, 500, 1000, 2000])   # 检测文件数量
# 主次层级：主线(主色A) 2.5pt 实线；对比线 1.5pt 虚线；标记白心
styles = [('#4C72B0', '-',  'o', 2.5), ('#C44E52', '--', 's', 1.5),
          ('#55A868', '-.', '^', 1.5), ('#8E9AAF', ':',  'D', 1.5)]
for (color, ls, mk, lw), (name, y) in zip(styles, series.items()):
    ax.plot(x, y, color=color, linestyle=ls, marker=mk,
            markersize=5, linewidth=lw, markerfacecolor='white', label=name)   # 标记 4–6pt
ax.set_xlabel('检测文件数量 (个)')
ax.set_ylabel('耗时 (ms)')
ax.set_xlim(0, x.max() * 1.05); ax.set_ylim(0, None)   # 从 0 起始（性能对比强制）
ax.grid(axis='y', linestyle='--', color='lightgray', linewidth=0.6, alpha=0.8)  # 仅横向网格
ax.legend(frameon=False, fontsize=9)
```

**分组柱状图（多方案指标对比）**

- **柱宽统一**，组内柱间距 < 组间间距
- **单色扁平填充**，无渐变、无立体浮雕；组内用与热力图同款发散族的低饱和版（柔蓝/柔红/淡蓝，即端色向灰白混合约30%）区分，避免大面积高饱和色块；**基础图表不默认添加斜线/圆点纹理**（多组年份等场景可用透明度或横线/竖线纹理区分）
- **Y 轴必须从 0 起始**；柱顶数值标注字号 7–8pt、深灰色（炭墨黑）
- 一组图表彩色 ≤4 种，其余用灰度柱；误差棒用炭墨黑 + capsize

```python
fig, ax = plt.subplots(figsize=(6.3, 4.0))
groups = ['方案A', '方案B', '方案C']; metrics = ['准确率', '召回率', 'F1']
data = np.array([[0.92, 0.88, 0.90], [0.85, 0.83, 0.84], [0.88, 0.90, 0.89]])
n_g, n_m = data.shape
bar_w = 0.7 / n_m                      # 柱宽统一；组内柱心距=柱宽 < 组间距 0.3
colors = ['#7F99C5', '#D38083', '#B7CAE4']      # 组内 与热力图同款发散族低饱和版：柔蓝/柔红/淡蓝
for i in range(n_m):
    centers = np.arange(n_g) + (i - (n_m - 1) / 2) * bar_w
    bars = ax.bar(centers, data[:, i], width=bar_w, color=colors[i],
                  edgecolor='white', linewidth=0.8, label=metrics[i])
    for b, v in zip(bars, data[:, i]):
        ax.text(b.get_x() + b.get_width() / 2, v + 0.005, f'{v:.2f}',
                ha='center', va='bottom', fontsize=7.5, color='#2F353B')  # 柱顶 7–8pt 深灰
ax.set_xticks(np.arange(n_g)); ax.set_xticklabels(groups)
ax.set_ylim(0, data.max() * 1.15)               # Y 轴必须从 0 起始
ax.set_ylabel('指标值')
ax.grid(axis='y', linestyle='--', color='lightgray', linewidth=0.6, alpha=0.8)
ax.legend(frameon=False, fontsize=9)
```

**箱线图（误差/耗时分布、稳定性实验）**

- 箱体**主色A 填充（α0.7）**，中位线**绛红加粗**
- 离群点统一**小型实心圆点、单一岩石灰**；须（Whiskers）**炭墨黑**
- 仅保留**横向细网格**，简化视觉干扰；每组箱体尺寸完全一致、均匀排布；可叠加半透明灰色抖动散点展示原始分布

```python
fig, ax = plt.subplots(figsize=(6.3, 4.0))
rng = np.random.default_rng(0)
data = [rng.normal(20, 3, 50), rng.normal(35, 5, 50), rng.normal(50, 8, 50)]
for i, d in enumerate(data, start=1):            # 叠加抖动散点（原始分布）
    ax.scatter(np.full_like(d, i) + rng.uniform(-0.08, 0.08, len(d)), d,
               s=10, color='#8E9AAF', alpha=0.35, edgecolors='none')
ax.boxplot(data, patch_artist=True, widths=0.45,                     # 箱体尺寸一致
    boxprops=dict(facecolor='#4C72B0', alpha=0.7, color='#2F353B'),  # 主色A 填充 α0.7
    medianprops=dict(color='#C44E52', linewidth=2),                  # 中位线绛红加粗
    whiskerprops=dict(color='#2F353B'), capprops=dict(color='#2F353B'),  # 须/端 炭墨黑
    flierprops=dict(marker='o', markersize=4, markerfacecolor='#8E9AAF',  # 离群点岩石灰
                    markeredgecolor='none', alpha=0.7))
ax.set_xticks(range(1, 4)); ax.set_xticklabels(['模型1', '模型2', '模型3'])
ax.set_ylabel('耗时 (ms)')
ax.grid(axis='y', linestyle='--', color='lightgray', linewidth=0.6, alpha=0.8)
```

**饼图（仅限占比统计，竞赛论文尽量少用）**

- 区块 **≤5 类**，分类过多改用柱状图
- **扁平化无立体凸起**，区块细灰分割线；靠学术低饱和配色 + 细灰分割线区分（不默认添加斜线/圆点纹理）
- 百分比文字放区块内部、小字清晰
- **学术建议**：性能、指标对比优先柱状/折线；饼图仅用于模块占比、资源分配

```python
fig, ax = plt.subplots(figsize=(4.8, 4.8))
labels = ['特征提取', '模型推理', '数据加载', '其他']          # ≤5 类
sizes  = [52, 30, 12, 6]
colors = ['#7F99C5', '#D38083', '#B7CAE4', '#E5BFC0']       # 与分组柱状图同款低饱和发散族：柔蓝/柔红/淡蓝/淡红
wedges, _, autotexts = ax.pie(sizes, autopct='%1.1f%%', colors=colors,
    startangle=90, counterclock=False,
    wedgeprops=dict(edgecolor='#8E9AAF', linewidth=0.8),     # 细灰分割线，无立体
    textprops={'fontsize': 9})
for t in autotexts:
    t.set_fontsize(8); t.set_color('#2F353B')              # 百分比内嵌小字（炭墨黑，= COLOR_INK，字面量保证可独立运行）
ax.legend(wedges, labels, loc='center left', bbox_to_anchor=(1.0, 0.5),
          frameon=False, fontsize=9)
ax.set_aspect('equal')
```

**条形图（类别名称较长时替代柱状图）**

- 类别文字**左对齐**（水平条形天然满足），条形统一高度
- 规则同柱状图：数值轴从 0 起始、条端标注 7–8pt 深灰、彩色 ≤4 种其余灰度；适合长文本标签

```python
fig, ax = plt.subplots(figsize=(6.3, 4.2))
cats = ['YOLOv8 检测模型', 'Faster R-CNN 检测模型', 'SSD 检测模型', 'CenterNet 检测模型']
vals = [0.923, 0.874, 0.831, 0.796]
bars = ax.barh(cats, vals, height=0.6, color='#4C72B0',
               edgecolor='white', linewidth=0.8)
for b, v in zip(bars, vals):
    ax.text(v + 0.005, b.get_y() + b.get_height() / 2, f'{v:.3f}',
            va='center', ha='left', fontsize=7.5, color='#2F353B')
ax.set_xlim(0, max(vals) * 1.12)             # 数值轴从 0 起始
ax.set_xlabel('mAP@0.5')
ax.grid(axis='x', linestyle='--', color='lightgray', linewidth=0.6, alpha=0.8)
```

**热力图低饱和补充**：相关性/准确率矩阵等需黑白打印的场景，可将模板2的发散学术低饱和 `DIVERGENT_CMAP` 换为单色低饱和顺序色系，如 `sns.light_palette('#4C72B0', as_cmap=True)`（蓝→浅灰），并保持格子细灰边框（`linewidths=0.6, linecolor='#8E9AAF'`）与色阶条（`cbar_kws` 标注数值区间）。

#### 流程图专项规范与代码模板（第二章问题分析图 / 开发流程 / 系统架构图）

> **第二章问题分析必须插入**问题分析图（流程图/技术路线/系统架构图），遵循以下专项规范。

**布局逻辑**

- **串行流程**：自上而下排列
- **多并行分支**：均分多列、严格对齐（各列模块宽度、高度、水平位置一致）
- **总分结构**：顶层居中、底层收拢（顶层一个总模块 → 中间多个并行模块 → 底层合并输出）
- **连接线**：从模块侧边中点进出，正交折线（先垂后平），**严禁箭头交叉、横穿模块**

**图形样式**

- 统一**圆角 3–5pt 扁平化方框**（`FancyBboxPatch` + `round,rounding_size`），无直角、无立体效果
- 区分模块类型（学术低饱和“工程美学”）：
  - **核心算法/处理单元**：填充浅蓝 `#D6E4F0`，边框主色A `#4C72B0`（加深边框突出）
  - **配置 / skill 文件等辅助模块**：填充极淡灰 `#F5F5F5`，边框岩石灰 `#8E9AAF` 虚线
  - **输出成果**：填充浅灰蓝 `#EBF2FA`，边框主色A `#4C72B0`
- 框内文字统一**炭墨黑 `#2F353B`** 居中，字号 ≥9pt；行数过多时拆分为多个模块

**箭头规范**

- **主流程**：炭墨黑实线箭头（`color='#2F353B'`, `linestyle='-'`），直角折线
- **次要数据流**（反馈、回传、参数传递）：岩石灰虚线箭头（`color='#8E9AAF'`, `linestyle='--'`）

**图标优化（提升高级感）**

- 模块内可内嵌**简约单色线性矢量图标**（芯片、文档、终端、界面、报表），与模块文字同色、置于文字上方
- 禁用卡通 3D 图标、彩色 emoji；保持单色线性风格

```python
# ===== 流程图/架构图模板（第二章问题分析图） =====
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch, FancyArrowPatch

# 模块类型样式（学术低饱和工程美学）：核心算法浅蓝 / 配置辅助极淡灰虚线 / 输出浅灰蓝
STYLE = {
    'algo':   dict(facecolor='#D6E4F0', edgecolor='#4C72B0', linestyle='-',  hatch=None,  textcolor='#2F353B'),
    'config': dict(facecolor='#F5F5F5', edgecolor='#8E9AAF', linestyle='--', hatch=None,  textcolor='#2F353B'),
    'output': dict(facecolor='#EBF2FA', edgecolor='#4C72B0', linestyle='-',  hatch=None,  textcolor='#2F353B'),
}

def draw_box(ax, x, y, w, h, text, kind='algo', icon=''):
    """统一圆角 3–5pt 扁平化方框：无直角、无立体效果；icon 为单色线性图标字符（可选，显示于模块上部）"""
    s = STYLE[kind]
    ax.add_patch(FancyBboxPatch(
        (x, y), w, h,
        boxstyle='round,pad=0.02,rounding_size=0.05',   # 圆角半径（≈3–5pt）
        facecolor=s['facecolor'], edgecolor=s['edgecolor'],
        linestyle=s['linestyle'], linewidth=1.2, hatch=s['hatch']))
    if icon:
        ax.text(x + w/2, y + h*0.76, icon, ha='center', va='center',
                fontsize=13, color=s['textcolor'])          # 单色线性图标置于模块上部
        ax.text(x + w/2, y + h*0.38, text, ha='center', va='center',
                fontsize=10, color=s['textcolor'])
    else:
        ax.text(x + w/2, y + h/2, text, ha='center', va='center',
                fontsize=10, color=s['textcolor'])

def draw_arrow(ax, x1, y1, x2, y2, primary=True):
    """连接线从模块侧边中点进出；主流程=实心深灰箭头，次要数据流=灰色虚线箭头"""
    ax.add_patch(FancyArrowPatch((x1, y1), (x2, y2),
        arrowstyle='-|>', mutation_scale=14, linewidth=1.2,
        color='#2F353B' if primary else '#8E9AAF',
        linestyle='-' if primary else '--'))

fig, ax = plt.subplots(figsize=(8, 6.5))
ax.set_xlim(0, 10); ax.set_ylim(0, 10); ax.axis('off')

# 总分结构：顶层居中 → 并行分支均分多列、严格对齐 → 底层收拢
draw_box(ax, 3.0, 8.2, 4.0, 1.0, '数据预处理', 'config')      # 浅灰虚线边框
draw_box(ax, 1.0, 5.2, 3.0, 1.0, '算法模块A', 'algo')         # 纯色填充（核心算法）
draw_box(ax, 6.0, 5.2, 3.0, 1.0, '算法模块B', 'algo')
draw_box(ax, 3.0, 2.2, 4.0, 1.0, '结果输出', 'output')        # 浅灰蓝填充（输出成果）

# 串行自上而下 + 正交折线：侧边中点进出，不横穿模块
ax.plot([5.0, 5.0], [8.2, 7.0], color='#2F353B', linewidth=1.2)   # 顶层底边中点垂直向下
ax.plot([2.5, 7.5], [7.0, 7.0], color='#2F353B', linewidth=1.2)   # 水平分流线
for cx in (2.5, 7.5):
    draw_arrow(ax, cx, 7.0, cx, 6.2)    # 主流程：进入各分支顶边中点
    draw_arrow(ax, cx, 5.2, cx, 4.2)    # 分支底边中点出，向收拢线汇聚
ax.plot([2.5, 7.5], [4.2, 4.2], color='#2F353B', linewidth=1.2)   # 水平收拢线
draw_arrow(ax, 5.0, 4.2, 5.0, 3.2)      # 主流程：进入底层顶边中点
# 次要数据流（参数反馈）：正交折线——从"结果输出"右边中点(7.0, 2.7)出发，先平后垂，
# 进入"算法模块B"底边中点(7.5, 5.2)，末段用灰色虚线箭头（严禁斜线直连或起点悬空）
ax.plot([7.0, 7.5], [2.7, 2.7], color='#8E9AAF', linewidth=1.2, linestyle='--')
draw_arrow(ax, 7.5, 2.7, 7.5, 5.2, primary=False)

ax.set_title('问题分析流程图', fontsize=12, pad=10)
plt.savefig('../figures/final/fig1_flow_q_overview.png', dpi=300, bbox_inches='tight')
```

> 复杂系统架构图（模块多、层级深）可选用 graphviz（`pip install graphviz`），但需保持同一套样式规范（圆角扁平方框、纹理区分、深灰主箭头、单色线性图标）。

#### 可视化要求清单

> 本清单不设单独维护的条目：出图自检直接对照本章"强制要求"、各"基础图型绘制规范"与"高级图表配色要点"（唯一权威出处），论文成稿阶段按第 7 章"论文质量自检清单"中图表相关项复核。

***

### 5. 排版规范（LaTeX）

#### 页面设置

| 项目    | 设置                                         |
| ----- | ------------------------------------------ |
| 纸张    | A4，纵向                                      |
| 页边距   | 四边2.5cm（上/下/左/右均为2.5cm）                   |
| 论文题目  | 黑体，三号（16pt），居中                             |
| 一级标题  | 黑体，四号（14pt），居中，段前段后各0.5行                   |
| 二级标题  | 黑体，小四（12pt），左对齐                            |
| 三级标题  | 黑体，小四（12pt），左对齐                            |
| 中文正文  | 宋体，小四（12pt），1倍行距，首行缩进2字符                   |
| 西文/数字 | Times New Roman，小四（12pt）                   |
| 数学公式  | Times New Roman，小四，居中，右侧编号；跨行公式整体居中、编号在右侧 |
| 图表标题  | 宋体，五号，居中（图下表上）                             |
| 页码    | 页尾居中，从第一页（摘要页）开始编号，摘要页即为第1页；全文禁止页眉                     |
| 总页数   | 正文25-30页，附录不做页数要求                        |

#### 排版强制规范

**0. 匿名与保密要求（一票否决，违反即取消评奖资格）**：

- 摘要页、正文、附录（含支撑材料）任何位置**禁止出现**参赛者姓名、所在学校、赛区、参赛队号、指导教师等任何身份信息
- **禁止页眉**：页眉区域必须完全留空，`\renewcommand{\headrulewidth}{0pt}`，页眉不得出现任何文字、图片或横线
- 作者区必须留空：`\author{}`、`\date{}`，`\maketitle` 不得显示作者与日期
- 页脚仅允许居中页码，页脚不得出现学校/队号等身份信息
- 图片、表格、代码注释、文件名等位置同样不得泄露身份信息（检查图片中是否有学校水印/名称）
- **页码设置**：从第一页（摘要页）开始连续编号，摘要页为第 1 页，页码页尾居中；`\maketitle` 后必须加 `\thispagestyle{fancy}` 覆盖默认 plain 样式

**1. 摘要格式与正文完全一致**：

- 摘要页边距 = 正文页边距（四边均为2.5cm）
- 摘要字号 = 正文字号（`\normalsize`）
- 首行缩进 = 正文首行缩进（`2em`）
- 摘要页加页码（第1页）

**2. 图片文字完整性**：

- matplotlib 必须设置中文字体：`plt.rcParams['font.sans-serif'] = ['SimHei', 'Microsoft YaHei']`
- 必须设置负号正常显示：`plt.rcParams['axes.unicode_minus'] = False`
- 保存时指定 `bbox_inches='tight'`
- 缺字体环境（Linux/macOS 容器）使用检测回退：优先探测可用中文字体（SimHei → Microsoft YaHei → Noto Sans CJK SC → WenQuanYi），全部缺失时显式警告，禁止静默输出方框
- 图内字号与正文对应：整版宽图（约6.3in）图内标签 ≥9pt（font.size=11 满足）；图缩至半版心（约3.2in）展示时须将 `font_scale` 提至 1.3 以上，保证印刷等效字号 ≥9pt
- LaTeX中图片宽度不超过 `\textwidth`

**3. 中文编码规范**：

- `.tex` 文件必须为 **UTF-8 无BOM** 编码
- 使用 `\usepackage{ctex}` 处理中文
- **禁止** `\usepackage[utf8]{inputenc}` + ctex 组合
- 必须使用 `xelatex` 编译

**4. 文字不超出纸张**：

- 长公式使用 `\begin{split}` 分行，跨行公式须整体居中且右侧带编号：
  - 单编号跨行：`\begin{equation}\begin{split}...\end{split}\end{equation}`，整体居中，右侧仅 1 个编号
  - 逐行编号跨行：`\begin{align}...\end{align}`，每行右侧有编号
  - 禁止用无编号的 `$$...$$` 或 `\[...\]` 排版主要公式
- 长表格使用 `p{宽度}` 或 `tabularx` 控制宽度
- 添加 `\usepackage{seqsplit}` 处理长英文单词
- 所有 `\begin{table}` 和 `\begin{figure}` 使用 `[H]` 强制定位

**5. 分页规则（强制执行）**：

- **摘要页**：题目 + 摘要 + 关键词，三者必须在同一页内完成，**摘要页为第1页**，页码底部居中
- **正文**：从第2页开始连续编号，各章节之间自然衔接，不强制分页
- **参考文献**：正文结束后，使用`\newpage`另起一页，页码连续
- **附录（支撑材料）**：参考文献结束后，使用`\newpage`另起一页，页码连续
- **禁止**将摘要或关键词挤到第二页；若空间不足，须压缩摘要字数（控制在1000字以内）

**6. 数学符号与字体规范**：

- **公式合理使用（与第3章"公式使用规范"配套）**：核心公式（目标函数/关键约束/状态方程）必须 equation 独立居中编号；R²、MAE、RMSE、MAPE 等检测量公式仅首次定义一次，后续仅引用指标名+数值；禁止过度详细的分步推导公式堆砌
- **变量**：斜体（如 $x$, $y$, $\alpha$, $\beta$）
- **矩阵/向量**：正体加粗（如 $\boldsymbol{A}$, $\boldsymbol{x}$）
- **单位与缩写**：正体（如 kg, m/s, LP, GA）
- 正文中西文和数字统一使用 Times New Roman
- 公式中函数名用正体（如 $\sin$, $\max$, $\sum$）

**7. 图表规范**：

- 表格统一使用**三线表**（`\toprule`, `\midrule`, `\bottomrule`），禁止竖线
- 表标题位于表**上方**，图标题位于图**下方**
- 所有图表必须有编号（自动编号）
- 每张图表前后必须有**文字分析过渡**，禁止图表孤立出现
- 格式：`如图X所示，……` 或 `见表X，……`

**8. 标题后必须有正文**：

- 各级标题后必须有正文内容，禁止标题后直接跟另一个标题
- 若章节内容较短，至少写一句引导性文字

**9. caption 设置规范**：

- 使用 `\captionsetup{font=small, labelsep=space, skip=6pt}`
- **禁止** `font={font=10.5pt}` 或 `font={size=10.5pt}`
- 有效 font 值：`scriptsize`, `footnotesize`, `small`, `normalsize`, `large`, `Large`

**10. 模型假设排版规范（重点关注）**：

- **必须使用三线表**呈现假设，禁止使用逐条列表（`\begin{itemize}`）或纯文字段落
- 表格列结构：编号 / 假设内容 / 合理性说明（LaTeX 实现中禁止竖线）
- 表题位于表格**上方**，格式：`表1 模型假设`
- **编号列**：居中对齐，使用阿拉伯数字（1, 2, 3, ...），加粗
- **假设内容列**：左对齐，使用完整陈述句，禁止缩写
- **合理性说明列**：左对齐，须给出物理依据或文献支撑，禁止仅写"合理"
- 假设条数控制在 **4-6 条**，过少缺乏严谨性，过多冲淡重点
- 表格前后须有**引导文字和过渡分析**，禁止表格孤立出现
- 每条假设须在正文建模时**显式引用**（如"根据假设3，可忽略XX影响"）

**正确写法（tabularx，推荐）**：

```latex
\begin{tabularx}{\textwidth}{c X X}
% c: 编号居中  X: 自动换行，宽度均分剩余空间
```

**正确写法（p列，备选）**：

```latex
\begin{tabular}{c p{5cm} p{6cm}}
% p{5cm}: 固定宽度自动换行，注意三列总宽不超\textwidth
```

**禁止写法**：

```latex
\begin{tabular}{cll}   % l列不换行，长文字必溢出！
```

**常见假设排版错误（含显示不全防错，最高频排版问题）**：

| 错误类型 | 错误示例 | 正确做法 |
| -------- | -------- | -------- |
| 使用列表代替表格 | `\begin{itemize} \item 假设1...` | 使用 `tabular` 三线表 |
| 表题位置错误 | 表题在表格下方 | 表题在表格**上方** |
| 合理性说明空洞 | "该假设合理" | "依据文献[1]，XX影响占比<3%，可忽略" |
| 假设未被引用 | 正文中未提及假设 | 建模时显式引用"由假设X可知..." |
| 含竖线 | `\begin{tabular}{|c|l|l|}` | `\begin{tabularx}{\textwidth}{c X X}` 配合 `\toprule` 等（长文本自动换行，防溢出） |
| 文字溢出显示不全 | `\begin{tabular}{cll}` 长文字不换行 | 改用 `tabularx` 的 `X` 列或 `p{宽度}` 列 |
| 表格超出版心 | 未限制总宽度 | `\begin{tabularx}{\textwidth}{...}` 锁定宽度 |
| 表格底部被截断 | 假设过多`table`环境不跨页 | 控制在4-6条；必须更多时用`longtable` |
| 行高不统一 | 换行后单元格错位 | 用 `m{宽度}`（`array`宏包）垂直居中对齐 |

#### LaTeX模板（精简版）

```latex
\documentclass[12pt,a4paper]{article}

% ========== 编码与中文支持 ==========
\usepackage{ctex}                    % 中文支持（禁止inputenc）

% ========== 宏包 ==========
\usepackage{amsmath,amssymb,amsfonts}
\usepackage{bm}                      % 矩阵/向量加粗
\usepackage{geometry}
\usepackage{graphicx}
\usepackage{float}
\usepackage{booktabs}                % 三线表
\usepackage{array}                   % m{}列类型（垂直居中）
\usepackage{tabularx}                % X列类型（自动宽度换行）
\usepackage{multirow}
\usepackage{caption}
\usepackage{subcaption}
\usepackage{hyperref}
\usepackage{fancyhdr}
\usepackage{titlesec}
\usepackage{listings}
\usepackage{xcolor}
\usepackage{seqsplit}                % 长单词断行

% ========== 西文字体 Times New Roman ==========
\setmainfont{Times New Roman}        % 西文和数字使用 Times New Roman

% ========== 页面设置（四边2.5cm） ==========
\geometry{top=2.5cm, bottom=2.5cm, left=2.5cm, right=2.5cm}

% ========== 标题格式（2026规范） ==========
\renewcommand{\thesection}{\chinese{section}}  % 一级标题使用中文数字
\titleformat{\section}{\centering\heiti\fontsize{14}{18}\selectfont}{\thesection、}{1em}{}  % 标题显示加顿号，交叉引用不受影响
\titleformat{\subsection}{\heiti\fontsize{12}{16}\selectfont}{\arabic{section}.\arabic{subsection}}{1em}{}
\titleformat{\subsubsection}{\heiti\fontsize{12}{16}\selectfont}{\arabic{section}.\arabic{subsection}.\arabic{subsubsection}}{1em}{}

% ========== 正文格式 ==========
\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}
\renewcommand{\baselinestretch}{1}  % 1倍行距

% ========== 图表标题 ==========
\captionsetup{font=small, labelsep=space, skip=6pt}
\captionsetup[figure]{position=below}
\captionsetup[table]{position=above}

% ========== 页眉页脚：禁止页眉；页码从第一页（摘要页）起页尾居中 ==========
\pagestyle{fancy}
\fancyhf{}                        % 清空页眉页脚（页眉必须留空）
\fancyfoot[C]{\thepage}           % 页尾居中页码，从摘要页第1页开始
\renewcommand{\headrulewidth}{0pt} % 禁止页眉横线（保证无页眉）

% ========== 代码样式 ==========
\lstset{
    basicstyle=\small\ttfamily,
    keywordstyle=\color{blue},
    commentstyle=\color{green!60!black},
    stringstyle=\color{red!70!black},
    numbers=left,
    numberstyle=\tiny\color{gray},
    frame=single,
    breaklines=true
}

\begin{document}

% ========== 第一页：题目 + 摘要 + 关键词（必须同页，页码从本页开始） ==========
\title{\heiti\fontsize{16}{20}\selectfont 论文题目}
\author{}
\date{}
\maketitle
\thispagestyle{fancy}  % 覆盖 \maketitle 默认的 plain 样式，确保首页页脚与正文一致

\vspace{0.3cm}

% 摘要（与标题、关键词同一页，手动格式与正文一致）
\noindent{\heiti\fontsize{14}{18}\selectfont 摘要：}\par
\setlength{\parindent}{2em}
\normalsize
本文针对[问题描述]，综合运用[方法A]、[方法B]和[方法C]，建立了[模型名称]模型，对[核心研究对象]进行了深入研究。

\vspace{0.2cm}

\noindent{\heiti 关键词：}关键词1；关键词2；关键词3

% ========== 关键词后换页，正文从第2页开始 ==========
\newpage

% ========== 正文内容 ==========
% 一、问题背景与重述
% 二、问题分析
% 三、模型假设
\section{模型假设}

针对本题实际情况，在建模前提出如下假设，如表\ref{tab:assumptions}所示。

\begin{table}[H]
\centering
\caption{模型假设}
\label{tab:assumptions}
\begin{tabularx}{\textwidth}{c X X}
\toprule
编号 & \multicolumn{1}{c}{假设内容} & \multicolumn{1}{c}{合理性说明} \\
\midrule
1 & 假设数据在采集过程中无系统性偏差 & 依据题目说明，数据经标准化预处理 \\
2 & 假设各周期决策相互独立，无跨周期资源传递 & 题目未声明资源可累积，故按独立处理 \\
3 & 假设模型参数在求解周期内保持恒定 & 短时间尺度内参数漂移可忽略\cite{ref1} \\
4 & 假设随机扰动服从均值为零的正态分布 & 依据中心极限定理，多源扰动叠加趋近正态 \\
\bottomrule
\end{tabularx}
\end{table}

% 四、符号说明
% 五、模型建立与求解（若所有问题共用一套数据，则先设"五、数据处理"，本章顺延为第六章，后续章节类推）
% 六、模型的评价、改进与推广

% ========== 参考文献（另起一页，页码连续） ==========
\newpage
\begin{thebibliography}{99}
\bibitem{ref1} ...
\end{thebibliography}

% ========== 附录/支撑材料（另起一页，页码连续） ==========
\newpage
\section*{附录}
% 附录A 支撑材料清单
% 附录B 核心代码

\end{document}
```

***

### 6. 参考文献规范

#### GB/T 7714格式

```
期刊论文：[序号] 作者. 篇名[J]. 刊名, 年, 卷(期): 起止页码.
图书：[序号] 作者. 书名[M]. 出版地: 出版者, 出版年: 起止页码.
学位论文：[序号] 作者. 篇名[D]. 保存地: 保存单位, 年份.
网页：[序号] 作者. 题名[EB/OL]. (发布日期)[引用日期]. URL.
```

#### 引用数量建议

- 正文引用5-8篇为宜
- 至少2篇为近5年文献
- 至少1篇为英文文献

#### 引用查证（强制性）

所有引用文献必须通过在线检索工具逐条核实，严禁编造。

**查证流程**：

1. 整理所有参考文献条目
2. 逐条在 Google Scholar / CNKI 中检索
3. 核对作者、标题、刊名、卷期、页码、年份
4. 点击所有 DOI 和 URL 验证可访问性
5. 将确认无误的文献写入 .tex 文件

***

### 7. 论文质量自检清单

#### [致命] 匿名与保密（一票否决，违反直接取消评奖资格）

| 检查项  | 修复方法                             |
| ---- | -------------------------------- |
| 摘要页/正文/附录出现参赛者姓名、学校、赛区、队号、指导教师 | 全文删除（含文字、图片水印、页眉页脚、代码注释、文件名） |
| 存在页眉或页眉横线 | 清空页眉内容并设 `\renewcommand{\headrulewidth}{0pt}` |
| 页码未从摘要页（第1页）开始 | 全文 `\pagestyle{fancy}`，`\maketitle` 后加 `\thispagestyle{fancy}` |
| 页码未页尾居中 | `\fancyfoot[C]{\thepage}`，确保 `\fancyhf{}` 后页脚仅剩居中页码 |

#### [致命] 中文编码问题

| 检查项  | 修复方法                             |
| ---- | -------------------------------- |
| 文件编码 | 保存为 UTF-8（无BOM）                  |
| 中文乱码 | 使用 xelatex 编译                    |
| 宏包冲突 | 删除 `\usepackage[utf8]{inputenc}` |

#### [严重] 输出文件完整性

- `paper/paper.pdf` 必须存在且可正常打开
- `paper/paper.docx` 必须存在且可正常打开
- 两文件内容一致（标题、摘要、数值、图表编号对应）

#### [严重] PDF 与 Word 格式一致性检查（重点）

- 重点检查 Word 文档格式，须与 PDF 一致：
  - 题目：三号黑体居中；摘要标签：四号黑体
  - 正文：小四宋体，1倍行距，首行缩进2字符
  - 一级标题：四号黑体居中；二级标题：小四黑体左对齐
  - 三线表（无竖线）、图题在下、表题在上
  - 页码位置一致
- **不强制要求** Word 中标号的交叉引用与超链接，不因缺少交叉引用扣分

#### [严重] 摘要与正文一致性

- 摘要数值 = 正文表格数值（精确到同一小数位）
- 摘要方法名 = 正文模型名 = 代码实现名

#### [严重] 模型选择理由

- 必须说明选择该算法的理由
- 至少提及1种替代方案并说明为何不选
- 参数设置需有依据（参考文献建议范围）

#### [严重] 变量与符号一致性

- 每个符号唯一，无冲突
- 大小写统一
- 所有符号均在符号说明表中定义

#### [中等] 公式、图表完整性

- 公式编号连续，无重复
- 跨行公式整体居中，编号位于右侧
- 核心公式（目标函数/关键约束/状态方程）已作为编号公式插入且被正文引用
- R²/MAE/RMSE/MAPE 等检测量公式仅首次定义一次，后续仅引用名称+数值
- 无过度详细的分步推导公式堆砌
- Word 版公式为 OMML 数学格式且居中（可在公式编辑器编辑），非文本/图片模拟
- 图表编号连续，无跳跃
- 图题在下，表题在上
- 三线表格式（无竖线）
- 第二章必须含问题分析图（流程图/技术路线图），符合流程图专项规范
- 性能对比图坐标轴从 0 起始；折线图同图曲线≤5条
- 多组图形用学术低饱和配色+明暗/透明度区分，黑白打印可辨识（不默认斜线/圆点纹理）

#### [中等] 正文语言表述

- 正文每问采用"问题—回应"结构：先陈述问题，后给出回答
- 每问结尾有明确结论段：给出最优方案 + 关键数值 + 达标判断
- 每个问题之间有一句承上启下（含上问结论或下问任务），无纯形式衔接
- 无（1）（2）（3）机械分条行文，段落连贯、过渡自然
- 结论均有具体数值或指标支撑，无"很明显/效果很好/一定程度上"等空泛表述
- 全文无 AI 痕迹：无"随着…的发展""综上所述""值得注意的是"等模板腔与套话
- 每张图、每个表均有至少一段文字解读（趋势 + 原因 + 结论）

#### [中等] 误差分析

- 给出相对误差或置信区间
- 与基准方案对比，给出提升百分比

#### [严重] 参考文献查证

- 所有文献在数据库中可查
- 元数据准确（作者、标题、刊名、卷期、页码）
- DOI/URL 可访问

#### [轻微] 表达规范

**黑名单（出现即需修改）**：

- "较好" "很大" "显著" -> 替换为具体数值
- "可以看出" "不难发现" -> 给出数据或公式支撑
- "众所周知" "显然" -> 给出引用或推导

***

### 8. 最终论文评分（百分制）

#### 评分维度与权重

| 维度 | 分值 | 评分依据 |
| ---- | ---- | -------- |
| **摘要** | 30 | 结构完整性、数值具体性、递进关系、与正文一致性 |
| **算法/模型正确性** | 20 | 数学推导无误、约束完备、求解结果合理 |
| **创新性** | 20 | 方法创新度、跨学科融合、指标构建独创性 |
| **写作能力** | 15 | 逻辑连贯、学术语态、数据支撑、无空泛表达 |
| **排版** | 15 | 格式规范、图表完整、符号一致、编译无误 |
| **合计** | 100 | $S \geq 85$ 方可最终输出 |

#### 各维度评分细则

**1. 摘要（30分）**

| 检查项 | 扣分标准 |
| ------ | -------- |
| 模型名称/方法与正文不一致 | 每处 -5 |
| 数值结果与正文表格不一致 | 每处 -5 |
| 缺少具体数值结果（仅定性描述） | -8 |
| 未体现问题间递进关系 | -5 |
| 字数超出 800-1000 字范围 | -3 |
| 缺少误差/不确定度分析 | -4 |

**2. 算法/模型正确性（20分）**

| 检查项 | 扣分标准 |
| ------ | -------- |
| 模型选择无充分理由（未对比替代方案） | -6 |
| 目标函数或约束条件缺失 | -5 |
| 求解结果明显不合理（如违反物理约束） | -8 |
| 参数设置无依据（未引用文献建议范围） | -3 |
| 缺少误差分析/敏感性分析/对比实验 | 每缺一项 -2（若已在摘要维度扣过"缺少误差/不确定度分析"，此处不重复扣） |

**3. 创新性（20分）**

| 检查项 | 扣分标准 |
| ------ | -------- |
| 全部使用基础方法无创新 | -10 |
| 创新点缺乏理论支撑 | -5 |
| 未构建自定义指标或改进算法 | -5 |

**4. 写作能力（15分）**

| 检查项 | 扣分标准 |
| ------ | -------- |
| 存在空泛表达（"较好""显著"等黑名单词） | 每处 -1 |
| 结论缺少数据支撑 | -3 |
| 段落间逻辑断裂 | -2 |
| 病句或表述歧义 | 每处 -1 |

**5. 排版（10分）**

| 检查项 | 扣分标准 |
| ------ | -------- |
| **出现参赛者身份/学校/赛区信息，或存在页眉（一票否决）** | **直接淘汰，不计分** |
| 页码未从摘要页（第1页）开始，或未页尾居中 | -2 |
| 变量/符号前后不一致 | 每处 -2 |
| 公式编号不连续或重复 | -2 |
| 图表编号跳跃或缺失 | 每处 -1 |
| 图题/表题位置错误（图下表上） | 每处 -1 |
| 非三线表格式（含竖线） | -2 |
| 编译报错或文字超出纸张 | -3 |
| 模型假设未用三线表（用列表/纯文字） | -2 |
| 假设合理性说明空洞（仅写"合理"） | 每处 -1 |
| 假设条数不在4-6条范围 | -1 |
| 正文中未显式引用假设编号 | -2 |
| 跨行公式未居中或右侧缺编号 | 每处 -1 |
| 核心公式缺失或未编号（目标函数/关键约束） | -2（若已在"算法/模型正确性"维度扣过"目标函数或约束条件缺失"，此处不重复扣） |
| 检测量公式重复列出 / 公式过度堆砌 | 每处 -1 |
| Word 中公式为文本/图片模拟，非数学格式 | -2 |
| Word 格式与 PDF 不一致（字体/字号/行距/缩进/标题层级/三线表） | 每处 -1 |

#### 评分输出模板

```
========== 论文评分表 ==========
维度              得分    满分
---------------------------------
摘要              XX      30
算法/模型正确性    XX      20
创新性            XX      20
写作能力          XX      15
排版              XX      15
---------------------------------
总分              XX      100
---------------------------------
判定：[达标/需优化]

扣分明细：
1. [维度] [检查项] -X分：具体说明
2. ...
=================================
```

#### 优化触发规则

- **$S < 85$**：列出所有扣分项，按分值从高到低排序，逐项修改后重新评分
- **$S \geq 85$**：输出最终论文（PDF + Word），附最终评分表
- **任一维度得分为 0**：不论总分多少，强制优化该维度

***

## 使用方式

**触发场景**：

1. 用户上传赛题文本或粘贴赛题内容
2. 用户提问"分析这道题"或"帮我建模"
3. 用户要求推荐算法或编写代码
4. 用户提交论文草稿要求润色
5. 用户要求先联网查证赛题背景再进行分析与建模

**输出风格**：

- 默认使用中文输出
- 代码块标注语言类型
- 表格清晰对齐
- 关键结论突出显示

***

## 快速参考

### 算法选择速查

| 问题特征      | 推荐算法           |
| --------- | -------------- |
| 非线性、不连续或不可导 | 遗传算法       |
| 0-1变量     | 0-1整数规划 + 遗传算法 |
| 高维决策空间    | 分层构建初始解 + 智能优化 |
| 多方法融合     | 多模型加权集成、分阶段混合求解（如启发式+精确校正） |
| 评价/排序类问题 | 熵权-TOPSIS（首选）、AHP、灰色关联分析 |
| 指标权重确定 | 熵权法、CRITIC、AHP |
| 最短路径/网络流 | Dijkstra/Floyd、最大流、最小生成树 |
| 路径规划/配送 | TSP/VRP + GA/蚁群求解 |
| 时序预测 | ARIMA、Prophet、LSTM；小样本用GM(1,1) |
| 机理演化类（A题） | 微分方程组 + RK4数值解 + 敏感性分析 |
| 方程求根/非线性求解 | 二分法、牛顿迭代法 |
| 插值/数据补全 | 三次样条插值、拉格朗日插值 |
| 项目排程/关键路径 | 关键路径法（CPM/PERT） |
| 连续参数快速优化 | 梯度下降、共轭梯度（大空间则用智能优化） |

### 算法实现速查

> 原则：有成熟库的方法优先调用，禁止手动重复实现已有算法；自写代码集中于无现成实现的方法（评价赋权、灰色预测、仿真框架等）。需单独安装的库先在阶段零环境预检中检查可用性，安装失败时退化为等价替代方法。

| 算法/方法类别 | 推荐实现 |
| -------------- | ------------------------ |
| 线性规划 / 0-1整数规划 / 混合整数 | `pulp`（自带CBC求解器）或 `scipy.optimize.milp`；禁止手写单纯形法 |
| 非线性/约束优化 | `scipy.optimize.minimize`（SLSQP/trust-constr）；凸问题用 `cvxpy` |
| 连续全局优化 | `scipy.optimize.differential_evolution`（差分进化）、`dual_annealing`（模拟退火） |
| 组合启发式（GA/SA/PSO等） | 自行实现，编码与算子须贴合问题；指派/TSP可用 `python-ortools` |
| 多目标优化（NSGA-II/III） | `pymoo`（需单独安装） |
| 微分方程数值解 | `scipy.integrate.solve_ivp`（自动选RK45/BDF）；手写RK4仅作原理演示 |
| 图论（最短路/生成树/最大流/匹配） | `networkx`；大规模稀疏图用 `scipy.sparse.csgraph` |
| 插值与拟合 | `scipy.interpolate`（CubicSpline/interp1d）、`numpy.polyfit` |
| 统计检验与相关性 | `scipy.stats`（ttest_ind、chi2_contingency、spearmanr、shapiro） |
| 回归分析 | 统计推断用 `statsmodels`（提供p值/置信区间）；纯预测用 `sklearn` |
| 时间序列 | `statsmodels`（ARIMA、ExponentialSmoothing）；Prophet 需单独安装 `prophet` |
| 机器学习（分类/聚类/降维） | `scikit-learn`；梯度提升树用 `xgboost`/`lightgbm` |
| 灰色预测GM(1,1)/马尔可夫链 | 自写（累加生成 + 最小二乘参数估计 + 后验差检验C/P） |
| 熵权法/TOPSIS/AHP/灰色关联/模糊综合评价 | 自写（矩阵标准化 + 赋权公式），注意负向指标标准化方向 |
| 仿真（蒙特卡洛/离散事件/排队/元胞自动机） | `numpy.random` + 自写事件驱动框架 |
| 信号处理 | `numpy.fft`（FFT）、`pywt`（小波，需单独安装） |

### 问题递进关系

| 递进类型    | 典型表述                  |
| ------- | --------------------- |
| 简单→复杂   | "在问题一的基础上，进一步综合考虑..." |
| 静态→动态   | "考虑到实际因素/动态变化..."     |
| 确定→不确定  | "在确定的最优配置基础上，引入随机需求（不确定性），构建随机规划模型"    |
| 单目标→多目标 | "引入多目标优化，采用NSGA-II求解Pareto前沿..." |

### 常见错误速查

| 错误类型      | 解决方案                                |
| --------- | ----------------------------------- |
| 中文乱码      | 使用 xelatex，删除 inputenc              |
| 图片文字不全    | 设置 SimHei，使用 bbox\_inches='tight'   |
| 图片中文显示方框  | 缺字体环境用字体检测回退（pick\_cjk\_font），安装 SimHei 或 Noto Sans CJK |
| 折线图曲线过多难区分 | 同图≤5条，线型+标记区分，超限分图         |
| 性能对比图Y轴不从0起 | 强制 `ax.set_ylim(0, ...)`，避免视觉误导    |
| 黑白打印分不清组别 | 用学术低饱和配色+明暗/透明度区分；多组年份可用横线/竖线纹理 |
| 文字超出纸张    | 使用 seqsplit，tabularx，[H]定位         |
| caption报错 | 使用 font=small，禁止 font={font=10.5pt} |
| 假设用列表非表格   | 改用 tabular 三线表，表题在上方，含合理性说明        |
| 假设表格显示不全   | `tabular`的`l`列不换行，改用`tabularx`的`X`列  |
| 正文AI痕迹过重（模板腔/套话/衔接生硬） | 见第3章"正文语言表述规范"：直入主题、衔接句带信息量、结论个性化 |
| Word中公式显示为普通文本/乱码 | 用 pandoc 从 paper.tex 生成 .docx，公式自动转 OMML 原生数学格式 |
| 公式过度堆砌/检测量公式重复列式 | 见第3章"公式使用规范"：推导从简、检测量公式仅首次定义 |



