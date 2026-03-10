# NUDT 学位论文 LaTeX 模板

本仓库提供了一个用于撰写国防科技大学（NUDT）硕士/博士学位的 LaTeX 模板。此模板优化了目录结构，使其可读性更强同时统一并修正了以往多个版本中存在的不一致问题（如专硕支持、目录页眉页脚显示等），旨在提供清晰、高效且跨平台兼容的论文写作体验。

## 更新记录
+ **2026年3月11日**：优化字体配置逻辑和目录结构，增加对 Windows 和 Linux 系统的跨平台支持。现在可通过文档类选项 `windows` 或 `linux` 自动适配对应操作系统的字体，无需手动修改 `.cls` 文件。
+ **2024年10月11日**：重构模板仓库，统一格式规范。主要修正包括：完善对专业学位（专硕）的支持，修复目录页前后空白页的页眉页脚显示问题，并整合了关键使用说明以提高效率。

## 系统要求与测试环境
模板已在以下环境中测试通过：
1.  **Windows 11** + VSCode + TeX Live 2021 / 2024
2.  **Windows 11 (WSL2, Ubuntu 20.04)** + VSCode + TeX Live 2019
    *   (实测在 WSL2 中编译速度约为纯 Windows 环境的3倍，但需将字体文件复制到 WSL 内，而非使用软链接，以避免跨系统 I/O 性能瓶颈)

## 快速开始
### 1. 获取与编译
1.  **获取模板**：克隆或下载本仓库至本地。
2.  **主文件**：论文的主体内容在 `mainpaper.tex` 中编辑。
3.  **编译**：在 VSCode 或其他编辑器中编译 `mainpaper.tex` 即可。
    *   **推荐编译链**：`xelatex -> biber -> xelatex -> xelatex`
    *   此编译链适用于使用 `biblatex` 生成参考文献的情况（通过 `biber` 选项启用）。若使用传统 `bibtex`，编译链为 `xelatex -> bibtex -> xelatex -> xelatex`。

### 2. 生成论文的不同版本
最终论文分为四个版本：评阅版明评、评阅版盲评、存档版明评、存档版盲评。版本控制通过 `mainpaper.tex` 主文件中的选项和条件语句实现。

**在文档类选项中控制核心属性**：
| 选项 | 说明 |
| :--- | :--- |
| `master`/`doctor` | 硕士/博士学位论文 |
| `prof` | 专业学位（专硕） |
| `twoside` | 双面打印 |
| `biber` | 使用 `biblatex` + `biber` 生成参考文献（对应上述编译链） |
| `ttf`, `otf`, `fz`, `fandol` | 字体方案（见下方[字体配置](#字体配置)说明） |
| `windows`/`linux` | **（新增）** 指定编译操作系统，以自动调用正确的字体配置 |
| `anon` | 生成盲评版本（匿名作者、导师等信息） |
| `resumebib` | 使用 `biblatex` 从 `.bib` 文件生成作者成果列表（需与 `biber` 选项同用） |

**示例**：一个专硕、明评、双面打印、使用 `biblatex`、在 Windows 下编译的配置如下：
latex
\documentclass[master,twoside,biber,prof,ttf,windows]{nudtpaper}

在 Linux 系统下编译时，只需将 `windows` 改为 `linux`：
latex
\documentclass[master,twoside,biber,prof,ttf,linux]{nudtpaper}


**控制评阅/存档版**：
在 `mainpaper.tex` 文件中（约第100行附近），通过 `\ifreview` 开关控制：
latex
% 评阅版论文
% \newif\ifreview\reviewtrue
% 存档版论文
\newif\ifreview\reviewfalse


**关于独创性声明**：
模板已支持将签字扫描后的 `独创性声明扫描件.pdf` 直接插入最终论文。只需将该文件放置在根目录，模板会自动处理，无需每次用 PDF 编辑器手动合并。

## 字体配置
字体问题是编译失败和格式错误的常见原因。模板已针对 Windows 和 Linux 系统分别预置了字体配置方案。

### 1. 学校模板要求字体
*   中文：仿宋_GB2312， 黑体， 宋体（本模板中宋体加粗由“华文中宋”替代）， 楷体_GB2312
*   英文：Times New Roman, Arial

### 2. 模板的字体选择逻辑
1.  **指定操作系统**：在文档类选项中声明 `windows` 或 `linux`。
2.  **选择字体类型**：在文档类选项中声明 `ttf` (Windows系统字体/文泉驿)、`otf` (Adobe/Noto)、`fz` (方正)、`fandol` 中的一种。
3.  模板会根据`操作系统`和`字体类型`的组合，自动加载对应的字体族。

### 3. 如何确认和安装字体
*   **Windows**：字体名可能包含版本号。在“设置”->“个性化”->“字体”中搜索并查看字体属性，获取其完整名称（如`仿宋GB2312 v2.00.ttf`）。
*   **Linux (如Ubuntu)**：
    bash
    # 安装常用开源中文字体
    sudo apt-get install fonts-wqy-zenhei fonts-wqy-microhei fonts-noto-cjk fonts-arphic-ukai fonts-dejavu
    # 刷新字体缓存
    fc-cache -fv
    # 查看已安装字体名，用于排查
    fc-list


## 故障排查
1.  **XeLaTeX 编译缓慢**：通常是因为系统字体缓存问题或跨系统文件访问慢（如从Windows访问WSL内的文件）。
    *   **解决**：尝试在编译前刷新字体缓存：`fc-cache -fv`。对于WSL用户，建议将项目文件和工作区完全放在WSL文件系统内进行编译，速度显著提升。
2.  **字形替换警告**：LaTeX 在缩放数学公式字体时，若找不到精确尺寸，会使用最接近的尺寸替代。此类警告通常可忽略，不影响最终排版效果。
3.  **字体缺失错误**：检查是否正确指定了`windows`/`linux`选项，并确保对应系统上安装了所选字体类型包含的字体。

## VSCode 配置示例
以下 `settings.json` 配置可供参考，已包含针对本模板的优化编译链和清理设置。
```json
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
        "*.fdb_latexmk"
    ],
    //设置为onFaild 在构建失败后清除辅助文件
    "latex-workshop.latex.autoClean.run": "onFailed",
    // 使用上次的recipe编译组合
    "latex-workshop.latex.recipe.default": "大论文：xelatex -> biber -> xelatex*2",
    // 用于反向同步的内部查看器的键绑定。ctrl/cmd +点击(默认)或双击
    "latex-workshop.view.pdf.internal.synctex.keybinding": "double-click",
    /****end latex****/
```


## 支持与联系
如果在使用中遇到问题或有改进建议，欢迎通过以下方式联系：
+ **邮箱**：ballad_l@163.com
+ **建议**：请尽量详细描述您遇到的问题、使用的操作系统、TeX发行版版本以及相关的编译日志。

## 致谢
本模板的诞生与发展离不开前辈们的工作，在此特别感谢：
+ 原始模板基础：[liubenyuan/nudtpaper](https://github.com/liubenyuan/nudtpaper)
+ 提供了重要修正与参考：[TomHeaven/nudt_thesis](https://github.com/TomHeaven/nudt_thesis)
