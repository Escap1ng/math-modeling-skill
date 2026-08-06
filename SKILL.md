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

### 阶段一：赛题分析与背景调研

**不输出给用户**，仅作为建模依据：

0. **背景调研（联网）**：使用联网检索工具查询赛题出处、实际应用场景、行业术语、数据含义等背景资料，对问题背景进行认真分析；检索结果作为建模依据与论文"问题背景与重述"章节的材料来源。
1. **问题本质**：核心问题是什么？属于哪类问题（优化/预测/评价/分类/微分方程）？
2. **已知条件**：可用数据、约束条件（资源/时间/物理）
3. **输出目标**：每个子问题需要什么形式的结果（数值/曲线/方案/排序）
4. **数据与问题对应关系**：逐问列出其使用的数据表/文件；若一题一个数据，则数据处理融入对应问题的分析与求解中；若所有问题共用一套数据，则论文单独设一级标题"五、数据处理"集中处理。

### 阶段二：工作目录创建

```bash
第X题_赛题简称/
├── code/          # Python代码（按问题编号：q1_*.py, q2_*.py）
├── figures/       # 可视化图表（fig1.png, fig2.png，≥300 DPI）
└── paper/         # 论文（paper.tex + paper.pdf + paper.docx）
```

### 阶段三：算法选择（内部推理，不输出）

**不输出给用户**，仅在内部完成并择优：

1. **候选算法生成**：针对每个小问，结合问题类型、数据规模、约束条件，从算法库中筛选 2–3 种可行算法（至少 1 种具有明显创新性）。
2. **内部比对**：从求解精度、计算复杂度、鲁棒性、可解释性、实现可行性五个维度，对候选算法进行量化或定性评估。
3. **择优决策**：选择综合质量更优的算法作为本问的求解方案，直接进入阶段四的代码实现与论文写作。

**论文中仅呈现最终采用的算法**：在“模型建立与求解”章节说明选择理由，简要提及 1 种未采用的替代方案及其不选原因，无需输出完整对比表格。

**要求**：

- 至少 1 个候选算法具有明显创新性（可引入交叉学科方法）
- 最终方案的数学描述使用学术语态，公式独立呈现
- 形成逻辑闭环，控制字数

### 阶段四：代码实现

**技术栈优先级**：

1. Python（numpy, scipy, pandas, matplotlib, seaborn）
2. 优化建模（pulp, cvxpy, scipy.optimize）
3. 机器学习（scikit-learn, xgboost）
4. 数据读取（PyMuPDF, openpyxl, pandas）

**代码规范**：

- 完整可运行，保存至 `code/` 文件夹
- 使用 numpy 向量化操作
- 关键参数通过注释说明
- 输出清晰的结果摘要
- 可视化保存至 `figures/`，学术风格，≥300 DPI

### 阶段五：论文输出

**输出物（必须同时生成 PDF 与 Word）**：

- `.tex` 源文件 + `.pdf` 成品论文
- `.docx` Word 文档
- 存放至 `paper/` 文件夹
- 图片路径使用相对路径 `../figures/figX.png`

**生成命令（PDF 与 Word 均需执行）**：

```bash
# 1. 生成 PDF
cd paper
xelatex -interaction=nonstopmode paper.tex
xelatex -interaction=nonstopmode paper.tex

# 2. 生成 Word
cd ../code
python generate_word.py
```

**技术栈**：

- LaTeX：xelatex 编译
- Word：python-docx 库（需安装：`pip install python-docx`）

### 阶段六：论文评分与优化（强制执行）

论文生成后，**必须**按百分制评分体系进行量化评估。低于 85 分须针对性优化后重新评分，**≥85 分方可最终输出**。

**评分流程**：

1. 逐项打分并记录扣分理由
2. 汇总总分，判定是否达标
3. 若 $S < 85$：列出具体扣分项 -> 针对性修改 -> 重新评分，循环直至达标
4. 若 $S \geq 85$：输出最终论文，附评分表

***

## 核心能力

### 1. 算法库（精选高频+前沿）

#### 经典优化（获奖论文高频）

**精确求解**：

- 0-1整数规划、非线性规划、动态规划、分支定界法、线性规划（LP）、匈牙利算法（指派问题）

**启发式优化**：

- 遗传算法（GA）：自适应交叉变异、精英保留
- 模拟退火（SA）：多起点退火、自适应冷却
- 粒子群（PSO）：混沌初始化、动态惯性权重
- 禁忌搜索（TS）：禁忌表记忆、邻域搜索增强

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

#### 综合评价与多属性决策（评价/排序类问题首选）

**TOPSIS（逼近理想解排序法，首选）**：与熵权法搭配为熵权-TOPSIS，获奖论文高频，适用于"对多个方案/对象综合评价并排序"类问题
**权重确定**：熵权法（客观权重）、CRITIC权重法（客观权重）、层次分析法 AHP（主观权重）
**综合评价**：灰色关联分析、模糊综合评价
**效率评价**：数据包络分析（DEA）

#### 物理与工程建模

**运动动力学**：运动学模型、拉格朗日力学、有限元分析、刚体动力学
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
# 关键参数（基于获奖论文）
POP_SIZE = 120          # 种群规模：100-200
MAX_GEN = 150           # 最大迭代：100-200
CROSS_RATE = 0.85       # 交叉率：0.8-0.9
MUT_RATE = 0.12         # 变异率：0.1-0.15
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

