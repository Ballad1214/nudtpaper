# NUDT 学位论文 LaTeX 模板

本模板为撰写国防科技大学（NUDT）硕士/博士学位论文的 LaTeX 模板。模板优化了目录结构，统一并修正了以往版本中存在的问题，提供了清晰、易用且跨平台兼容的论文写作体验。

## 主要特性

- **统一的格式规范**：解决多个模板版本间的格式不一致问题
- **完善的版本控制**：通过文档类选项轻松生成不同论文版本
- **专硕支持**：完整支持专业学位（专硕）格式要求
- **跨平台字体支持**：提供三种字体方案，适配不同系统环境
- **自动化流程**：支持独创性声明自动插入，无需手动合并PDF
- **优化目录结构**：修正目录页前后空白页的页眉页脚显示

## 更新记录

+ **2026年4月17日**：
1) 最新模板要求封面（学术学位）、（专业学位）为仿宋，已更新；
2) 修复了图标标题的英文字体未显示为times问题；
3) 根据zzw同学反馈字体加粗后偏下，重定义了该命令，增加了偏移量；
4) 新增了更加美观的中英文连字符（详情见文档），可以按需取用。

+ **2026年3月16日**：
1) 根据2026年新模板调整了封面、页眉显示等内容；
2) 新增**答辩委员会**和**复核专家组**；
3) 重构版本控制逻辑，将评阅版/存档版控制开关和复核版/无需复核改为文档类选项，简化用户操作。
+ **2026年3月14日**：
1) 简化字体配置，移除操作系统选项，只保留 ttf、otf、fz 三种字体选项；
2) 新增Linux一键安装字体脚本。
+ **2026年3月11日**：优化字体配置逻辑和目录结构，增加 Windows 和 Linux 系统跨平台支持
+ **2024年10月11日**：重构模板仓库，统一格式规范，完善专业学位支持

## 快速开始

### 1. 字体自动安装脚本（Linux）

针对Ubuntu/Linux用户，提供了字体自动安装脚本(windows直接自己右键安装)：

```bash
# 先安装FreeSerif字体
sudo apt-get install fonts-freefont-ttf

# 设置脚本执行权限
chmod +x install-fonts.sh

# 用户安装（推荐）
./install-fonts.sh

# 系统安装（需要sudo权限）
sudo ./install-fonts.sh --system
```

```
项目目录/
├── install-fonts.sh    # 字体安装脚本
└── font/              # 字体目录
    ├── fz/           # 方正字体 (.ttf/.otf)
    ├── ttf/          # TTF 字体 (.ttf)
    └── otf/          # OTF 字体 (.otf)
```
- **Linux**：`fc-list` 查看已安装字体
- **Windows**：在"设置"→"个性化"→"字体"中查看
- 刷新字体缓存：`fc-cache -fv`
### 2. 获取与编译

1.  **获取模板**：克隆或下载本仓库至本地
2.  **主文件**：论文主体内容在 `mainpaper.tex` 中编辑
3.  **编译**：在 VSCode 或其他编辑器中编译 `mainpaper.tex`

    - **推荐编译链**：`xelatex -> biber -> xelatex -> xelatex`
    - 此编译链适用于使用 `biblatex` 生成参考文献（通过 `biber` 选项启用）
    - 若使用传统 `bibtex`，编译链为 `xelatex -> bibtex -> xelatex -> xelatex`

### 3. 版本控制：通过文档类选项一键生成

模板支持生成多种论文版本，所有版本控制完全通过 `\documentclass` 选项实现：

**核心选项说明**：

| 选项 | 作用说明 |
|------|----------|
| `master`/`doctor` | 学位类型：硕士 / 博士 |
| `prof` | 专业学位 |
| `twoside` | 双面打印 |
| `biber` | 使用 biblatex + biber 生成参考文献 |
| `ttf`/`otf`/`fz` | 字体方案：系统字体/Adobe字体/方正字体 |
| `anon` | 生成盲评版本（隐去作者、导师等信息） |
| `review` | 生成评阅版（不包含公开评阅信息、答辩委员会、复核专家组） |
| `addreview` | 包含复核专家组信息（仅在存档版生效） |
| `resumebib` | 使用 biblatex 从 .bib 文件生成成果列表 |

