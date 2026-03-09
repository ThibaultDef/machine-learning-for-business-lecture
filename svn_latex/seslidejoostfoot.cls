%% Changed footnotesize
\NeedsTeXFormat{LaTeX2e}[1995/12/01]%
\ProvidesClass{seslidejoost4}[2005/11/24 v0.99 Systems Engineering TU/e slides]%
% 0.9:  Eerste versie%
% 0.91: Optie "code" van pdfscreen weggelaten%
% 0.94: \tableofcontents toegevoegd.
% 0.95: Variabelen list-omgeving aangepast (itemize, enumerate, etc)
% 0.96: Optie "pagenumber" en "nopagenumber" toegevoegd
% 0.97: Kleinere bovenrand en ander panel, geen logo
% 0.98: Geen bovenrand, panel en onderrand andere tint, hoofdachtergrond weer wit,
%       klein tu-logo linksonder in panel,
%       Systems Engineering Group ipv /department of mechanical engineering,
%       alle letters wat kleiner in hoofdtekst,
%       menu in panel en hoofdtekst andere marges gegeven,
%       optie nopanel betere marges gegeven,
%       opties navigation(default) en nonavigation gemaakt (met of zonder navigatieknoppen),
%       opties notconfidential(default) en confidential gemaakt (in rood onder elke slide),
% 0.99: aanwijspijltje in panel, letters hoofdtekst weer 1 puntje groter...
\newif\if@seslide@panel   \@seslide@paneltrue%
\newif\if@seslide@english \@seslide@englishtrue%
\newif\if@seslide@screen  \@seslide@screentrue%
\newif\if@seslide@pagenumber  \@seslide@pagenumbertrue%
\newif\if@seslide@navigation  \@seslide@navigationtrue%
\newif\if@seslide@confidential  \@seslide@confidentialtrue%
\newcommand{\tue@department}{}%
%
%
%
%
\DeclareOption{a4paper}{%
  \setlength{\paperheight}{297mm}%
  \setlength{\paperwidth}{210mm}}%
\DeclareOption{dutch}{%
  \@seslide@englishfalse%
  \PassOptionsToPackage{dutch}{tuefont}}%
\DeclareOption{english}{%
  \@seslide@englishtrue%
  \PassOptionsToPackage{english}{tuefont}}%
\DeclareOption{final}{\setlength\overfullrule{0pt}}%
\DeclareOption{draft}{\setlength\overfullrule{5pt}}%
\DeclareOption{screen}{%
  \@seslide@screentrue%
  \PassOptionsToPackage{screen}{pdfscreen}}%
\DeclareOption{print}{%
  \@seslide@screenfalse%
  \PassOptionsToPackage{print}{pdfscreen}}%
\DeclareOption{panel}{%
  \@seslide@paneltrue%
  \PassOptionsToPackage{panelleft,paneltoc}{pdfscreen}}%
\DeclareOption{nopanel}{%
  \@seslide@panelfalse%
  \PassOptionsToPackage{panelleft,paneltoc}{pdfscreen}}%
\DeclareOption{pagenumber}{%
  \@seslide@pagenumbertrue}%
\DeclareOption{nopagenumber}{%
  \@seslide@pagenumberfalse}%