#### 预剪枝策略（获奖论文高频）

**核心思想**：在枚举/搜索前，通过约束分析和启发式规则剔除明显不优的方案，压缩搜索空间。

**实施步骤**：

1. **约束分析**：根据资源总量约束$10x+5y+2z=N$，确定各变量取值范围
2. **启发式规则**：避开惩罚值（如某类切片为0必受惩罚），限定$x,y,z \geq 1$
3. **贪心压缩**：使资源块分配尽量占满（靠近N），减少剩余资源
4. **模拟筛选**：对初始方案进行单次实验，删除得分低于基准线的方案

**复杂度降低效果**：

- 原始：$O(M^N)$（M=方案数，N=周期数）
- 预剪枝后：$O(K \cdot N)$（K=剪枝后方案数，通常K≤6）

```python
def pre_pruning(total_rb, rb_per_slice):
    """预剪枝生成可行方案"""
    schemes = []
    for x in range(1, total_rb // rb_per_slice[0] + 1):
        for y in range(1, (total_rb - x*rb_per_slice[0]) // rb_per_slice[1] + 1):
            z = (total_rb - x*rb_per_slice[0] - y*rb_per_slice[1]) // rb_per_slice[2]
            if z >= 1:
                schemes.append((x, y, z))
    return schemes
```

#### 系统化实验设计（获奖论文核心方法）

**适用场景**：多周期决策问题，需从K种方案中选择N个周期的最优组合。

**实施步骤**：

1. **单方案实验**：对每种基础方案连续执行N次，记录得分
2. **方案筛选**：删除得分最低的方案（如负分方案）
3. **组合实验**：将剩余方案两两组合，进行模拟实验
4. **变异验证**：对最优解进行单点变异，遍历验证

```python
def systematic_experiments(schemes, n_periods, simulator):
    """系统化实验设计"""
    # Step1: 单方案实验
    scores = []
    for s in schemes:
        score = simulator.run([s] * n_periods)
        scores.append((s, score))
    # Step2: 删除劣方案
    valid = [s for s, sc in scores if sc > 0]
    if not valid:  # 边界保护：全部被淘汰则保留最优方案
        valid = [max(scores, key=lambda x: x[1])[0]]
    # Step3: 组合实验
    best_score = -1e9
    best_scheme = [valid[0]] * n_periods  # 默认方案
    for i in range(len(valid)):
        for j in range(i+1, len(valid)):
            for k in range(n_periods+1):
                combo = [valid[i]]*k + [valid[j]]*(n_periods-k)
                sc = simulator.run(combo)
                if sc > best_score:
                    best_score = sc
                    best_scheme = combo
    # Step4: 变异验证——对最优解单点变异，遍历验证
    for pos in range(n_periods):
        for s in valid:
            if best_scheme[pos] != s:
                mutant = best_scheme.copy()
                mutant[pos] = s
                sc = simulator.run(mutant)
                if sc > best_score:
                    best_score = sc
                    best_scheme = mutant
    return best_scheme, best_score
```

#### 遗传算法交叉验证（获奖论文标准流程）

**适用场景**：验证启发式求解结果的全局最优性。

**流程**：

1. 以预剪枝后的方案作为基因库
2. 随机生成初始种群（每个个体为N周期决策序列）
3. 选择（前20%）+ 交叉（单点）+ 变异（10%概率）
4. 迭代50代，验证收敛性

```python
import random

def ga_cross_validate(gene_pool, n_periods, simulator,
                      pop_size=50, n_gen=50, mut_rate=0.1):
    """遗传算法交叉验证"""
    pop = [random.choices(gene_pool, k=n_periods) for _ in range(pop_size)]
    for gen in range(n_gen):
        fitness = [simulator.run(ind) for ind in pop]
        # 精英保留
        elite = sorted(zip(pop, fitness), key=lambda x: -x[1])[:pop_size//5]
        # 交叉变异
        new_pop = [e[0] for e in elite]
        while len(new_pop) < pop_size:
            p1, p2 = random.sample([e[0] for e in elite], 2)
            point = random.randint(0, n_periods-1)
            child = p1[:point] + p2[point:]
            if random.random() < mut_rate:
                idx = random.randint(0, n_periods-1)
                child[idx] = random.choice(gene_pool)
            new_pop.append(child)
        pop = new_pop
    # 重新计算最终种群适应度（修复：原fitness对应旧种群）
    fitness = [simulator.run(ind) for ind in pop]
    return max(zip(pop, fitness), key=lambda x: x[1])
```

#### 迁移适宜度指标（异构网络创新方法）

**适用场景**：异构网络中用户从微基站迁移到宏基站的决策。