**版本生成方法**：

1. [**明评/盲评**]由文档类选项 `anon` 控制：
   - 传入 `anon` 选项：生成盲评版（隐去作者、导师等信息）
   - 不传 `anon` 选项：生成明评版（显示完整信息）

2. [**评阅版/存档版**]由文档类选项 `review` 控制：
   - 传入 `review` 选项：生成评阅版（不包含公开评阅信息、答辩委员会、复核专家组）
   - 不传 `review` 选项：生成存档版（包含完整评阅信息）

3. [**复核版/无需复核**]由文档类选项 `addreview` 控制：
   - 传入 `addreview` 选项：生成复核版（显示复核专家组信息）
   - 不传 `addreview` 选项：不显示复核专家组信息

**常用配置示例**：

```latex
% 存档版明评，专硕，双面打印，使用TTF字体
\documentclass[master,twoside,biber,prof,ttf]{src/nudtpaper}

% 存档版明评含复核，学术学位博士，使用方正字体
\documentclass[doctor,twoside,biber,fz,addreview]{src/nudtpaper}

% 评阅版明评，专硕，使用OTF字体
\documentclass[master,twoside,biber,prof,otf,review]{src/nudtpaper}

% 评阅版盲评，学术学位博士，使用TTF字体
\documentclass[doctor,biber,ttf,review,anon]{src/nudtpaper}

% 存档版盲评，学硕，使用OTF字体
\documentclass[doctor,biber,otf,anon]{src/nudtpaper}
```

**独创性声明**：
模板支持将签字扫描后的 `独创性声明扫描件.pdf` 自动插入最终论文。只需将该文件放置在项目根目录即可，模板会自动处理，无需手动合并PDF。

**字体配置**

模板提供三种预置字体方案，在文档类选项中指定：

```latex
\documentclass[...,ttf]{src/nudtpaper}     % 使用系统字体
\documentclass[...,otf]{src/nudtpaper}     % 使用Adobe/Noto字体
\documentclass[...,fz]{src/nudtpaper}      % 使用方正字体
```

| 字体方案 | 适用系统 | 说明 |
|----------|----------|------|
| `ttf` | Windows/Linux | Windows系统字体或Linux默认字体 |
| `otf` | 跨平台 | Adobe字体或Noto CJK字体 |
| `fz` | 已安装方正字体 | 方正系列字体 |





## 系统要求与测试环境

模板已在以下环境中测试通过：

| 操作系统 | 编辑器 | TeX发行版 |
|----------|--------|-----------|
| Windows 11 | VSCode | TeX Live 2021/2024 |
| Windows 11 (WSL2+Ubuntu 24.04) | VSCode | TeX Live 2025 |
| macOS | VSCode | MacTeX |

## 故障排查

1.  **XeLaTeX 编译缓慢**
    - **原因**：系统字体缓存问题
    - **解决**：运行 `fc-cache -fv` 刷新字体缓存

2.  **字体缺失错误**
    - 确保选择正确的字体选项（ttf/otf/fz）
    - 确保系统已安装对应字体
    - 使用字体安装脚本（Linux用户）
    - 检查字体名称是否准确

3.  **字形替换警告**
    - LaTeX在缩放数学公式字体时，若找不到精确尺寸会使用最接近的尺寸替代
    - 此类警告通常可忽略，不影响最终排版效果

## VSCode 配置

以下 `settings.json` 配置已针对本模板优化：

