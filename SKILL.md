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
- **算法选择与设计**：说明选择该算法的理由（对比至少1种替代方案），如采用约束分析、剪枝等搜索空间压缩策略须一并描述，给出算法流程图并列出关键参数表。算法介绍必须结合本题问题的结构与数据特点撰写，禁止通用模板式介绍文字，关键超参的选取依据须在正文阐释。
- **求解结果**：用表格呈现核心结果，与前一问对比并说明提升百分比，配以文字解读关键数值。
- **结果验证**（按问题类型选用，禁止套用固定流程）：优化类问题用替代算法（或精确法）互验、绘制迭代收敛曲线图并作参数敏感性分析，条件允许时与精确法/一体化模型对照或报告下界间隙（optimality gap）以衡量解的最优性，多目标问题不得仅靠人为给定权重集生成解集，应以 ε-约束法或等价全域扫描获取全域 Pareto 前沿并说明折中方案的选取依据；预测类问题用留出法/时序交叉验证并报告 MAE/RMSE/R² 等误差指标（按需补充领域标准指标），并作多维度误差拆解（如分组/分时段），当预测结果注入下游决策时须分析预测误差向下游结果的传导；评价类问题作权重扰动鲁棒性检验并与替代评价方法对比；微分方程类问题与解析解/极限情形对比，并作守恒量校验与步长收敛性验证。稳健性/敏感性检验是模型检验的通用环节（不限于优化类），但形式须与问题类型匹配：优化类扰动关键参数、预测类检验结论对超参/训练样本的稳定性、评价类扰动权重/数据、微分方程类扰动参数/初值；核心是验证关键结论在合理扰动下是否保持稳定，无不确定参数的模型不做形式化扰动。
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

**4. 题目要求逐项响应**：题目明确要求的基线、对照与输出内容必须逐项响应并完成，缺失即硬伤。

**5. 现实适用性讨论**：理想化模型/仿真须讨论其与工程现实的差距及对结果的影响。

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
- **图型跟随数据结构，匹配时优先高端效果**：图表类型由数据结构与表达目标决定；数据适用时优先采用三维曲面图、热力图、等高线图、网络/关系图、平行坐标图等高级优质图表提升表现力（详见下方推荐图表类型表与「图型创新与跨图统一」）；**图库不是边界**——表内与模板覆盖不到的图型按结论需要现绘，不必硬套最接近的模板；基础图型（折线/柱状/饼）仍是表达主力，禁止为视觉效果强行升级图型（如收敛曲线强改三维曲面）
- **组合图规范**：双轴图（同一主题的多量纲指标同图，如左右轴分别表示数值与占比/速率）**可以使用**；**禁止将多张不相干图硬凑成组合图**——多子图组合仅限同主题的关联子图（如拟合图+残差图、多方法对比），每个子图须在正文中分别解读
- **图内文字防重叠**：图例不遮挡数据（frameon=False 或指定位置）；坐标轴标签过长时旋转/换行；数据点标注自动避让（offset/bbox/adjustText）；密集数据仅标注关键点，禁止文字互相重叠遮挡
- **拟合结果必须可视化**：拟合曲线 vs 原始数据
- **误差分析必须可视化**：残差图、误差分布图
- **所有图表必须具备出版级质量**：分辨率≥300 DPI，矢量格式优先；密度类图（大规模散点/hexbin/3D曲面）可降至 200 DPI，线条/柱状类优先矢量 PDF（分级策略见 plot_style.py 说明）
- **预览与正式版同品质**：调试/预览图（含 `figures/tmp/`、示范图）与交付图同一品质——一律 `savefig.dpi=300` 保存（密度类图可按分级策略降至 200），禁止生成低分辨率预览图
- **全局-局部互补**：时序类结果应附关键时段局部放大图；分配/调度类结果应附关键资源利用率视图，与全局图互补，避免局部特征被遗漏

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
| 泰勒图              | 多模型综合评价（相关系数与 RMSE 同图）  | ★★★★★ | matplotlib          |
| 云雨图（raincloud）  | 配对分布 + 个体观测 + 均值趋势          | ★★★★★ | matplotlib / seaborn |
| 交叉验证 ROC 图       | 分类器性能与折间置信带                 | ★★★★  | scikit-learn / matplotlib |
| SHAP 重要性组合图     | 特征重要性（柱状总览 + 蜂群细节）       | ★★★★★ | shap / matplotlib   |
| 环形热图            | 分组周期/时段数据强度矩阵               | ★★★★  | matplotlib          |
| 和弦图              | 实体间流量与关联结构                    | ★★★★  | matplotlib / plotly |
| 半边小提琴 + 下三角相关矩阵 | 分组分布对比与两两相关一图打尽    | ★★★★  | matplotlib / seaborn |
| 预测-真实值边缘分布组合图 | 回归诊断（散点 + 两侧边际分布）      | ★★★★  | seaborn / matplotlib |

> 上述 8 类本 skill 无内置代码模板：若已安装 `mathmodel-figure` 技能可直接套其同名模板（自带确定性模拟数据、PNG/PDF/SVG 三格式），否则按本章规范现绘，样式一律取自 `plot_style.py`。

> 基础图型（折线/柱状/箱线/环形/条形）的逐项绘制规范与代码模板见下文「基础图型绘制规范与代码模板」。

#### 图型创新与跨图统一（图库不是边界）

> **选图自由、样式零自由**：图型可以大胆创新，但色、字号、尺寸、坐标框架、图题口径必须全部收敛到 `plot_style.py` 与下面的统一契约。

**选图原则**

- 图型由**数据结构与要论证的结论**决定；上表与内置模板只是加速器，**不是边界**——覆盖不到就现绘
- **禁止为套用模板而改数据语义**，禁止把不相干的图硬凑成多子图；也禁止为视觉效果强行升级图型（收敛曲线不改成三维曲面）
- 数据适合时就大胆用更有表现力的图型：等高线+填充、相图/零净增长线、平行坐标、small multiples 小多图、双轴组合、和弦/桑基、龙卷风、差值双柱、脊线图、瀑布图、甘特图、地图热力
- 拿不准就回到唯一判据：**这张图要证明什么**；一句话说不出来，就不该画

**六条硬标准**（模板库外现绘逐条满足）

1. 样式来源唯一：`from plot_style import ...`，脚本内不写 hex 色值、不写裸字号
2. 坐标框架一律 `style_axes()`；数值轴从 0 起，不误导性截断
3. 颜色只承担身份/方向/层级三职责（见「Nature 风格配色」四条不变式）
4. 文字最少且可读：禁 mathtext 与中文混排；系列 ≤5 优先线尾/条端直接标注取代图例
5. 证据完整：置信带、误差棒、`R²`/RMSE/n 该显示就显示；显示每一次观测，别只画均值
6. 出图后必看渲染产物（自检项见第 7 章清单）——代码跑通不等于图没问题

**跨图风格统一契约**（全文强制，创新图不豁免）

- **先登记再画图**：动笔前定一张方法-颜色对照（本文方法=主角蓝、对照方法=橙/紫/青、基准=灰、背景/种群=浅调），全文每张图（含模板图与现绘图）一律按这张表取色
- 模板图与现绘图共用同一套 `plot_style.py` 常量，**视觉差只允许来自图型本身**
- 尺寸与字号只取 `FIG_FULL/FIG_TALL/FIG_SQUARE` 与 `FS_*`，不允许"这张图字大一点"
- 色相超过 6 个说明图型选错了：改分图或热图，而不是继续加色
- 图题口径一致：一句话写结论，不写绘制过程

**现绘最小骨架**（复制到 `code/qX_custom.py` 后只改数据与图型，其余不动）

```python
from plot_style import (COLOR_BASELINE, COLOR_MAIN, FILL_ALPHA, FIG_FULL, FS_ANNOT,
                        FS_LABEL, save_fig, style_axes)

rng = np.random.default_rng(2026)              # 种子固定，结果可复现
x = np.linspace(0, 10, 60)
y_main = np.abs(np.sin(x)) + rng.normal(0, 0.08, x.size)

fig, ax = plt.subplots(figsize=FIG_FULL)       # 尺寸取自 plot_style，勿手写
ax.fill_between(x, y_main - 0.15, y_main + 0.15, color=COLOR_MAIN, alpha=FILL_ALPHA,
                label='±1σ 区间', zorder=2)     # 不确定度该给就给
ax.plot(x, y_main, color=COLOR_MAIN, linewidth=2.2, label='本文方法', zorder=4)
ax.plot(x, 0.6 * np.abs(np.cos(x)), color=COLOR_BASELINE, linewidth=1.4, linestyle='--',
        label='基准', zorder=3)                  # 基准永远是灰
ax.text(x[-1], y_main[-1], ' 本文方法', color=COLOR_MAIN, fontsize=FS_ANNOT,
        va='center')                            # 系列 ≤5：直接标注取代图例
ax.set_xlabel('自变量 x')
ax.set_ylabel('目标值 y')                       # 轴标注物理含义 + 单位，禁 mathtext 混排中文
ax.set_xlim(0, x.max() * 1.18)                  # 右侧留直接标注位，文字不被裁掉
ax.set_ylim(0, None)                            # 性能类数值轴从 0 起
style_axes(ax, grid='y')                        # 坐标框架统一
ax.set_title('图题写结论，不写绘制过程', fontsize=FS_LABEL)
save_fig(fig, '../figures/final/figX_custom.png', vector=True)
```