```python
def migration_suitability(user, src_bs, macro_bs, bs_data, alpha=0.5):
    """
    迁移适宜度 = α * 基站剩余资源标准化 + (1-α) * 速率增益比标准化
    注意：min_res/max_res/min_gain/max_gain 需在调用前基于全局基站数据预计算
          calc_rate 需根据具体赛题的信道模型定义
    """
    # 基站剩余资源标准化
    res_rem = bs_data[src_bs]['remaining_rb'] / bs_data[src_bs]['total_rb']
    res_norm = (res_rem - min_res) / (max_res - min_res + 1e-6)
    # 速率增益比
    r_macro = calc_rate(macro_bs, user)
    r_src = calc_rate(src_bs, user)
    gain = r_macro / (r_src + 1e-6)
    gain_norm = (gain - min_gain) / (max_gain - min_gain + 1e-6)
    # 加权
    return alpha * res_norm + (1 - alpha) * gain_norm
```

#### 跨周期优化（动态调度创新方法）

**适用场景**：mMTC等高时延容忍任务的跨周期调度。

```python
def cross_period_optimization(queues, n_periods, delay_sla=500e-3):
    """跨周期任务延续机制"""
    for user, tasks in queues.items():
        for task in tasks:
            # 允许未完成任务延续至后续周期
            if task.waiting_time < delay_sla:
                task.carry_over = True  # 标记为跨周期任务
    # 终态统计法：n_periods周期结束后统一计算QoS
    total_qos = sum(calc_qos(task) for tasks in queues.values() for task in tasks)
    return total_qos

# 注意：calc_qos 需根据具体赛题定义，n_periods 为总周期数
```

#### QoS累加计算规范（基于优秀论文）

**核心原则**：系统总QoS = 所有用户所有任务得分之和（非均值）

```python
def calc_total_qos_sum(urllc_qoss, embb_qoss, mmtc_qoss):
    """
    正确的QoS累加计算（非均值）
    系统总QoS = sum(所有URLLC用户得分) + sum(所有eMBB用户得分) + sum(所有mMTC用户得分)
    """
    total = sum(urllc_qoss) + sum(embb_qoss) + sum(mmtc_qoss)
    return total

# 错误做法（均值求和）：
# total = np.mean(urllc_qoss) + np.mean(embb_qoss) + np.mean(mmtc_qoss)

# 多周期场景：
# 总QoS = sum(所有周期所有用户得分)
```

**关键区别**：

- ❌ 错误：`np.mean(qoss_u) + np.mean(qoss_e) + np.mean(qoss_m)`
- ✅ 正确：`sum(qoss_u) + sum(qoss_e) + sum(qoss_m)`

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
    """使用 pandas 读取 Excel"""
    return pd.read_excel(file_path, engine='openpyxl')
```

#### Word文档生成模块（python-docx）

```python
from docx import Document
from docx.shared import Pt, Cm, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_CELL_VERTICAL_ALIGNMENT
from docx.oxml.ns import qn

def create_word_paper():
    """创建符合国赛格式的Word文档"""
    doc = Document()
    
    # 页面设置：A4，页边距2.5cm
    section = doc.sections[0]
    section.page_width = Cm(21.0)
    section.page_height = Cm(29.7)
    section.top_margin = Cm(2.5)
    section.bottom_margin = Cm(2.5)
    section.left_margin = Cm(2.5)
    section.right_margin = Cm(2.5)
    
    # 论文题目：三号黑体居中
    title = doc.add_paragraph()
    title.alignment = WD_ALIGN_PARAGRAPH.CENTER
    run = title.add_run('论文题目')
    run.font.name = '黑体'
    run._element.rPr.rFonts.set(qn('w:eastAsia'), '黑体')
    run.font.size = Pt(16)  # 三号
    run.bold = True
    
    # 摘要标签：四号黑体
    abstract_label = doc.add_paragraph()
    run = abstract_label.add_run('摘要：')
    run.font.name = '黑体'
    run._element.rPr.rFonts.set(qn('w:eastAsia'), '黑体')
    run.font.size = Pt(14)  # 四号
    run.bold = True
    
    # 摘要正文：小四宋体，1倍行距
    abstract = doc.add_paragraph()
    abstract.paragraph_format.line_spacing = 1
    abstract.paragraph_format.first_line_indent = Cm(0.74)  # 2字符
    run = abstract.add_run('本文针对[问题描述]...')
    run.font.name = '宋体'
    run._element.rPr.rFonts.set(qn('w:eastAsia'), '宋体')
    run.font.size = Pt(12)  # 小四
    
    # 关键词
    keywords = doc.add_paragraph()
    run = keywords.add_run('关键词：')
    run.bold = True
    run.font.name = '宋体'
    run._element.rPr.rFonts.set(qn('w:eastAsia'), '宋体')
    run.font.size = Pt(12)
    run = keywords.add_run('关键词1；关键词2；关键词3')
    run.font.name = '宋体'
    run._element.rPr.rFonts.set(qn('w:eastAsia'), '宋体')
    run.font.size = Pt(12)
    
    # 分页
    doc.add_page_break()
    
    # 一级标题：四号黑体居中
    section1 = doc.add_paragraph()
    section1.alignment = WD_ALIGN_PARAGRAPH.CENTER
    run = section1.add_run('一、问题背景与重述')
    run.font.name = '黑体'
    run._element.rPr.rFonts.set(qn('w:eastAsia'), '黑体')
    run.font.size = Pt(14)  # 四号
    run.bold = True
    
    # 正文段落：小四宋体，1倍行距
    body = doc.add_paragraph()
    body.paragraph_format.line_spacing = 1
    body.paragraph_format.first_line_indent = Cm(0.74)
    run = body.add_run('正文内容...')
    run.font.name = '宋体'
    run._element.rPr.rFonts.set(qn('w:eastAsia'), '宋体')
    run.font.size = Pt(12)
    
    # 三线表示例：文字上下左右均居中
    from docx.oxml import OxmlElement

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
            header_row = table.rows[0]
            for cell in header_row.cells:
                tcPr = cell._tc.get_or_add_tcPr()
                cell_borders = OxmlElement('w:tcBorders')
                btm = OxmlElement('w:bottom')
                btm.set(qn('w:val'), 'single')
                btm.set(qn('w:sz'), '4')
                btm.set(qn('w:space'), '0')
                btm.set(qn('w:color'), '000000')
                cell_borders.append(btm)
                tcPr.append(cell_borders)

    def set_cell_center(cell, text, font_name='宋体', font_size=Pt(12)):
        """设置单元格文字上下左右居中"""
        cell.text = ''
        p = cell.paragraphs[0]
        p.alignment = WD_ALIGN_PARAGRAPH.CENTER  # 水平居中
        run = p.add_run(text)
        run.font.name = font_name
        run._element.rPr.rFonts.set(qn('w:eastAsia'), font_name)
        run.font.size = font_size
        cell.vertical_alignment = WD_CELL_VERTICAL_ALIGNMENT.CENTER  # 垂直居中

    # 创建三线表
    table = doc.add_table(rows=3, cols=3)
    set_three_line_table(table)
    # 填充示例数据并居中
    headers = ['参数', '数值', '单位']
    data = [['α', '0.85', '—'], ['β', '1.20', 'm/s']]
    for i, h in enumerate(headers):
        set_cell_center(table.rows[0].cells[i], h)
    for r, row_data in enumerate(data):
        for c, val in enumerate(row_data):
            set_cell_center(table.rows[r+1].cells[c], val)
    
    # 保存
    doc.save('../paper/paper.docx')
    print('Word文档已生成：paper/paper.docx')

