%%This a a version created by ChatGPT on 5.12.2025 to suit the needs of overleaf

%% ----------------------------------------------------------------------
%% Clean TU-Delft-like Dissertation Class (Overleaf-safe)
%% A5 paper, two-sided, XeLaTeX/LuaLaTeX only
%% ----------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dissertation}[2025/01/01 Thesis Class Cleaned]

% ------------------------------------------------------------
% Options
%% Options added by Jacob
%% Conditional to include cover art in pdf
\newif\ifprintcover
\DeclareOption{cover}{\printcovertrue}
%% Conditional to speed up compilation
\newif\ifdraft
\DeclareOption{drafts}{\drafttrue}
%% Conditional to compile review version
\newif\ifreview
\DeclareOption{review}{\reviewtrue}
%% Conditional to include optional reviewers comments inline
\newif\ifaec
\DeclareOption{reviewcomments}{\aectrue}

% ------------------------------------------------------------
% Base Class
% ------------------------------------------------------------
\ProcessOptions\relax
\LoadClass[twoside,openright]{book}

% ------------------------------------------------------------
% REQUIRED MODERN PACKAGES
% ------------------------------------------------------------
\RequirePackage{geometry}     % must come early
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{hyperref}
\RequirePackage{tikz}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{natbib}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage{mathtools}
\RequirePackage{pdfpages}
\RequirePackage{fancyhdr}
% ------------------------------------------------------------
% GEOMETRY — A5, two-sided
% ------------------------------------------------------------
\geometry{
    a5paper,
    twoside,
    inner=22mm,
    outer=15mm,
    top=18mm,
    bottom=20mm,
    headheight=14pt,
    headsep=12pt,
    footskip=12pt
}

% ------------------------------------------------------------
% COLORS (TUD-like)
% ------------------------------------------------------------
\definecolor{tudelft-cyan}{cmyk}{1,0,0,0}
\definecolor{tudelft-black}{cmyk}{0,0,0,1}
\definecolor{tudelft-white}{cmyk}{0,0,0,0}
\definecolor{title}{HTML}{003366}

% ------------------------------------------------------------
% FONTS — Overleaf-safe defaults
% (No Bookman/Tahoma/Cambria unless explicitly set)
% ------------------------------------------------------------
\RequirePackage{fontspec}
\setmainfont{TeX Gyre Pagella}
\setsansfont{TeX Gyre Heros}
\setmonofont{TeX Gyre Cursor}

\RequirePackage{unicode-math}
\setmathfont{TeX Gyre Pagella Math}

% Title styles
\def\titlefont{\rmfamily}
\def\titleshape{}
\def\titlestyle{\titlefont\titleshape\bfseries}
\def\headerstyle{\titlefont\titleshape}

% ------------------------------------------------------------
% SECTION FORMATTING
% ------------------------------------------------------------
\titleformat{\chapter}[display]
  {\titlestyle\Huge\color{title}}
  {\chaptername\ \thechapter}{1ex}{}

\titleformat{\section}
  {\titlestyle\Large}{\thesection}{1em}{}

\titleformat{\subsection}
  {\titlestyle\large}{\thesubsection}{1em}{}

% ------------------------------------------------------------
% HYPERREF SETTINGS
% ------------------------------------------------------------
\hypersetup{
    colorlinks=true,
    linkcolor=title,
    urlcolor=tudelft-cyan,
    citecolor=title,
    pdfauthor={},
    pdftitle={}
}

% ------------------------------------------------------------
% PAGE STYLE (fancyhdr) + THUMBS
% ------------------------------------------------------------
\pagestyle{plain}              % default (frontmatter etc.)
\providecommand{\cropmarks}{}  % do nothing unless you want real cropmarks

% ---- THUMBTAGS ----
\usetikzlibrary{calc}

\newlength{\thumbheight}
\setlength{\thumbheight}{12pt}
\newlength{\thumbvspace}
\setlength{\thumbvspace}{2pt}

\newif\ifthumb
\thumbtrue

% right thumb (odd pages, outer edge right)
\newcommand*\rthumb{%
  \ifthumb
  \begin{tikzpicture}[remember picture,overlay]
    \coordinate (topmargin) at (0pt,1in+\topmargin+\headheight+\headsep);
    \coordinate (right margin) at (1in+\evensidemargin,0pt);
    % Position of the top vertex
    \coordinate (A) at ($(current page.north east)-(topmargin)-(0pt,\value{chapter}\thumbvspace-\thumbvspace)$);
    % Define the side length of the triangle
    \pgfmathsetlengthmacro{\side}{3*\thumbheight}
    % Compute the other two vertices for an equilateral triangle pointing left
    \coordinate (B) at ($(A)+(0pt,-\side)$);
    \coordinate (C) at ($(A)+(-{\side*0.866}, -0.5*\side)$);
    \fill[title] (A)--(B)--(C)--cycle;
    % Place the chapter number near the center
		\coordinate (center) at ($ (A)!0.5!(B)!0.33!(C) $);
		\node at (center)[color=tudelft-white, font=\bfseries, anchor=center]{
			\fontsize{0.75\thumbheight}{0.75\thumbheight}\selectfont
			\thechapter
		};
  \end{tikzpicture}%
  \fi
}		