多子图主次分明用 `gs = fig.add_gridspec(2, 2, width_ratios=[1.5, 1], hspace=0.45, wspace=0.3)` + `add_panel_label(ax, 'a')`：hero 面板不得与陪衬等大，每个子图回答一个**唯一**问题，同指标子图共享上下限（`sharey=True`）。

**反哺规则**：同一图型在论文里出现 ≥2 次、或属竞赛高频图型，就按模板 1–5 的写法把它登记进下文「高频图表代码模板」，后续复用而不是每次现绘。

#### 高级图表配色要点

- **散点/气泡图**：单系列主角蓝 `COLOR_MAIN` α0.5–0.6（重叠自然加深体现密度）；离群点/关键解用 `ACCENT_ORANGE` + 白描边并放大；多系列按 `identity_color(i)` 取色；叠加拟合线用主角蓝加粗
- **雷达图**：填充主角蓝 α0.2（极淡不遮网格）；轮廓主角蓝 2pt 实线；对比模型取次系列身份色虚线、填充 α0.1；网格线 `NEUTRAL_LIGHT`
- **桑基图/和弦图**：节点按身份色序列着色；连线（流量）半透明 0.4–0.6 且**颜色继承起始节点**，便于追踪流量归属
- **地图热力图**：底图极简（仅海岸线/省界浅灰）；数据层用 `SEQUENTIAL_CMAP` 单色顺序系；**禁红绿配色**（色盲不友好）
- **平行坐标图**：样本**降采样（≤60 条/类）防线条过密**；透明度 0.3–0.5；按类别取 `identity_color(i)`；图例置于图外防重叠

#### Nature 风格配色（必须使用）

**统一原则**：颜色只承担三种职责——**身份**（这是哪个方法/哪条系列）、**方向**（升还是降）、**层级**（主证据还是支持信息）；纯装饰性用色一律禁止。同时兼顾区分度、色盲友好、印刷一致性与黑白打印层次。

| 职责 | 常量 | 值 | 用法 |
| :--- | :--- | :--- | :--- |
| 身份·主角 | `COLOR_MAIN` | `#1A6FC4` | 本文方法/主系列，**每张图的同一含义固定不变** |
| 身份·同族 | `COLOR_MAIN_LIGHT` / `COLOR_MAIN_PALE` | `#5B9BD5` / `#B4D4F0` | 主系列变体、支持信息 |
| 身份·次系列 | `ACCENT_ORANGE` / `ACCENT_PURPLE` / `ACCENT_TEAL` / `ACCENT_CORAL` / `ACCENT_LAVENDER` | `#E28E2C` / `#7B5FD6` / `#33B5A5` / `#D9544D` / `#B89BD9` | 按序取用 `identity_color(i)`，第 0 个恒为主角蓝 |
| 基准 | `COLOR_BASELINE` / `COLOR_BASELINE_DARK` | `#767676` / `#4D4D4D` | 对照/参考/均值线，**永远是灰** |
| 方向 | `COLOR_POSITIVE` / `COLOR_NEGATIVE` | `#2E9E44` / `#E53935` | **只用于有正负的变化量**（差值、增益、损失） |
| 中性 | `NEUTRAL_BG` / `NEUTRAL_LIGHT` / `NEUTRAL_MID` / `NEUTRAL_DARK` / `COLOR_INK` | `#F5F5F5` / `#D8D8D8` / `#A8A8A8` / `#606060` / `#333333` | 底色、网格、次要文字、轴线、正文与标题 |
| 层级 | `TONE_RAMP` / `tint()` | 主角蓝 → 中调 → 浅调 → 中性灰 | 排名与主次：深=主证据，浅=陪衬（同族降饱和，不另立色板） |
| 色图 | `DIVERGENT_CMAP` / `SEQUENTIAL_CMAP` | 蓝→浅灰→珊红 / 浅→主角蓝 | 发散矩阵与响应曲面 / 单极数据与黑白打印变体 |

**四条不变式**（跨图、跨子图都必须成立）：

1. **同一方法同一颜色**：某方法在子图 a 是主角蓝，在 b、c、d 与另一张图里仍是主角蓝，不为"更醒目"而改色
2. **基准恒为灰**：等权重、移动平均、贪心基线等一切参照对象取 `COLOR_BASELINE`；不得用灰色画主角、用亮色画基准
3. **红绿只留给方向**：绿=变好/上升、红=变差/下降，且须同时给出 `↑`/`↓` 与正负号做冗余编码（`delta_annotation()` 直接产出文本与颜色）；表达"类别身份"改用蓝/橙/紫/青——得分 0.8 的模型不是"绿色"，而是"主角蓝"
4. **饱和与明度编码层级**：主结果用全饱和，支持信息降饱和或走 `TONE_RAMP`；系列超过 6 个色相说明图型选错了，改分图或热图，而不是继续加色

**常见误用 → 修正**：

| 误用 | 修正 |
| :--- | :--- |
| 同一方法在各子图里颜色不同 | 一个方法一个颜色，全篇复用 |
| 用红绿区分"方法A / 方法B" | 身份用蓝/橙/紫，红绿只标增减 |
| 所有柱等亮等饱和、看不出主次 | 主角全饱和，陪衬走 `TONE_RAMP` |
| 灰色画主结果、亮色画基线 | 反过来：主角取强色，基线取灰 |
| 图例色块占掉三成版面 | 直接标注在线尾/条端，或把图例移到图下方 |

> **唯一定义**：以上色板/色图/纹理/尺寸/字号常量的唯一出处是下方 `code/plot_style.py`，正式出图一律 `from plot_style import ...` 引用；**禁止在脚本里硬编码十六进制色值或裸字号**（历史漂移教训：模板代码曾误重复绛红、字号各处手写 7.5/9/10 不一致）。

**禁用配色**：

- ❌ 纯黑 `#000000`（一律 `COLOR_INK` `#333333`，更柔和高级）
- ❌ 纯红 `#FF0000` + 纯绿 `#00FF00` 作系列配色（色盲不友好；红绿只按方向色规则出现）
- ❌ `rainbow` / `jet` 色图（感知不均匀，学术禁用）
- ❌ 超过 6 种高饱和色同时出现
- ❌ 在绘图脚本里硬编码 hex 色值（改色请改 `plot_style.py`）

**纹理编码（可选，非默认）**：

- 基础图表（分组柱状/环形/条形）**不默认添加斜线/圆点纹理**，靠身份色 + `TONE_RAMP` 明度阶梯区分
- 多组年份对比等确需区分时，可用透明度或纹理（横线 `---`、竖线 `|||`，序列常量 `HATCH_SEQUENCE`）
- 若使用纹理：柱体/扇区 `edgecolor` 统一**白色**、`linewidth=0.8`（Nature 分隔口径）

#### 全局视觉统一（全文图表强制）

- **主色一致**：全文所有图表主色统一——图1 用主角蓝代表"模型A"，图5 中"模型A"必须仍是主角蓝（`identity_color(0)` 恒为主角蓝，跨图图例一致）
- **图内文字语言**：用户未明确说明时，图中标题、坐标轴标签、图例、colorbar 标签、注解**一律中文**（专业术语用「中文（缩写）」形式，如「决定系数（R²）」「均方根误差（RMSE）」，单位用国际符号 cm/kg/℃）；仅当明确要求全英文时才整体改用英文。同一篇论文内所有图表语言必须统一，禁止中英混排（如中文标题配英文图例）
- **禁 mathtext 与中文混排**：`"问题规模 $n$（个）"` 这类写法会让中文退化成方框（mathtext 段不做字体回退）；要么写纯文本 `"问题规模 n（个）"`，要么整串都用公式
- **字体与字号**：西文/数字 Arial（缺则 Helvetica/Liberation Sans，最终兜底 DejaVu Sans），中文 Microsoft YaHei → SimHei → Noto Sans CJK SC；字号一律取 `FS_TITLE/FS_LABEL/FS_TICK/FS_LEGEND/FS_ANNOT`（8–10.5pt，比正文略小但清晰），禁逐脚本手写
- **坐标框架**：一律调用 `style_axes(ax, grid='y')`（横向条形 `grid='x'`、散点可 `both`、等高线可 `None`；热图例外需四边闭合），禁止在各脚本里重复手写 spine/网格/刻度设置
- **去噪**：删除无意义背景色/过粗边框/阴影；去上右 spine；图例默认无框、系列 ≤5 优先直接标注；留白是高级感的来源

#### 统一绘图工具模块（强制统一使用，code/plot_style.py）

> 绘图样式初始化全部收敛于此模块，所有绘图脚本 `import` 即可复用，避免每脚本重复粘贴样式代码；集中管理 Nature 语义色板（身份/基准/方向/中性/层级）、色图、纹理、三档标准尺寸、分级字号与样式助手（`style_axes`/`add_panel_label`/`annotate_bars`/`delta_annotation`/`identity_color`/`tint`）及统一保存入口（自动 300DPI、防裁切、保存后关闭 figure 防内存累积）。