# 执行生成
create_word_paper()
```

**Word文档格式要点**：

- 中文字体设置：`run._element.rPr.rFonts.set(qn('w:eastAsia'), '字体名')`
- 西文字体：Times New Roman（默认或显式设置）
- 行距：1倍（`paragraph_format.line_spacing = 1`）
- 首行缩进：2字符（约0.74cm）
- 分页：`doc.add_page_break()`
- **页眉必须留空**：禁止任何页眉文字、线条或图片
- **页码页脚居中**：从第一页（摘要页）开始编号（摘要页为第1页），全文连续
- **匿名要求**：摘要页、正文、附录任何位置禁止出现参赛者姓名、学校、赛区、队号、指导教师等信息

***

### 3. 论文写作规范

#### 论文结构（必须遵循）

| 章节                | 内容要求                                | 分页要求                        |
| ----------------- | ----------------------------------- | --------------------------- |
| **标题**            | 20-30字，突出方法+对象+问题类型                 | 与摘要、关键词**同页**               |
| **摘要**            | 800-1000字，必须含具体数值和误差分析              | 与标题、关键词**同页**               |
| **关键词**           | 3-5个，分号分隔                           | 与标题、摘要**同页**，关键词后`\newpage` |
| **一、问题背景与重述**    | 背景（联网调研所得，引用文献）+ 逐问重述              | 正文第1页                       |
| **二、问题分析**        | 整体思路（建议插入技术路线图）+ 逐问分析 + 数据与问题对应关系分析 | 正文续                         |
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

#### 模型求解规范

每问的求解以**融会贯通的中文叙述**呈现，论文正文中**禁止机械使用（1）（2）（3）分条语言**，须按中文书写习惯自然行文。求解过程一般按以下环节组织，各环节以连贯段落和引导语衔接：

- **数据预处理**：进行数据完整性检验（缺失值检测）与有效性检验（异常值检测），辅以分布图、区间检验图等可视化手段，并在文字中说明处理结果。
- **算法选择与设计**：说明选择该算法的理由（对比至少1种替代方案），描述预剪枝等搜索空间压缩策略，给出算法流程图并列出关键参数表。
- **求解结果**：用表格呈现核心结果，与前一问对比并说明提升百分比，配以文字解读关键数值。
- **交叉验证**：按获奖论文标准流程进行，如采用遗传算法验证启发式求解结果，绘制迭代收敛曲线图，并作鲁棒性分析。
- **结果可视化与分析**：插入结果分析图，对图中数据特征与变化趋势进行物理解释。
- **模型检验与误差分析**：按需进行统计检验（残差正态性、异方差性），给出误差指标（MAE、RMSE、MAPE、R² 至少2项），与基准方法或文献结果对比并说明改进百分比，简要讨论模型对参数扰动的稳健性。

**图表描述要求（强制执行）**：论文中对每张图、每个表必须用至少一段话进行清晰仔细的描述，说明图中数据特征、变化趋势及由图表得出的结论，禁止图表孤立出现。

#### 优秀论文核心特征（基于获奖论文提炼）

**1. 预剪枝+系统化实验+GA交叉验证的三段式求解**：

- 预剪枝：将$O(M^N)$压缩到$O(K \cdot N)$（M=原始方案数，K=剪枝后方案数）
- 系统化实验：单方案实验→组合实验→变异验证
- GA交叉验证：50代迭代验证全局最优性

**2. 创新指标构建**：

- 迁移适宜度指标：$\alpha \cdot$ 剩余资源 $+ (1-\alpha) \cdot$ 速率增益
- 跨周期优化：mMTC任务延续至后续周期
- 终态统计法：10周期结束后统一计算

**3. 数据预处理必须包含**：

- 数据完整性检验（缺失值）
- 数据有效性检验（异常值/离群值）
- 可视化分布图

**4. 结果验证必须包含**：

- 遗传算法收敛曲线
- 关键跃迁现象分析
- 算法鲁棒性检验
- 与启发式结果的方法论闭环

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
"本模型可推广应用于\[类似场景1]、\[类似场景2]等领域，只需调整\[某参数/某约束]即可适配。"

***

### 4. 可视化规范

#### 强制要求

- **每道小题至少1张彩色图**（建议2-3张）
- **优先使用高端效果**：三维图、热力图、等高线图
- **拟合结果必须可视化**：拟合曲线 vs 原始数据
- **误差分析必须可视化**：残差图、误差分布图
- **所有图表必须具备出版级质量**：分辨率≥300 DPI，矢量格式优先

#### 推荐图表类型

| 图表类型            | 适用场景           | 视觉效果  | 推荐库                 |
| --------------- | -------------- | ----- | ------------------- |
| 三维曲面图           | 多参数优化、地形可视化    | ★★★★★ | matplotlib / plotly |
| 热力图             | 相关性矩阵、参数分析     | ★★★★★ | seaborn / plotly    |
| 等高线图            | 优化可行域、Pareto前沿 | ★★★★  | matplotlib          |
| 动态演化图           | 时序仿真、迭代收敛      | ★★★★  | matplotlib / plotly |
| 小提琴图+箱线图叠加      | 数据分布、多组对比      | ★★★★★ | seaborn             |
| 拟合对比图（含置信带）     | 模型拟合效果         | ★★★★  | matplotlib          |
| 误差带图            | 置信区间、不确定性      | ★★★★  | matplotlib          |
| 雷达图             | 多指标综合评价对比      | ★★★★  | matplotlib          |
| 桑基图             | 流量分配、资源流转      | ★★★★  | plotly              |
| 联合分布图           | 多变量相关性分析       | ★★★★★ | seaborn / plotly    |
| 脊线图（Ridge Plot） | 多组分布对比（优雅）     | ★★★★★ | matplotlib          |
| 双轴/组合图          | 多量纲指标同图展示      | ★★★★  | matplotlib          |

#### 现代学术配色方案（必须使用）

**核心原则**：配色需兼顾**区分度、色盲友好、印刷一致性**，避免高饱和原色。

```python
# ===== 推荐配色板（按场景选用） =====

