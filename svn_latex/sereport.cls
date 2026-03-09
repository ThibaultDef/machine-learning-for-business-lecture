%% DAvB 27-10-2006:
%% switched off section footers (\leftmark,\rightmark) 
%% changed seweb.se.wtb.tue.nl to se.wtb.tue.nl
%% commented out: \eg\ie\cf\etc
\NeedsTeXFormat{LaTeX2e}[1995/12/01]%
\ProvidesClass{sereport}[2006/27/10 v1.1 SE report conform TU/e huisstijl]%
%% 2006/27/10 v1.1 Pagestyle after titlepage empy, removed - from SE-Report


%
\DeclareOption{draft}{%
  \PassOptionsToClass{draft}{book}}%
\DeclareOption{final}{%
  \PassOptionsToClass{final}{book}}%
%
\ExecuteOptions{final}%
\ProcessOptions\relax%
%
\RequirePackage[reqno,tbtags,cmex10]{amsmath}[2000/01/15]%
%%DAvB This is package by Erjen: \RequirePackage[english]{tuefont}[2004/11/08]%
%%DAvB instead require fontenc, use mathtime, and set \sfdefault to {zmb}
%%Order is important!!!
%%First load mathtime, then change font \sfdefault to zmb, in this way, the font of keywords
%%in Chi models (e.g. disc) remains computer modern sf (with the right size and shape).
%%The commands below come from file tuestyle.sty (TUE MiKTeX)
%% from beamerfontthemetueplain.sty (TUE style for beamer update)
%% and from tuefont.sty (Erjen)
\RequirePackage[T1]{fontenc} 
%% cmbold insteand of mtbold, because the mtplus fonts do not come with MikTeX (or TU/e additions) anymore.
%\RequirePackage[mtbold,subscriptcorrection]{mathtime} 
\RequirePackage[cmbold,subscriptcorrection]{mathtime} 
%\renewcommand{\sfdefault}{phv}    %% Helvetica is usually chosen for headings (fatter than {zmb}, see below)
\renewcommand*{\sfdefault}{ftm}   %% Font from Erjen (tuefont.sty), not available in default MiKTeX
                                   %% MiKTeX equivalent is {zmb} as used below
%\renewcommand*{\sfdefault}{zmb}   %% Font as used in tuebeamer

%%Do not use the tue font for times, but keep the times font from mathtime:
%\renewcommand{\rmdefault}{zsc}    %% From Erjen (tuefont.sty)
%%Keep \ttdefault as computer modern, therefore do not execute next line:
%\renewcommand{\ttdefault}{pcr}
%\renewcommand*{\bfdefault}{b}     %% From Erjen (tuefont.sty)

\RequirePackage[dutch,english]{babel}[1999/09/09]%
\RequirePackage{xspace}[1997/10/13]%
\RequirePackage[T1]{url}[1999/03/02]%
\RequirePackage{amsthm}[1994/12/01]%
%
\LoadClass[a4paper,10pt,twoside,titlepage,openright,onecolumn]{book}[1999/09/10]%
%
%Voorlopig alleen de regelafstand van normalsize op 4mm gezet, rest zoals in%
%standaard 10pt book. Behalve dan aanpassing van een aantal skips door%
%adjustvertspacing zoals gebeurt in amsbook.%
%Afstanden voor list-omgevingen ook nog standaar gelaten.%
\def\@adjustvertspacing{%
  \bigskipamount.7\baselineskip plus.7\baselineskip%
  \medskipamount\bigskipamount \divide\medskipamount\tw@%
  \smallskipamount\medskipamount \divide\smallskipamount\tw@%
  \abovedisplayskip\medskipamount%
  \belowdisplayskip \abovedisplayskip%
  \abovedisplayshortskip\abovedisplayskip%
  \advance\abovedisplayshortskip-1\abovedisplayskip%
  \belowdisplayshortskip\abovedisplayshortskip%
  \advance\belowdisplayshortskip 1\smallskipamount%
  \jot\baselineskip \divide\jot 4 \relax%
}%
\renewcommand\normalsize{%
  \@setfontsize\normalsize{10pt}{4mm}%
  \@adjustvertspacing%
  \let\@listi\@listI}%