```python
# code/plot_style.py —— 统一样式模块（保存至 code/，绘图脚本 from plot_style import ... 复用）
# Nature 版式：颜色只承担三种职责——身份（哪个方法/系列）、方向（升还是降）、层级（主证据还是陪衬）；
# 字号、轴线、网格、面板标号、数值标注一律取自本模块常量并调用 style_axes / add_panel_label /
# annotate_bars 等助手，禁止在脚本里另行定义色值或裸字号。
import os
import warnings
import matplotlib
matplotlib.use('Agg')   # 非交互后端：无 GUI 开销，批量出图稳定（交互调试时删除本行）
import matplotlib.pyplot as plt
import seaborn as sns
from matplotlib import font_manager
from matplotlib.colors import LinearSegmentedColormap, to_hex, to_rgb

# ===== 身份色（identity）：只回答"这是哪个方法/哪条系列"，跨图含义不变 =====
COLOR_MAIN         = '#1A6FC4'   # 主角蓝：本文方法/主系列，每张图同一含义固定不变
COLOR_MAIN_LIGHT   = '#5B9BD5'   # 同族中调：主系列变体
COLOR_MAIN_PALE    = '#B4D4F0'   # 同族浅调：支持信息
ACCENT_ORANGE      = '#E28E2C'   # 次系列 1（橙）
ACCENT_PURPLE      = '#7B5FD6'   # 次系列 2（紫）
ACCENT_TEAL        = '#33B5A5'   # 次系列 3（青）
ACCENT_CORAL       = '#D9544D'   # 次系列 4（珊红）
ACCENT_LAVENDER    = '#B89BD9'   # 次系列 5（淡紫）
IDENTITY_PALETTE = (COLOR_MAIN, ACCENT_ORANGE, ACCENT_PURPLE,
                    ACCENT_TEAL, ACCENT_CORAL, ACCENT_LAVENDER)

# ===== 基准色（baseline）：对照/参考/均值一律中灰，不与主角抢身份 =====
COLOR_BASELINE      = '#767676'
COLOR_BASELINE_DARK = '#4D4D4D'

# ===== 方向色（signal）：只用于有正负之分的变化量（差值、增益、损失） =====
COLOR_POSITIVE = '#2E9E44'   # ↑ 提升
COLOR_NEGATIVE = '#E53935'   # ↓ 下降

# ===== 中性色（底色/网格/次要文字/轴线/正文）；禁纯黑 #000000，一律 COLOR_INK =====
NEUTRAL_BG    = '#F5F5F5'
NEUTRAL_LIGHT = '#D8D8D8'
NEUTRAL_MID   = '#A8A8A8'
NEUTRAL_DARK  = '#606060'
COLOR_INK     = '#333333'

TONE_RAMP = (COLOR_MAIN, COLOR_MAIN_LIGHT, COLOR_MAIN_PALE, NEUTRAL_MID)  # 深=主证据，浅=陪衬
LINE_PALETTE = [COLOR_MAIN, ACCENT_ORANGE, ACCENT_PURPLE, COLOR_BASELINE]
FILL_ALPHA = 0.15          # 置信带/填充一律淡，不遮数据
HATCH_SEQUENCE = ('', '---', '|||')   # 可选纹理：无/横线/竖线（基础图表不默认斜线圆点）

# 兼容别名：旧脚本里"红=负面、绿=正向、橙=强调、灰=基准"的角色映射保持不变（值随 Nature 色板更新）；
# 新代码请直接使用上面的语义常量。
COLOR_ACCENT  = COLOR_NEGATIVE
COLOR_SAGE    = COLOR_POSITIVE
COLOR_MUSTARD = ACCENT_ORANGE
COLOR_ROCK    = COLOR_BASELINE

# ===== 色图（与身份色同族，保证跨图色彩一致） =====
DIVERGENT_CMAP = LinearSegmentedColormap.from_list(
    'academic_div', [(0.0, COLOR_MAIN), (0.5, NEUTRAL_BG), (1.0, ACCENT_CORAL)])  # 负蓝→浅灰→珊红
SURFACE_CMAP = DIVERGENT_CMAP                        # 发散型曲面/矩阵沿用同一色图
SEQUENTIAL_CMAP = LinearSegmentedColormap.from_list(  # 单极数据与黑白打印变体
    'academic_seq', [(0.0, '#F2F5FA'), (1.0, COLOR_MAIN)])

# ===== 字号与线宽（Nature 版式：小字、细线、多留白） =====
FS_TITLE, FS_LABEL, FS_TICK, FS_LEGEND, FS_ANNOT, FS_PANEL = 10.5, 9.5, 8.5, 8.5, 8.0, 12.0
AX_LINEW, TICK_LEN, TICK_PAD = 0.7, 3.2, 3.0
GRID_LINESTYLE = (0, (4, 3))   # 浅灰细虚线，只保留数值轴方向

# ===== 标准尺寸（A4 版心 16cm ≈ 6.3in；Nature 单栏 89mm ≈ 3.5in） =====
FIG_FULL = (6.3, 4.0)     # 整版宽图（折线、柱状、条形）
FIG_TALL = (6.3, 5.5)     # 双子图竖版（拟合+残差等）
FIG_SQUARE = (5.6, 4.6)   # 近方形（热图、环图、散点方阵、等高线）

# ===== 字体检测回退（按安装情况过滤字体栈，缺字体环境避免静默方框与 findfont 刷屏） =====
_INSTALLED_FONTS = {f.name for f in font_manager.fontManager.ttflist}

def pick_cjk_font(candidates=('Microsoft YaHei', 'SimHei', 'Noto Sans CJK SC', 'WenQuanYi Micro Hei')):
    for name in candidates:
        if name in _INSTALLED_FONTS:
            return name
    warnings.warn('未找到任何中文字体，图中中文将显示为方框！请安装 Microsoft YaHei 或 Noto Sans CJK。')
    return 'sans-serif'

def pick_font_stack(latin=('Arial', 'Helvetica', 'Liberation Sans')):
    """西文候选只保留已安装的，再补 DejaVu Sans 兜底符号与中文字体。"""
    stack = [name for name in latin if name in _INSTALLED_FONTS]
    stack += ['DejaVu Sans', pick_cjk_font()]
    return stack

# ===== 语义取色与标注助手（脚本内不写 hex、不写裸字号，一律调这些） =====
def identity_color(i):
    """按序取身份色：第 0 个恒为主角蓝，其后橙/紫/青/珊红/淡紫，超出循环。"""
    return IDENTITY_PALETTE[i % len(IDENTITY_PALETTE)]

def tint(color, amount=0.35):
    """向白混合以降饱和/体现层级（0 原色，1 纯白）；同族明度阶梯用它，不要另立色板。"""
    r, g, b = to_rgb(color)
    return to_hex((r + (1 - r) * amount, g + (1 - g) * amount, b + (1 - b) * amount))

def delta_annotation(base, value, digits=0):
    """相对基准的有向变化 → (文本, 颜色)：↑绿 ↓红；只用于真正表达增降的场合。"""
    if base == 0:
        return '—', COLOR_BASELINE
    pct = (value - base) / abs(base) * 100
    arrow, color = (('↑', COLOR_POSITIVE) if pct > 0
                    else ('↓', COLOR_NEGATIVE) if pct < 0
                    else ('=', COLOR_BASELINE))
    return f'{arrow}{abs(pct):.{digits}f}%', color

def style_axes(ax, grid='y'):
    """Nature 式坐标框架：去上/右 spine、细轴线外伸刻度、只留单向浅灰细虚线网格（热图例外勿调）。"""
    for side in ('top', 'right'):
        ax.spines[side].set_visible(False)
    for side in ('left', 'bottom'):
        ax.spines[side].set_visible(True)
        ax.spines[side].set_linewidth(AX_LINEW)
        ax.spines[side].set_color(NEUTRAL_DARK)
    ax.tick_params(axis='both', which='both', direction='out', length=TICK_LEN,
                   width=AX_LINEW, color=NEUTRAL_DARK, colors=COLOR_INK,
                   labelsize=FS_TICK, pad=TICK_PAD)
    for axis in (ax.xaxis, ax.yaxis):
        axis.label.set_fontsize(FS_LABEL)
        axis.label.set_color(COLOR_INK)
    if grid in ('x', 'y', 'both'):
        ax.grid(axis=grid, color=NEUTRAL_LIGHT, linewidth=0.6, linestyle=GRID_LINESTYLE)
        ax.set_axisbelow(True)
    return ax

def add_panel_label(ax, label, x=-0.11, y=1.02, fontsize=FS_PANEL):
    """多子图面板标号（粗体小写字母，压在轴框外左上）。"""
    ax.text(x, y, label, transform=ax.transAxes, fontsize=fontsize,
            fontweight='bold', color=COLOR_INK, va='bottom', ha='left')
    return ax

def annotate_bars(ax, bars, fmt='{:.2f}', orient='v', fontsize=FS_ANNOT, color=NEUTRAL_DARK):
    """柱/条端数值标注：偏移按轴范围自适应，负值自动移到下方，小字深灰不抢数据。"""
    lo, hi = (ax.get_ylim() if orient == 'v' else ax.get_xlim())
    step = (hi - lo) * 0.015
    for bar in bars:
        if orient == 'v':
            value, x, y = bar.get_height(), bar.get_x() + bar.get_width() / 2, bar.get_height()
            y += step if value >= 0 else -step
            ax.text(x, y, fmt.format(value), ha='center',
                    va='bottom' if value >= 0 else 'top', fontsize=fontsize, color=color)
        else:
            value = bar.get_width()
            x = value + (step if value >= 0 else -step)
            y = bar.get_y() + bar.get_height() / 2
            ax.text(x, y, fmt.format(value), va='center',
                    ha='left' if value >= 0 else 'right', fontsize=fontsize, color=color)
    return ax

def apply_style():
    # font.family 必须给"列表"：matplotlib 3.6+ 的字形回退只在 family 为多字体列表时逐字体查找，
    # 中文走 CJK 字体、缺的字形（−、₁、² 等）自动落到 DejaVu Sans；写成别名 'sans-serif' 只取
    # 列表第一个可用字体，中文缺字形直接方框。未安装候选由 pick_font_stack 先过滤，免得刷屏警告。
    sns.set_theme(style='ticks', palette=LINE_PALETTE, font_scale=1.0,
                  rc={'axes.axisbelow': True, 'axes.edgecolor': NEUTRAL_DARK,
                      'axes.labelcolor': COLOR_INK, 'axes.spines.top': False,
                      'axes.spines.right': False, 'xtick.color': COLOR_INK,
                      'ytick.color': COLOR_INK, 'figure.frameon': False})
    plt.rcParams.update({          # 覆盖顺序：set_theme 在前，微调在后
        'font.family': pick_font_stack(),
        'axes.unicode_minus': False,
        'svg.fonttype': 'none',    # SVG 里的中文保持可编辑文本
        'pdf.fonttype': 42,        # PDF 嵌 TrueType，便于排版软件编辑
        'figure.dpi': 100,         # 仅影响屏幕交互渲染速度；存图一律 savefig.dpi，与正式版同品质
        'savefig.dpi': 300,        # 输出出版级分辨率（预览与正式同品质）
        'savefig.facecolor': 'white',
        'font.size': FS_LABEL,
        'axes.titlesize': FS_TITLE,
        'axes.titleweight': 'bold',
        'axes.titlecolor': COLOR_INK,
        'axes.titlepad': 10,
        'axes.labelsize': FS_LABEL,
        'axes.linewidth': AX_LINEW,
        'xtick.labelsize': FS_TICK,
        'ytick.labelsize': FS_TICK,
        'xtick.direction': 'out',
        'ytick.direction': 'out',
        'xtick.major.size': TICK_LEN,
        'ytick.major.size': TICK_LEN,
        'legend.fontsize': FS_LEGEND,
        'legend.frameon': False,   # 图例无框；系列 ≤5 时优先直接标注取代图例
        'legend.handlelength': 1.8,
        'legend.borderaxespad': 0.4,
        'lines.markersize': 4.5,
        'patch.linewidth': 0.8,
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

各绘图脚本一律走同一入口（取色取字号只从本模块，脚本内不出现 hex 与裸字号）：

```python
from plot_style import save_fig, style_axes, identity_color, FIG_FULL, COLOR_BASELINE
fig, ax = plt.subplots(figsize=FIG_FULL)
# ... 绘图逻辑：系列取 identity_color(i)，基准/参照取 COLOR_BASELINE ...
style_axes(ax, grid='y')       # 坐标框架统一，禁逐脚本手写 spine/网格/刻度设置
save_fig(fig, '../figures/final/fig2_perf_q1.png', vector=True)
```

#### 高频图表代码模板

> **函数化建议**：正式项目中可将每个模板封装为参数化函数（仅暴露数据/标签/路径参数），统一放入 `code/plot_templates.py` 复用，避免逐次复制改造；样式初始化统一复用 `code/plot_style.py`（见上），模板内勿重复设置 rcParams（参考上方统一绘图工具模块的组织方式）。

**模板1：三维曲面图（定比三维框 + 独立 colorbar）**

```python
from matplotlib.colors import Normalize            # 与 numpy / pyplot 一并 import
from plot_style import (DIVERGENT_CMAP, FS_LABEL, FS_TICK, FS_TITLE, save_fig)
# 冷暖双极（高值珊红/低值主角蓝）；单极数据或黑白打印变体换 SEQUENTIAL_CMAP