# 1. 主色调板 —— 分类数据（6色，色盲友好）
CATEGORY_PALETTE = ['#4C72B0', '#DD8452', '#55A868', '#C44E52', '#8172B3', '#937860']

# 2. 连续色板 —— 热力图/曲面图
#    发散型（有中心值）: 'coolwarm' 或 'RdBu_r'
#    顺序型（无中心值）: 'YlGnBu' 或 'viridis'
#    定性高对比: 'Set2'（≤8类）

# 3. 论文招牌配色 —— 2~4条曲线对比
LINE_PALETTE = ['#2196F3', '#FF5722', '#4CAF50', '#9C27B0']
# 蓝(主) / 橙红(对比) / 绿(正面) / 紫(辅助)

# 4. 渐变填充色（面积图/置信带）
FILL_ALPHA = 0.15  # 置信带透明度
```

**禁用配色**：

- ❌ 纯红`#FF0000` + 纯绿`#00FF00`组合（色盲不友好）
- ❌ `rainbow` / `jet` 色图（感知不均匀，学术禁用）
- ❌ 超过6种高饱和色同时出现

#### 全局样式模板（必须调用）

```python
import matplotlib.pyplot as plt
import matplotlib as mpl
import numpy as np
import seaborn as sns

# ===== 中文字体与基础设置（必须） =====
plt.rcParams['font.sans-serif'] = ['SimHei', 'Microsoft YaHei']
plt.rcParams['axes.unicode_minus'] = False
plt.rcParams['figure.dpi'] = 300
plt.rcParams['savefig.dpi'] = 300
plt.rcParams['savefig.bbox'] = 'tight'
plt.rcParams['font.size'] = 11
plt.rcParams['axes.linewidth'] = 1.2
plt.rcParams['xtick.major.width'] = 1.0
plt.rcParams['ytick.major.width'] = 1.0

# ===== 学术风格主题（推荐使用） =====
sns.set_theme(
    style='ticks',           # 带刻度线，学术首选
    palette=CATEGORY_PALETTE,
    font='SimHei',
    font_scale=1.1,
    rc={
        'axes.axisbelow': True,
        'axes.edgecolor': '#333333',
        'axes.labelcolor': '#333333',
        'axes.spines.top': False,    # 去掉上 spine
        'axes.spines.right': False,  # 去掉右 spine
        'xtick.color': '#333333',
        'ytick.color': '#333333',
        'figure.frameon': False,
    }
)

# ===== 保存时防止文字被裁切（必须） =====
plt.savefig('fig.png', dpi=300, bbox_inches='tight', pad_inches=0.1)
# 如需矢量图（论文插图首选）：
# plt.savefig('fig.pdf', bbox_inches='tight')
# plt.savefig('fig.svg', bbox_inches='tight')
```