% left thumb (even pages, outer edge left)
\newcommand*\lthumb{%
  \ifthumb
  \begin{tikzpicture}[remember picture,overlay]
    \coordinate (topmargin) at (0pt,1in+\topmargin+\headheight+\headsep);
    % Position of the top vertex
    \coordinate (A) at ($(current page.north west)-(topmargin)-(0pt,\value{chapter}\thumbvspace-\thumbvspace)$);
    % Define the side length of the triangle
    \pgfmathsetlengthmacro{\side}{3*\thumbheight}
    % Compute the other two vertices for an equilateral triangle pointing left
    \coordinate (B) at ($(A)-(0pt,-\side)$);
    \coordinate (C) at ($(A)-(-{\side*0.866}, -0.5*\side)$);
    \fill[title] (A)--(B)--(C)--cycle;
    \coordinate (center) at ($ (A)!0.5!(B)!0.33!(C) $);
		\node at (center)[color=tudelft-white, font=\bfseries, anchor=center]{
			\fontsize{0.75\thumbheight}{0.75\thumbheight}\selectfont
			\thechapter
		};
  \end{tikzpicture}%
  \fi
}

% ------------------------------------------------------------
% SECTION / CHAPTER FORMATTING (old style)
% ------------------------------------------------------------
% old chapter number size; adjust to taste
\newcommand{\chapternumbersize}{40pt}

\titleformat{\chapter}[display]
  {\flushright\titlestyle}
  {\fontsize{\chapternumbersize}{\chapternumbersize}\selectfont\bfseries\thechapter}
  {0pt}
  {\Huge\color{title}}

\titlespacing{\chapter}{0pt}{0pt}{2\baselineskip}

\titleformat{\section}
  {\titlestyle\Large}{\thesection}{1em}{}

\titleformat{\subsection}
  {\titlestyle\large}{\thesubsection}{1em}{}

% ------------------------------------------------------------
% MAINMATTER PAGE STYLE (old style, with thumbs)
% ------------------------------------------------------------
\fancypagestyle{mainmatter}{%
  \fancyhf{}%
  % Page numbers + thumbs on outer corners
  \fancyhead[LE]{\cropmarks\lthumb\titlefont\thepage}%
  \fancyhead[RO]{\cropmarks\rthumb\titlefont\thepage}%
  % Chapter name on even pages
  \fancyhead[RE]{\titlefont\titleshape\nouppercase{\leftmark}}%
  % Section name on odd pages
  \fancyhead[LO]{\titlefont\titleshape\nouppercase{\rightmark}}%
}

% Make mainmatter style active when mainmatter starts
\let\oldmainmatter\mainmatter
\renewcommand{\mainmatter}{%
  \oldmainmatter
  \pagestyle{mainmatter}%
}


% ------------------------------------------------------------
% GLOSSARIES + ACRONYMS
% ------------------------------------------------------------
\RequirePackage[acronym,toc]{glossaries}
\makeglossaries

% ------------------------------------------------------------
% print options
% ------------------------------------------------------------
%% Set the paper size to 17 by 24 cm, approximately halfway between A4 and A5.
%    \if@print
        %% In print mode we add a 3 mm bleed on the outside of the page.
%        \geometry{
%            papersize = {173mm,246mm},
%            layoutsize = {167mm,240mm},
%            layoutoffset = {3mm,3mm},
%            bindingoffset = -3mm
%        }
%    \else
%        \geometry{papersize={170mm,240mm}}
%   \fi
%% We decrease the margins slightly from the default (scale = 0.7).
%\geometry{hscale=0.75,vscale=0.8}
%% Remove the header and page number on empty pages.
%\def\cleardoublepage{%
%    \clearpage%
%    \if@twoside%
%        \ifodd\c@page%
%        \else%
%            \thispagestyle{empty}%
%            \vspace*{\fill}%
%            \newpage%
%        \fi%
%    \fi%
%        \vspace*{\fill}%
%            \newpage%
%        \fi%
%    \fi%
%}
%    \if@print%
%        \newcommand*\cropmarks{%
%            \ifodd\c@page%
%                \begin{tikzpicture}[remember picture,overlay]
%                    \draw ($(current page.north east)+(0mm,-3mm)$) -- ($(current page.north east)+(-2mm,-3mm)$);
%                    \draw ($(current page.north east)+(-3mm,0mm)$) -- ($(current page.north east)+(-3mm,-2mm)$);
%                    \draw ($(current page.south east)+(0mm,3mm)$) -- ($(current page.south east)+(-2mm,3mm)$);
%                    \draw ($(current page.south east)+(-3mm,0mm)$) -- ($(current page.south east)+(-3mm,2mm)$);
%                \end{tikzpicture}%
%            \else%
%                \begin{tikzpicture}[remember picture,overlay]
%                    \draw ($(current page.north west)+(0mm,-3mm)$) -- ($(current page.north west)+(2mm,-3mm)$);
%                    \draw ($(current page.north west)+(3mm,0mm)$) -- ($(current page.north west)+(3mm,-2mm)$);
%                    \draw ($(current page.south west)+(0mm,3mm)$) -- ($(current page.south west)+(2mm,3mm)$);
%                    \draw ($(current page.south west)+(3mm,0mm)$) -- ($(current page.south west)+(3mm,2mm)$);
%                \end{tikzpicture}%
%            \fi%
%        }
%    \else
%        \newcommand*\cropmarks{}
%    \fi%
% ------------------------------------------------------------
% Other
% ------------------------------------------------------------
%% Redefine the title command to accept an optional subtitle.
\renewcommand*\title[2][]{%
    \def\@subtitle{#1}%
    \def\@title{#2}%
    %% Add the title to the PDF meta data.
    \hypersetup{pdftitle=#2}%
}
%% Define an unnumbered footnote command.
\def\blfootnote{\xdef\@thefnmark{}\@footnotetext}
% ------------------------------------------------------------
% END
% ------------------------------------------------------------
