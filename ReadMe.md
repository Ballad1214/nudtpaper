# NUDT 学位论文 LaTeX 模板

本仓库提供了一个用于撰写国防科技大学（NUDT）硕士/博士学位的 LaTeX 模板。此模板优化了目录结构，使其可读性更强同时统一并修正了以往多个版本中存在的不一致问题（如专硕支持、目录页眉页脚显示等），旨在提供清晰、高效且跨平台兼容的论文写作体验。

## 更新记录
+ **2026年3月14日**：简化字体配置，移除操作系统选项，只保留 ttf、otf、fz 三种字体选项。新增字体自动安装脚本，支持一键安装所需字体。
+ **2026年3月11日**：优化字体配置逻辑和目录结构，增加对 Windows 和 Linux 系统的跨平台支持。现在可通过文档类选项 `windows` 或 `linux` 自动适配对应操作系统的字体，无需手动修改 `.cls` 文件。
+ **2024年10月11日**：重构模板仓库，统一格式规范。主要修正包括：完善对专业学位（专硕）的支持，修复目录页前后空白页的页眉页脚显示问题，并整合了关键使用说明以提高效率。

## 系统要求与测试环境
模板已在以下环境中测试通过：
1.  **Windows 11** + VSCode + TeX Live 2021 / 2024
2.  **Windows 11(wsl2+Ubuntu 24.04)** + VSCode + TeX Live2025
3.  **macOS** + VSCode + MacTeX

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
| `ttf`, `otf`, `fz` | 字体方案（见下方#字体配置说明） |
| `anon` | 生成盲评版本（匿名作者、导师等信息） |
| `resumebib` | 使用 `biblatex` 从 `.bib` 文件生成作者成果列表（需与 `biber` 选项同用） |

**示例**：一个专硕、明评、双面打印、使用 `biblatex`、使用 TTF 字体的配置如下：
```latex
\documentclass[master,twoside,biber,prof,ttf]{src/nudtpaper}
```

如需使用 OTF 字体：
```latex
\documentclass[master,twoside,biber,prof,otf]{src/nudtpaper}
```

如需使用方正字体：
```latex
\documentclass[master,twoside,biber,prof,fz]{src/nudtpaper}
```

**控制评阅/存档版**：
在 `mainpaper.tex` 文件中（约第100行附近），通过 `\ifreview` 开关控制：
```latex
% 评阅版论文
% \newif\ifreview\reviewtrue
% 存档版论文
\newif\ifreview\reviewfalse
```

**关于独创性声明**：
模板已支持将签字扫描后的 `独创性声明扫描件.pdf` 直接插入最终论文。只需将该文件放置在根目录，模板会自动处理，无需每次用 PDF 编辑器手动合并。

## 字体配置
字体问题是编译失败和格式错误的常见原因。模板提供了三种预置的字体方案，用户只需选择适合自己系统的方案即可。

### 1. 学校模板要求字体
*   中文：仿宋_GB2312， 黑体， 宋体（本模板中宋体加粗由"华文中宋"替代）， 楷体_GB2312
*   英文：Times New Roman, Arial

### 2. 模板的字体方案
模板提供三种字体方案，用户只需在文档类选项中指定其中一种：

| 字体方案 | 说明 | 适用系统 |
| :--- | :--- | :--- |
| `ttf` | Windows/Linux 系统字体 | 已安装 Windows 系统字体或 Linux 默认字体 |
| `otf` | Adobe/Noto 字体 | 已安装 Adobe 字体或 Noto CJK 字体 |
| `fz` | 方正字体 | 已安装方正系列字体 |

### 3. 字体自动安装脚本使用方法
针对 Ubuntu/Linux 用户，我们提供了字体自动安装脚本，可一键安装所需的字体文件。

**使用步骤**：
1. 准备字体文件目录结构：
   ```
   项目目录/
   ├── install-fonts.sh    # 字体安装脚本
   └── font/               # 字体目录
       ├── fz/             # 方正字体 (.ttf/.otf)
       ├── ttf/            # TTF 字体 (.ttf)
       └── otf/            # OTF 字体 (.otf)
   ```

2. 设置脚本权限并运行：
   ```bash
   # 设置脚本执行权限
   chmod +x install-fonts.sh
   
   # 运行脚本（用户安装，推荐）
   ./install-fonts.sh
   
   # 或系统安装（需要 sudo 权限）
   sudo ./install-fonts.sh --system
   ```

3. 脚本功能：
   - 自动检测并安装字体目录下的字体文件
   - 按字体类型自动分类处理
   - 备份现有字体配置
   - 自动更新字体缓存
   - 提供详细的安装报告

### 4. 如何确认字体已正确安装
*   **Linux**：
    ```bash
    # 查看已安装字体
    fc-list
    
    # 搜索特定字体
    fc-list | grep -i "字体名称"
    
    # 刷新字体缓存
    fc-cache -fv
    ```

*   **Windows**：在"设置"→"个性化"→"字体"中查看已安装的字体。

## 故障排查
1.  **XeLaTeX 编译缓慢**：通常是因为系统字体缓存问题。
    *   **解决**：尝试在编译前刷新字体缓存：`fc-cache -fv`。

2.  **字形替换警告**：LaTeX 在缩放数学公式字体时，若找不到精确尺寸，会使用最接近的尺寸替代。此类警告通常可忽略，不影响最终排版效果。

3.  **字体缺失错误**：
    *   确保选择了正确的字体选项（ttf/otf/fz）
    *   确保系统上安装了所选字体方案对应的字体
    *   使用字体安装脚本（Linux用户）自动安装所需字体
    *   检查字体名称是否正确，Windows 字体名可能包含版本号

## VSCode 配置示例
以下 `settings.json` 配置可供参考，已包含针对本模板的优化编译链和清理设置。

```json
{
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
    "latex-workshop.view.pdf.internal.synctex.keybinding": "double-click"
}
```

## 支持与联系
如果在使用中遇到问题或有改进建议，欢迎通过以下方式联系：
+ **邮箱**：ballad_l@163.com
+ **建议**：请尽量详细描述您遇到的问题、使用的操作系统、TeX发行版版本以及相关的编译日志。

## 致谢
本模板的诞生与发展离不开前辈们的工作，在此特别感谢：
+ 原始模板基础：https://github.com/liubenyuan/nudtpaper
+ 提供了重要修正与参考：https://github.com/TomHeaven/nudt_thesis