#### 高频图表代码模板

**模板1：三维曲面图（带渐变光照效果）**

```python
fig = plt.figure(figsize=(8, 6))
ax = fig.add_subplot(111, projection='3d')

surf = ax.plot_surface(X, Y, Z,
    cmap='coolwarm',           # 发散型色图
    alpha=0.9,
    edgecolor='none',
    antialiased=True,
    rstride=1, cstride=1
)
ax.contourf(X, Y, Z, zdir='z', offset=Z.min(), cmap='coolwarm', alpha=0.3)

fig.colorbar(surf, ax=ax, shrink=0.6, pad=0.1, label='目标函数值')
ax.set_xlabel('参数α', labelpad=10)
ax.set_ylabel('参数β', labelpad=10)
ax.set_zlabel('目标值', labelpad=10)
ax.view_init(elev=25, azim=135)   # 最佳视角
plt.savefig('fig_3d_surface.png', dpi=300, bbox_inches='tight')
```

**模板2：热力图（带数值标注 + 遮罩上三角）**

```python
fig, ax = plt.subplots(figsize=(7, 6))
mask = np.triu(np.ones_like(corr_matrix, dtype=bool), k=1)  # 遮罩上三角（不含对角线），更简洁

sns.heatmap(corr_matrix, mask=mask,
    annot=True, fmt='.2f',
    cmap='coolwarm',          # 发散型：红正蓝负
    center=0,                 # 以0为中心
    vmin=-1, vmax=1,
    square=True,
    linewidths=0.5,
    linecolor='white',
    cbar_kws={'shrink': 0.8, 'label': '相关系数'},
    ax=ax
)
ax.set_title('参数相关性矩阵', fontsize=14, fontweight='bold', pad=15)
plt.savefig('fig_heatmap.png', dpi=300, bbox_inches='tight')
```

**模板3：拟合对比图（含置信带 + 残差子图）**

```python
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(8, 7),
    gridspec_kw={'height_ratios': [3, 1], 'hspace': 0.05})

# 上图：拟合曲线 + 置信带
ax1.scatter(x_data, y_data, s=20, c='#4C72B0', alpha=0.6,
            edgecolors='white', linewidth=0.5, label='观测值', zorder=3)
ax1.plot(x_fit, y_fit, color='#DD8452', linewidth=2, label='拟合曲线', zorder=4)
ax1.fill_between(x_fit, y_lower, y_upper,
    color='#DD8452', alpha=0.15, label='95% 置信区间', zorder=2)
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

plt.savefig('fig_fitting.png', dpi=300, bbox_inches='tight')
```

**模板4：迭代收敛曲线（双轴：目标值 + 最优解变化）**

```python
fig, ax1 = plt.subplots(figsize=(8, 5))

# 所有种群适应度（散点背景）
ax1.scatter(generations, all_fitness, s=5, c='#4C72B0', alpha=0.15, label='种群个体')
# 最优适应度（主线）
ax1.plot(generations, best_fitness, color='#DD8452', linewidth=2.5,
         label='最优适应度', zorder=5)
# 均值适应度
ax1.plot(generations, mean_fitness, color='#55A868', linewidth=1.5,
         linestyle='--', label='均值适应度', alpha=0.8)

ax1.set_xlabel('迭代代数', fontsize=12)
ax1.set_ylabel('适应度值', fontsize=12, color='#333333')
ax1.legend(frameon=False, loc='upper right')
ax1.grid(True, alpha=0.3, linestyle=':', linewidth=0.8)

plt.savefig('fig_convergence.png', dpi=300, bbox_inches='tight')
```

**模板5：多方案对比柱状图（带误差棒 + 显著性标注）**

```python
fig, ax = plt.subplots(figsize=(8, 5))
colors = ['#4C72B0', '#DD8452', '#55A868', '#C44E52']

bars = ax.bar(x_labels, values, yerr=std_values,
    color=colors[:len(x_labels)], edgecolor='white', linewidth=1.2,
    capsize=5, error_kw={'linewidth': 1.2, 'capthick': 1.5},
    width=0.6, alpha=0.85)

# 柱顶标注数值
for bar, val in zip(bars, values):
    ax.text(bar.get_x() + bar.get_width()/2, bar.get_height() + max(std_values)*0.5,
            f'{val:.2f}', ha='center', va='bottom', fontsize=10, fontweight='bold')

ax.set_ylabel('指标值')
ax.grid(axis='y', alpha=0.3, linestyle=':', linewidth=0.8)
plt.savefig('fig_comparison.png', dpi=300, bbox_inches='tight')
```

**模板6：Pareto前沿图（多目标优化）**

