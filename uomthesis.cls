% uomthesis.cls - The University of Melbourne PhD Thesis LaTeX Class File.

% Original work by Paul Cochrane, 2004

% Updated by Casey Visintin, 2017

% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
%   
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%    
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uomthesis}[26/02/2015 The University of Melbourne BioSciences thesis LaTeX class]

% ifthenelse for if loops
\RequirePackage{ifthen}

% is the thesis for Phd, MRes or Hons?  
% define the default first
\newcommand{\degreetext}{Doctor of Philosophy}
\DeclareOption{phd}{\renewcommand{\degreetext}%
{of the degree of Doctor of Philosophy}}
\DeclareOption{mres}{\renewcommand{\degreetext}%
{for the degree of Master of Research}}
\DeclareOption{hons}{\renewcommand{\degreetext}%
{in partial fulfilment of the degree of Bachelor of Science with Honours}}

% print a copyright page on the back of the title page?
\newboolean{copyrightpage}
\setboolean{copyrightpage}{false}
\DeclareOption{copyrightpage}{\setboolean{copyrightpage}{true}}

% print ``Examiner's copy'' on the title page?
\newboolean{examinerscopy}
\setboolean{examinerscopy}{false}
\DeclareOption{examinerscopy}{\setboolean{examinerscopy}{true}}

% use small caps for the title text?
\newboolean{titlesmallcaps}
\setboolean{titlesmallcaps}{false}
\DeclareOption{titlesmallcaps}{\setboolean{titlesmallcaps}{true}}

% finished processing options
\ProcessOptions\relax

% load the book class using 12pt font, a4paper, and start chapters on
% righthand/odd pages (note openany may also be used)
\LoadClass[12pt,a4paper]{book}

% set up margins (these are worked out from info from Printery)
%\setlength{\oddsidemargin}{-1in}   \setlength{\evensidemargin}{-1in}
%\addtolength{\oddsidemargin}{25mm} \addtolength{\evensidemargin}{20mm}
%\setlength{\marginparwidth}{40pt}  \setlength{\marginparsep}{10pt}
\setlength{\topmargin}{-5mm}       \setlength{\headsep}{0.4in}
\setlength{\textheight}{227mm}     \setlength{\textwidth}{165mm}

% new margins based on UoM requirements
\usepackage[outer=2.6cm,bindingoffset=6mm,bottom=3.5cm]{geometry}


\brokenpenalty=10000   % dunno what this does, maybe handy

% this stops one figure taking up a whole page and lets more text onto
% the one page when a figure exists
\renewcommand\floatpagefraction{0.9} %   Default = 0.5

% macros for defining the department, OrcID, various dates and the title and
% author of the thesis.
\def\department#1{\gdef\@department{#1}}
\def\orcid#1{\gdef\@orcid{#1}}
\def\submitdate#1{\gdef\@submitdate{#1}}
\def\copyrightyear#1{\gdef\@copyrightyear{#1}} % \author, \title in report
\def\@title{}
\def\@author{}
\def\@submitdate{\ifcase\the\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space \number\the\year}
\def\@copyrightyear{\number\the\year}

%%% load the required packages
% fancyhdr for nice, fancy headings
\RequirePackage{fancyhdr}
% ccaption for good caption handling
%\RequirePackage{ccaption}
% xspace so that spaces after commands are handled correctly
\RequirePackage{xspace}

