# Math Modeling Helper

![Version](https://img.shields.io/github/v/release/Escap1ng/math-modeling-skill?sort=semver&label=release&color=blue)
![License](https://img.shields.io/github/license/Escap1ng/math-modeling-skill)
![Repo Size](https://img.shields.io/github/repo-size/Escap1ng/math-modeling-skill)
![Release Date](https://img.shields.io/github/release-date/Escap1ng/math-modeling-skill)
![Contributors](https://img.shields.io/github/contributors/Escap1ng/math-modeling-skill)

**🌐 Language:** [English](https://github.com/Escap1ng/math-modeling-skill/blob/main/README.en.md) | 中文

数学建模竞赛全流程 AI 辅助技能 —— 从赛题分析到论文生成，一站式解决。

覆盖**赛题理解 → 模型构建 → 算法实现 → 论文输出 → 质量自评** 完整链路，专为**高教社杯全国大学生数学建模竞赛（CUMCM）** 设计，同时适用于其他数学建模赛事。推荐使用多模态AI模型。

内置海量算法库与获奖论文级排版规范，从赛题输入到论文定稿全程自动评分迭代，帮助你在赛期内高效产出结构完整、格式规范、结果可验证的高质量参赛论文。

<small><b>免责声明：</b>  本工具生成的所有内容仅供学习参考，使用者须自行核实准确性并确保符合赛事学术诚信要求。排版格式以官方为准。</small>

> **⚠️ v2.1.0 更新说明：**
>
> **本次更新内容：**
> - 算法库大幅优化：新增图论与网络优化专题（最短路径、最小生成树、最大流、TSP/VRP等）
> - 统计与数据分析补充：灰色预测GM(1,1)、马尔可夫链预测、组合预测（国赛高频）
> - 物理与工程建模新增：微分方程数值解法（欧拉法、龙格-库塔法、有限差分法、SIR/SEIR模型）
> - 算法选择速查表补充：最短路径/网络流、路径规划/配送、时序预测、机理演化类等条目
> - 删除非通用特定模板代码，提升算法库通用性
> - 评分流程新增熔断机制（最大3轮优化），防止无限循环

## 🚀 Quick Start

首先将本仓库添加为 skill，然后：

只需三步，快速体验：

```
1️⃣ 上传赛题文件（PDF/Excel/文本）或粘贴赛题内容
 ↓
2️⃣ 技能自动完成：赛题分析 → 算法选择 → 代码实现 → 论文生成
 ↓
3️⃣ 获取完整的项目目录：code/（代码）+ figures/（图表）+ paper/（论文 PDF + Word）
```
**示例输出结构：**

```
第X题_赛题简称/
├── code/ # Python 代码（按问题编号：q1_*.py, q2_*.py）
├── figures/ # 可视化图表（fig1.png, fig2.png，≥300 DPI）
└── paper/ # 论文（paper.tex + paper.pdf + paper.docx）
```
## ✨ 核心能力

| 阶段 | 能力 | 说明 |
| :--- | :--- | :--- |
| 🔍 赛题分析 | 问题识别与拆解 | 自动判定问题类型（优化/预测/评价/分类/微分方程），梳理已知条件、约束与输出目标 |
| 🎯 算法优选 | 多维度智能筛选 | 从候选算法中按精度、复杂度、鲁棒性、可解释性择优，至少包含 1 种创新方案 |
| 💻 代码实现 | 完整可运行 | 基于 Python 技术栈生成规范代码，含参数说明、结果摘要、出版级可视化 |
| 📄 论文输出 | 双格式同步生成 | 同时输出符合国赛排版规范的 LaTeX PDF 与 Word 文档 |
| ✅ 质量自评 | 百分制量化评估 | 按摘要、正确性、创新性、写作、排版五维度评分，低于 85 分自动迭代优化 |

## 🧮 算法库覆盖

| 类别 | 方法 |
| :--- | :--- |
| 经典优化 | 0-1整数规划、非线性规划、动态规划<br>分支定界、线性规划（LP）、匈牙利算法<br>目标规划、运输问题、二次规划、拉格朗日松弛<br>博弈论（零和博弈、纳什均衡、演化博弈） |
| 启发式优化 | 遗传算法（GA）、模拟退火（SA）<br>粒子群（PSO）、禁忌搜索（TS） |
| 图论与网络优化 | 最短路径（Dijkstra、Floyd、Bellman-Ford）<br>最小生成树（Prim/Kruskal）、最大流（Ford-Fulkerson/Dinic）<br>TSP（动态规划/2-opt/最近邻+GA）、VRP、二分图匹配 |
| 群体智能 | 差分进化（DE）、蚁群算法（ACO）、灰狼优化（GWO）<br>鲸鱼优化（WOA）、人工蜂群（ABC）<br>麻雀搜索（SSA）、蜣螂优化（DBO）、金豺优化（GJO）、白鲸优化（BWO） |
| 机器学习 | XGBoost、SVM、随机森林、LightGBM<br>CatBoost、KNN、Transformer、CNN<br>RNN/LSTM、自编码器（AE/VAE） |
| 强化学习 | DQN、PPO、SAC、TD3 |
| 统计分析 | 假设检验（Z/t/卡方、ANOVA、Shapiro-Wilk）<br>回归插值（RSM、GPR、岭回归/Lasso）<br>降维聚类（PCA、t-SNE、K-means、UMAP、GMM）<br>时间序列（ARIMA、Prophet、Holt-Winters、VAR）<br>小样本预测（灰色预测GM(1,1)、马尔可夫链、组合预测） |
| 综合评价 | TOPSIS、熵权法、CRITIC、AHP<br>灰色关联分析、模糊综合评价、DEA |
| 物理与工程 | 运动学、拉格朗日力学、有限元分析<br>微分方程数值解（欧拉法、RK4、有限差分法、SIR/SEIR）<br>蒙特卡洛仿真、DES、元胞自动机、排队论 |
| 信号处理 | FFT、小波变换、EMD、卡尔曼滤波、HHT |
| 前沿方法 | PINN、DeepONet/FNO、数字孪生<br>符号回归、SHAP/LIME、因果推断<br>NSGA-II/III、贝叶斯优化、GNN |

## 🔄 工作流

```
赛题输入 → 问题分析（内部推理）→ 工作目录创建 → 算法选择（内部推理）
 ↓
最终输出 ← 论文评分 ≥ 85？→ 论文生成（PDF + Word）← 代码实现
 ↓ 否
 针对性优化 → 重新评分（循环，最多3轮）
```
## 📐 输出规范

- 📝 **论文格式** ：严格遵循国赛排版要求（A4、四边 2.5cm 页边距、宋体/黑体、三线表等）

- 🎨 **可视化** ：出版级质量，≥300 DPI，学术配色方案，禁用 jet/rainbow 色图；每个小问图片≥1张（有必要可多插），全文建议 6 张以上、保底不低于 4 张，图片随对应分析文字就近插入

- 📚 **参考文献** ：GB/T 7714 格式，5-8 篇，逐条在线查证

- 💯 **评分体系** ：摘要（30）+ 算法正确性（20）+ 创新性（20）+ 写作（10）+ 排版（10）= 100 分

## 📁 文件说明

| 文件 | 说明 |
| :--- | :--- |
| `SKILL.md` | 技能定义文件，包含完整工作流、算法库、代码模板、论文排版规范、评分体系 |

## License

MIT License
