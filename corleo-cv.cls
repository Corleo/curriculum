\ProvidesClass{corleo-cv}[2018/01/06 Classe para editar CV]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption{grayscale}{\def\@cv@grayscale{}}
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}

%%%%%%%%%%
% Colors %
%%%%%%%%%%
    \RequirePackage{xcolor}

    \definecolor{white}{RGB}{255,255,255}
    \definecolor{gray}{HTML}{4D4D4D}
    \definecolor{lightgray}{HTML}{888888}
    \definecolor{darkgray}{HTML}{333333}

    \definecolor{green}{HTML}{C2E15F}
    \definecolor{orange}{HTML}{FDA333}
    \definecolor{purple}{HTML}{D3A4F9}
    \definecolor{red}{HTML}{FB4485}
    \definecolor{blue}{HTML}{6CE0F1}

    \ifdefined\@cv@print
        \colorlet{green}{gray}
        \colorlet{orange}{gray}
        \colorlet{purple}{gray}
        \colorlet{red}{gray}
        \colorlet{blue}{gray}

        \colorlet{header}{gray}
        \colorlet{fillheader}{white}
    \else
        \ifdefined\@cv@grayscale
            \colorlet{green}{gray}
            \colorlet{orange}{gray}
            \colorlet{purple}{gray}
            \colorlet{red}{gray}
            \colorlet{blue}{gray}
        \fi
        \colorlet{header}{white}
        \colorlet{fillheader}{lightgray}
    \fi
    \colorlet{textcolor}{gray}
    \colorlet{headercolor}{gray}


%%%%%%%%%
% Fonts %
%%%%%%%%%
    \RequirePackage[quiet]{fontspec}
    \RequirePackage[]{fontawesome5}
    \RequirePackage[math-style=TeX]{unicode-math}

    \newfontfamily\bodyfont[]{Helvetica Neue}
    \newfontfamily\thinfont[]{Helvetica Neue UltraLight}
    \newfontfamily\headingfont[]{Helvetica Neue Condensed Bold}

    \defaultfontfeatures{Ligatures=TeX}
    \setmainfont[Color=textcolor]{Helvetica Neue Light}


%%%%%%%%%%%%
% Language %
%%%%%%%%%%%%
    % \RequirePackage[brazil]{babel}
    \RequirePackage{polyglossia}
    \setdefaultlanguage[]{brazil}


%%%%%%%%%%
% Header %
%%%%%%%%%%
    \RequirePackage{tikz}

    \newcommand{\header}[3]{%
        \begin{tikzpicture}[remember picture,overlay]
            \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=4.5cm] (box) at (current page.north){};
            \node [anchor=center] (name) at (box) {%
                \fontsize{40pt}{72pt}\color{header}%
                {\bodyfont #1}%
            };
            \node [anchor=north] (profession) at (name.south) {%
                \fontsize{16pt}{24pt}\color{header}%
                \bodyfont #2%
            };
            \node [anchor=north] (civil-state) at (profession.south) {%
                \fontsize{12pt}{24pt}\color{header}%
                \bodyfont #3%
            };
        \end{tikzpicture}
        \vspace{2.5cm}
    }
    \pagestyle{empty}


%%%%%%%%%%%%
% Sections %
%%%%%%%%%%%%
    \RequirePackage{titlesec}
    \RequirePackage{parskip}
    \newcounter{colorCounter}

    \def\@sectioncolor#1#2#3{%
        {%
            \color{%
                \ifcase\value{colorCounter}%
                    blue\or%
                    red\or%
                    orange\or%
                    green\or%
                    purple\else%
                    headercolor\fi%
            } #1#2#3%
        }%
        \stepcounter{colorCounter}%
    }

    \renewcommand{\section}[1]{
        \vspace{\parskip}
        {%
            \LARGE\headingfont\color{headercolor}%
            \@sectioncolor #1%
        }
        \vspace{\parskip}
    }

    \titleformat{\section}                      % <command>
        {\section}      % <format>
        {}              % <label> specify sectioning label
        {0em}           % <sep> horiz sep between label and title body
        {}              % <before-code> precedes the title body
        % [\titlerule]    % <after-code> follows the title body
    \titleformat{\subsection}%
        {\Large\headingfont\color{headercolor}}%
        {}{0em}{}
    \titleformat{\subsubsection}%
        {\large\headingfont\color{headercolor}}%
        {}{0em}{}

    % \titlespacing{\section}{0pt}{2\parskip}{\parskip}
    \titlespacing{\subsection}{0pt}{\parskip}{\parskip}
    \titlespacing{\subsubsection}{0pt}{\parskip}{\parskip}

    \newcommand\sidesection{\@startsection{section}{1}{0pt}%
        {0.8\baselineskip}%
        {0.2\baselineskip}%
        {\Large\headingfont\color{headercolor}}%
    }
    \newcommand\sidesubsection{\@startsection{section}{2}{0pt}%
        {0.7\baselineskip}%
        {0.2\baselineskip}%
        {\large\headingfont\color{headercolor}}%
    }
    \setcounter{secnumdepth}{0}