S = 1.35   # 大幅面 3D 图（9.2×7.2 in）字号整体放大一档；仍一律由 FS_* 派生，禁裸字号

fig = plt.figure(figsize=(9.2, 7.2))               # 3D 大图需更宽画布，故不用 FIG_FULL
ax = fig.add_axes([0.02, 0.05, 0.78, 0.88], projection='3d')   # 手动留位：右侧空出 colorbar，勿用 add_subplot + colorbar(ax=ax)（会压扁曲面）

norm = Normalize(vmin=Z.min(), vmax=Z.max())      # 色带上下限锁定数据极值，颜色与高度严格对应
surf = ax.plot_surface(X, Y, Z, cmap=DIVERGENT_CMAP, norm=norm,
    linewidth=0, antialiased=True, shade=True, alpha=0.96,
    rstride=1, cstride=1)                         # 大网格提速：rstride=cstride=max(1, Z.shape[0]//80)

ax.set_xlabel('参数 α', fontsize=FS_LABEL * S, labelpad=10)   # 图内标注一律中文（依赖 plot_style 的 CJK 字体回退）
ax.set_ylabel('参数 β', fontsize=FS_LABEL * S, labelpad=10)
ax.set_zlabel('目标值', fontsize=FS_LABEL * S, labelpad=8)
ax.set_xlim(X.min(), X.max()); ax.set_ylim(Y.min(), Y.max()); ax.set_zlim(Z.min(), Z.max())
ax.set_xticks(np.linspace(X.min(), X.max(), 6))   # 刻度手动等分，避免长小数挤占版面
ax.set_yticks(np.linspace(Y.min(), Y.max(), 6))
ax.set_zticks(np.linspace(Z.min(), Z.max(), 5))
ax.tick_params(labelsize=FS_TICK * S, pad=2)      # 刻度字号小于轴标签，密集刻度仍清晰
ax.view_init(elev=31, azim=42)                    # 俯角 31°/方位 42°：起伏与遮挡最平衡
ax.set_box_aspect((1.18, 1.45, 0.72))             # 关键：三维框物理比例独立于数据量程，防曲面压扁/拉长

for axis in (ax.xaxis, ax.yaxis, ax.zaxis):        # 三面透明 + 浅灰描边：去默认灰底，黑白打印仍有层次
    axis.pane.set_facecolor((1, 1, 1, 0))
    axis.pane.set_edgecolor('#d0d0d0')             # 3D 专用描边灰，不套用 2D 的 NEUTRAL_* 体系
ax.grid(True, color=(0.72, 0.72, 0.72, 0.65), linewidth=0.6)

cax = fig.add_axes([0.84, 0.23, 0.028, 0.48])      # 独立 colorbar 轴：窄条 + 半幅高，与曲面互不侵占
cbar = fig.colorbar(surf, cax=cax)
cbar.set_label('目标值', fontsize=FS_LABEL * S, labelpad=10)
cbar.set_ticks(np.linspace(Z.min(), Z.max(), 5))
cbar.ax.tick_params(labelsize=FS_TICK * S)
cbar.outline.set_linewidth(0.75)

ax.set_title('参数响应曲面', fontsize=FS_TITLE * S, pad=18)
save_fig(fig, '../figures/final/fig_3d_surface.png', vector=True, dpi=200)   # 密度类 3D 图按分级策略取 200 DPI
```

**模板2：热力图（带数值标注 + 遮罩上三角）**

```python
from plot_style import DIVERGENT_CMAP, FS_TICK, FS_TITLE, save_fig
# 发散色图：负主角蓝 → 中心浅灰 → 正珊红（禁 jet/rainbow）；黑白打印换 SEQUENTIAL_CMAP

fig, ax = plt.subplots(figsize=(7, 6))             # 近方形版面亦可直接用 FIG_SQUARE
mask = np.triu(np.ones_like(corr_matrix, dtype=bool), k=1)  # 遮罩上三角（不含对角线），更简洁

sns.heatmap(corr_matrix, mask=mask,
    annot=True, fmt='.2f',
    cmap=DIVERGENT_CMAP,
    center=0,                 # 以 0 为中心，正负方向可读
    vmin=-1, vmax=1,
    square=True,
    linewidths=0.6,
    linecolor='white',        # 白色细格线分隔，不用灰线（Nature 分隔口径）
    annot_kws={'fontsize': FS_TICK},   # 格内数值用常规无衬线，禁等宽字体（Consolas 等与全篇不符）
    cbar_kws={'shrink': 0.8, 'label': '相关系数'},
    ax=ax
)
ax.tick_params(length=0)                          # 刻度线归零：热图靠格线定位，刻度是噪声
ax.set_title('参数相关性矩阵', fontsize=FS_TITLE, fontweight='bold', pad=10)
ax.set_xlabel('')                                 # 特征名已在刻度标签给出，勿重复
save_fig(fig, '../figures/final/fig_heatmap.png', dpi=300)   # 小格数值标注需 300 DPI 保清晰
```

**模板3：拟合对比图（含置信带 + 残差子图）**

```python
from plot_style import (COLOR_BASELINE, COLOR_MAIN, FILL_ALPHA, FIG_TALL, FS_ANNOT,
                        FS_LABEL, NEUTRAL_BG, add_panel_label, save_fig, style_axes)

