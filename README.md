# Math Modeling Helper

![Version](https://img.shields.io/github/v/release/Escap1ng/math-modeling-skill?sort=semver&label=release&color=blue)
![License](https://img.shields.io/github/license/Escap1ng/math-modeling-skill)
![Repo Size](https://img.shields.io/github/repo-size/Escap1ng/math-modeling-skill)
![Release Date](https://img.shields.io/github/release-date/Escap1ng/math-modeling-skill)
![Contributors](https://img.shields.io/github/contributors/Escap1ng/math-modeling-skill)
![Last Commit](https://img.shields.io/github/last-commit/Escap1ng/math-modeling-skill)

**🌐 Language:** [English](https://github.com/Escap1ng/math-modeling-skill/blob/main/README.en.md) | 中文

数学建模竞赛全流程 AI 辅助技能 —— 从赛题分析到论文生成，一站式解决。

覆盖**赛题理解 → 模型构建 → 算法实现 → 论文输出 → 质量自评** 完整链路，专为**高教社杯全国大学生数学建模竞赛（CUMCM）** 设计，同时适用于其他数学建模赛事。推荐使用多模态AI模型。

内置海量算法库与获奖论文级排版规范，从赛题输入到论文定稿全程自动评分迭代，帮助你在赛期内高效产出结构完整、格式规范、结果可验证的高质量参赛论文。

<small><b>免责声明：</b>  本工具生成的所有内容仅供学习参考，使用者须自行核实准确性并确保符合赛事学术诚信要求。排版格式以官方为准。</small>

> **⚠️ v2.0.0 稳定性提示：** 本版本尚未大规模测试，可能存在不稳定性，使用前请仔细检查输出结果，异常请通过 Issue 反馈。
> 本次重点更新：强化匿名与保密要求（一票否决、禁止页眉）、页码从摘要页起页尾居中，并同步更新 LaTeX 模板、自检清单与评分体系。

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
|---|---|---|
| 🔍 赛题分析 | 问题识别与拆解 | 自动判定问题类型（优化/预测/评价/分类/微分方程），梳理已知条件、约束与输出目标 |
| 🎯 算法优选 | 多维度智能筛选 | 从候选算法中按精度、复杂度、鲁棒性、可解释性择优，至少包含 1 种创新方案 |
| 💻 代码实现 | 完整可运行 | 基于 Python 技术栈生成规范代码，含参数说明、结果摘要、出版级可视化 |
| 📄 论文输出 | 双格式同步生成 | 同时输出符合国赛排版规范的 LaTeX PDF 与 Word 文档 |
| ✅ 质量自评 | 百分制量化评估 | 按摘要、正确性、创新性、写作、排版五维度评分，低于 85 分自动迭代优化 |

## 🧮 算法库覆盖

| 类别 | 方法 |
|---|---|
| 经典优化 | 0-1整数规划、非线性规划、动态规划<br>分支定界、线性规划（LP）、匈牙利算法 |
| 启发式优化 | 遗传算法（GA）、模拟退火（SA）<br>粒子群（PSO）、禁忌搜索（TS） |
| 群体智能 | 差分进化（DE）、蚁群算法（ACO）、灰狼优化（GWO）<br>鲸鱼优化（WOA）、人工蜂群（ABC）<br>麻雀搜索（SSA）、蜣螂优化（DBO） |
| 机器学习 | XGBoost、SVM、随机森林、LightGBM<br>CatBoost、KNN、Transformer、CNN<br>RNN/LSTM、自编码器（AE/VAE） |
| 强化学习 | DQN、PPO、SAC、TD3 |
| 统计分析 | 假设检验（Z/t/卡方、ANOVA、Shapiro-Wilk）<br>回归插值（RSM、GPR、岭回归/Lasso）<br>降维聚类（PCA、t-SNE、K-means、UMAP、GMM）<br>时间序列（ARIMA、Prophet、Holt-Winters、VAR） |
| 综合评价 | TOPSIS、熵权法、CRITIC、AHP<br>灰色关联分析、模糊综合评价、DEA |
| 物理与工程 | 运动学、拉格朗日力学、有限元分析<br>蒙特卡洛仿真、DES、元胞自动机、排队论 |
| 信号处理 | FFT、小波变换、EMD、卡尔曼滤波、HHT |
| 前沿方法 | PINN、DeepONet/FNO、数字孪生<br>符号回归、SHAP/LIME、因果推断<br>NSGA-II/III、贝叶斯优化、GNN |

## 🔄 工作流

```
赛题输入 → 问题分析（内部推理）→ 工作目录创建 → 算法选择（内部推理）
 ↓
最终输出 ← 论文评分 ≥ 85？→ 论文生成（PDF + Word）← 代码实现
 ↓ 否
 针对性优化 → 重新评分（循环）
```
## 📐 输出规范

- 📝 **论文格式** ：严格遵循国赛排版要求（A4、四边 2.5cm 页边距、宋体/黑体、三线表等）

- 🎨 **可视化** ：出版级质量，≥300 DPI，学术配色方案，禁用 jet/rainbow 色图

- 📚 **参考文献** ：GB/T 7714 格式，5-8 篇，逐条在线查证

- 💯 **评分体系** ：摘要（30）+ 算法正确性（20）+ 创新性（20）+ 写作（10）+ 排版（10）= 100 分

## 📁 文件说明

| 文件 | 说明 |
|---|---|
| `SKILL.md` | 技能定义文件，包含完整工作流、算法库、代码模板、论文排版规范、评分体系 |

## License

MIT License
