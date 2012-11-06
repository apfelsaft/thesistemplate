\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iaikthesis}[2012/10/12 IAIK master theses document class]
\LoadClass[a4paper,
            abstract=yes,
            11pt,
            DIV=12,     % reduce borders a bit
            openright,
            toc=bib,    % include bibliography in table of contents
            BCOR=5mm,   % loss through page fold (when bound as book)
%            draft,
            twoside]{scrreprt}

\RequirePackage[english,ngerman]{babel}                 % load english and german languages
\RequirePackage{url}                                    % for urls
\RequirePackage[utf8]{inputenc}                         % encoding of input files
\RequirePackage{setspace}                               % control line spacing
\RequirePackage[komastyle,
                headsepline,
                markuppercase]{scrpage2}                % use default styles from koma-script for header and footer
\RequirePackage{graphicx}                               % for \includegraphics
\RequirePackage{color}
\RequirePackage{listings}                               % code listings
\RequirePackage{cite}                                   % slightly more options for citations
% class retrieves language as option
\DeclareOption{english}{\AtBeginDocument{\selectlanguage{english}}}
\DeclareOption{german}{\AtBeginDocument{\selectlanguage{ngerman}}}
\ExecuteOptions{english}
\ProcessOptions\relax

% define labels
\newcommand\definetoday{%
 \renewcommand*\today{%
  \iflanguage{english}{%
   \number\day\space \ifcase\month\or%
    January\or%
    February\or%
    March\or%
    April\or%
    May\or%
    June\or%
    July\or%
    August\or%
    September\or%
    October\or%
    November\or%
    December\or%
   \fi\space \number\year
  }{%
   \number\day.~\ifcase\month\or%
    J\"anner\or%
    Februar\or%
    M\"arz\or%
    April\or%
    Mai\or%
    Juni\or%
    Juli\or%
    August\or%
    September\or%
    Oktober\or%
    November\or%
    Dezember%
   \fi\space \number\year
  }%
 }
}

%% increase the line spacing for easier reading
\renewcommand{\baselinestretch}{1.1}

%% avoid widows (the last line of a paragraph at
%% the start of a page) and orphans/clubs
%% (the first line of paragraph at the end of a page)
\clubpenalty = 99999
\widowpenalty = 99999
\displaywidowpenalty = 99999

%% avoid annoying line overflow
\setlength{\emergencystretch}{2em}

%% do not number Part X pages
\renewcommand*{\partpagestyle}{empty}

%% internal lables 
\newcommand\kindname{%
 \iflanguage{english}{Master~Thesis}{Masterarbeit}%
}
\newcommand\supervisorname{%
 \iflanguage{english}{Supervisor}{Betreuer}%
}
\newcommand\assessorname{%
 \iflanguage{english}{Assessor}{Gutachter}%
}
\newcommand\supervisorsname{%
 \iflanguage{english}{Supervisors}{Betreuer}%
}
\newcommand\universityaddress{%
  \iflanguage{english}{%
    Graz University of Technology\\
    A-8010 Graz, Austria
  }{
    Technische Universität Graz\\
    A-8010 Graz, Österreich
  }%
}

%% default values
\global\let\@supervisors\@empty
\newcommand*\@mailaddress\@empty
\global\let\@matriculationnumber\@empty
\newcommand*\@plaintitle\@empty
\newcommand*\@plainauthor\@empty
\global\let\@assessor\@empty


