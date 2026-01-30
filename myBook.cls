\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{myBook}[2024/07/10 Custom book class with math and code environments]

% 基于 book 类
\LoadClass[11pt]{book}

% ================ 字体设置 (PDFLaTeX 兼容) ================
% 使用 newpx 系列字体（与 Palatino 兼容的改进版）
\usepackage{newpxtext}      % 文本字体
\usepackage{newpxmath}      % 数学字体

% 等宽字体配置
\usepackage{courier}        % 使用 Courier 作为等宽字体

% ================ 页面布局 (使用 ptmt 中的配置) ================
\usepackage[rmargin=3.85cm, lmargin=3.85cm, bmargin=4cm, tmargin=4cm]{geometry}

% ================ 避免包冲突的解决方案 ================
% 先加载核心数学包，避免后续冲突
\usepackage{amsmath}
\usepackage{amsfonts}

% 特殊处理 amsthm：在加载前释放可能冲突的命令
\makeatletter
\@ifpackageloaded{amssymb}{}{
  % 如果 amssymb 尚未加载，释放可能冲突的命令
  \let\openbox\undefined
  \let\Bbbk\undefined
}
\makeatother

% 加载 amsthm 但避免重新定义 openbox
\RequirePackage{amsthm}

% 现在安全地加载 amssymb
\usepackage{amssymb}

% ================ 其他基本包 ================
\usepackage{array}
\usepackage{graphicx}
\usepackage{xcolor}
\usepackage{longtable}

% ================ 颜色定义 ================
\definecolor{ecolor}{RGB}{0,0,0}

% Python 代码颜色
\definecolor{python-blue}{RGB}{27,142,224}
\definecolor{python-red}{RGB}{186,33,33}
\definecolor{python-green}{RGB}{0,128,0}
\definecolor{python-purple}{RGB}{128,0,128}
\definecolor{python-black}{RGB}{0,0,0}
\definecolor{python-background}{RGB}{248,248,248}