\normalsize%
\renewcommand\small{%
   \@setfontsize\small\@ixpt{11}%
   \@adjustvertspacing%
   \def\@listi{\leftmargin\leftmargini%
               \topsep 4\p@ \@plus2\p@ \@minus2\p@%
               \parsep 2\p@ \@plus\p@ \@minus\p@%
               \itemsep \parsep}%
}%
\renewcommand\footnotesize{%
   \@setfontsize\footnotesize{\@viiipt}{9.5}%
   \@adjustvertspacing%
   \def\@listi{\leftmargin\leftmargini%
               \topsep 3\p@ \@plus\p@ \@minus\p@%
               \parsep 2\p@ \@plus\p@ \@minus\p@%
               \itemsep \parsep}%
}%
\renewcommand\scriptsize{\@setfontsize\scriptsize\@viipt\@viiipt}%
\renewcommand\tiny{\@setfontsize\tiny\@vpt\@vipt}%
\renewcommand\large{\@setfontsize\large\@xiipt{14}}%
\renewcommand\Large{\@setfontsize\Large\@xivpt{18}}%
\renewcommand\LARGE{\@setfontsize\LARGE\@xviipt{22}}%
\renewcommand\huge{\@setfontsize\huge\@xxpt{25}}%
\renewcommand\Huge{\@setfontsize\Huge\@xxvpt{30}}%
%
\setlength{\parindent}{0mm}%
\setlength{\headheight}{16mm}%
\setlength{\headsep}{24mm}%
\setlength{\topskip}{4mm}%
\setlength{\footskip}{8mm}%
\setlength{\textwidth}{136mm}%
\@settopoint\textwidth%
\setlength{\textheight}{220mm}%
\setlength{\marginparsep}{4mm}%
\setlength{\marginparpush}{\baselineskip}%
\setlength{\oddsidemargin}{42mm}\addtolength{\oddsidemargin}{-1in}%
\setlength{\evensidemargin}{\paperwidth}\addtolength{\evensidemargin}{-\textwidth}\addtolength{\evensidemargin}{-\oddsidemargin}\addtolength{\evensidemargin}{-2in}%%
\setlength{\marginparwidth}{24mm}%
\@settopoint\oddsidemargin%
\@settopoint\marginparwidth%
\@settopoint\evensidemargin%
\setlength{\topmargin}{12mm}\addtolength{\topmargin}{-1in}%
\@settopoint\topmargin%
%%ONDERSTAANDE SETTINGS VAN AMSBOOK OVERGENOMEN%
\AtBeginDocument{\settoheight{\footnotesep}{\footnotesize M$^1$}%
                 \pagestyle{headings}}%