%% public parameters for title page:
\newcommand*\@supervisor{insert the name of your supervisor}
\newcommand*\@institute{insert the institute of your supervisor}
\newcommand*\institute[1]{\gdef\@institute{#1}}
\newcommand*\mailaddress[1]{\gdef\@mailaddress{#1}}
\newcommand*\matriculationnumber[1]{\gdef\@matriculationnumber{#1}}
\newcommand*\plaintitle[1]{\gdef\@plaintitle{#1}}
\newcommand*\plainauthor[1]{\gdef\@plainauthor{#1}}
\subject{\kindname}
\newcommand{\supervisor}[1]{%
 \def\@supervisor{#1}
 \publishers{\supervisorname: #1}
}
\newcommand{\assessor}[1]{%
 \def\@assessor{#1}
}
\newcommand{\supervisors}[1]{%
 \def\@supervisors{#1}
 \publishers{\supervisorsname:
  {
   \def\and{\\}
   \begin{tabular}[t]{l}
   #1
   \end{tabular}
  }
 }
}
\renewcommand\abstract[1]{%
 \global\setbox\absbox=\hbox{#1}%
}
\global\let\@acknowledgments\@empty
\newcommand\acknowledgments[1]{\def\@acknowledgments{#1}}
\newcommand*\frontmatter{%
 \if@twoside\cleardoublepage\else\clearpage\fi
  \@mainmatterfalse\pagestyle{plain}\pagenumbering{Roman}%
}
\newcommand*\mainmatter{%
 \if@twoside\cleardoublepage\else\clearpage\fi
  \@mainmattertrue\pagenumbering{arabic}\pagestyle{scrheadings}\automark[section]{chapter}%
}
\newcommand*\backmatter{%
\if@openright\cleardoublepage\else\clearpage\fi
  \@mainmatterfalse%
}

%% remove indentation of footnotes with multiple lines
\deffootnote[1em]{1em}{1em}{\textsuperscript{\thefootnotemark}}

%% captions of float environments should be bold in sansserif font
\setkomafont{captionlabel}{\sffamily\bfseries}

% setup at \begin{document}
\AtBeginDocument{%
 \global\newbox\absbox%
 \renewcommand\abstractname{%
  \iflanguage{english}{Abstract}{Zusammenfassung (Englisch)}%
 }
 \newcommand\zusfname{Zusammenfassung}
 \newcommand\ackname{%
  \iflanguage{english}{Acknowledgments}{Danksagung}%
 }
 \definetoday
}

% title page
\renewcommand*\maketitle[1][-1]{{%
  \setcounter{page}{#1}
  \thispagestyle{empty}
  \begin{center}
    \vspace*{3em}
    {\Large\sffamily\textbf{\@subject}}
    \vskip2.5em
    {\titlefont\Huge\@plaintitle}
    \vskip6em
    {\Large\@plainauthor
      \ifx\@matriculationnumber\@empty{}
      \else \ (\@matriculationnumber)
      \fi
      \vskip.4em
      \ifx\@mailaddress\@empty{}
      \else\texttt{\href{mailto:\@mailaddress}{\@mailaddress}}
      \fi
    }
    \vfill
    {\large\vbox{%
      \ifx\@supervisors\@empty
        \ifx\@assessor\@empty {}
        \else
            \assessorname: \@assessor\\
            \iflanguage{english}{\gdef\supervisorname{Advisor}}{}
        \fi
        \supervisorname: \@supervisor
      \else
        \supervisorsname\\ { \def\and{\\} \@supervisors}
      \fi
      }
      \vfill
      \includegraphics[width=3cm]{tug_logo}
      \vskip1.5em
      {\@institute\\ \universityaddress}
      \vfill
      {Graz, \@date}
    }
  \end{center}
  \cleardoublepage
  \frontmatter
}}

\newcommand\statutorydeclaration[1][-1]{{%
  \cleardoublepage
  \setcounter{page}{#1}
  \thispagestyle{empty}
  \section*{Eidesstattliche Erkl{\"a}rung}
  \thispagestyle{empty}

  Ich erkl{\"a}re an Eides statt, dass ich die vorliegende Arbeit selbstst{\"a}ndig verfasst,
  andere als die angegebenen Quellen/Hilfsmittel nicht benutzt, und die den benutzten Quellen
  w{\"o}rtlich und inhaltlich entnommene Stellen als solche kenntlich gemacht habe.

  \iflanguage{english}{%
	  \vspace{2em}
	  \section*{Statutory Declaration}
	  I declare that I have authored this thesis independently, that I have not used other than
	  the declared sources / resources, and that I have explicitly marked all material which has
	  been quoted either literally or by content from the used sources.
  }{}
	
  \vspace{2cm}
  \noindent\mbox{}
    \hskip 0pt plus .25fill
    \hrulefill
    \hskip 0pt plus .5fill
    \hrulefill
    \hskip 0pt plus .25fill
  \mbox{}
  \\
  \noindent\mbox{}
    \hskip 1em plus .25fill
    Ort, Datum/Place, Date
    \hskip 2em plus .5fill
    Unterschrift/Signature
    \hskip 1em plus .25fill
  \mbox{}
  \cleardoublepage
}}

\let\@OLDtableofcontents\tableofcontents
\renewcommand\tableofcontents{%
    % \pagestyle{empty}
    % \cleardoublepage
    % \begin{center}
    % \normalfont\sectfont\nobreak\abstractname
    % \@endparpenalty\@M
    % \end{center}
    % \unhbox\absbox
    % \par\vfil\null
    % \ifx\@acknowledgments\@empty{}\else
    % \cleardoublepage
    % \chapter*{\ackname}
    % \@acknowledgments
    % \cleardoublepage
    % \fi
    \@OLDtableofcontents
    \cleardoublepage
    \mainmatter
}
\endinput

%% Force KOMAscript to re-calculate margins
% \KOMAoptions{DIV=last}