% ================ 定理环境设置 ================
% 自定义定理样式
\newtheoremstyle{namedthm}
{3pt}
{3pt}
{\normalfont}
{}
{\bfseries}
{.}
{0.5em}
{\thmname{#1}\thmnumber{ #2}\thmnote{ (#3)}}

\theoremstyle{namedthm}

% 定义所有定理环境
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[section]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{axiom}{Axiom}[section]  % 添加 axiom 环境
\theoremstyle{definition}
\newtheorem{definition}{Definition}[section]
\newtheorem{conjecture}{Conjecture}[section]
\newtheorem{example}{Example}[section]
\theoremstyle{remark}
\newtheorem{remark}{Remark}
\newtheorem{note}{Note}
\newcommand\ebibname{Bibliography}
\newtheorem{case}{Case}

% ================ 定理引用命令 ================
% 最简单的方法：使用自定义标签命令
\makeatletter

% 定义一个新的标签命令，可以接受名称
\newcommand{\namedlabel}[2]{%
  \label{#1}%
  \ifx\\#2\\%
  \else
    \expandafter\gdef\csname name@#1\endcsname{#2}%
  \fi
}

% 重新定义引用命令
\newcommand{\thmref}[1]{%
  \@ifundefined{name@#1}{%
    \textbf{theorem~\ref{#1}}%
  }{%
    \textbf{theorem~\ref{#1}, \csname name@#1\endcsname}%
  }%
}

\newcommand{\propref}[1]{%
  \@ifundefined{name@#1}{%
    \textbf{proposition~\ref{#1}}%
  }{%
    \textbf{proposition~\ref{#1}, \csname name@#1\endcsname}%
  }%
}

\newcommand{\lemmaref}[1]{%
  \@ifundefined{name@#1}{%
    \textbf{lemma~\ref{#1}}%
  }{%
    \textbf{lemma~\ref{#1}, \csname name@#1\endcsname}%
  }%
}

\newcommand{\corref}[1]{%
  \@ifundefined{name@#1}{%
    \textbf{corollary~\ref{#1}}%
  }{%
    \textbf{corollary~\ref{#1}, \csname name@#1\endcsname}%
  }%
}

\newcommand{\axiomref}[1]{%
  \@ifundefined{name@#1}{%
    \textbf{axiom~\ref{#1}}%
  }{%
    \textbf{axiom~\ref{#1}, \csname name@#1\endcsname}%
  }%
}

\makeatother


% ================ 代码环境 ================
\usepackage{listings}
\usepackage{tcolorbox}
\tcbuselibrary{listings, breakable}

\lstdefinestyle{python-style}{
    basicstyle=\ttfamily\small\color{python-black},
    commentstyle=\color{python-green},
    keywordstyle=\color{python-blue},
    stringstyle=\color{python-red},
    showstringspaces=false,
    breaklines=true,
    frame=none,
    backgroundcolor=\color{python-background},
    numbers=left,
    numberstyle=\tiny\color{gray},
    numbersep=5pt,
    tabsize=4,
    language=Python
}

\newtcblisting{pythoncode}[1][]{
    colback=python-background,
    colframe=gray!50!black,
    listing only,
    listing options={style=python-style},
    breakable,
    #1
}

\newtcblisting{pythoncodenotitle}[1][]{
    colback=python-background,
    colframe=gray!50!black,
    listing only,
    listing options={style=python-style},
    breakable,
    title={},
    #1
}

\newtcbox{\pythoninline}{
    on line,
    boxrule=0.5pt,
    colback=python-background,
    colframe=gray!50!black,
    fontupper=\ttfamily\small\color{python-black},
    boxsep=2pt,
    left=2pt,
    right=2pt,
    top=1pt,
    bottom=1pt
}

\newtcbox{\pythoninlinenoframe}{
    on line,
    boxrule=0pt,
    colback=python-background,
    fontupper=\ttfamily\small\color{python-black},
    boxsep=2pt,
    left=2pt,
    right=2pt,
    top=1pt,
    bottom=1pt
}

% ================ 其他包 ================
\usepackage[algoruled]{algorithm2e}
\usepackage[british]{babel}
\usepackage{booktabs}
\usepackage[2.0, compress]{bxpdfver}
\usepackage{csquotes}
\usepackage[onehalfspacing]{setspace}
\usepackage{enumitem}
\usepackage{fancyhdr}
\usepackage{float}
\usepackage[bottom, hang, symbol]{footmisc}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{mdframed}
\usepackage[babel=true, final]{microtype}
\usepackage{parskip}
\usepackage{ragged2e}
\usepackage{titlesec}
\usepackage{hyperref}
\usepackage{multirow}
\usepackage{pdfpages,tikz}
\usetikzlibrary{matrix, positioning}
\usepackage{nicematrix}

% ================ 页眉页脚设置 ================
\pagestyle{fancy}
\renewcommand{\sectionmark}[1]{\markright{#1}}
\fancyfoot{}
\fancyhead[LE, RO]{\thepage}
\fancyhead[LO, RE]{\normalfont\rightmark}
\renewcommand{\headrulewidth}{0.5pt}

% ================ 章节格式 ================
\titleformat{\chapter}[display]
  {\bfseries\huge}
  {\filright \bf{\chaptertitlename} \Huge\thechapter}
  {1ex}
  {\titlerule\vspace{1ex}\filleft}
  [\vspace{1ex}\titlerule]

% ================ 列表设置 ================
\setlist[itemize]{leftmargin=*, nosep, noitemsep}
\setlist[enumerate]{leftmargin=*, nosep, noitemsep, label=(\arabic*)}
\setlist{
  leftmargin=4em,
  itemindent=6pt,
  labelsep=0.5em,
  itemsep=2pt,
  parsep=2pt,
  topsep=2pt
}

% Case 环境专用列表
\newlist{casenv}{enumerate}{4}
\setlist[casenv]{leftmargin=*,align=left,widest={iiii}}
\setlist[casenv,1]{label={{\itshape\ \casename} \arabic*.},ref=\arabic*}
\setlist[casenv,2]{label={{\itshape\ \casename} \roman*.},ref=\roman*}
\setlist[casenv,3]{label={{\itshape\ \casename\ \alph*.}},ref=\alph*}
\setlist[casenv,4]{label={{\itshape\ \casename} \arabic*.},ref=\arabic*}

% ================ 超链接设置 ================
\hypersetup{
  pdfborder={0 0 0},
  colorlinks,
  citecolor=python-purple,
  filecolor=python-purple,
  linkcolor=python-purple,
  urlcolor=python-purple,
  bookmarks=true,
  frenchlinks=true,
  pdfencoding=unicode,
  pdftitle={Name of the Book},
  pdfauthor={First Author et al.},
  pdfsubject={computer science},
  pdfkeywords={computer science}
}

% ================ 深度设置 ================
\setcounter{secnumdepth}{5}
\setcounter{tocdepth}{5}

% ================ 自定义命令 ================
\newcommand{\undersign}{
    \begin{flushright}
        \vfill
        First Author {\normalfont\textit{\&}} Second Author
        \rmfamily\normalfont
    \end{flushright}
}

% ================ 证明环境修正 ================
\renewcommand{\proofname}{\normalfont\bfseries\color{ecolor} Proof}

% ================ 定理环境名称 ================
\providecommand{\casename}{Case}
\providecommand{\claimname}{Claim}
\providecommand{\conjecturename}{Conjecture}
\providecommand{\corollaryname}{Corollary}
\providecommand{\definitionname}{Definition}
\providecommand{\examplename}{Example}
\providecommand{\exercisename}{Exercise}
\providecommand{\factname}{Fact}
\providecommand{\lemmaname}{Lemma}
\providecommand{\problemname}{Problem}
\providecommand{\propositionname}{Proposition}
\providecommand{\remarkname}{Remark}
\providecommand{\solutionname}{Solution}
\providecommand{\theoremname}{Theorem}
\providecommand{\axiomname}{Axiom}  % 添加 axiom 名称

% ================ 参考文献支持 ================
\usepackage{natbib}
% 默认参考文献样式
\providecommand{\bibstyleoption}{apalike}
\newcommand{\setbibstyle}[1]{\renewcommand{\bibstyleoption}{#1}}

\endinput