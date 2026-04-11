%% 本文件由 docstrip 工具生成。
%%
%% 原始源文件为：
%% nudtpaper.dtx (包含选项 `cls')
%%
%% 这是一个生成的文件。
%%
%% 版权所有 (C) 2020 Liu Benyuan <liubenyuan@gmail.com>
%%
%% 本文件可依据 LaTeX 项目公共许可证 (LaTeX Project Public License) 1.3a 版
%% 或更高版本（您可自行选择）进行分发和/或修改。
%% 该许可证的最新版本可在以下网址找到：
%% http://www.latex-project.org/lppl.txt
%%
%% 该许可证的 1.3a 版及更高版本是 LaTeX 2004/10/01 版及之后所有发行的组成部分。
%%
%% 如需生成文档，请将扩展名为 `.dtx' 的原始源文件运行于 LaTeX。
%%
%% 如有任何建议，请联系：LiuBenYuan <liubenyuan@gmail.com>
%% 感谢 Xue Ruini <xueruini@gmail.com> 提供的 thuthesis 类！
%% 感谢 sofoot 提供的原始 NUDT 论文类！
%%
%% 本文件由 Ballad 在原有模板基础上进行了修改和优化，主要修改包括：
%% 1. 简化字体选项，只保留 ttf、otf、fz 三种字体配置
%% 2. 修正目录页前后空白页的页眉页脚显示问题
%% 3. 支持直接插入独创性声明扫描件 PDF 文件，无需手动合并
%% 4. 优化文档结构与代码注释，提高可维护性
%% 修改日期：2026年3月11日
%%

\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{nudtpaper}
[2020/07/01 v2.8 NUDT 学位论文模板]

% ============================================================================
% 1. 类选项声明
% ============================================================================
\newif\ifismaster\ismastertrue
\DeclareOption{master}{\ismastertrue}   % 硕士学位论文
\DeclareOption{doctor}{\ismasterfalse}  % 博士学位论文
\newif\ifisanon\isanonfalse
\DeclareOption{anon}{\isanontrue}       % 盲评（匿名）版本
\newif\ifisreview\isreviewfalse
\DeclareOption{review}{\isreviewtrue}   % 评阅版本

\newif\ifisaddreview\isaddreviewfalse
\DeclareOption{addreview}{\isaddreviewtrue} % 复核专家组版本

\newif\ifistwoside\istwosidefalse
\DeclareOption{twoside}{\istwosidetrue} % 双面打印
\newif\ifisprof\isproffalse
\DeclareOption{prof}{\isproftrue}       % 专业学位
\DeclareOption*{\PackageWarning{nudtpaper}{未知选项 '\CurrentOption'}}

% 字体选项（简化版，只保留 ttf、otf、fz）
\newif\ifisttf\isttffalse
\newif\ifisotf\isotffalse
\newif\ifisfz\isfzfalse
\DeclareOption{ttf}{\isttftrue}      % Windows/Linux 系统字体
\DeclareOption{otf}{\isotftrue}      % Adobe/Noto 字体
\DeclareOption{fz}{\isfztrue}        % 方正字体

% 参考文献处理选项
\newif\ifisbiber\isbiberfalse
\DeclareOption{biber}{\isbibertrue}  % 使用 biblatex + biber
\newif\ifisresumebib\isresumebibfalse
\DeclareOption{resumebib}{\isresumebibtrue} % 使用 biblatex 生成成果列表

\ProcessOptions\relax

% ============================================================================
% 2. 基础类与宏包加载
% ============================================================================
\RequirePackage{ifthen,calc}
\ifistwoside
  \LoadClass[a4paper,12pt,openright,twoside]{book}
\else
  \LoadClass[a4paper,12pt,openany]{book}
\fi

% 页面布局与标题样式
\RequirePackage[includeheadfoot]{geometry}
\RequirePackage[center,pagestyles]{titlesec}
\RequirePackage{titletoc}
\RequirePackage{graphicx}
\RequirePackage[config]{subfig}
\RequirePackage{float}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{tabularx}
\RequirePackage{src/slashbox}     % 表格斜线分割宏包
\RequirePackage[neverdecrease]{paralist}
\RequirePackage{enumitem}
\RequirePackage{xcolor}

% 数学相关宏包
\RequirePackage{amsmath,amssymb}
\RequirePackage[Symbolsmallscale]{upgreek}
\interdisplaylinepenalty=2500
\RequirePackage{bm}
\RequirePackage[T1]{fontenc}

% 定理与证明环境
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}

% 中文字体与编码支持
\RequirePackage[CJKchecksingle,no-math]{xeCJK}
\RequirePackage{zhnumber}
\RequirePackage{indentfirst}
\RequirePackage{xunicode-addon}
\RequirePackage{notoccite}

% 实用宏包
\RequirePackage{pdfpages}  % 插入 PDF 文件

% 自定义波浪线符号
\newcommand{\fttilde}{\fontspec{FreeSerif}\selectfont}