```json
    /****latex配置****/
    // 设置是否自动编译
    "latex-workshop.latex.autoBuild.run": "never",
    //右键菜单
    "latex-workshop.showContextMenu": true,
    //从使用的包中自动补全命令和环境
    "latex-workshop.intellisense.package.enabled": true,
    //编译出错时设置是否弹出气泡设置
    "latex-workshop.message.error.show": false,
    "latex-workshop.message.warning.show": false,
    // 编译工具和命令
    "latex-workshop.latex.tools": [
        {
            "name": "xelatex",
            "command": "xelatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOCFILE%"
            ]
        },
        {
            "name": "xelatexNopdf",
            "command": "xelatex",
            "args": [
                "-no-pdf",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOCFILE%"
            ]
        },
        {
            "name": "pdflatex",
            "command": "pdflatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOCFILE%"
            ]
        },
        {
            "name": "latexmk",
            "command": "latexmk",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "-pdf",
                "-outdir=%OUTDIR%",
                "%DOCFILE%"
            ]
        },
        {
            "name": "bibtex",
            "command": "bibtex",
            "args": [
                "%DOCFILE%"
            ]
        },
        {
            "name": "biber",
            "command": "biber",
            "args": [
                "%DOCFILE%"
            ]
        }
    ],
    // 用于配置编译链
    "latex-workshop.latex.recipes": [
        {
            "name": "XeLaTeX",
            "tools": [
                "xelatex"
            ]
        },
        {
            "name": "PDFLaTeX",
            "tools": [
                "pdflatex"
            ]
        },
        {
            "name": "BibTeX",
            "tools": [
                "bibtex"
            ]
        },
        {
            "name": "LaTeXmk",
            "tools": [
                "latexmk"
            ]
        },
        {
            "name": "大论文：xelatex -> biber -> xelatex*2",
            "tools": [
                "xelatexNopdf",
                "biber",
                "xelatexNopdf",
                "xelatex"
            ]
        },
        {
            "name": "大论文2：xelatex -> biber -> xelatex*2",
            "tools": [
                "xelatex",
                "biber",
                "xelatex",
                "xelatex"
            ]
        },
        {
            "name": "xelatex -> bibtex -> xelatex*2",
            "tools": [
                "xelatex",
                "bibtex",
                "xelatex",
                "xelatex"
            ]
        },
        {
            "name": "pdflatex -> bibtex -> pdflatex*2",
            "tools": [
                "pdflatex",
                "bibtex",
                "pdflatex",
                "pdflatex"
            ]
        }
    ],
    //文件清理。此属性必须是字符串数组
    "latex-workshop.latex.clean.fileTypes": [
        "*.aux",
        "*.bbl",
        "*.blg",
        "*.idx",
        "*.ind",
        "*.lof",
        "*.lot",
        "*.out",
        "*.toc",
        "*.acn",
        "*.acr",
        "*.alg",
        "*.glg",
        "*.glo",
        "*.gls",
        "*.ist",
        "*.fls",
        "*.log",
        "*.fdb_latexmk",
        "*.synctex.gz",
        "*.bbl",
        "*.thm"
    ],
    //设置为onFaild 在构建失败后清除辅助文件
    "latex-workshop.latex.autoClean.run": "onFailed",
    // 使用上次的recipe编译组合
    "latex-workshop.latex.recipe.default": "大论文：xelatex -> biber -> xelatex*2",
    // 用于反向同步的内部查看器的键绑定。ctrl/cmd +点击(默认)或双击
    "latex-workshop.view.pdf.internal.synctex.keybinding": "double-click",
    /****end latex****/
```

完整配置示例请参阅 #vscode-配置示例。

## 文件结构

```
nudtpaper/
├── mainpaper.tex          # 主文档
├── src/
│   ├── nudtpaper.cls     # 文档类文件
│   └── mynudt.sty        # 自定义宏包
├── subTex/               # 各章节内容
│   ├── abstract.tex      # 中英文摘要
│   ├── chap01.tex       # 第一章
│   ├── chap02.tex       # 第二章
│   ├── ack.tex          # 致谢
│   ├── resume.tex       # 作者成果
│   ├── resumeanon.tex   # 匿名成果信息（盲评版用）
│   ├── reviewinfo.tex   # 公开评阅信息
│   ├── defenseinfo.tex  # 答辩委员会
│   └── addreviewinfo.tex # 复核专家组
├── ref/                  # 参考文献
│   └── refs.bib
├── figures/              # 图片文件
├── font/                 # 字体文件（可选）
│   ├── ttf/
│   ├── otf/
│   └── fz/
└── README.md            # 本文档
```

## 支持与联系

如果在使用中遇到问题或有改进建议，欢迎联系：

- **邮箱**：ballad_l@163.com
- **建议**：请提供详细的问题描述、操作系统、TeX发行版版本及编译日志

## 致谢

本模板基于以下项目修改和集成：

- 原始模板基础：https://github.com/liubenyuan/nudtpaper
- 重要修正与参考：https://github.com/TomHeaven/nudt_thesis