fig, (ax1, ax2) = plt.subplots(2, 1, figsize=FIG_TALL,
    gridspec_kw={'height_ratios': [3, 1], 'hspace': 0.12})

# 上图：拟合曲线 + 置信带（观测灰、模型主角蓝、置信带主角蓝淡填充）
ax1.scatter(x_data, y_data, s=20, c=COLOR_BASELINE, alpha=0.6,
            edgecolors='white', linewidth=0.5, label='观测值', zorder=3)
ax1.plot(x_fit, y_fit, color=COLOR_MAIN, linewidth=2.2, label='拟合曲线', zorder=4)
ax1.fill_between(x_fit, y_lower, y_upper,
    color=COLOR_MAIN, alpha=FILL_ALPHA, label='95% 置信区间', zorder=2)
ax1.text(0.02, 0.95, f'R² = {r2:.3f}   RMSE = {rmse:.3f}   n = {len(y_data)}',
         transform=ax1.transAxes, va='top', fontsize=FS_ANNOT, color=COLOR_BASELINE,
         bbox=dict(facecolor=NEUTRAL_BG, edgecolor='none', pad=2.5))   # 检测量写在图上，正文不再重复公式
ax1.set_ylabel('因变量 y')                        # 纯文本，禁 "$y$" 与中文混排（会变方框）
style_axes(ax1, grid='y'); add_panel_label(ax1, 'a')
ax1.legend(frameon=False, loc='lower right', fontsize=FS_LABEL)

# 下图：残差图（零线取基准灰虚线，±2σ 带用主角蓝淡填充）
residuals = y_data - y_pred
ax2.scatter(x_data, residuals, s=15, c=COLOR_MAIN, alpha=0.7,
            edgecolors='white', linewidth=0.3)
ax2.axhline(y=0, color=COLOR_BASELINE, linewidth=1.2, linestyle='--')
ax2.fill_between(x_data, -2*np.std(residuals), 2*np.std(residuals),
    color=COLOR_BASELINE, alpha=0.08)
ax2.set_xlabel('自变量 x')
ax2.set_ylabel('残差')
style_axes(ax2, grid='y'); add_panel_label(ax2, 'b')

save_fig(fig, '../figures/final/fig_fitting.png', vector=True)
```

**模板4：迭代收敛曲线（种群适应度 + 最优/均值适应度）**

```python
from plot_style import (COLOR_BASELINE, COLOR_MAIN, COLOR_MAIN_PALE, FIG_FULL, FS_ANNOT,
                        delta_annotation, save_fig, style_axes)

fig, ax1 = plt.subplots(figsize=FIG_FULL)

# 所有种群适应度（浅调散点作背景）：>1万点时子采样 + rasterized，兼顾渲染速度与矢量文件体积
sub = slice(None, None, 2)   # 每隔1代采样；点数极大时可改为 None, None, 5
ax1.scatter(generations[sub], all_fitness[sub], s=5, c=COLOR_MAIN_PALE, alpha=0.5,
            label='种群个体', rasterized=True, zorder=2)
# 最优适应度（主证据：主角蓝加粗）
ax1.plot(generations, best_fitness, color=COLOR_MAIN, linewidth=2.2,
         label='最优适应度', zorder=5)
# 均值适应度（支持信息：基准灰虚线）
ax1.plot(generations, mean_fitness, color=COLOR_BASELINE, linewidth=1.5,
         linestyle='--', label='均值适应度', alpha=0.9, zorder=4)

# 收敛代数：相邻代改进不足首代的 0.1% 即视为收敛（全程未收敛则取末代）；累计变化用方向色 + ↑/↓
delta = np.abs(np.diff(best_fitness))
conv_mask = delta < 0.001 * delta[0]
conv = int(np.argmax(conv_mask)) if conv_mask.any() else len(generations) - 1
ax1.axvline(generations[conv], color=COLOR_BASELINE, linewidth=0.8, linestyle=':')
gain, gcolor = delta_annotation(best_fitness[0], best_fitness[-1], digits=1)
ax1.annotate(f'收敛于第 {generations[conv]} 代，累计 {gain}',
             xy=(generations[conv], best_fitness[conv]), xytext=(8, -22),
             textcoords='offset points', fontsize=FS_ANNOT, color=gcolor)

ax1.set_xlabel('迭代代数')
ax1.set_ylabel('适应度值')
style_axes(ax1, grid='y')
ax1.legend(frameon=False, loc='upper right')

save_fig(fig, '../figures/final/fig_convergence.png', vector=True)
```

**模板5：Pareto前沿图（多目标优化）**

```python
from plot_style import (ACCENT_ORANGE, COLOR_BASELINE, COLOR_MAIN, FIG_SQUARE, FS_ANNOT,
                        NEUTRAL_LIGHT, save_fig, style_axes)

fig, ax = plt.subplots(figsize=FIG_SQUARE)

# 候选解浅灰点云（背景），非支配前沿主角蓝白心标记（主证据）
ax.scatter(obj1_all, obj2_all, s=15, c=NEUTRAL_LIGHT, alpha=0.6,
           edgecolors='none', label='候选解', zorder=2)
pareto_sorted = sorted(zip(obj1_pareto, obj2_pareto))
ax.plot([p[0] for p in pareto_sorted], [p[1] for p in pareto_sorted],
    color=COLOR_MAIN, linewidth=2, marker='o', markersize=6,
    markerfacecolor='white', markeredgewidth=1.5,
    label='Pareto 前沿', zorder=4)

# 折中解（离理想点最近，按两目标各自极值等权衡量）用橙色星标；理想投影用基准灰虚线
o1_min = min(p[0] for p in pareto_sorted)
o2_min = min(p[1] for p in pareto_sorted)
knee = min(pareto_sorted, key=lambda p: abs(p[0] - o1_min) + abs(p[1] - o2_min))
ax.scatter(*knee, marker='*', s=220, c=ACCENT_ORANGE, edgecolors='white',
           linewidths=0.8, zorder=6, label='折中解')
ax.axvline(knee[0], color=COLOR_BASELINE, linewidth=0.8, linestyle='--', zorder=1)
ax.axhline(knee[1], color=COLOR_BASELINE, linewidth=0.8, linestyle='--', zorder=1)
ax.annotate(f'折中解 ({knee[0]:.2f}, {knee[1]:.2f})', xy=knee, xytext=(10, -16),
            textcoords='offset points', fontsize=FS_ANNOT, color=ACCENT_ORANGE)

ax.set_xlabel('目标 f1（成本）')                    # 纯文本下标，禁 mathtext 与中文混排
ax.set_ylabel('目标 f2（工期）')
style_axes(ax, grid='both')
ax.legend(frameon=False, loc='upper right')
save_fig(fig, '../figures/final/fig_pareto.png', vector=True)
```

#### 基础图型绘制规范与代码模板（折线/柱状/箱线/环形/条形）

> 高频基础图型的逐项规范，与上方 Nature 配色及 `plot_style.py` 统一样式模块配套：取色只用语义常量，坐标框架一律 `style_axes()`，数值标注一律 `annotate_bars()`；强调黑白打印/色盲场景的明暗区分（纹理仅多组年份等场景可选）。热力图灰度打印变体见本节末注意事项。

**折线图（性能对比、耗时、准确率变化曲线）**

- X/Y 轴**完整标注物理含义 + 单位**（如：检测文件数量、耗时（ms））
- 网格由 `style_axes(ax, grid='y')` 统一给出：只保留数值轴方向浅灰细虚线，纵向网格删除
- 性能对比类**坐标轴起点从 0 开始**（避免视觉误导）
- **主次层级**：主线（本文方法）`COLOR_MAIN` 2.2pt 实线 + 白心标记；对比方法取 `identity_color(i)` 1.5pt；**基准/参照一律 `COLOR_BASELINE` 虚线**；置信带用线条同色 + `FILL_ALPHA`
- 同图曲线 ≤5 条，超过分图；**优先线尾直接标注取代图例**；禁用粗艳丽线条与大面积填充渐变

```python
from plot_style import COLOR_BASELINE, FIG_FULL, FS_ANNOT, identity_color, save_fig, style_axes

fig, ax = plt.subplots(figsize=FIG_FULL)
x = np.array([100, 200, 500, 1000, 2000])                    # 检测文件数量
line_styles = [('-', 'o', 2.2), ('--', 's', 1.5), ('-.', '^', 1.5), (':', 'D', 1.5)]
for i, ((name, y), (ls, mk, lw)) in enumerate(zip(series.items(), line_styles)):
    is_baseline = name.startswith('基准')                     # 参照对象走灰，不占身份色
    color = COLOR_BASELINE if is_baseline else identity_color(i)
    ax.plot(x, y, color=color, linestyle=ls, marker=mk, linewidth=lw,
            markerfacecolor='white', label=name)              # 线型+标记+颜色三重冗余
    ax.text(x[-1], y[-1], f' {name}', color=color, fontsize=FS_ANNOT, va='center')  # 线尾直标