% This constructs the UOM title page
\def\titlep{%
    \thispagestyle{empty}%
    \null\vskip.4in%
    \begin{center}
        \ifthenelse{\boolean{titlesmallcaps}}
            {\huge\sc\expandafter{\@title}} % put in small caps
            {\Large\uppercase\expandafter{\@title}} % use standard title
    \end{center}
    \vfill
    \begin{center}
        \textrm{By}\\
        \vskip.4in
        \textrm{\@author}\\
        \textrm{\scriptsize\@orcid}\\
    \end{center}
    \vskip.7in
    \begin{center}
        \textsc{Submitted in total fulfilment \\of the requirements of the degree of\\ 
        \degreetext{}\\ \vspace{.5cm}
\@submitdate\vspace{.5cm}
        \\
        School of \expandafter{\@department}\\
        Faculty of Science\\ \vspace{0cm}
        The University of Melbourne\\ }
        \vspace{1cm}
    \end{center}
    \ifthenelse{\boolean{examinerscopy}}{%
        \begin{center}
            %\vskip1in
            {\LARGE \textsc{Examiner's Copy}}
        \end{center}%
        }{}
    \vfill
    \vskip.5in\newpage}

% this defines the signature for the signature page where the standard
% declaration is put
\long\def\signature#1{%
\begin{center}
\begin{minipage}{4in}
\parindent=0pt
Except where acknowledged in the customary manner, the material
presented in this thesis is, to the best of my knowledge, original and
has not been submitted in whole or part for a degree in any university.
\par
\vspace{.5in}
\hbox to 4in{\hfil\shortstack{\vrule width 3in height 0.4pt\\#1}}
\end{minipage}
\end{center}}

% this is the actual signature page
\def\signaturepage{%
	\vskip.1in
	\signature{\@author}}

% now put in the titlepage
% (bit of a misnomer really, as it is really the first three or four pages.
\def\titlepage{%
    \pagenumbering{roman}  % make sure that front matter is numbered Roman
    \titlep
    \ifthenelse{\boolean{copyrightpage}}{%
        \newpage
        \vspace*{\fill}
        \begin{center}
            \copyright{} \@author, \@copyrightyear.
        \end{center}
        \begin{center}
            %Typeset in \LaTeXe{}.
        \end{center}
        \normalsize
        %\newpage
        %\signaturepage
        }{}
}

% set the pagestyle to look good
\pagestyle{fancy}

%%%%% Fancyhdr stuff
% give the header a bit more room, otherwise LaTeX will spew on each page
\addtolength{\headheight}{2.5pt}
% define how headers are marked, for details, see fancyhdr docs
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}

% define where sections, chapters and pagenumbers are put
% see fancyhdr docs for details
% the \nouppercase stops book.cls making the contents, bibliography
% and index headers from being all in uppercase.
% The options used here are essentially that in Lamport's book, but
% with small caps for the headings.
\fancyhf{}
\fancyhead[LE,RO]{\nouppercase{\thepage}}
\fancyhead[LO]{\sc \nouppercase{\rightmark}}
\fancyhead[RE]{\sc \nouppercase{\leftmark}}

%%% other settings required for a thesis
% It's a references section, not a bibliography, hence redefine
% \bibname (i.e. change ``Bibliography'' to ``References'')
%\renewcommand*{\bibname}{References} % <--Redefine name here
\renewcommand*{\bibname}{} % <-- or suppress references section naming altogether

% use 1.5 line spacing for the examiners copy
% single line spacing for the final copy
\ifthenelse{\boolean{examinerscopy}}{%
\renewcommand{\baselinestretch}{1.5}}%
{\renewcommand{\baselinestretch}{1}}

% spell things correctly
\newenvironment{centre}{\begin{center}}{\end{center}}
\newenvironment{itemise}{\begin{itemize}}{\end{itemize}}

%make the computer code look presentable
\usepackage{listings}
\usepackage[usenames,dvipsnames,svgnames]{xcolor}
\lstset{ %
  language=R,                % the language of the code
  basicstyle=\scriptsize,           % the size of the fonts that are used for the code
  numbers=left,                   % where to put the line-numbers
  numberstyle=\tiny\color{gray},  % the style that is used for the line-numbers
  stepnumber=1,                   % the step between two line-numbers. If it's 1, each line
                                  % will be numbered
  numbersep=5pt,                  % how far the line-numbers are from the code
  backgroundcolor=\color{white},      % choose the background color. You must add \usepackage{color}
  showspaces=false,               % show spaces adding particular underscores
  showstringspaces=false,         % underline spaces within strings
  showtabs=false,                 % show tabs within strings adding particular underscores
  frame=lines,                   % adds a frame around the code
  rulecolor=\color{black},        % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. commens (green here))
  tabsize=2,                      % sets default tabsize to 2 spaces
  captionpos=b,                   % sets the caption-position to bottom
  breaklines=true,                % sets automatic line breaking
  breakatwhitespace=false,        % sets if automatic breaks should only happen at whitespace
  %title=\lstname,                   % show the filename of files included with \lstinputlisting;
                                  % also try caption instead of title
  keywordstyle=\ttfamily,          % keyword style
  commentstyle=\color{DarkGreen},       % comment style
  stringstyle=\color{Maroon},         % string literal style
  %escapeinside={\%*}{*)},            % if you want to add a comment within your code
  morekeywords={*,...},              % if you want to add more keywords to the set
  otherkeywords={!,!=,~,$,*,\&,\%/\%,\%*\%,\%\%,<-,<<-},  %$
  keywords={}
}

%make spiffy chapter title pages
\usepackage[grey,times]{quotchap}

%\usepackage{makeidx} % <-- not sure this is required...

%%%%% optional packages
\usepackage[authoryear]{natbib}
		% this is the natural sciences bibliography citation
		% style package.

%%%%% set up the bibliography style
\bibliographystyle{thesis_ref_style}

% allows the table of contents, bibliography and index to be added to the table of
% contents if desired, the option used here specifies that the table of
% contents is not to be added. tocbibind needs to be after natbib
% otherwise bits of it get trampled.
\usepackage[nottoc]{tocbibind}

% load standard graphics package for inclusion of images and eps files into LaTeX document
\usepackage{graphicx}
\graphicspath{{./graphics/}{../graphics/}} %define a graphics directory

% this is handy for mathematicians and physicists (and quantitative ecologists :)
% see http://www.ams.org/tex/amslatex.html
\usepackage{amsmath,amsfonts,amssymb}

%%%additional formatting and functionality stuff
%set the nesting and numbering patterns for the TOC and sections
\setcounter{tocdepth}{3}
\setcounter{secnumdepth}{3}

% caption handling with some changes to defaults
\usepackage{setspace}
\usepackage{caption}
\captionsetup[figure]{labelfont={small,sc},labelsep=colon,font={small,singlespacing},width={.9\textwidth}}
\captionsetup[table]{labelfont={small,sc},labelsep=colon,font={small,singlespacing},width={.9\textwidth},singlelinecheck=false}

%%% create tables that look good and play well with others
\usepackage{tabularx}
\usepackage{booktabs}
\usepackage{multirow}
\usepackage{array}
%\usepackage{ltablex}
\usepackage{longtable}

% redefine tabular environment
\let\oldtabular\tabularx
\renewcommand{\tabularx}{\scriptsize\oldtabular}
\newcolumntype{P}[1]{>{\linespread{.9}\raggedright\arraybackslash}p{#1}}
\newcolumntype{Y}{>{\linespread{.7}\raggedright\arraybackslash}X}

% enable more control over internal referencing of figures and tables
\usepackage{cleveref}

% add functionality for subfigures
% \usepackage[caption=false]{subfig}
%\captionsetup[subfigure]{position=top,labelfont=bf,textfont=normalfont,singlelinecheck=off,justification=raggedright} %place labels on top left
% \captionsetup[subfigure]{labelfont=rm,margin=0pt}

% tikZ is stellar for manually creating and controlling drawing content
%\useackage{tikz} % <-- enable functionality

% this allows a clean insertion of external PDFs such as journal articles
%\usepackage{pdfpages} % <-- enable functionality

% wrap text nicely around figures and images
\usepackage{wrapfig}

% \usepackage{lipsum} % <-- enable for testing typography

%%% define new commands and some aliases
\newcommand{\B}{\textbf}
\newcommand{\TL}{\textless}
\newcommand{\PRZ}{\text{Pr}\bigl( >\mid Z \mid \bigr)}

%define an abstract environment for the beginning of the chapters
\newenvironment{localsize}[1]
{%
  \clearpage
  \let\orignewcommand\newcommand
  \let\newcommand\renewcommand
  \makeatletter
  \input{bk#1.clo}%
  \leftskip2em
  \rightskip\leftskip
  \par
  \makeatother
  \let\newcommand\orignewcommand
}

%define an abstract environment for the main document
\newenvironment{localsize-main}[1]
{%
  \let\orignewcommand\newcommand
  \let\newcommand\renewcommand
  \makeatletter
  \input{bk#1.clo}%
  \leftskip2em
  \rightskip\leftskip
  \par
  \makeatother
  \let\newcommand\orignewcommand
}

%add prefix 'Appendix' to TOC and headings
\makeatletter
\newcommand\appendix@chapter[1]{%
  \refstepcounter{chapter}%
  \orig@chapter*{Appendix \@Alph\c@chapter: #1}%
  \addcontentsline{toc}{chapter}{Appendix \@Alph\c@chapter: #1}%
}
\let\orig@chapter\chapter
\g@addto@macro\appendix{\let\chapter\appendix@chapter}
\makeatother

% make sure floats appear AFTER first mention in text
\usepackage{flafter}
\usepackage{placeins}

\let\Oldsection\section
\renewcommand{\section}{\FloatBarrier\Oldsection}

\let\Oldsubsection\subsection
\renewcommand{\subsection}{\FloatBarrier\Oldsubsection}

\let\Oldsubsubsection\subsubsection
\renewcommand{\subsubsection}{\FloatBarrier\Oldsubsubsection}

%tighten up all spacing in document
%\usepackage[subtle]{savetrees}

\setlength{\textfloatsep}{10pt plus 1.0pt minus 4.0pt}
\setlength{\intextsep}{10pt plus 2.0pt minus 2.0pt}

% enable images to be overlayed on top of one another
\usepackage{stackengine}

% improves float placements
\usepackage{float}

%\clubpenalty = 10000
%\widowpenalty = 10000
%\displaywidowpenalty = 10000

%\raggedbottom