%%%%%%%%%%%%%%%%%%%
% Left side block %
%%%%%%%%%%%%%%%%%%%
    \newcommand{\topleft}{5.52}
    \newcommand{\topright}{2.5cm}

    \RequirePackage[absolute,overlay]{textpos} % option: showboxes
    \setlength{\TPHorizModule}{1cm} % unit for <hpos>
    \setlength{\TPVertModule}{1cm}  % unit for <vpos>
    \newenvironment{sideblock}{%
        \begin{textblock}{5.4}(1.2, \topleft) % \begin{textblock}{<hsize>}(<hpos>,<vpos>)
        \begin{flushleft}%
    }{%
        \end{flushleft}%
        \end{textblock}%
    }


%%%%%%%%%%%%%%%%%%
% Variable Table %
%%%%%%%%%%%%%%%%%%
    \newcommand{\vartable}[3]{%
        % [<# elem>]:
        %   {<table width>} : percentage of \textwidth
        %   {<col sep>}     : same as for table
        %   {<data>}        : formated data for the table
        \par\vspace{.2em}%
        \begin{tabular*}{#1\textwidth}{@{\extracolsep{\fill}}#2}%
        #3%
        \end{tabular*}%
        \par\vspace{.3em}%
    }

%%%%%%%%%%%%%%%%
% Custom Lists %
%%%%%%%%%%%%%%%%
    \RequirePackage{enumitem}

    % left aligned list
    \newenvironment{leftlist}%
        {\begin{itemize}[leftmargin=*,noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt]}%
        {\end{itemize}}

    % mid left aligned list
    \newenvironment{midleftlist}%
        {\begin{itemize}[leftmargin=1.2em,noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt]}%
        {\end{itemize}}


%%%%%%%%%%%%%%%%%%%%
% List environment %
%%%%%%%%%%%%%%%%%%%%
    \RequirePackage{xargs}

    \setlength{\tabcolsep}{0pt}
    \newenvironment{entrylist}%
        {\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}}%
        {\end{tabular*}}

    \renewcommand{\bfseries}{\headingfont\color{headercolor}}
    \newcommandx{\entry}[5][5=\setline]{%
        {\small #1}&\parbox[t]{0.74\textwidth}{%
            \textbf{#2}%
            \hfill%
            {\footnotesize\addfontfeature{Color=lightgray} #3}\\%
            #4#5
        }\\
    }


%%%%%%%%%%%%%%%%
% Social icons %
%%%%%%%%%%%%%%%%
    \RequirePackage{xstring}

    \newcommand{\phone}[1]{%
        \href{tel:#1}%
        {\faIcon{phone} #1}
        % {#1}
    }

    \newcommand{\cellphone}[1]{%
        \href{tel:#1}%
        {\faIcon{mobile-alt} #1}
        % {#1}
    }

    \newcommand{\whatsapp}[1]{%
        \href{cel:#1}%
        {\faIcon{whatsapp} #1}
        % {#1}
    }

    \newcommand{\email}[1]{%
        \href{mailto:#1}%
        {\faIcon{envelope} #1}
        % {#1}
    }

    \newcommand{\website}[1]{%
        \href{http://#1}{#1}
    }

    \newcommandx{\address}[2][2=nolink]{%
        \IfEqCase{#2}{%
            {link}%
                {\href{https://www.google.com/maps/search/?api=1&query=#1}{\faIcon{map-marker-alt} #1}}%
            {nolink}%
                {{\faIcon{map-marker-alt} #1}}%
        }[\PackageError{address}{Undefined option to address: #1}{}]%
    }

    \newcommand{\social}[3]{
        \href{#1/#3}{#2 \raisebox{0.1ex}{\scriptsize/} #3}
    }

    \newcommand{\linkedin}[1]{%
        \social{https://linkedin.com/in}{\faIcon{linkedin}}{#1}
    }

    \newcommand{\instagram}[1]{%
        \social{https://instagram.com}{\faIcon{instagram}}{#1}
    }

    \newcommand{\facebook}[1]{%
        \social{https://facebook.com}{\faIcon{facebook-square}}{#1}
    }

    \newcommand{\twitter}[1]{%
        \social{https://twitter.com}{\faIcon{twitter-square}}{#1}
    }

    \newcommand{\github}[1]{%
        \social{https://github.com}{\faIcon{github-square}}{#1}
    }


%%%%%%%%%%
% Others %
%%%%%%%%%%
    \newcommand{\dashbarr}{\textendash~}
    \newcommandx{\setline}[1][1=1]{\par\vspace{#1em}}

    \RequirePackage[
        a4paper,
        left=7.6cm,
        right=1.5cm,
        top=\topright,
        bottom=2.5cm,
        nohead,
        nofoot
    ]{geometry}
    \RequirePackage[hidelinks]{hyperref}
    \RequirePackage{lipsum}