ax.set_xlabel('检测文件数量（个）')
ax.set_ylabel('耗时（ms）')
ax.set_xlim(0, x.max() * 1.3)      # 从 0 起始（性能对比强制）+ 右侧留直接标注位
ax.set_ylim(0, None)
style_axes(ax, grid='y')
save_fig(fig, '../figures/final/fig_line_q1.png', vector=True)
```

**分组柱状图（多方案指标对比）**

- **柱宽统一**，组内柱间距 < 组间间距；**Y 轴必须从 0 起始**
- **单色扁平填充**，无渐变、无立体浮雕；**指标（系列）取身份色 `identity_color(i)`，方案（同族层级）取 `TONE_RAMP` 明度**；基础图表不默认加斜线/圆点纹理（多组年份等确需区分时用透明度或 `HATCH_SEQUENCE`）
- 柱端数值一律走 `annotate_bars()`（`FS_ANNOT` 小字 + `NEUTRAL_DARK`），不手写 `ax.text`
- 对照组相对本文方案的均值增益用 `delta_annotation()` 输出 `↑/↓` + 方向色；误差棒用 `COLOR_INK` + capsize

```python
from plot_style import (FIG_FULL, FS_ANNOT, annotate_bars, delta_annotation,
                        identity_color, save_fig, style_axes)

fig, ax = plt.subplots(figsize=FIG_FULL)
groups = ['方案A', '方案B', '方案C']
metrics = ['准确率', '召回率', 'F1']
data = np.array([[0.92, 0.88, 0.90], [0.85, 0.83, 0.84], [0.88, 0.90, 0.89]])
n_g, n_m = data.shape
bar_w = 0.7 / n_m                      # 柱宽统一；组内柱心距=柱宽 < 组间距 0.3
for i in range(n_m):
    centers = np.arange(n_g) + (i - (n_m - 1) / 2) * bar_w
    bars = ax.bar(centers, data[:, i], width=bar_w,
                  color=identity_color(i),                         # 指标（系列）取身份色
                  edgecolor='white', linewidth=0.8, label=metrics[i])
    annotate_bars(ax, bars, fmt='{:.2f}')                          # 柱端数值统一标注
gain, gcolor = delta_annotation(data[1].mean(), data[0].mean(), digits=1)   # 方案A vs 方案B
ax.text(0.98, 0.96, f'方案A 均值增益 {gain}', transform=ax.transAxes,
        ha='right', va='top', fontsize=FS_ANNOT, color=gcolor)             # 方向色 + ↑/↓
ax.set_xticks(np.arange(n_g)); ax.set_xticklabels(groups)
ax.set_ylim(0, data.max() * 1.12)                              # Y 轴必须从 0 起始
ax.set_ylabel('指标值')
style_axes(ax, grid='y')
ax.legend(frameon=False, ncols=len(metrics), loc='upper center',
          bbox_to_anchor=(0.5, -0.08))                         # 图例移到轴下方，不压数据
save_fig(fig, '../figures/final/fig_bar_q2.png', vector=True)
```

**箱线图（误差/耗时分布、稳定性实验）**

- **白底箱体 + 身份色边框 + 同色 2.2pt 粗中位线**（Nature 口径：箱体不填充主色，避免大面积色块压过中位数）
- 均值用**白心菱形**；个体观测以同色半透明**抖动点全量呈现**（显示每一次观测，不只画摘要）
- 离群点统一**单一基准灰小实心圆**，不额外赋色；须与端帽取 `COLOR_INK`
- 每组箱体尺寸完全一致、均匀排布；网格走 `style_axes(ax, grid='y')`

```python
from plot_style import (COLOR_BASELINE, COLOR_INK, FIG_FULL, identity_color, save_fig,
                        style_axes)

fig, ax = plt.subplots(figsize=FIG_FULL)
rng = np.random.default_rng(0)
data = [rng.normal(20, 3, 50), rng.normal(35, 5, 50), rng.normal(50, 8, 50)]
for i, d in enumerate(data):                                  # 个体观测：同色抖动点全量
    ax.scatter(np.full_like(d, i + 1) + rng.uniform(-0.12, 0.12, len(d)), d,
               s=9, color=identity_color(i), alpha=0.35, edgecolors='none', zorder=2)
bp = ax.boxplot(data, patch_artist=True, widths=0.45, zorder=3,      # 箱体尺寸一致、均匀排布
    boxprops=dict(facecolor='white', linewidth=1.2),                 # 白底箱体（边框逐箱同色）
    medianprops=dict(linewidth=2.2),                                 # 中位线加粗（同上取身份色）
    whiskerprops=dict(color=COLOR_INK, linewidth=1.0),
    capprops=dict(color=COLOR_INK, linewidth=1.0),
    flierprops=dict(marker='o', markersize=4, markerfacecolor=COLOR_BASELINE,
                    markeredgecolor='none', alpha=0.8))              # 离群点单一基准灰
for i, (box, med) in enumerate(zip(bp['boxes'], bp['medians'])):
    box.set_edgecolor(identity_color(i))                             # 边框与中位线同组同色
    med.set_color(identity_color(i))
for i, d in enumerate(data):                                         # 均值：白心菱形
    ax.scatter(i + 1, np.mean(d), marker='D', s=34, facecolor='white',
               edgecolor=identity_color(i), linewidths=1.2, zorder=5)
ax.set_xticks(range(1, len(data) + 1)); ax.set_xticklabels(['模型1', '模型2', '模型3'])
ax.set_ylabel('耗时（ms）')
ax.set_ylim(0, None)
style_axes(ax, grid='y')
save_fig(fig, '../figures/final/fig_box_q3.png', vector=True)
```

**环形图（模块占比，替代饼图；竞赛论文尽量少用）**

- 类别 **≤5 类**，分类过多改用柱状/条形；性能与指标对比优先柱状/折线
- 占比由 **`TONE_RAMP` 同族明度**编码（最大块最深，逐级变浅），分隔线统一**白色 1.2pt**，扁平无立体
- **取消图例**：类别与百分比用引线直接标注在环外；中心留白写总量
- 学术建议：优先柱状/折线，环形图只用于模块占比、资源分配这类构成关系

```python
from plot_style import COLOR_INK, FIG_SQUARE, FS_ANNOT, FS_TITLE, TONE_RAMP, save_fig

fig, ax = plt.subplots(figsize=FIG_SQUARE)
labels = ['特征提取', '模型推理', '数据加载', '其他']       # ≤5 类
sizes = [52, 30, 12, 6]
ranks = np.empty(len(sizes), dtype=int)
ranks[np.argsort(sizes)[::-1]] = np.arange(len(sizes))      # 0 = 最大块 → 明度最深
wedges, _ = ax.pie(sizes, startangle=90, counterclock=False,
    colors=[TONE_RAMP[min(r, len(TONE_RAMP) - 1)] for r in ranks],
    wedgeprops=dict(width=0.38, edgecolor='white', linewidth=1.2))   # width<1 → 真环形（中空），白色分隔无立体
for w, label, value in zip(wedges, labels, sizes):          # 引线直标取代图例
    ang = np.deg2rad((w.theta1 + w.theta2) / 2)
    ax.annotate(f'{label}\n{value:.1f}%', xy=(np.cos(ang) * 0.99, np.sin(ang) * 0.99),
                xytext=(np.cos(ang) * 1.26, np.sin(ang) * 1.26), ha='center', va='center',
                fontsize=FS_ANNOT, color=COLOR_INK,
                arrowprops=dict(arrowstyle='-', color=COLOR_INK, linewidth=0.6))
ax.text(0, 0, f'合计\n{sum(sizes):.0f} s', ha='center', va='center',
        fontsize=FS_TITLE, fontweight='bold', color=COLOR_INK)   # 环心写总量
save_fig(fig, '../figures/final/fig_ring_q4.png', vector=True)
```

**条形图（类别名称较长或排名对比）**

- 长类别名一律用横向条形；**按数值降序排列**，第一名主角蓝、其后逐级走 `TONE_RAMP` 明度（明度即排名）
- 数值轴从 0 起始；条端数值用 `annotate_bars(ax, bars, orient='h')`，不手写 `ax.text`
- 类别标签左对齐（横向天然满足）、条形统一高度；网格走 `style_axes(ax, grid='x')`

```python
from plot_style import FIG_FULL, TONE_RAMP, annotate_bars, save_fig, style_axes

fig, ax = plt.subplots(figsize=FIG_FULL)
cats = ['YOLOv8 检测模型', 'Faster R-CNN 检测模型', 'SSD 检测模型', 'CenterNet 检测模型']
vals = [0.923, 0.874, 0.831, 0.796]
order = np.argsort(vals)[::-1]                              # 降序：第一名置于顶部且颜色最深
cats = [cats[i] for i in order]; vals = [vals[i] for i in order]
bars = ax.barh(np.arange(len(cats)), vals, height=0.6,
               color=[TONE_RAMP[min(r, len(TONE_RAMP) - 1)] for r in range(len(vals))],
               edgecolor='white', linewidth=0.8)