% ============================================================================
% 3. 参考文献处理配置
% ============================================================================
\ifisbiber
  % 使用 biblatex + biber
  \RequirePackage[backend=biber,style=gb7714-2015,gbalign=gb7714-2015,%
                  gbnamefmt=lowercase,gbpub=false]{biblatex}%
  
  % 参考文献条目格式设置
  \setlength{\bibitemsep}{1pt}
  \setlength{\bibnamesep}{0ex}
  \setlength{\bibinitsep}{0ex}
  \setlength{\biblabelsep}{6pt}
  \newlength{\refindent}
  \setlength{\refindent}{24pt}
  
  \renewcommand{\itemcmd}{%
    \setlength{\lengthid}{0cm}%
    \setlength{\lengthlw}{\textwidth}%
    \addtolength{\lengthlw}{-\lengthid}%
    \addvspace{\bibitemsep}%
    \hangindent\lengthid%
    \hspace{\refindent}\mkgbnumlabel{\printfield{labelnumber}}%
    \hspace{\biblabelsep}}
  
  % 页码间隔符设置
  \DefineBibliographyExtras{english}{\renewcommand*{\bibrangedash}{{\fttilde\textsim}}}
  
  % 参考文献标题格式
  \defbibheading{subbibliography}[\bibname]{%
    \section*{#1}}
  
  % 编辑者格式设置
  \DeclareDelimFormat{streditortypes}{\bibopenparen%
    \edef\userfieldabcde{userd}%
    \ifcurrentname{editor}{\edef\userfieldabcde{userc}}{}%
    \ifcurrentname{bookauthor}{\edef\userfieldabcde{userb}}{}%
    \ifcase\value{gbbiblocalcase}%
      \iffieldequalstr{\userfieldabcde}{chinese}{\bibstring{\thefield{editortype}scn}}{}%
      \iffieldequalstr{\userfieldabcde}{korean}{\bibstring{\thefield{editortype}skr}}{}%
      \iffieldequalstr{\userfieldabcde}{japanese}{\bibstring{\thefield{editortype}sjp}}{}%
      \iffieldequalstr{\userfieldabcde}{english}{\bibstring{\thefield{editortype}s}}{}%
      \iffieldequalstr{\userfieldabcde}{french}{\bibstring{\thefield{editortype}s}}{}%
      \iffieldequalstr{\userfieldabcde}{russian}{\bibstring{\thefield{editortype}s}}{}%
    \or%
    \bibstring{\thefield{editortype}scn}%
    \or%
    \bibstring{\thefield{editortype}s}%
    \fi\bibcloseparen}
  
  \DeclareDelimFormat{streditortype}{\bibopenparen%
    \edef\userfieldabcde{userd}%
    \ifcurrentname{editor}{\edef\userfieldabcde{userc}}{}%
    \ifcurrentname{bookauthor}{\edef\userfieldabcde{userb}}{}%
    \ifcase\value{gbbiblocalcase}%
      \iffieldequalstr{\userfieldabcde}{chinese}{\bibstring{\thefield{editortype}cn}}{}%
      \iffieldequalstr{\userfieldabcde}{korean}{\bibstring{\thefield{editortype}kr}}{}%
      \iffieldequalstr{\userfieldabcde}{japanese}{\bibstring{\thefield{editortype}jp}}{}%
      \iffieldequalstr{\userfieldabcde}{english}{\bibstring{\thefield{editortype}}}{}%
      \iffieldequalstr{\userfieldabcde}{french}{\bibstring{\thefield{editortype}}}{}%
      \iffieldequalstr{\userfieldabcde}{russian}{\bibstring{\thefield{editortype}}}{}%
    \or%
    \bibstring{\thefield{editortype}cn}%
    \or%
    \bibstring{\thefield{editortype}}%
    \fi\bibcloseparen}
  
  % 文章中引用格式
  \renewbibmacro*{in:}{%
    \iftoggle{bbx:gbpunctin}{\printtext{\textbf{//}\allowbreak}}%
    {\setunit{\adddot\addspace}%
     \iffieldequalstr{userd}{chinese}%
     {\printtext{\bibstring{incn}}}%
     {\printtext{\bibstring{in}}}%
    }}
  
  % 成果列表参考文献环境设置
  \ifisresumebib
    \defbibenvironment{resumebib}{%
      \list
        {\printtext[labelnumberwidth]{%
          \printfield{labelprefix}%
          \printfield{labelnumber}}}
        {\setlength{\labelwidth}{\labelnumberwidth}%
         \setlength{\labelsep}{\biblabelsep}%
         \setlength{\leftmargin}{\bibhang}%
         \addtolength{\leftmargin}{\labelnumberwidth}%
         \setlength{\itemindent}{\bibitemindent}%
         \setlength{\itemsep}{\bibitemsep}%
         \setlength{\parsep}{\bibparsep}}%
         \renewcommand*{\makelabel}[1]{\hss##1}}
      {\endlist}
      {\item}
  \fi
\else
  % 使用传统 natbib + bibtex
  \RequirePackage[numbers,sort&compress,square]{natbib}
  \let\newcite=\cite
  \let\parencite=\newcite
  \let\inlinecite=\newcite
  \newcommand{\upcite}[1]{\textsuperscript{\newcite{#1}}} % 上标形式引用
  \renewcommand{\cite}[1]{\textsuperscript{\newcite{#1}}} % 上标形式引用
\fi

% ============================================================================
% 4. 超链接与日期设置
% ============================================================================
\RequirePackage[bookmarksnumbered=true,colorlinks=false,linkcolor=black,citecolor=black,pdfborder=0 1 1]{hyperref}
\RequirePackage{datetime}
\defaultfontfeatures{Mapping=tex-text}
\xeCJKsetcharclass{"0}{"2E7F}{0}
\xeCJKsetcharclass{"2E80}{"FFFF}{1}

% ============================================================================
% 5. 字体配置
% ============================================================================
% 5.1 TTF 字体配置
\newcommand{\installttf}{
  %%%% 英文字体
  \setmainfont{Times New Roman}
  \setsansfont{Arial}
  \setmonofont{Courier New}
  %%%% 中文字体
  \setCJKmainfont[BoldFont={STZhongsong}]{SimSun}
  \setCJKsansfont{SimHei} % 黑体
  \setCJKmonofont{FangSong_GB2312} % 仿宋
  %%%% 字体别名
  \setCJKfamilyfont{song}{SimSun}
  \setCJKfamilyfont{hei}{SimHei}
  \setCJKfamilyfont{fs}{FangSong_GB2312} % 仿宋
  \setCJKfamilyfont{kai}{KaiTi_GB2312}   % 楷体
}

% 5.2 OTF 字体配置（Adobe/Noto 字体）
\newcommand{\installotf}{
  %%%% 英文字体
  \setmainfont{Times New Roman PS Std}
  \setsansfont{Arial}
  \setmonofont{Courier New}
  %%%% 中文字体
  \setCJKmainfont[BoldFont={STZhongsong}]{Adobe Song Std}
  \setCJKsansfont{Adobe Heiti Std} % 黑体
  \setCJKmonofont{Adobe Fangsong Std} % 仿宋
  %%%% 字体别名
  \setCJKfamilyfont{song}{Adobe Song Std}
  \setCJKfamilyfont{hei}{Adobe Heiti Std}
  \setCJKfamilyfont{fs}{Adobe Fangsong Std} % 仿宋
  \setCJKfamilyfont{kai}{Adobe Kaiti Std}   % 楷体
}

% 5.3 FZ 字体配置（方正字体）
\newcommand{\installfz}{
  %%%% 英文字体
  \setmainfont{Times New Roman}
  \setsansfont{Arial}
  \setmonofont{Courier New}
  %%%% 中文字体
  \setCJKmainfont[BoldFont={FZYaSong-DB-GBK}]{FZShuSong_GB18030-Z01}
  \setCJKsansfont{FZHei-B01} % 黑体
  \setCJKmonofont{FZFangSong-Z02} % 仿宋
  %%%% 字体别名
  \setCJKfamilyfont{song}{FZShuSong_GB18030-Z01}
  \setCJKfamilyfont{hei}{FZHei-B01}
  \setCJKfamilyfont{fs}{FZFangSong-Z02} % 仿宋
  \setCJKfamilyfont{kai}{FZKai-Z03}     % 楷体
}

% 5.4 根据字体选项选择配置
\ifisttf
  \installttf
\fi
\ifisotf
  \installotf
\fi
\ifisfz
  \installfz
\fi

% 5.5 如果没有指定字体选项，默认使用 TTF
\ifisttf\else\ifisotf\else\ifisfz\else
  \installttf
\fi\fi\fi

% ============================================================================
% 6. 字体与排版命令定义
% ============================================================================
% 字体命令别名
\newcommand{\cusong}{\bfseries}
\newcommand{\song}{\CJKfamily{song}}     % 宋体
\newcommand{\fs}{\CJKfamily{fs}}         % 仿宋体
\newcommand{\kai}{\CJKfamily{kai}}       % 楷体
\newcommand{\hei}{\CJKfamily{hei}}       % 黑体
\def\songti{\song}
\def\fangsong{\fs}
\def\kaishu{\kai}
\def\heiti{\hei}

% 字号定义
\newlength\thu@linespace
\newcommand{\thu@choosefont}[2]{%
    \setlength{\thu@linespace}{#2*\real{#1}}%
    \fontsize{#2}{\thu@linespace}\selectfont}
\def\thu@define@fontsize#1#2{%
    \expandafter\newcommand\csname #1\endcsname[1][\baselinestretch]{%
    \thu@choosefont{##1}{#2}}}

% 中文字号定义
\thu@define@fontsize{chuhao}{42bp}     % 初号
\thu@define@fontsize{xiaochu}{36bp}    % 小初
\thu@define@fontsize{yihao}{26bp}      % 一号
\thu@define@fontsize{xiaoyi}{24bp}     % 小一
\thu@define@fontsize{erhao}{22bp}      % 二号
\thu@define@fontsize{xiaoer}{18bp}     % 小二
\thu@define@fontsize{sanhao}{16bp}     % 三号
\thu@define@fontsize{xiaosan}{15bp}    % 小三
\thu@define@fontsize{sihao}{14bp}      % 四号
\thu@define@fontsize{banxiaosi}{13bp}  % 半小四
\thu@define@fontsize{xiaosi}{12bp}     % 小四
\thu@define@fontsize{dawu}{11bp}       % 大五
\thu@define@fontsize{wuhao}{10.5bp}    % 五号
\thu@define@fontsize{xiaowu}{9bp}      % 小五
\thu@define@fontsize{liuhao}{7.5bp}    % 六号
\thu@define@fontsize{xiaoliu}{6.5bp}   % 小六
\thu@define@fontsize{qihao}{5.5bp}     % 七号
\thu@define@fontsize{bahao}{5bp}       % 八号

% 常用字符串定义
\newcommand{\china}{中华人民共和国}
\def\nudtpaper{\textsc{Nudt}\textsc{Paper}}

% 标点符号定义
\newcommand{\pozhehao}{\kern0.2em\rule[0.8ex]{1.6em}{0.1ex}\kern0.2em}  % 全角破折号
\newcommand{\xiaopozhe}{\kern0.2em\rule[0.8ex]{0.6em}{0.1ex}\kern0.2em} % 半角破折号

% 目录和图表标题名称
\renewcommand\contentsname{目\hspace{1em}录}
\renewcommand\listfigurename{图\hspace{1em}目\hspace{1em}录}
\renewcommand\listtablename{表\hspace{1em}目\hspace{1em}录}
\newcommand\listequationname{公式索引}
\newcommand\equationname{公式}
\renewcommand\bibname{参考文献}
\renewcommand\indexname{索引}
\renewcommand\figurename{图}
\renewcommand\tablename{表}
\renewcommand\appendixname{附录}

% 日期格式
\def\CJK@today{\zhdigits{\the\year}年\zhnumber{\the\month}月}
\renewcommand\zhtoday{\CJK@today}
\newcommand\entoday{\monthname{}, \the\year}

% ============================================================================
% 7. 页面布局设置
% ============================================================================
\geometry{top=21mm,bottom=25.5mm,left=30mm,right=30mm}
\geometry{headheight=9mm,headsep=1mm,footskip=9mm}

% 页眉页脚样式
\renewcommand\setheadrule[1]{%
  \ifdim#1=\z@
    \let\makeheadrule\@empty
  \else
    \def\makeheadrule{%
    \makebox[0pt][l]{\rule[.2\baselineskip]{\linewidth}{1.5pt}}%
    \rule{\linewidth}{1.5pt}}%
  \fi}

\renewpagestyle{plain}{
  \sethead{}{\raisebox{.65\baselineskip}{\songti \wuhao \ifisanon{~}\else{国防科技大学\@optionpaperclass{}学位论文}\fi}}{}%
  \setfoot{}{{\songti \wuhao 第~\thepage~页}}{}%
  \headrule%
  \footrule%
}
\setfootrule{1bp}

% ============================================================================
% 8. 文档结构命令
% ============================================================================
\renewcommand\frontmatter{%
    \if@openright\cleardoublepage\else\clearpage\fi
    \@mainmatterfalse
    \pagenumbering{Roman}
    \pagestyle{plain}}

\newcommand\midmatter{%
    \if@openright\cleardoublepage\else\clearpage\fi
    \@mainmatterfalse
    \pagenumbering{roman}
    \pagestyle{plain}}

\renewcommand\mainmatter{%
    \if@openright\cleardoublepage\else\clearpage\fi
    \@mainmattertrue
    \pagenumbering{arabic}
    \pagestyle{plain}}

\renewcommand\backmatter{%
    \if@openright\cleardoublepage\else\clearpage\fi
    \titleformat{\chapter}{\filcenter \heiti \sanhao}{附录\,\thechapter\,}{1em}{}
    \titlecontents{chapter}[0pt]{\vspace{0.25\baselineskip} \heiti \xiaosi[1.25]}
      {附录\,\thecontentslabel\quad}{}
      {\hspace{.5em}\titlerule*{.}\contentspage}
    \@mainmattertrue
    \pagestyle{plain}}

\renewcommand\cleardoublepage{\clearpage\if@openright \ifodd\c@page\else
  \newpage{}
  \thispagestyle{plain}%empty->plain
  \vspace*{\fill}
  \begin{center}
  \end{center}
  \vspace*{\fill}
  \clearpage\fi\fi%
}

% 目录格式
\titlecontents{chapter}[0pt]{\vspace{0.25\baselineskip} \heiti \xiaosi[1.25]}
    {第\zhnumber{\thecontentslabel}章\quad}{}
    {\hspace{.5em}\titlerule*{.}\contentspage}
\titlecontents{section}[2em]{\songti \xiaosi[1.25]}
    {\thecontentslabel\quad}{}
    {\hspace{.5em}\titlerule*{.}\contentspage}
\titlecontents{subsection}[4em]{\songti \xiaosi[1.25]}
    {\thecontentslabel\quad}{}
    {\hspace{.5em}\titlerule*{.}\contentspage}
\titlecontents{figure}[0pt]{\songti \xiaosi[1.25]}
    {\makebox[3.5em][l]{图~\thecontentslabel\quad}}{}
    {\hspace{.5em}\titlerule*{.}\contentspage}
\titlecontents{table}[0pt]{\songti \xiaosi[1.25]}
    {\makebox[3.5em][l]{表~\thecontentslabel\quad}}{}
    {\hspace{.5em}\titlerule*{.}\contentspage}

% 章节命令重定义
\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{plain}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\nudt@chapter\@schapter}
\def\nudt@chapter[#1]#2{
  \ifnum \c@secnumdepth >\m@ne
    \if@openright\cleardoublepage\else\clearpage\fi
    \phantomsection
    \if@mainmatter
      \refstepcounter{chapter}%
      \addcontentsline{toc}{chapter}%
        {\protect\numberline{\thechapter}#1}%
    \else
      \addcontentsline{toc}{chapter}{#1}%
    \fi
  \else
    \addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \if@twocolumn
    \@topnewpage[\@makechapterhead{#2}]%
  \else
    \@makechapterhead{#2}%
    \@afterheading
  \fi
}

% ============================================================================
% 9. 摘要与关键词环境
% ============================================================================
\newcommand\cabstractname{摘\hspace{1em}要}
\newcommand\eabstractname{ABSTRACT}
\newcommand\ckeywordsname{关键词}
\newcommand\ckeywords[1]{{\hei\xiaosi \ckeywordsname：#1}}
\newcommand\ekeywordsname{Key Words}
\newcommand\ekeywords[1]{\textsf{\xiaosi \ekeywordsname：#1}}

\newenvironment{cabstract}{%
    \chapter{\cabstractname}
    \xiaosi
    \@afterheading}
    {\par\vspace{2em}\par}

\newenvironment{eabstract}{%
    \chapter{\textsf{\eabstractname}}
    \xiaosi
    \@afterheading}
    {\par\vspace{2em}\par}

% ============================================================================
% 10. 章节格式与间距设置
% ============================================================================
\newcommand{\sectionbreak}{%
  \addpenalty{-300}%
  \vspace*{0pt}%
}

\setlength{\topskip}{0pt}
\setcounter{secnumdepth}{3}
\setlength{\footnotesep}{2.2ex \@minus 2bp}

\titleformat{\chapter}{\filcenter\sf \heiti\sanhao[1.25]}{第\zhnumber{\thechapter}章\,}{1em}{}
\titleformat{\section}{\filcenter\bfseries \cusong\sihao[1.25]}{\thesection}{1em}{}
\titleformat{\subsection}{\sf \heiti\xiaosi[1.25]}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{\bfseries \cusong\xiaosi[1.25]}{\thesubsubsection}{1em}{}

\titlespacing{\chapter}{0pt}{2.4ex-\topskip-\heightof{A}}{2.4ex \@minus 2bp}
\titlespacing{\section}{0pt}{2ex-\heightof{a}}{2ex \@minus 2bp}
\titlespacing{\subsection}{2em}{2ex \@minus 2bp}{2ex \@minus 2bp}
\titlespacing{\subsubsection}{2em}{1ex \@minus 2bp}{1ex \@minus 2bp}

% 正文大小设置
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{12.87bp}%
  \renewcommand{\baselinestretch}{1.3}%
  \setlength\abovedisplayskip{10bp \@minus 1bp}%
  \setlength\abovedisplayshortskip{10bp \@minus 1bp}%
  \setlength\belowdisplayskip{\abovedisplayskip}%
  \setlength\belowdisplayshortskip{\abovedisplayshortskip}%
}

% 中文段落缩进
\newlength\CJK@twochars
\def\CJKindent{%
  \settowidth\CJK@twochars{中国}%
  \parindent\CJK@twochars}
\AtBeginDocument{%
  \CJKindent\relax
  \checkparameter\relax
}

\setlength{\parskip}{0bp \@minus 1bp}
\newcommand*{\ziju}[1]{\renewcommand{\CJKglue}{\hskip #1}}

% ============================================================================
% 11. 参考文献环境设置
% ============================================================================
\newlength\biblabelwd
\settowidth\biblabelwd{\widthof{[999]}} % 最大参考文献编号宽度

\renewenvironment{thebibliography}[1]{%
  \chapter*{\bibname}%
  \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
  \begin{enumerate}[label={[\arabic{enumi}]},itemsep=0pt,parsep=0pt,labelindent=\CJK@twochars,labelwidth=\biblabelwd,leftmargin=0pt,itemindent=*,align=left]
  \@openbib@code%
  \sloppy\frenchspacing%
  \clubpenalty4000%
  \widowpenalty4000%
  \interlinepenalty4000%
  \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
     \end{enumerate}\frenchspacing}

% ============================================================================
% 12. 浮动体设置
% ============================================================================
\setlength{\floatsep}{12bp}
\setlength{\intextsep}{12bp}
\setlength{\textfloatsep}{12bp}
\setlength{\@fptop}{0bp}
\setlength{\@fpsep}{12bp}
\setlength{\@fpbot}{0bp}

\renewcommand{\textfraction}{0.01}
\renewcommand{\topfraction}{0.98}
\renewcommand{\bottomfraction}{0.98}
\renewcommand{\floatpagefraction}{0.90}

\clubpenalty=5000
\widowpenalty=5000
\displaywidowpenalty=5000

% 表格字体设置
\let\old@tabular\@tabular
\def\thu@tabular{\wuhao[1.25]\old@tabular}

% 图表标题设置
\DeclareCaptionLabelFormat{thu}{{\wuhao[1.25]\song#1~\rmfamily #2}}
\DeclareCaptionLabelSeparator{thu}{\hspace{1em}}
\DeclareCaptionFont{thu}{\wuhao[1.25]}
\captionsetup{labelformat=thu,labelsep=thu,font=thu}
\captionsetup[table]{position=top,belowskip=0bp \@plus 2bp \@minus 2bp,aboveskip=6bp \@plus 2bp \@minus 2bp}%
\captionsetup[figure]{position=bottom,belowskip=-3bp \@plus 2bp \@minus 2bp,aboveskip=6bp \@plus 2bp \@minus 2bp}%
\captionsetup[subfloat]{labelformat=simple,font=thu,captionskip=6bp,nearskip=6bp,farskip=0bp,topadjust=0bp}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\renewcommand{\thesubtable}{(\alph{subtable})}

% 长表格设置
\let\thu@LT@array\LT@array
\def\LT@array{\thu@LT@array}

% ============================================================================
% 13. 自定义环境定义
% ============================================================================
% 符号列表环境
\newenvironment{denotation}[1][2.71828cm]{
    \noindent\vskip-4bp\begin{list}{}%
    {\vskip-30bp\xiaosi[1.5]
    \renewcommand\makelabel[1]{\textbf{##1}\hfil}
    \setlength{\labelwidth}{#1} % 标签盒子宽度
    \setlength{\labelsep}{0cm} % 标签与列表文本距离
    \setlength{\itemindent}{0em} % 标签缩进量
    \setlength{\leftmargin}{\labelwidth+\labelsep+2em} % 左边界
    \setlength{\rightmargin}{0cm}
    \setlength{\parsep}{0cm} % 段落间距
    \setlength{\itemsep}{0cm} % 标签间距
    \setlength{\listparindent}{0pt} % 段落缩进量
    \setlength{\topsep}{0pt} % 标签与上文的间距
}}{\end{list}}

% 致谢环境
\newenvironment{ack}{%
    \chapter*{致\hspace{1em}谢}%
    \addcontentsline{toc}{chapter}{致谢}%
    \ifisanon\color{white}\else\relax\fi%
    \xiaosi%
    \@afterheading}
    {\par\vspace{2em}\par}

% 作者成果环境
\newenvironment{resume}{%
    \chapter*{作者在学期间取得的学术成果}
    \addcontentsline{toc}{chapter}{作者在学期间取得的学术成果}
    \xiaosi
    \@afterheading\vspace{-0.5em}}
    {\par\vspace{2em}\par}

% 公开评阅信息环境
\newenvironment{reviewinfo}{
    \chapter*{公开评阅信息}
    \addcontentsline{toc}{chapter}{公开评阅信息}
    \xiaosi
    \@afterheading\vspace{-1em}}
    {\par\vspace{2em}\par}

% 答辩委员会信息环境
\newenvironment{defenseinfo}{
    \chapter*{答辩委员会}
    \addcontentsline{toc}{chapter}{答辩委员会}
    \xiaosi
    \@afterheading\vspace{-1em}}
    {\par\vspace{2em}\par}

% 复核专家组信息环境
\newenvironment{addreviewinfo}{
    \chapter*{复核专家组}
    \addcontentsline{toc}{chapter}{复核专家组}
    \xiaosi
    \@afterheading\vspace{-1em}}
    {\par\vspace{2em}\par}
% ============================================================================
% 14. 定理与证明环境设置
% ============================================================================
% 无编号定理样式
\renewtheoremstyle{nonumberplain}%
  {\item[\hspace*{2em} \theorem@headerfont ##1\ \theorem@separator]}%
  {\item[\hspace*{2em} \theorem@headerfont ##1\ (##3)\theorem@separator]}
\theoremstyle{nonumberplain}
\theorembodyfont{\kai\xiaosi[1.3]}
\theoremheaderfont{\hei\xiaosi[1.3]}
\theoremseparator{:\,}
\newtheorem{proof}{证明}[chapter]
\newtheorem{assumption}{假设}[chapter]

% 有编号定理样式
\renewtheoremstyle{plain}%
  {\item[\hspace*{2em} \theorem@headerfont ##1\ ##2\theorem@separator]}%
  {\item[\hspace*{2em} \theorem@headerfont ##1\ ##2\ (##3)\theorem@separator]}
\theoremstyle{plain}
\theorembodyfont{\kai\xiaosi[1.3]}
\theoremheaderfont{\hei\xiaosi[1.3]}
\theoremsymbol{}
\newtheorem{definition}{定义}[chapter]
\newtheorem{lemma}{引理}[chapter]
\newtheorem{theorem}{定理}[chapter]
\newtheorem{axiom}{公理}[chapter]
\newtheorem{corollary}{推论}[chapter]
\newtheorem{conjecture}{猜想}[chapter]
\newtheorem{proposition}{命题}[chapter]
\newtheorem{exercise}{练习}[section]
\newtheorem{example}{例}[chapter]
\newtheorem{problem}{问题}[section]
\newtheorem{remark}{注释}[section]

% ============================================================================
% 15. 封面信息命令定义
% ============================================================================
\def\classification#1{\def\@classification{#1}}     % 中图分类号
\def\serialno#1{\def\@serialno{#1}}                 % 学号
\def\UDC#1{\def\@UDC{#1}}                           % UDC号
\def\confidentiality#1{\def\@confidentiality{#1}}   % 密级
\def\title#1{\def\@title{#1}}                       % 中文题目
\newtoks\displaytitle                               % 用于独创性声明的题目
\def\author#1{\def\@author{#1}}
\def\zhdate#1{\def\@zhdate{#1}}                     % 中文日期
\def\subject#1{\def\@subject{#1}}                   % 中文学科
\def\researchfield#1{\def\@researchfield{#1}}       % 中文研究方向
\def\supervisor#1{\def\@supervisor{#1}}             % 导师
\def\cosupervisor#1{\def\@cosupervisor{#1}}         % 协助指导教师
\def\papertype#1{\def\@papertype{#1}}               % 工学/理学
\def\entitle#1{\def\@entitle{#1}}                   % 英文题目
\def\enauthor#1{\def\@enauthor{#1}}                 % 英文作者
\def\ensupervisor#1{\def\@ensupervisor{#1}}         % 英文导师
\def\encosupervisor#1{\def\@encosupervisor{#1}}     % 英文协助指导教师
\def\endate#1{\def\@endate{#1}}                     % 英文日期
\def\ensubject#1{\def\@ensubject{#1}}               % 英文专业
\def\enpapertype#1{\def\@enpapertype{#1}}           % Engineering/Science
\def\optionpaperclass#1{\def\@optionpaperclass{#1}} % 学位类别
\def\optionpaperclassen#1{\def\@optionpaperclassen{#1}} % 英文学位类别
\def\optionas#1{\def\@optionas{#1}}                 % 指导教师称谓

% 默认学位设置
\ifismaster
  \optionpaperclass{硕士}
  \optionpaperclassen{Master}
  \optionas{Supervisor}
\else
  \optionpaperclass{博士}
  \optionpaperclassen{Ph.D}
  \optionas{Supervisor}
\fi

% 参数检查
\newcommand{\checkparameter}
{
  \ifthenelse{\isundefined{\@cosupervisor}}{\cosupervisor{}}{}
  \ifthenelse{\isundefined{\@encosupervisor}}{\encosupervisor{}}{}
}

% ============================================================================
% 16. 辅助命令定义
% ============================================================================
% 空双页命令（用于目录前的空白页）
\newcommand\emptydoublepage{\clearpage\if@openright \ifodd\c@page\else
  \newpage{}
  \thispagestyle{empty}%empty->plain
  \vspace*{\fill}
  \begin{center}
  \end{center}
  \vspace*{\fill}
  \clearpage\fi\fi%
}

% ============================================================================
% 17. 封面生成命令
% ============================================================================
\def\maketitle{%
  \def\entry##1##2##3{%
    \multicolumn{##1}{l}{\underline{\hbox to ##2{\hfil##3\hfil}}}
    }
  \null
  \ifisanon%
  \author{}%
  \serialno{}%
  \enauthor{}%
  \supervisor{}%
  \cosupervisor{}%
  \ensupervisor{}%
  \encosupervisor{}%
  \else\relax\fi%
  \pagenumbering{alph}% 不显示页码，仅用于打印
  \thispagestyle{empty}%
  \begin{center}\leavevmode % 表格环境
  {\fangsong \wuhao[1.25]%
    \begin{tabular}{llcll}
    分类号  & \entry{1}{3.2cm}{\@classification} & \hspace*{4.8cm}%
    学号    & \entry{1}{3.2cm}{\@serialno}         \\[5mm]    %
    U\ D\ C & \entry{1}{3.2cm}{\@UDC} &            \hspace*{4.8cm}
    密级 & \entry{1}{3.2cm}{\@confidentiality}
    \end{tabular}
  }
  \par
  \vspace*{2.5cm} % 插入空白
  {\heiti\sanhao \@optionpaperclass{}学位论文}\\
    \vspace{10bp}
    {\heiti\sanhao\ifisprof{（专业学位）}\else{（学术学位）}\fi}\\
  \vspace{12bp}
  {\cusong\erhao[1.25] \@title \par}%
  \vspace{45bp} % 从WORD中得来
  {\heiti \sihao
    \begin{tabular}{cp{8cm}c}
      \ifismaster
      \raisebox{-3.7ex}[0pt]{\makebox[3cm][s]{硕\hfill{}士\hfill{}生\hfill{}姓\hfill{}名}} &
      \else
      \raisebox{-3.7ex}[0pt]{\makebox[3cm][s]{博\hfill{}士\hfill{}生\hfill{}姓\hfill{}名}} &
      \fi
        {\fs \hfil\raisebox{-3.7ex}[0pt]{\@author}\hfil{}} & \\[3.2ex]
        \cline{2-2}
        % \ifisprof
        % \raisebox{-3.7ex}[0pt]{\makebox[3cm][s]{专\hfill{}业\hfill{}学\hfill{}位\hfill{}类\hfill{}别}} &
        % \else
        \raisebox{-3.7ex}[0pt]{\makebox[3cm][s]{学\hfill{}科\hfill{}专\hfill{}业}} &
        % \fi
        {\fs \hfil\raisebox{-3.7ex}[0pt]{\@subject}\hfil{}} & \\[3.2ex]
        \cline{2-2}
        % \ifisprof
        % \raisebox{-3.7ex}[0pt]{\makebox[3cm][s]{专\hfill{}业\hfill{}学\hfill{}位\hfill{}领\hfill{}域}} &
        % \else
        \raisebox{-3.7ex}[0pt]{\makebox[3cm][s]{研\hfill{}究\hfill{}方\hfill{}向}} &
        % \fi
        {\fs \hfil\raisebox{-3.7ex}[0pt]{\@researchfield}\hfil{}} & \\[3.2ex]
        \cline{2-2}
        \raisebox{-3.7ex}[0pt]{\makebox[3cm][s]{指\hfill{}导\hfill{}教\hfill{}师}} &
        {\fs \hfil\raisebox{-3.7ex}[0pt]{\@supervisor}\hfil{}} & \\[3.2ex]
        \cline{2-2}
      \ifx\@cosupervisor\@empty\else
      \raisebox{-3.7ex}[0pt]{\makebox[3cm][s]{协\hfill{}助\hfill{}指\hfill{}导\hfill{}教\hfill{}师}} &
          {\fs \hfil\raisebox{-3.7ex}[0pt]{\@cosupervisor}\hfil{}} & \\[3.2ex]
          \cline{2-2}
      \fi
    \end{tabular}
  }
  \end{center}%

  \par
  \vfill
  {\centering \cusong \sanhao \ifisanon{~}\else{国防科技大学}\fi\\[0.8em]
    {\@zhdate \par}%
  }
  \vspace{1mm}
  \emptydoublepage
  % \cleardoublepage
  \newpage
  \thispagestyle{empty}%

  \begin{center}\leavevmode
  \vfill\bfseries
  {\erhao[1.25] \@entitle \par}
  {\sanhao[1.25]
  \vfill\vfill\vfill\vfill\vfill\vfill
  \begin{tabular}{rl}
    Candidate:\ & {\textsf{\@enauthor}}\\
    \@optionas{}:\ & {\textsf{\@ensupervisor}}\\
    \ifx\@encosupervisor\@empty\else
      Associate \@optionas{}:\ & {\textsf{\@encosupervisor}} \\
    \fi
  \end{tabular}}
  \vfill\vfill\vfill\vfill
  {\sanhao[1.5]
A \ifisprof{thesis}\else{dissertation} \fi \\
Submitted in partial fulfillment of the requirements\\
for the \ifisprof{professional }\else{}\fi degree of \ \ \textsf{\@optionpaperclassen{} of \@enpapertype}\\
in\ \ \textsf{\@ensubject}\\
\makebox[\textwidth]{\ifisanon{~}\else{National University of Defense Technology}\fi}\\
\ifisanon{~}\else{Changsha,\ \ Hunan,\ \ P.R.China}\fi\\[5mm]
~\@endate~
  }
  \end{center}\vfill

  \renewcommand{\baselinestretch}{1.5}%
  \ifisanon{~}\else{%
    \emptydoublepage
    % \cleardoublepage
    \newpage
    \thispagestyle{empty}
    
    \includepdf[pages=1]{独创性声明扫描件.pdf}
  }\fi

  \normalsize % 恢复正常大小，正文开始
  \def\@tabular{\wuhao[1.25]\old@tabular} % 之后表格字体使用5号
  \emptydoublepage
  % \cleardoublepage%
  \newpage
  \thispagestyle{empty}
} % \maketitle 结束

\endinput
%%
%% 文件 `nudtpaper.cls' 结束