```python
fig, ax = plt.subplots(figsize=(7, 6))

# 所有解（灰色背景）
ax.scatter(obj1_all, obj2_all, s=15, c='#CCCCCC', alpha=0.4,
           edgecolors='none', label='非支配解', zorder=2)
# Pareto最优前沿
pareto_sorted = sorted(zip(obj1_pareto, obj2_pareto))
ax.plot([p[0] for p in pareto_sorted], [p[1] for p in pareto_sorted],
    color='#DD8452', linewidth=2, marker='o', markersize=6,
    markerfacecolor='white', markeredgewidth=1.5,
    label='Pareto前沿', zorder=4)

ax.set_xlabel('目标 $f_1$', fontsize=12)
ax.set_ylabel('目标 $f_2$', fontsize=12)
ax.legend(frameon=True, fancybox=True, framealpha=0.8, loc='best')
ax.grid(True, alpha=0.2, linestyle=':', linewidth=0.8)
plt.savefig('fig_pareto.png', dpi=300, bbox_inches='tight')
```

#### 可视化要求清单

- [ ] 每道小题至少1张彩色图
- [ ] 优化问题：三维曲面图 + 迭代收敛曲线
- [ ] 参数分析：热力图 + 等高线图
- [ ] 拟合问题：拟合对比图（含置信区间）
- [ ] 误差分析：残差图 + 误差分布图
- [ ] 所有图表使用推荐配色方案，禁用 `jet`/`rainbow`
- [ ] 图表分辨率≥300 DPI，重要插图建议 PDF/SVG 矢量格式
- [ ] 坐标轴标签完整（物理量+单位）
- [ ] 图例清晰，位置合理，不遮挡数据
- [ ] 去掉右侧和上方 spine（学术简洁风格）
- [ ] 散点图使用半透明 + 白色描边，避免过绘遮挡
- [ ] 多子图布局使用 `gridspec_kw` 控制比例
- [ ] 每张图有明确的 `suptitle` 或 `title`

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

- matplotlib 必须设置中文字体：`plt.rcParams['font.sans-serif'] = ['SimHei']`
- 必须设置负号正常显示：`plt.rcParams['axes.unicode_minus'] = False`
- 保存时指定 `bbox_inches='tight'`
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
- 表格列结构：`| 编号 | 假设内容 | 合理性说明 |`，禁止竖线
- 表题位于表格**上方**，格式：`表1 模型假设`
- **编号列**：居中对齐，使用阿拉伯数字（1, 2, 3, ...），加粗
- **假设内容列**：左对齐，使用完整陈述句，禁止缩写
- **合理性说明列**：左对齐，须给出物理依据或文献支撑，禁止仅写"合理"
- 假设条数控制在 **4-6 条**，过少缺乏严谨性，过多冲淡重点
- 表格前后须有**引导文字和过渡分析**，禁止表格孤立出现
- 每条假设须在正文建模时**显式引用**（如"根据假设3，可忽略XX影响"）

**显示完整性（重点防错）**：

假设表格"显示不完全"是最高频排版问题，须严格按以下规范处理：

| 问题原因 | 现象 | 解决方案 |
| -------- | ---- | -------- |
| `l`列不换行 | 长文字溢出右边界 | 改用 `p{宽度}` 或 `tabularx` 的 `X` 列 |
| 未限制总宽度 | 表格超出版心 | `\begin{tabularx}{\textwidth}{...}` 锁定宽度 |
| `table`不跨页 | 假设多时底部被截断 | 假设控制在4-6条；若必须更多，改用 `longtable` |
| 行高不统一 | 换行后单元格错位 | 用 `m{宽度}`（`array`宏包）垂直居中对齐 |

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

**常见假设排版错误**：

| 错误类型 | 错误示例 | 正确做法 |
| -------- | -------- | -------- |
| 使用列表代替表格 | `\begin{itemize} \item 假设1...` | 使用 `tabular` 三线表 |
| 表题位置错误 | 表题在表格下方 | 表题在表格**上方** |
| 合理性说明空洞 | "该假设合理" | "依据文献[1]，XX影响占比<3%，可忽略" |
| 假设未被引用 | 正文中未提及假设 | 建模时显式引用"由假设X可知..." |
| 含竖线 | `\begin{tabular}{|c|l|l|}` | `\begin{tabular}{cll}` 配合 `\toprule` 等 |
| 文字溢出显示不全 | `\begin{tabular}{cll}` 长文字不换行 | 改用 `\begin{tabularx}{\textwidth}{c X X}` |
| 表格底部被截断 | 假设过多`table`环境不跨页 | 控制在4-6条；必须更多时用`longtable` |

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
\renewcommand{\thesection}{\chinese{section}}  % 一级标题使用中文数字，确保交叉引用与显示一致
\titleformat{\section}{\centering\heiti\fontsize{14}{18}\selectfont}{\thesection}{1em}{}
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

#### \[致命] 匿名与保密（一票否决，违反直接取消评奖资格）

| 检查项  | 修复方法                             |
| ---- | -------------------------------- |
| 摘要页/正文/附录出现参赛者姓名、学校、赛区、队号、指导教师 | 全文删除（含文字、图片水印、页眉页脚、代码注释、文件名） |
| 存在页眉或页眉横线 | 清空页眉内容并设 `\renewcommand{\headrulewidth}{0pt}` |
| 页码未从摘要页（第1页）开始 | 全文 `\pagestyle{fancy}`，`\maketitle` 后加 `\thispagestyle{fancy}` |
| 页码未页尾居中 | `\fancyfoot[C]{\thepage}`，确保 `\fancyhf{}` 后页脚仅剩居中页码 |