\DeclareOption{b}{\renewcommand{\tue@department}{\tueb}}%
\DeclareOption{bib}{\renewcommand{\tue@department}{\tuebib}}%
\DeclareOption{bmt}{\renewcommand{\tue@department}{\tuebmt}}%moet nog verbeterd%
\DeclareOption{e}{\renewcommand{\tue@department}{\tuee}}%
\DeclareOption{id}{\renewcommand{\tue@department}{\tueid}}%
\DeclareOption{sai}{\renewcommand{\tue@department}{\tuesai}}%
\DeclareOption{st}{\renewcommand{\tue@department}{\tuest}}%
\DeclareOption{tm}{\renewcommand{\tue@department}{\tuetm}}%
\DeclareOption{tn}{\renewcommand{\tue@department}{\tuetn}}%
\DeclareOption{w}{\renewcommand{\tue@department}{\tuew}}%
\DeclareOption{wi}{\renewcommand{\tue@department}{\tuewi}}%
\DeclareOption{fb}{\renewcommand{\tue@department}{\tuefb}}%
\DeclareOption{ipo}{\renewcommand{\tue@department}{\tueipo}}%
\DeclareOption{nonavigation}{\@seslide@navigationfalse}% JvE 2005-05-09%
\DeclareOption{navigation}{\@seslide@navigationtrue}% JvE 2005-05-09%
\DeclareOption{notconfidential}{\@seslide@confidentialfalse}% JvE 2005-05-09%
\DeclareOption{confidential}{\@seslide@confidentialtrue}% JvE 2005-05-09%
%
\ExecuteOptions{a4paper,screen,panel,w,navigation,notconfidential}%
\ProcessOptions\relax%
%
%
%
\ifx\pdfoutput\undefined%
  \ClassError{seslide}{PDF-LaTeX required}{Use pdflatex instead of latex}%
  %probeer nog een beetje goed te laten gaan...%
  \PassOptionsToPackage{dvips}{pdfscreen}%
  \newcommand{\AddToOverlay}[1]{}%
  \newcommand{\margins}[4]{}%
  \newlength\panelwidth%
  \newcommand{\screensize}[2]{}%
  \newcommand{\backgroundcolor}[1]{}%
  \newenvironment{slide}{}{}%
\fi%
\LoadClass[a4paper,11pt]{article}[1999/09/10]%
\RequirePackage{pdfscreen}[2000/07/07]%
%%DAvB\RequirePackage[color,slide]{tuefont}[2004/09/06] %% Instead load color package%
\RequirePackage{color}[1999/02/16] 






%
%
\renewcommand\tiny{\@setfontsize\tiny{8.5pt}{4mm}}%
\renewcommand\scriptsize{\@setfontsize\scriptsize\@xpt{4mm}}%
%\renewcommand\footnotesize{\@setfontsize\footnotesize{\@xiipt}{8mm}}%
\renewcommand\footnotesize{\@setfontsize\footnotesize{\@xpt}{6mm}}%
\renewcommand\small{\@setfontsize\small{12pt}{8mm}}%
\renewcommand\normalsize{\@setfontsize\normalsize{16pt}{12mm}}%
\renewcommand\large{\@setfontsize\large{24pt}{12mm}}%
\renewcommand\Large{\@setfontsize\Large{28pt}{12mm}}%
\renewcommand\LARGE{\@setfontsize\LARGE{36pt}{12mm}}%
\renewcommand\huge{\@setfontsize\huge{48pt}{12mm}}%
\renewcommand\Huge{\@setfontsize\Huge{60pt}{12mm}}%
\newcommand\navigbuttonsize{\@setfontsize\normalsize{14pt}{12mm}}%
\newcommand\pagenumbersize{\@setfontsize\normalsize{14pt}{12mm}}%
\newcommand\footertextsize{\@setfontsize\normalsize{14pt}{12mm}}%
\newcommand\confidentialtextsize{\@setfontsize\normalsize{14pt}{12mm}}%
\normalfont%
\normalsize%


%
\renewcommand\section{\@startsection{section}{1}{\z@}%
                                   {\baselineskip}%
                                   {1pt}%
                                   {\normalfont\large\bfseries}}%
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                   {\baselineskip}%
                                   {1pt}%
                                   {\normalfont\normalsize\bfseries}}%
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                   {\baselineskip}%
                                   {-1em}%
                                   {\normalfont\normalsize\bfseries}}%
\setlength{\parindent}{0mm}%
\setlength{\parskip}{0mm}%
\setlength{\topsep}{0mm}%
\setlength{\partopsep}{0mm}%
\setlength{\itemsep}{0mm}%
\setlength{\parsep}{0mm}%
\setlength{\rightmargin}{0mm}%
\setlength{\listparindent}{0mm}%
\setlength{\leftmargin}{1.5em}%
\setlength{\leftmargini}{1.5em}%
\setlength{\leftmarginii}{1.5em}%
\setlength{\labelsep}{0.5em}%
\setlength{\labelwidth}{-\leftmargini}%
\addtolength{\labelwidth}{-\labelsep}%
\setlength{\itemindent}{\listparindent}%
\def\@listi{\leftmargin\leftmargini%
            \labelwidth\leftmargini%
            \advance\labelwidth-\labelsep}%