ax.set_yticks(np.arange(len(cats))); ax.set_yticklabels(cats)
ax.invert_yaxis()
annotate_bars(ax, bars, fmt='{:.3f}', orient='h')            # 条端数值统一标注
ax.set_xlim(0, max(vals) * 1.12)                              # 数值轴从 0 起始
ax.set_xlabel('mAP@0.5')
style_axes(ax, grid='x')
save_fig(fig, '../figures/final/fig_hbar_q5.png', vector=True)
```

**热力图灰度打印变体**：需黑白打印的场景（如附录矩阵图），把模板2 的发散色图 `DIVERGENT_CMAP` 换成 `SEQUENTIAL_CMAP`（浅→主角蓝单色顺序系），格线仍保持白色 `linewidths=0.6, linecolor='white'`，并在 `cbar_kws` 里标注数值区间；层级差异改由明度承担，灰度打印仍可读。

#### 流程图专项规范与代码模板（第二章问题分析图 / 开发流程 / 系统架构图）

> **第二章问题分析必须插入**问题分析图（流程图/技术路线/系统架构图），遵循以下专项规范。
>
> **本 skill 唯一内置版式 = 总分布局问题分析图**（内容 dict 驱动 + 自动正交连线 + 出图前中文字宽门禁）：模块与连线只描述"是什么关系"，坐标由程序算，改一个模块不必重画全部连接线。其余大版式见本节末「其余版式」表，按需另画。

**布局逻辑**

- **串行流程**：自上而下排列
- **多并行分支**：均分多列、严格对齐（各列模块宽度、高度、水平位置一致）
- **总分结构**：顶层居中、底层收拢（顶层一个总模块 → 中间多个并行模块 → 底层合并输出）
- **连接线**：从模块侧边中点进出，正交折线（先垂后平），**严禁箭头交叉、横穿模块**

**图形样式**

- 统一**圆角 3–5pt 扁平化方框**（`FancyBboxPatch` + `round,rounding_size`），无直角、无立体效果
- 区分模块类型（学术低饱和“工程美学”；**示意图专用色板，与 `plot_style.py` 的数据图色板相互独立**）：
  - **核心算法/处理单元**：填充浅蓝 `#D6E4F0`，边框学术蓝 `#4C72B0`（加深边框突出）
  - **配置 / skill 文件等辅助模块**：填充极淡灰 `#F5F5F5`，边框岩石灰 `#8E9AAF` 虚线
  - **输出成果**：填充浅灰蓝 `#EBF2FA`，边框学术蓝 `#4C72B0`
- 框内文字统一**炭墨黑 `#2F353B`** 居中，字号 ≥9pt；行数过多时拆分为多个模块

**箭头规范**

- **主流程**：炭墨黑实线箭头（`color='#2F353B'`, `linestyle='-'`），直角折线
- **次要数据流**（反馈、回传、参数传递）：岩石灰虚线箭头（`color='#8E9AAF'`, `linestyle='--'`）

**图标优化（提升高级感）**

- 模块内可内嵌**简约单色线性矢量图标**（芯片、文档、终端、界面、报表），与模块文字同色、置于文字上方
- 禁用卡通 3D 图标、彩色 emoji；保持单色线性风格

**容量预算（出图前必算，非事后补救）**

- 图内文字一律中文（见「全局视觉统一 · 图内文字语言」）；宽度口径：**汉字 ≈ 字号 px、半角字符（字母/数字/空格）≈ 字号/2、行高 ≈ 字号 + 3**
- 每行汉字数 ≤ `(盒宽 − 8) // 字号`，总行数 ≤ `(盒高 − 8 − 22×有图标) // (字号 + 3)`；用 `\n` 手动断行，**禁止依赖自动折行**
- 字号 ≥12.5 px（≈9 pt 红线）；行数放不下就**拆模块**，而不是缩字号硬塞
- 下方模板在写文件前逐槽校验，超框即报「槽位 + 需宽 + 可用宽 + 每行汉字数」并终止出图（`SystemExit(2)`）——不允许产出压字的图

**连线纪律**

- 端点离盒边 1 px（紧贴边线视觉上像被框吞掉）；进出点一律取四边中点，由 `from_side`/`to_side` 指定，默认「下出上入」
- 一分多 / 多合一画成**竖线 + 横母线 + 分支**（同组分支共用一条汇流横线即自动成母线），禁止画成 N 条独立斜线
- **严禁斜线直连与横穿模块**；有遮挡风险时用 `via` 给中间拐点手动绕行

```python
# ===== 问题分析流程图 / 系统架构图模板（第二章问题分析图，内容 dict 驱动） =====
# 画布口径：1 px = 0.01 inch，y 轴向下（越靠下 y 越大），与字宽预算同一单位
from math import hypot
import unicodedata
import matplotlib
matplotlib.use('Agg')
from matplotlib.figure import Figure
from matplotlib.patches import FancyBboxPatch, Polygon
from plot_style import save_fig          # 统一保存入口；中文字体已由其探测配置

FS, ICON_H, RADIUS = 16, 22, 5           # 字号 / 图标行占位 / 圆角（px）；16 px ≈ 11.5 pt
TXT, GREY, DASH = '#2F353B', '#8E9AAF', (0, (3, 3))
STYLE = {'algo':   dict(fill='#D6E4F0', stroke='#4C72B0', ls='solid'),   # 核心算法/处理单元
         'config': dict(fill='#F5F5F5', stroke=GREY, ls=DASH),           # 配置/数据/辅助
         'output': dict(fill='#EBF2FA', stroke='#4C72B0', ls='solid')}   # 输出成果

def text_width(s, fs=FS):
    """一行文字的像素宽：汉字/全角 = 字号，半角 = 字号/2 —— 超框判断的唯一依据"""
    return sum(fs if unicodedata.east_asian_width(c) in 'WF' else fs / 2 for c in str(s))

def lines_of(v):
    return [''] if v is None else ([str(x) for x in v] if isinstance(v, (list, tuple))
                                   else str(v).split('\n'))

def check_module(m, fs, W, H, problems):
    """出图前门禁：宽度/高度/越界三类逐槽记录，攒够一起报，免得改一处跑一次"""
    ls = lines_of(m['text'])
    for ln in ls:
        need = text_width(ln, fs)
        if need > m['w'] - 8:
            problems.append(f"{m['id']}.text：「{ln[:10]}…」需 {need:.0f}px > 可用 {m['w']-8:.0f}px"
                            f"（每行 ≤{int((m['w']-8)//fs)} 汉字）")
    hneed = len(ls) * (fs + 3) + (ICON_H if m.get('icon') else 0) + 8
    if hneed > m['h']:
        problems.append(f"{m['id']}.text：{len(ls)} 行需高 {hneed:.0f}px > 盒高 {m['h']:g}px")
    if m['x'] < 0 or m['y'] < 0 or m['x'] + m['w'] > W or m['y'] + m['h'] > H:
        problems.append(f"{m['id']}：越出画布 {W:g}×{H:g}")

def setup_canvas(w, h):
    fig = Figure(figsize=(w / 100, h / 100), dpi=100)
    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_xlim(0, w); ax.set_ylim(h, 0); ax.axis('off')     # y 轴向下
    return fig, ax

def draw_box(ax, m, fs):
    """圆角扁盒 + 居中多行文字（可选单色线性图标行）；配色只由 kind 决定，勿逐盒手写"""
    s = STYLE[m['kind']]
    r = min(RADIUS, m['w'] / 2, m['h'] / 2)
    ax.add_patch(FancyBboxPatch((m['x'], m['y']), m['w'], m['h'],
        boxstyle=f'round,pad=0,rounding_size={r}', linewidth=1.2,
        edgecolor=s['stroke'], linestyle=s['ls'], facecolor=s['fill'], zorder=2))
    top, box_h = m['y'], m['h']
    if m.get('icon'):
        ax.text(m['x'] + m['w']/2, m['y'] + 4 + ICON_H/2, m['icon'], ha='center',
                va='center', fontsize=fs + 2, color=TXT, zorder=3)
        top, box_h = m['y'] + ICON_H, m['h'] - ICON_H - 4
    ax.text(m['x'] + m['w']/2, top + box_h/2, '\n'.join(lines_of(m['text'])),
            ha='center', va='center', fontsize=fs, color=TXT, fontweight='bold',
            linespacing=(fs + 3) / fs, zorder=3)

def anchor(m, side):
    """出/入锚点 = 该边中点外移 1 px（端点压在框线上，视觉上像被框吞掉）"""
    cx, cy = m['x'] + m['w']/2, m['y'] + m['h']/2
    return {'top': (cx, m['y']-1), 'bottom': (cx, m['y']+m['h']+1),
            'left': (m['x']-1, cy), 'right': (m['x']+m['w']+1, cy)}[side]

def route(p0, s0, p1, s1, via=None):
    """两点 + 出入方向 → 正交折线：垂出垂入走「垂-平-垂」，同列直连；via 非空则全接管"""
    if via:
        return [p0] + [(float(a), float(b)) for a, b in via] + [p1]
    x0, y0 = p0; x1, y1 = p1
    v0, v1 = s0 in ('top', 'bottom'), s1 in ('top', 'bottom')
    if v0 and v1:
        return [p0, p1] if abs(x0-x1) < 0.5 else [p0, (x0, (y0+y1)/2), (x1, (y0+y1)/2), p1]
    if not v0 and not v1:
        return [p0, p1] if abs(y0-y1) < 0.5 else [p0, ((x0+x1)/2, y0), ((x0+x1)/2, y1), p1]
    return [p0, (x0, y1), p1] if v0 else [p0, (x1, y0), p1]

def arrow_head(ax, p_from, p_to, size, color):
    dx, dy = p_to[0] - p_from[0], p_to[1] - p_from[1]
    n = hypot(dx, dy)
    if n == 0:
        return
    ux, uy = dx/n, dy/n
    L, hw = max(size, 1.6), 0.45 * size
    bx, by = p_to[0] - ux*L, p_to[1] - uy*L
    ax.add_patch(Polygon([(bx-uy*hw, by+ux*hw), p_to, (bx+uy*hw, by-ux*hw)], closed=True,
        facecolor=color, edgecolor=color, linewidth=0.6, joinstyle='miter', zorder=6.5))

def draw_edge(ax, m0, m1, primary=True, s0='bottom', s1='top', via=None):
    """主流程=炭墨实线，次要数据流=岩石灰虚线；整条折线一次 plot，虚线节奏才连续"""
    pts = route(anchor(m0, s0), s0, anchor(m1, s1), s1, via)
    color, ls = (TXT, 'solid') if primary else (GREY, DASH)
    ax.plot([p[0] for p in pts], [p[1] for p in pts], color=color, linewidth=1.2,
            linestyle=ls, zorder=6, solid_capstyle='butt')
    arrow_head(ax, pts[-2], pts[-1], 6, color)

# ---- 内容源：只写"有哪些模块、谁指向谁"，折线坐标交给 route 自动算 ----
CONTENT = {
    'canvas': {'w': 800, 'h': 650}, 'font_size': FS, 'title': '问题分析流程图',
    'modules': [   # x/y 为盒左上角；并行分支同宽同高、列位均分（此例两列 x=80/440，宽 280）
        {'id': 'prep',   'text': '数据预处理',             'kind': 'config', 'x': 250, 'y': 56,  'w': 300, 'h': 70},
        {'id': 'algo_a', 'text': '算法模块A\n（子问题一）', 'kind': 'algo',   'x': 80,  'y': 250, 'w': 280, 'h': 110},
        {'id': 'algo_b', 'text': '算法模块B\n（子问题二）', 'kind': 'algo',   'x': 440, 'y': 250, 'w': 280, 'h': 110},
        {'id': 'out',    'text': '结果输出',               'kind': 'output', 'x': 250, 'y': 470, 'w': 300, 'h': 70},
    ],
    'edges': [     # 默认「下出上入」；一分多/多合一共用中线 → 自动成竖线+横母线+分支
        {'from': 'prep', 'to': 'algo_a'}, {'from': 'prep', 'to': 'algo_b'},
        {'from': 'algo_a', 'to': 'out'},  {'from': 'algo_b', 'to': 'out'},
        {'from': 'out', 'to': 'algo_b', 'primary': False,        # 参数反馈：右侧绕行虚线
         'from_side': 'right', 'to_side': 'right', 'via': [[780, 505], [780, 305]]},
    ],
}

def render(content):
    W, H = content['canvas']['w'], content['canvas']['h']
    fs = float(content.get('font_size', FS))
    mods = {m['id']: m for m in content['modules']}
    problems = []
    for m in mods.values():
        check_module(m, fs, W, H, problems)
    if problems:                        # 门禁：超框就不出图，改文案或加大盒子后重跑
        print(f'✗ 容量检查未通过（{len(problems)} 处超框）：')
        for p in problems:
            print('  -', p)
        raise SystemExit(2)
    fig, ax = setup_canvas(W, H)
    for m in mods.values():
        draw_box(ax, m, fs)
    for e in content['edges']:
        draw_edge(ax, mods[e['from']], mods[e['to']], e.get('primary', True),
                  e.get('from_side', 'bottom'), e.get('to_side', 'top'), e.get('via'))
    if content.get('title'):
        ax.text(W/2, fs + 8, content['title'], ha='center', va='center',
                fontsize=fs, color=TXT, fontweight='bold')
    return fig

save_fig(render(CONTENT), '../figures/final/fig1_flow_q_overview.png', vector=True)  # PNG 300DPI + 矢量 PDF
```