#### \[致命] 中文编码问题

| 检查项  | 修复方法                             |
| ---- | -------------------------------- |
| 文件编码 | 保存为 UTF-8（无BOM）                  |
| 中文乱码 | 使用 xelatex 编译                    |
| 宏包冲突 | 删除 `\usepackage[utf8]{inputenc}` |

#### \[严重] 输出文件完整性

- `paper/paper.pdf` 必须存在且可正常打开
- `paper/paper.docx` 必须存在且可正常打开
- 两文件内容一致（标题、摘要、数值、图表编号对应）

#### \[严重] PDF 与 Word 格式一致性检查（重点）

- 重点检查 Word 文档格式，须与 PDF 一致：
  - 题目：三号黑体居中；摘要标签：四号黑体
  - 正文：小四宋体，1倍行距，首行缩进2字符
  - 一级标题：四号黑体居中；二级标题：小四黑体左对齐
  - 三线表（无竖线）、图题在下、表题在上
  - 页码位置一致
- **不强制要求** Word 中标号的交叉引用与超链接，不因缺少交叉引用扣分

#### \[严重] 摘要与正文一致性

- 摘要数值 = 正文表格数值（精确到同一小数位）
- 摘要方法名 = 正文模型名 = 代码实现名

#### \[严重] 模型选择理由

- 必须说明选择该算法的理由
- 至少提及1种替代方案并说明为何不选
- 参数设置需有依据（参考文献建议范围）

#### \[严重] 变量与符号一致性

- 每个符号唯一，无冲突
- 大小写统一
- 所有符号均在符号说明表中定义

#### \[中等] 公式、图表完整性

- 公式编号连续，无重复
- 跨行公式整体居中，编号位于右侧
- 图表编号连续，无跳跃
- 图题在下，表题在上
- 三线表格式（无竖线）

#### \[中等] 误差分析

- 给出相对误差或置信区间
- 与基准方案对比，给出提升百分比

#### \[严重] 参考文献查证

- 所有文献在数据库中可查
- 元数据准确（作者、标题、刊名、卷期、页码）
- DOI/URL 可访问

#### \[轻微] 表达规范

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
| **写作能力** | 10 | 逻辑连贯、学术语态、数据支撑、无空泛表达 |
| **排版** | 10 | 格式规范、图表完整、符号一致、编译无误 |
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

**3. 创新性（20分）**

| 检查项 | 扣分标准 |
| ------ | -------- |
| 全部使用基础方法无创新 | -10 |
| 创新点缺乏理论支撑 | -5 |
| 未构建自定义指标或改进算法 | -5 |

**4. 写作能力（10分）**

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
| 缺少误差分析/敏感性分析/对比实验 | 每缺一项 -2 |
| 模型假设未用三线表（用列表/纯文字） | -2 |
| 假设合理性说明空洞（仅写"合理"） | 每处 -1 |
| 假设条数不在4-6条范围 | -1 |
| 正文中未显式引用假设编号 | -2 |
| 跨行公式未居中或右侧缺编号 | 每处 -1 |
| Word 格式与 PDF 不一致（字体/字号/行距/缩进/标题层级/三线表） | 每处 -1 |

#### 评分输出模板

```
========== 论文评分表 ==========
维度              得分    满分
---------------------------------
摘要              XX      30
算法/模型正确性    XX      20
创新性            XX      20
写作能力          XX      10
排版              XX      10
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
| 非线性、不连续可导 | 遗传算法           |
| 0-1变量     | 0-1整数规划 + 遗传算法 |
| 高维决策空间    | 分层构建初始解 + 智能优化 |
| 多方法融合     | 多方法智能融合策略      |
| 评价/排序类问题 | 熵权-TOPSIS（首选）、AHP、灰色关联分析 |
| 指标权重确定 | 熵权法、CRITIC、AHP |

### 问题递进关系

| 递进类型    | 典型表述                  |
| ------- | --------------------- |
| 简单→复杂   | "在问题一的基础上，进一步综合考虑..." |
| 静态→动态   | "考虑到实际因素/动态变化..."     |
| 确定→不确定  | "假设次品率通过抽样检测得到..."    |
| 单目标→多目标 | "引入多目标优化，采用NSGA-II求解Pareto前沿..." |

### 常见错误速查

| 错误类型      | 解决方案                                |
| --------- | ----------------------------------- |
| 中文乱码      | 使用 xelatex，删除 inputenc              |
| 图片文字不全    | 设置 SimHei，使用 bbox\_inches='tight'   |
| 文字超出纸张    | 使用 seqsplit，tabularx，\[H]定位         |
| caption报错 | 使用 font=small，禁止 font={font=10.5pt} |
| 摘要页边距错误   | 删除摘要环境内的 \setlength{\leftskip}      |
| 假设用列表非表格   | 改用 tabular 三线表，表题在上方，含合理性说明        |
| 假设表格显示不全   | `tabular`的`l`列不换行，改用`tabularx`的`X`列  |