\let\@listI\@listi%
\def\@listii {\leftmargin\leftmarginii%
              \labelwidth\leftmarginii%
              \advance\labelwidth-\labelsep}%
\def\@listiii{\leftmargin\leftmarginiii%
              \labelwidth\leftmarginiii%
              \advance\labelwidth-\labelsep}%
\def\@listiv {\leftmargin\leftmarginiv%
              \labelwidth\leftmarginiv%
              \advance\labelwidth-\labelsep}%
\def\@listv  {\leftmargin\leftmarginv%
              \labelwidth\leftmarginv%
              \advance\labelwidth-\labelsep}%
\def\@listvi {\leftmargin\leftmarginvi%
              \labelwidth\leftmarginvi%
              \advance\labelwidth-\labelsep}%
\@listi%

\newcounter{slidenumber}%
\def\SlideLastNumber{??}
\AtEndDocument{%
   \clearpage%
   \immediate\write\@auxout{\string\gdef\string\SlideLastNumber{\arabic{slidenumber}}}%
   }%

%
%Geen nummering van secties%
%\renewcommand\@seccntformat[1]{}%
\setcounter{secnumdepth}{0}%
%
%
\AddToOverlay{%
  \setlength{\unitlength}{1pt}%
  \put(0,0){%
% start of addition tu logo small JvE%
    \vbox to 2.8cm{%
      \hbox to 0cm{%
        \hskip 0.01\paperwidth\fontsize{0.07\paperwidth}{0mm}\selectfont\tuelogosmall%
        \hss%
      }%
      \vss%
    }%
% end of addition%
    \setlength{\@tempdima}{0.0691\paperheight}%
    \makebox(\strip@pt\paperwidth,\strip@pt\@tempdima)[ct]{%
      \definecolor{bottempanelcolor}{rgb}{0.8,0.8,0.8}
      \colorbox{bottempanelcolor}{%
        \vbox to \@tempdima{%
          \hrule width\paperwidth height 0.0025\paperheight depth 0pt%
          \vfill%
          \hbox to \paperwidth{%

            \if@seslide@navigation%
              \hbox to 0pt{%
                \hbox to \panelwidth{%
                  \hfill%
                    {\navigbuttonsize%
                    \Acrobatmenu{FirstPage}{\FBlack $\blacktriangleleft\!\!\blacktriangleleft$}%
                    \Acrobatmenu{PrevPage}{\FBlack $\blacktriangleleft$}%
                    \Acrobatmenu{GoBack}  {\Black $\blacktriangle$}%
                    \Acrobatmenu{NextPage}{\LBlack $\blacktriangleright$}%
                    \Acrobatmenu{LastPage}{\LBlack $\blacktriangleright\!\!\blacktriangleright$}%
                    }%
                  \hfill%
                }%
                \hss%
              }%
              \hskip 0.2\paperwidth%
                {\normalfont\footertextsize Systems Engineering Group}%
              \hfill%
            \else%
              \if@seslide@panel%
                \hbox to 0pt{%
                  \hskip 0.01\paperwidth% equal to leftmargin panel in panel-mode%
                    {\normalfont\footertextsize Systems Engineering Group}%
                }%
              \else%
                \hbox to 0pt{%
                  \hskip 1.5in% equal to leftmargin in nopanel-mode%
                  {\normalfont\footertextsize Systems Engineering Group}%
                }%
              \fi%
            \fi%
\hfill%
            \if@seslide@confidential%
             {\normalfont\confidentialtextsize\textcolor{red}{\textsc{Confidential}}}%
            \fi%
\hfill%
            \if@seslide@pagenumber%
              \hbox to 0pt{%
                \hss%
                \textcolor{black}{\normalfont\pagenumbersize\sffamily\theslidenumber\space\@Panelofname\space\SlideLastNumber\hskip 1em}%
              }%
            \else%
              \null%
            \fi%
          }%
          \vfill%
        }%
      }%
    }%
  }%
}%
%
\def\PDFSCR@Warning#1{%
  \def\@@@test{No overlay specified\MessageBreak%
            output will have only background color}%
  \def\@@@TEST{#1}%
  \ifx\@@@test\@@@TEST\relax%
  \else%
    \PackageWarning{pdfscreen}{#1}%
  \fi%
}%
%
%
%\if@se@panel%
  \margins{0.75in}{0.8in}{0.7in}{0.7in}% left right top bottom 1.03 1.03 1.17 0.68 old values%
  \panelwidth=1.8in%
  \panelofname{\negthinspace/\negthinspace}%
  \def\panel{%
    \begin{minipage}[t][\paperheight][c]{\panelwidth}%
      \backgroundcolor{white}%JvE 20050502
      \normalsfcodes%
      \centering%
      \vspace*{0.08\paperheight}% 0.135 old value%
      \vspace*{0.05\panelwidth}%
      \setlength{\baselineskip}{12pt}%
      \vbox\bgroup\rightskip0pt plus 1fill%
      \hbadness 10000%
      \@panel@toc
      \egroup\par%
      \vfill%
      \vspace*{0.05\panelwidth}%
      \vspace*{0.0691\paperheight}%
    \end{minipage}%
  }%
  \AtBeginDocument{%
    \def\@panel@toc{}%
    \@starttoc{toc}%
  }%
  \long\def\contentsline#1#2#3#4{%
    \g@addto@macro\@panel@toc{\panelline{#1}{#2}{#3}{#4}}%
  }%
%
  \newcounter{@@pagecursec}[page]%
  \newcounter{@@activestart}%
  \def\panelline#1#2#3#4{%
    \def\@@cHead{#1}%
    \ifx\@@cHead\@@secHead%allen panel-entry voor sections%
      \stepcounter{NUM}%
      \setcounter{@@pagecursec}{#3}%
      \ifnum\thepage<\the@@pagecursec%
        \showinactivepanelbutton{#2}{#4}%
        \addtocounter{page}{1}%
        \ifnum\thepage=\the@@pagecursec%
          \addtocounter{@@activestart}{1}%
        \fi%
        \addtocounter{page}{-1}%
      \else%
        \ifnum\theNUM<\the@@activestart%
          \showinactivepanelbutton{#2}{#4}%
        \else%
          \showactivepanelbutton{#2}{#4}%
          \setcounter{@@activestart}{\theNUM}%
        \fi%
      \fi%
    \fi%
  }%
%
  \def\showinactivepanelbutton#1#2{%
      \hspace{0.1\panelwidth}%
      \hyperlink{#2}{%
          \hbox to 0.9\panelwidth{%
            \color{tuegrijs}%
            \normalfont\fontsize{11pt}{4mm}\sffamily%
            \hbox{\vrule height12pt depth4pt width\z@}%
            \truncate{.85\panelwidth}{#1}\hfill%
        }%
      }%
      \vskip1truept%
  }%
 \def\showactivepanelbutton#1#2{%
     \hbox to \panelwidth{%
       \hbox to 0.1\panelwidth{%
           \color{tueblauw}%
           \normalfont\fontsize{11pt}{4mm}\sffamily%
           $\;\blacktriangleright\;$%
       }%
       \hbox to 0.9\panelwidth{%
         \hyperlink{#2}{%
           \color{tueblauw}%
           \normalfont\fontsize{11pt}{4mm}\sffamily%
           \hbox{\vrule height12pt depth4pt width\z@}%
           \truncate{.85\panelwidth}{#1}\hfill%
         }%
       }%
     }%
     \vskip1truept%
 }%


% \def\showactivepanelbutton#1#2{%
%       \hspace{0.05\panelwidth}%
%       \hyperlink{#2}{%
% %        \colorbox{tueblauw}{%
%           \hbox to 0.95\panelwidth{%
% %            \color{panelbackground}%
%             \color{tueblauw}%
%             \normalfont\fontsize{10pt}{4mm}\sffamily%
%             \hbox{\vrule height12pt depth4pt width\z@}%
%             \hfill\truncate{.9\panelwidth}{$\blacktriangleright$ #1}\hfill%
% %          }%
%         }%
%       }%
%       \vskip1truept%
%   }%

%
  \definecolor{panelbackground}{rgb}{0.9,0.9,0.9}%
  \backgroundcolor{white}%
%\else%
%  \margins{0.83in}{1.03in}{0.17in}{0.68in}%
%\fi%
\if@seslide@panel%
\else%
  \def\panelline#1#2#3#4{\space\hfill\space}%
  \margins{1.5in}{1.5in}{0.8in}{0.8in}% {2.83in}{1.03in}{1.17in}{0.68in} left right top bottom marges voor nopanel%
\fi%
%
\screensize{7.5in}{10in}%
%  \definecolor{tueachtergrond}{rgb}{0.898438,0.898438,0.898438}%
  \definecolor{section0}{rgb}{0,0,0}%
  \definecolor{section1}{rgb}{0,0,0}%
  \definecolor{section2}{rgb}{0,0,0}%
  \definecolor{section3}{rgb}{0,0,0}%
  \definecolor{section4}{rgb}{0,0,0}%
  \definecolor{section5}{rgb}{0,0,0}%
%
%
\renewenvironment{slide}{\newpage\addtocounter{slidenumber}{1}\section}{\vfill\newpage}%
\newenvironment{slide*}{\newpage\addtocounter{slidenumber}{1}\section*}{\vfill\newpage}%
%
\if@seslide@english%
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\else
\def\today{\number\day\space\ifcase\month\or
  januari\or februari\or maart\or april\or mei\or juni\or
  juli\or augustus\or september\or oktober\or november\or december\fi
  \space\number\year}
\fi
%
\def\subtitle#1{\gdef\@subtitle{#1}}
\let\@subtitle\@empty

\renewcommand{\maketitle}{%
  \begingroup%
    \def\panelline##1##2##3##4{\space\hfill\space}%
    \newpage%
    \addtocounter{slidenumber}{1}%
    \null%
    \vfill
    {\normalsize\@subtitle}%
    \vskip 0.15in
    {\fontsize{28pt}{8mm}\selectfont\@title}%
    \vskip 0.17in
    {\normalsize\@author}%
    \vfill
    \vfill
    {\normalsize\@date}%
    \vskip 0.0in% Was 0.15in ooit
    \null
    \newpage%
  \endgroup%
}%
%
\def\heading{\section*}%
\def\subheading{\subsection*}%
\def\subsubheading{\subsubsection*}%
%
\let\rmdefault\sfdefault%
%
\renewcommand{\tableofcontents}{%
    \begin{slide*}{\contentsname}
       \begin{itemize}
         \def\panelline##1##2##3##4{\item ##2}
         \@panel@toc
       \end{itemize}%
    \end{slide*}%
}
%
% Start definities om subslides te kunnen maken
\makeatletter%
\def\@linkcolor{black}%
\def\@anchorcolor{black}%
\def\@citecolor{black}%
\def\@filecolor{black}%
\def\@urlcolor{black}%
\def\@menucolor{black}%
\def\@pagecolor{black}%
\newcounter{parentslidenumber}%%
\@ifundefined{ignorespacesafterend}{%
  \def\ignorespacesafterend{\global\@ignoretrue}%
}{}%
\newenvironment{subslides}{%
  \refstepcounter{slidenumber}%
  \protected@edef\theparentslidenumber{\theslidenumber}%
  \setcounter{parentslidenumber}{\value{slidenumber}}%
  \setcounter{slidenumber}{0}%
  \def\theslidenumber{\theparentslidenumber}%
  \ignorespaces%
}{%
  \setcounter{slidenumber}{\value{parentslidenumber}}%
  \ignorespacesafterend%
}%
\makeatother%
% Einde definities van subslides
\endinput%