\setlength{\skip\footins}{7\p@ \@plus 11\p@}%
\setlength\floatsep{15\p@ \@plus 12\p@}%
\setlength\textfloatsep\floatsep%
\setlength\intextsep\floatsep%
\setlength\dblfloatsep{15\p@ \@plus 12\p@}%
\setlength\dbltextfloatsep{15\p@ \@plus 12\p@}%
\setlength\@fptop{0\p@ \@plus 1fil}%
\setlength\@fpsep{8\p@ \@plus 2fil}%
\setlength\@fpbot{0\p@ \@plus 1fil}%
\setlength\@dblfptop{0\p@ \@plus 1fil}%
\setlength\@dblfpsep{8\p@ \@plus 2fil}%
\setlength\@dblfpbot{0\p@ \@plus 1fil}%
\setlength\partopsep{0\p@}%
\parskip=0pt \relax%
%%OVERIGE SETTINGS UIT AMSBOOK (hebben we die nodig??)%
\skip\@mpfootins=\skip\footins%
\fboxsep=3pt \fboxrule=.4pt%
\arrayrulewidth=.4pt    \doublerulesep=2pt%
\labelsep=5pt           \arraycolsep=\labelsep%
\tabcolsep=\labelsep    \tabbingsep=\labelsep%
\parsep=0pt \relax \itemsep=0pt \relax%
\@lowpenalty=51         \@medpenalty=151        \@highpenalty=301%
\@beginparpenalty=-\@lowpenalty%
\@endparpenalty=-\@lowpenalty%
\@itempenalty=-\@lowpenalty%
%
%
%
%Hoofdstuk inclusief Bert's correctie van boldmath (voor als formule in titel)%
\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@schapter#1{%
                 \addcontentsline{toc}{chapter}{#1}%
                 \chaptermark{#1}%
                 \addtocontents{lof}{\protect\addvspace{10\p@}}%
                 \addtocontents{lot}{\protect\addvspace{10\p@}}%
                 \if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                    \thispagestyle{plain}%
                   \gdef\sethesis@plainoddhead{\hskip-28mm #1}%
                   \@afterheading
                 \fi}
\def\@makechapterhead#1{%
  \nointerlineskip\moveright -28mm\vbox{%
    \normalfont%
    \parbox[b][92mm][b]{164mm}{%
      \ifnum \c@secnumdepth >\m@ne%
        \if@mainmatter%
          \raggedright%
          \fontsize{24pt}{12mm}\selectfont \bfseries\sffamily%
          \@chapapp\space \thechapter%
          \newline%
        \fi%
      \fi%
      \fontsize{36pt}{16mm}\selectfont \bfseries\sffamily\boldmath%
      #1\newline%
    }%
    \vskip -2\baselineskip%
  }%
}%
\def\@makeschapterhead#1{%
  \nointerlineskip\moveright -28mm\vbox{%
    \normalfont%
    \parbox[b][92mm][b]{164mm}{%
      \raggedright%
      \fontsize{36pt}{16mm}\selectfont \bfseries\sffamily\boldmath%
      #1\newline%
    }%
    \vskip -2\baselineskip%
  }%
}%
\renewcommand\section{%
  \@startsection{section}%
                {1}%
                {\z@}%
                {-1.5\baselineskip}%
                {0.5\baselineskip}%
                {\normalfont\fontsize{18pt}{8mm}\selectfont \bfseries\sffamily\boldmath}%
}%
\renewcommand\subsection{%
  \@startsection{subsection}%
                {2}%
                {\z@}%
                {-0.75\baselineskip}%
                {0.25\baselineskip}%
                {\normalfont\fontsize{10pt}{4mm}\selectfont \bfseries\sffamily\boldmath}%
}%
\renewcommand\subsubsection{%
  \@startsection{subsubsection}%
                {3}%
                {\z@}%
                {-0.75\baselineskip}%
                {0.25\baselineskip}%
                {\normalfont\fontsize{10pt}{4mm}\selectfont \sffamily\boldmath}%
}%
\renewcommand\paragraph{%
  \@startsection{paragraph}%
                {4}%
                {\z@}%
                {-\baselineskip}%
                {-1em}%
                {\normalfont\fontsize{10pt}{4mm}\selectfont \bfseries\sffamily\boldmath}%
}%
\renewcommand\subparagraph{%
  \@startsection{subparagraph}%
                {5}%
                {\z@}%
                {-\baselineskip}%
                {-1em}%
                {\normalfont\fontsize{10pt}{4mm}\selectfont \sffamily\boldmath}%
}%
\renewcommand\@seccntformat[1]{\hb@xt@\z@{\hss\csname the#1\endcsname\hspace{4mm}}}%
%
\def\ps@plain{%
  \let\@mkboth\@gobbletwo%
  \def\@oddhead{%
    \hb@xt@\textwidth{%
      \normalfont\fontsize{36pt}{16mm}\selectfont \bfseries\sffamily\boldmath%
      \hb@xt@\z@{%
        \hskip-\oddsidemargin%
        \hskip-1in%
        \vrule width\paperwidth height1pt depth0pt\relax%
        \hss%
      }%
      \sethesis@plainoddhead\hfil
    }%
  }%
  \def\@evenhead{%
    \hb@xt@\textwidth{%
      \normalfont\fontsize{36pt}{16mm}\selectfont \bfseries\sffamily\boldmath%
      \hb@xt@\z@{%
        \hskip-\evensidemargin%
        \hskip-1in%
        \vrule width\paperwidth height1pt depth0pt\relax%
        \hss%
      }%
      \sethesis@evenhead\hfil
    }%
  }%
  \def\@evenfoot{%
    \hb@xt@\textwidth{%
      \normalfont\fontsize{10pt}{4mm}\selectfont \sffamily%
      \hb@xt@\z@{\hss\thepage\hskip 4mm}%
      \sethesis@evenfoot\hfil
    }
  }
  \def\@oddfoot{%
    \hb@xt@\textwidth{%
      \normalfont\fontsize{10pt}{4mm}\selectfont \sffamily%
      \hb@xt@\z@{\hss\thepage\hskip 4mm}%
      \sethesis@oddfoot\hfil
    }
  }
}%
\def\ps@headings{%
  \let\@mkboth\@gobbletwo%
  \def\@oddhead{%
    \hb@xt@\textwidth{%
      \normalfont\fontsize{18pt}{12mm}\selectfont \sffamily%
      \hb@xt@\z@{%
        \hskip-\oddsidemargin%
        \hskip-1in%
        \vrule width\paperwidth height1pt depth0pt\relax%
        \hss%
      }%
      \sethesis@oddhead\hfil
    }%
  }%
  \def\@evenhead{%
    \hb@xt@\textwidth{%
      \normalfont\fontsize{18pt}{12mm}\selectfont \sffamily%
      \hb@xt@\z@{%
        \hskip-\evensidemargin%
        \hskip-1in%
        \vrule width\paperwidth height1pt depth0pt\relax%
        \hss%
      }%
      \sethesis@evenhead\hfil
    }%
  }%
  \def\@evenfoot{%
    \hb@xt@\textwidth{%
      \normalfont\fontsize{10pt}{4mm}\selectfont \sffamily%
      \hb@xt@\z@{\hss\thepage\hskip 4mm}%
      \sethesis@evenfoot\hfil
    }
  }
  \def\@oddfoot{%
    \hb@xt@\textwidth{%
      \normalfont\fontsize{10pt}{4mm}\selectfont \sffamily%
      \hb@xt@\z@{\hss\thepage\hskip 4mm}%
      \sethesis@oddfoot\hfil
    }
  }
}%

\newcommand{\sethesis@oddhead}{}
\newcommand{\sethesis@evenhead}{}
%%DAvB \newcommand{\sethesis@oddfoot}{\leftmark}
%%DAvB \newcommand{\sethesis@evenfoot}{\rightmark}
\newcommand{\sethesis@oddfoot}{}
\newcommand{\sethesis@evenfoot}{}
\renewcommand{\chaptermark}[1]{\markboth{}{#1}}
\renewcommand{\sectionmark}[1]{\markboth{#1}{\rightmark}}
% \leftmark kan alleen gezet worden door markboth en bevat altijd de laatste
% markering van de pagina, terwijl \rightmark altijd de eerste markering bevat
% omdat ik de laatste sectie onderaan wil hebben staan moet die in \leftmark
% gezet worden en de hoofdstuktitel in \rightmark. Vervolgens komt het
% de hoofdstuktitel (\rightmark) komt op linkerpagina's en de sectietitel
% (\leftmark) op rechterpagina's
\renewcommand\tableofcontents{%
    \if@twocolumn%
      \@restonecoltrue\onecolumn%
    \else%
      \@restonecolfalse%
    \fi%
    \if@openright\cleardoublepage\else\clearpage\fi%
    \global\@topnum\z@%
    \@afterindentfalse%
    \markboth{\contentsname}{\contentsname}%
    \if@twocolumn%
      \@topnewpage[\@makeschapterhead{\contentsname}]%
    \else%
       \thispagestyle{plain}%
      \gdef\sethesis@plainoddhead{\hskip-28mm \contentsname}%
      \@afterheading%
    \fi%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi%
}
\renewenvironment{thebibliography}[1]
     {\chapter*{\bibname
        \@mkboth{\bibname}{\bibname}}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}


%
%   In elk geval moeten * omgevingen ook marken (check)
%   Bij verslag Johan viel op dat Bibliography was begonnen, maar volgende
%   pagina had nog 'recommandations' als mark
%   Verder moeten (net als bij amsbook) lege linkerpagina's echt leeg zijn
%
%  Verder verschijnen Bibliography en Contents nu te veel in inhoudsopgave
%  (en index ook) omdat dat nu door chapter* al gebeurt
%
%
%  Todo: figuuromgeving die caption links van figuur zet en figuur tussen
%        twee lange strepen.
%  Programmering van chapter aanpassen. In frontmatter gedeelte wordt
%  de nummering uitgezet, maar wel in table of contents opgenomen. Dat is
%  eigenlijk de chapter* die ik heb gemaakt. Moet mooier in een kunnen
%  verder wil je net als in amsbook dat de inhoudsopgave de volledige
%  titelnaam bevat en dat onderin eventueel een kortere titel kan staan.
%
%%DAvB:
%%\newcommand\eg{e.g.,\xspace}%
%%\newcommand\ie{i.e.,\xspace}%
%%\newcommand{\cf}{cf.\xspace}%
%%\newcommand\etc{etc.\@\xspace}%

\renewcommand\maketitle{\begin{titlepage}%
\let\footnotesize\small
\let\footnoterule\relax
\let \footnote \thanks
\normalfont
\null
\vbox to 0mm{\vss
\null\hskip-28mm\vbox{\normalfont Systems Engineering Group\par
Department of Mechanical Engineering\par
Eindhoven University of Technology\par
PO Box 513\par
5600 MB  Eindhoven\par
The Netherlands\par
%%DAvB http://seweb.se.wtb.tue.nl/}
http://se.wtb.tue.nl/}
\vskip 2mm
\null}
\vskip 14mm
\vbox to 37mm{%
\begin{center}\begin{minipage}{86mm}
\begin{center}
  \normalfont
  {\large SE Report: Nr.~\number\year-\@reportnumber \par}%
  \vskip 0.5em%
  {\LARGE \@title \par}%
  \vskip 1em%
  {\large\lineskip .75em%
   \begin{tabular}[t]{c}%
     \@author
   \end{tabular}\par}%
\end{center}
\end{minipage}\end{center}
}%vbox
\vfil
\vfill
\null\hfill ISSN: 1872-1567
\vskip 20mm
\begin{center}
SE Report: Nr.~\number\year-\@reportnumber\par
Eindhoven, \datum\par
%%DAvB SE Reports are available via http://seweb.se.wtb.tue.nl/sereports
SE Reports are available via http://se.wtb.tue.nl/sereports
\end{center}
\end{titlepage}%
\thispagestyle{empty}
}

\newcommand{\datum}{\ifcase\month\or January\or February\or March\or
                     April\or May\or June\or July\or August\or
                     September\or October\or November\or December\fi
                     \space\number\year}


\def\reportnumber#1{\gdef\@reportnumber{#1}}
\def\@reportnumber{\@latex@warning@no@line{No \noexpand\reportnumber given}}


\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thesection {\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}

\if@titlepage
  \newenvironment{abstract}{%
      \titlepage
      \null\vfil
      \@beginparpenalty\@lowpenalty
      \begin{center}%
        \bfseries \abstractname
        \@endparpenalty\@M
      \end{center}}%
     {\par\vfil\null\endtitlepage}
\else
  \newenvironment{abstract}{%
      \if@twocolumn
        \section*{\abstractname}%
      \else
        \small
        \begin{center}%
          {\bfseries \abstractname\vspace{-.5em}\vspace{\z@}}%
        \end{center}%
        \quotation
      \fi}
      {\if@twocolumn\else\endquotation\fi}
\fi

\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[section]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{proposition}[theorem]{Proposition}

\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{problem}[theorem]{Problem}
\newtheorem{example}[theorem]{Example}
\newtheorem{assumption}[theorem]{Assumption}
\newtheorem{property}[theorem]{Property}

\theoremstyle{remark}
\newtheorem{remark}[theorem]{Remark}



\endinput