**其余版式（按需另画，本 skill 不内置代码）**

| 版式 | 何时改用 | 一句话要点 |
| :--- | :--- | :--- |
| 五带技术路线图 | 想用一张图承载全文脉络：破题 → 数据与指标 → 方法与机制 → 结果对比 → 评价推广 | 竖版五带 + 左旗标右竖排标签；带序即叙事序，语义放错比超框严重 |
| 三栏研究框架图 | 展示"每个阶段做哪些研究内容、各用什么方法"的内容全景 | 左阶段链 / 中内容块 / 右方法清单，高度自适应 |
| 三栏阶段流程图 | 强调执行流程推进、决策分支与成果分发 | 中栏实色标题条 + 每块独立色系 |
| 横版任务流水线图 | 课题拆成任务一…任务四、每步挂做法细节，或答辩用 16:9 整页 | 横版多任务块，块内步骤流水线 |

四者沿用同一套圆角扁盒、三类模块配色与正交连线纪律；若已安装 `mathmodel-diagram` 技能可直接套其模板，否则按本节规范用同一批基元手画。竖版大画布（宽 ≥900 px）压到 A4 单栏会掉到 7 pt 以下，须整页横排或另做精简版。

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

**11. PDF 书签与跨页空白**：

- PDF 添加书签目录（加载 `hyperref` 后章节标题自动生成书签），方便评阅人跳转查阅
- 避免段末与下一页之间出现大片空白（通过图表位置或文字长度调整）

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
- 算法介绍结合本题问题的结构与数据特点，无通用模板式介绍文字；关键超参选取逻辑正文已阐释
- 题目明确要求的基线/对照已逐项完成

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
- 多组图形按 Nature 三职责取色（身份色 + `TONE_RAMP` 明度/透明度区分），灰度打印可辨识（不默认斜线/圆点纹理）
- 图内文字（标题/轴标签/图例/colorbar/注解）语言统一：未特别要求时全为中文，无中英混排（明确要求全英文时除外）
- 图内无 mathtext 与中文混排（`"问题规模 $n$（个）"` 会让中文渲染成方框，须写纯文本 `"问题规模 n（个）"`）
- 基准/参照线为灰色（`COLOR_BASELINE`），方向色（红/绿）只出现在有正负的变化量上且同时带 `↑/↓` 或正负号
- 同一方法在全文各图颜色一致（按画图前登记的方法-颜色对照取色，模板图与现绘图同色）
- 灰度打印下各系列仍可区分（不得仅靠红绿区分系列；主次层级由 `TONE_RAMP` 明度承担）

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
- 已做与问题类型匹配的稳健性/敏感性检验（扰动对象为参数/权重/样本/初值等），关键结论在合理扰动下稳定
- 预测类含多维度误差拆解；结果注入下游决策时含误差传导分析
- 多目标含全域 Pareto 与折中方案依据；优化类含最优性间隙或精确法对照

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
| 题目明确要求的基线/对照缺失 | -5 |
| 解集/最优性论证不足（多目标仅靠人为权重集无全域 Pareto；优化缺最优性间隙或精确法对照） | -3 |
| 算法介绍通用模板化、未结合问题，超参选取逻辑未阐释 | -4 |
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

**5. 排版（15分）**

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
| PDF 无书签，或段末跨页空白较大 | -1 |

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
| 图片中文显示方框  | 缺字体环境由 `pick_cjk_font` 检测回退，安装 Microsoft YaHei / SimHei / Noto Sans CJK |
| 折线图曲线过多难区分 | 同图≤5条，线型+标记区分，超限分图         |
| 性能对比图Y轴不从0起 | 强制 `ax.set_ylim(0, ...)`，避免视觉误导    |
| 黑白打印分不清组别 | 身份色 + `TONE_RAMP` 明度/透明度区分；多组年份可用横线/竖线纹理 |
| 文字超出纸张    | 使用 seqsplit，tabularx，[H]定位         |
| caption报错 | 使用 font=small，禁止 font={font=10.5pt} |
| 假设用列表非表格   | 改用 tabular 三线表，表题在上方，含合理性说明        |
| 假设表格显示不全   | `tabular`的`l`列不换行，改用`tabularx`的`X`列  |
| 正文AI痕迹过重（模板腔/套话/衔接生硬） | 见第3章"正文语言表述规范"：直入主题、衔接句带信息量、结论个性化 |
| Word中公式显示为普通文本/乱码 | 用 pandoc 从 paper.tex 生成 .docx，公式自动转 OMML 原生数学格式 |
| 公式过度堆砌/检测量公式重复列式 | 见第3章"公式使用规范"：推导从简、检测量公式仅首次定义 |



