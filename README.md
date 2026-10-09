<div align="center">

# 数学建模竞赛辅助技能

**Math Modeling Helper · V3.0.1**

赛题分析 · 算法优选 · 代码实现 · 论文润色 —— 从赛题输入到论文定稿的一站式 AI 建模技能

![Version](https://img.shields.io/badge/版本-V3.0.1-2563eb)
![License](https://img.shields.io/github/license/Escap1ng/math-modeling-skill?label=许可证&color=16a34a)
![Stars](https://img.shields.io/github/stars/Escap1ng/math-modeling-skill?label=Stars&color=f59e0b)
![Last Commit](https://img.shields.io/github/last-commit/Escap1ng/math-modeling-skill?label=最近提交&color=0ea5e9)
![Tech Stack](https://img.shields.io/badge/技术栈-Python%20%7C%20LaTeX%20%7C%20Pandoc-e8710a)

**中文** | [English](https://github.com/Escap1ng/math-modeling-skill/blob/main/README.en.md)

[项目简介](#项目简介) · [核心亮点](#核心亮点) · [使用](#使用) · [快速开始](#快速开始) · [工作流程](#工作流程) · [环境依赖](#环境依赖) · [算法库](#算法库) · [论文与排版规范](#论文与排版规范) · [可视化规范](#可视化规范) · [评分体系](#评分体系) · [目录与文件](#目录与文件) · [许可证](#许可证)

</div>

---

## 项目简介

面向数学建模竞赛的全流程 AI 辅助技能：**赛题理解 → 模型构建 → 算法实现 → 论文输出 → 质量自评**。技能本体是一份 Markdown（`SKILL.md`），复制即装；定稿一次给出 PDF 与 Word（公式为 Word 原生可编辑数学），不需人工二次排版。

> **适用赛事** —— 全国大学生数学建模竞赛（高教社杯 CUMCM）、美国大学生数学建模竞赛（MCM/ICM）、中国研究生数学建模竞赛（“华为杯”）、MathorCup 大学生数学建模挑战赛、全国大学生统计建模大赛、亚太地区大学生数学建模竞赛（APMCM）等；默认按国赛规范执行。

> **免责声明**：本工具生成的所有内容仅供学习参考，使用者须自行核实准确性，并严格遵守赛事学术诚信相关规定。论文排版以官方发布的最新规范为准。

---

## 核心亮点

| 亮点 | 说明 |
| :--- | :--- |
| 全流程自动化 | 七阶段一气呵成，细节见[工作流程](#工作流程) |
| 单文件技能 | 整个技能就是一份 `SKILL.md` —— 无插件、无脚本，复制即用、可直接改 |
| 双格式论文交付 | PDF 与 Word 一次同出 —— 多数方案只给单一 Markdown 或仅 PDF |
| 精选算法库 | 高频 + 前沿方法速查，见[算法库](#算法库) |
| 出版级可视化 | Nature 三色职责配色与统一样式模块，见[可视化规范](#可视化规范) |
| 获奖级排版规范 | 国赛获奖论文版式与匿名合规，见[论文与排版规范](#论文与排版规范) |
| 质量闭环 | 百分制五维自评与熔断机制，见[评分体系](#评分体系) |

---

## 使用

把根目录的 `SKILL.md` 复制到所用 agent 的技能目录即可（各工具目录位置不同，以其文档为准；文件夹名须与 `SKILL.md` 头部的 `name: math-modeling-helper` 一致，例如 `~/.claude/skills/math-modeling-helper/SKILL.md`）。依赖清单见[环境依赖](#环境依赖)。

---

## 快速开始

技能装入 AI IDE 后，三步即可完成建模：

```
1️⃣ 上传赛题文件（PDF / Excel / 文本）或直接粘贴赛题内容
 ↓
2️⃣ 技能自动执行七阶段工作流（见下文「工作流程」）
 ↓
3️⃣ 获取完整项目目录：code/ + figures/ + paper/（结构见下文「目录与文件」）
```

---

## 工作流程

```
阶段零 环境预检 → 阶段一 赛题分析 → 阶段二 目录创建 → 阶段三 算法选择
 ↓
最终输出 ← 阶段六 评分 ≥ 85？ → 阶段五 论文输出 ← 阶段四 代码实现
 ↓ 未达标
 针对性修改 → 重新评分（≤ 3 轮）
```

| 阶段 | 工作内容 |
| :--- | :--- |
| 阶段零 · 环境预检 | 检查 xelatex / pandoc / Python 依赖与绘图库，判定联网检索能力档位，缺失项自动安装，输出环境状态报告 |
| 阶段一 · 赛题分析 | 联网调研题目背景与全网已有思考，判定问题类型（优化 / 预测 / 评价 / 分类 / 微分方程），梳理数据、约束与每问输出目标 |
| 阶段二 · 目录创建 | 按题建立 `answer/` 目录，统一 code / figures / paper 产出位置 |
| 阶段三 · 算法选择 | 每问生成 2–3 种候选，并联网补前沿方法与高水平论文，按精度、复杂度、鲁棒性、可解释性、实现可行性五维择优，拟合性优先于高级性 |
| 阶段四 · 代码实现 | 先查成熟库与高 star 开源实现（核许可证），再写完整可运行代码，numpy 向量化，出版级可视化统一走样式模块出图 |
| 阶段五 · 论文输出 | xelatex 生成 PDF，pandoc 生成 Word（公式转 OMML），双格式同步交付 |
| 阶段六 · 评分优化 | 百分制五维自评，未达标则针对性修改后重评（定稿门槛见[评分体系](#评分体系)） |

---

## 环境依赖

以下依赖在阶段零自动预检，缺失项将自动安装或给出安装指引。

| 依赖 | 用途 | 安装方式 |
| :--- | :--- | :--- |
| TeX Live / MiKTeX（xelatex） | 编译 LaTeX 生成 PDF | 官网安装 |
| pandoc | LaTeX → Word，公式自动转 OMML | `winget install pandoc` 或官网下载 |
| Python 3.8+ | 数值计算、机器学习与绘图 | 官网安装 |
| python-docx / PyMuPDF / openpyxl / xlrd | Word 版式微调、PDF 与 Excel 数据读取 | `pip install python-docx pymupdf openpyxl xlrd` |
| numpy / pandas / scipy / matplotlib / seaborn | 数值计算、优化求解与绘图 | `pip install` |
| pulp / cvxpy / scikit-learn / xgboost / networkx / statsmodels | 规划建模、机器学习、图论、统计推断（按题选用） | `pip install` |
| graphviz / kaleido | 复杂架构图 / plotly 静态导出（可选） | 按需安装 |

一键安装 Python 依赖（`xelatex` 与 `pandoc` 为系统级安装，见上表）：

```bash
pip install numpy pandas scipy matplotlib seaborn openpyxl xlrd python-docx pymupdf pulp cvxpy scikit-learn xgboost networkx statsmodels
```

自检缺哪些包（全部可用则无输出）：

```bash
python -c "import importlib.util as u; [print('MISSING:', m) for m in ['numpy','pandas','scipy','matplotlib','seaborn','openpyxl','xlrd','docx','fitz'] if u.find_spec(m) is None]"
```

按题需要另装：`pymoo`（NSGA-II/III）、`prophet`（时间序列）、`pywt`（小波）。

---

## 算法库

| 分类 | 代表方法 |
| :--- | :--- |
| 基础数值方法 | 二分法、牛顿迭代法、梯度下降、共轭梯度、单纯形法、内点法<br>梯形 / 辛普森积分、高斯消元、LU 分解、最小二乘拟合<br>拉格朗日 / 牛顿 / 三次样条插值 |
| 经典优化方法 | 0-1 整数规划、非线性规划、动态规划、分支定界、线性规划（LP）、匈牙利算法<br>目标规划、运输问题、二次规划、拉格朗日松弛<br>博弈论（零和博弈、纳什均衡、演化博弈） |
| 启发式优化 | 遗传算法（GA）、模拟退火（SA）、粒子群优化（PSO）、禁忌搜索（TS） |
| 图论与网络优化 | 最短路径（Dijkstra / Floyd / Bellman-Ford）、最小生成树（Prim / Kruskal）、最大流、最小费用最大流<br>TSP / VRP、二分图匹配、拓扑排序、关键路径法（CPM / PERT）、欧拉 / 哈密顿回路 |
| 群体智能算法 | 差分进化（DE）、蚁群算法（ACO）、灰狼优化（GWO）、鲸鱼优化（WOA）、人工蜂群（ABC）<br>麻雀搜索（SSA）、蜣螂优化（DBO）、金豺优化（GJO）、白鲸优化（BWO） |
| 机器学习与深度学习 | XGBoost、SVM、随机森林、LightGBM、CatBoost、KNN<br>Transformer、CNN、RNN / LSTM、自编码器（AE / VAE）、注意力机制<br>强化学习：DQN、PPO、SAC、TD3 |
| 统计与数据分析 | 假设检验（Z / t / 卡方、ANOVA、Shapiro-Wilk）、相关性（Spearman / Kendall）<br>回归插值（响应面法 RSM、高斯过程回归 GPR、岭回归 / Lasso、多项式 / 逐步回归）<br>降维聚类（PCA、t-SNE、UMAP、K-means / DBSCAN、层次聚类、GMM）<br>时间序列（ARIMA、LSTM / GRU、Prophet、Holt-Winters、VAR）<br>小样本预测（灰色预测 GM(1,1)、马尔可夫链、组合预测）<br>分类判别（Fisher 判别、逻辑回归、朴素贝叶斯、决策树）<br>统计推断（极大似然估计 MLE、EM 算法、贝叶斯估计） |
| 综合评价与决策 | TOPSIS（熵权-TOPSIS 首选）、熵权法、CRITIC 权重法、层次分析法（AHP）<br>灰色关联分析、模糊综合评价、数据包络分析（DEA）<br>期望值决策法、决策树分析、成本效益分析 |
| 物理与工程建模 | 运动学、拉格朗日力学、有限元分析、刚体动力学<br>微分方程数值解（欧拉法、RK4、有限差分、SIR / SEIR、稳定性分析）<br>蒙特卡洛仿真、离散事件仿真 DES、元胞自动机、多智能体仿真 ABM、排队论 |
| 信号处理 | FFT、小波变换、经验模态分解 EMD、卡尔曼滤波、希尔伯特-黄变换（HHT） |
| 前沿创新方法 | 物理信息神经网络 PINN、算子学习（DeepONet / FNO）、数字孪生<br>符号回归、可解释 AI（SHAP / LIME）、因果推断（双重差分 DID、因果图）<br>多目标优化（NSGA-II / III、MOEA/D）、鲁棒 / 贝叶斯优化、GNN / GAT、社区发现（Louvain） |

---

## 论文与排版规范

- **匿名一票否决** —— 全文任何位置（含页眉页脚、图片、代码注释、文件名）禁止出现姓名、学校、赛区、队号、指导教师，页眉必须留空
- **双格式交付** —— `.tex` 源文件 + `.pdf` 成品 + `.docx` Word（pandoc 转换，公式为 OMML 原生数学格式，可在公式编辑器中编辑）
- **页面设置** —— A4 纸、四边 2.5cm 页边距；中文正文宋体小四、西文与数字 Times New Roman；页码页尾居中，摘要页即第 1 页
- **结构规范** —— 题目、摘要（800–1000 字、含具体数值与误差分析）、关键词三者同页；模型假设强制三线表（4–6 条，含合理性说明）；全文表格禁止竖线
- **公式规范** —— 核心公式（目标函数 / 关键约束 / 状态方程）独立编号并在正文引用；推导从简；检测量公式（R²/MAE/RMSE/MAPE）全文仅首次定义一次
- **正文表述** —— 问题—回应结构，每问结尾给出明确结论段；问题间强制承上启下；去 AI 化自查（禁模板腔开头、套话升华、过渡词滥用）
- **参考文献** —— GB/T 7714 格式，5–8 篇，至少 2 篇近 5 年文献、1 篇英文文献，逐条在线查证

---

## 可视化规范

- **出版级质量** —— 分辨率 ≥300 DPI（密度类图可降至 200），线条 / 柱状类优先矢量 PDF
- **Nature 三色职责配色** —— 颜色只承担身份（主角蓝打头）、方向（红绿仅表增减并带 ↑/↓）、层级（`TONE_RAMP` 明度）三种职责，基准恒为灰；禁 jet / rainbow / 纯黑 / 脚本内硬编码色值，灰度打印仍可辨
- **图表数量** —— 每小问至少 1 张彩色图，全文建议 6 张以上、保底 4 张；第二章强制插入问题分析流程图 / 技术路线图
- **统一样式模块** —— 色板、色图、纹理、三档尺寸、分级字号与样式助手（`style_axes` / `annotate_bars` / `delta_annotation` 等）单点定义于 `plot_style.py`，正式图与预览图同品质
- **图库不是边界** —— 图型随数据结构与要论证的结论选，模板库外可自由创新现绘；但样式零自由：全文一律共用同一套常量与「先登记方法-颜色对照」的跨图统一契约
- **高频模板内置** —— 三维曲面（定比三维框 + 独立 colorbar）、热力图（上三角遮罩）、拟合对比（置信带 + 残差子图）、迭代收敛曲线、Pareto 前沿、问题分析流程图（内容 dict 驱动 + 自动正交连线 + 字宽门禁）；泰勒图、云雨图、交叉验证 ROC、SHAP 组合等进阶图型另可套 `mathmodel-figure` 的同名模板作补充

---

## 评分体系

| 维度 | 分值 | 评分依据 |
| :--- | :--- | :--- |
| 摘要 | 30 | 结构完整性、数值具体性、递进关系、与正文一致性 |
| 算法 / 模型正确性 | 20 | 数学推导无误、约束完备、求解结果合理、参数依据可回溯 |
| 创新性 | 20 | 方法创新度、跨学科融合、自定义指标构建、以先验调研为据 |
| 写作能力 | 15 | 逻辑连贯、学术语态、数据支撑、无空泛表达与 AI 痕迹、事实陈述有来源 |
| 排版 | 15 | 格式规范、图表完整、符号一致、匿名合规（违反一票否决）、著录格式合规 |
| **合计** | **100** | **≥ 85 分方可最终输出** |

未达标时列出扣分项、针对性修改后重新评分，最多优化 3 轮；3 轮后仍未达标则输出当前版本并标注「需人工复核」，熔断机制防止无限循环。

---

## 目录与文件

**建模产出目录**

```
第X题_赛题简称/
└── answer/
    ├── code/       # Python 代码（q1_*.py、q2_*.py，含 plot_style.py 统一样式模块）
    ├── figures/
    │   ├── final/  # 交付图（语义命名，须被论文引用）
    │   └── tmp/    # 调试图（与正式版同品质，交付前整体删除）
    └── paper/      # paper.tex + paper.pdf + paper.docx
```

**仓库文件**

| 文件 | 说明 |
| :--- | :--- |
| `SKILL.md` | 技能核心：七阶段工作流、算法库详解、代码模板、可视化与排版规范、正文语言规范、百分制评分体系 |
| `README.md` | 中文说明文档（本文件） |
| `README.en.md` | 英文说明文档 |
| `LICENSE` | MIT 许可证 |

---

## 许可证

MIT License © 2026 Escap1ng
