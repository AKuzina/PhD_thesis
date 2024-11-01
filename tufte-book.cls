\NeedsTeXFormat{LaTeX2e}[1994/06/01]

\ProvidesClass{tufte-book}[2015/06/30 v3.5.3 Tufte-book class]

%%
% Declare we're tufte-book
\newcommand{\@tufte@class}{book}% the base LaTeX class (defaults to the article/handout style)
\newcommand{\@tufte@pkgname}{tufte-book}% the name of the package (defaults to tufte-handout)

%%
% Load the common style elements
\input{tufte-common.def}

%%
% Set up any book-specific stuff now

%%
% The front matter in Tufte's /Beautiful Evidence/ contains everything up
% to the opening page of Chapter 1.  The running heads, when they appear,
% contain only the (arabic) page number in the outside corner.
%\newif\if@mainmatter \@mainmattertrue
% \renewcommand\frontmatter{%
%   \@mainmatterfalse%
%   \pagenumbering{arabic}%
%   %\pagestyle{plain}%
%   \fancyhf{}%
%   \ifthenelse{\boolean{@tufte@twoside}}%
%     {\fancyhead[LE,RO]{\thepage}}%
%     {\fancyhead[RE,RO]{\thepage}}%
% }

%	flush T I G H T  L I S T S
%
% \AtBeginDocument{
% 	\setlist{topsep=0pt, itemsep=0pt, noitemsep}
% }
% 	diamond bullets
\renewcommand{\labelitemi}{$\vcenter{\hbox{\small$\diamond$}}$}


\renewcommand\frontmatter{%
  \if@openright%
    \cleardoublepage%
  \else%
    \clearpage%
  \fi%
  \@mainmatterfalse%
  \pagenumbering{roman}%
  %\pagestyle{plain}%
  \fancyhf{}%
  \ifthenelse{\boolean{@tufte@twoside}}%
    {\fancyhead[LE,RO]{\thepage}}%
    {\fancyhead[RE,RO]{\thepage}}%
}



%%
% The main matter starts numbering pages from the number 1 (the first page of the first chapter is page 1).


\renewcommand\mainmatter{%
  \if@openright%
    \cleardoublepage%
  \else%
    \clearpage%
  \fi%
  \@mainmattertrue%
    \pagenumbering{arabic}%
  \fancyhf{}%
  \ifthenelse{\boolean{@tufte@twoside}}%
    {% two-side
      \renewcommand{\chaptermark}[1]{\markboth{##1}{}}%
            \renewcommand{\partmark}[1]{\markboth{##1}{}}%
      %\fancyhead[LE]{\thepage\quad\smallcaps{\newlinetospace{\plaintitle}}}% book title
         \fancyhead[LE]{\thepage}% book title
      \fancyhead[RO]{\smallcaps{\newlinetospace{\leftmark}}\quad\thepage}% chapter title
    }%
    {% one-side
      \fancyhead[RE,RO]{\smallcaps{\newlinetospace{\plaintitle}}\quad\thepage}% book title
    }%
}

%%
% The back matter contains appendices, indices, glossaries, endnotes,
% biliographies, list of contributors, illustration credits, etc.
\renewcommand\backmatter{%
  \if@openright%
    \cleardoublepage%
  \else%
    \clearpage%
  \fi%
  \@mainmatterfalse%
}

%%
% If there is a `tufte-book-local.sty' file, load it.

% title
\IfFileExists{tufte-book-local.tex}{%
  \@tufte@info@noline{Loading tufte-book-local.tex}%
  \input{tufte-book-local}%
}{}

%%%
% remove paragraph indentation
% Paragraph indentation and separation for normal text
\renewcommand{\@tufte@reset@par}{%
  \setlength{\RaggedRightParindent}{0.0pc}%
  \setlength{\JustifyingParindent}{0.0pc}%
  \setlength{\parindent}{0pc}%
  \setlength{\parskip}{\baselineskip}%
}
\@tufte@reset@par

% Paragraph indentation and separation for marginal text
\renewcommand{\@tufte@margin@par}{%
  \setlength{\RaggedRightParindent}{0.0pc}%
  \setlength{\JustifyingParindent}{0.0pc}%
  \setlength{\parindent}{0.0pc}%
  \setlength{\parskip}{10pt}%
}
%%%

%%%%%%%% MAKE TITLE PAGES %%%%%%%%%%%%%%%%
%% Define all the pieces that go on the title page and the abstract.
% \title and \author already exist

\def\prevdegrees#1{\gdef\@prevdegrees{#1}}
\def\@prevdegrees{}

\def\department#1{\gdef\@department{#1}}

% If you are getting two degrees, use \and between the names.
\def\degree#1{\setbox0\hbox{#1}	 %for side effect of setting \@degreeword
  \gdef\@degree{#1}}

% \and is used inside the \degree argument to separate two degrees
\def\and{\gdef\@degreeword{degrees} \par and \par}
\def\@degreeword{degree}

\def\thesisdate#1{\gdef\@thesisdate{#1}}

% typically just a month and year
\def\degreemonth#1{\gdef\@degreemonth{#1}}
\def\degreeyear#1{\gdef\@degreeyear{#1}}

% Usage: \supervisor{name}{title}
%        \chairman{name}{title}

% since there can be more than one supervisor,
% we build the appropriate boxes for the titlepage and
% the abstractpage as the user makes multiple calls
% to \supervisor
\newbox\@titlesupervisor 	\newbox\@abstractsupervisor

\def\supervisor#1#2{\setbox\@titlesupervisor\vbox
  {\unvbox\@titlesupervisor \vskip 10pt% plus 1fil minus 1fil
  \def\baselinestretch{1}\large
  \signature{Certified by}{#1 \\ #2 \\ Thesis Supervisor}}
  \setbox\@abstractsupervisor\vbox{\unvbox\@abstractsupervisor
  \vskip\baselineskip \def\baselinestretch{1}\@normalsize 
  \par\noindent Thesis Supervisor: #1 \\ Title: #2}}

% department chairman, not thesis committee chairman
\def\chairman#1#2{\gdef\@chairmanname{#1}\gdef\@chairmantitle{#2}}

\makeatletter
% 	subtitle --title already exists
\newcommand\subtitle[1]{\renewcommand\@subtitle{#1}}
\newcommand\@subtitle{}
% 	university
\newcommand\university[1]{\renewcommand\@university{#1}}
\newcommand\@university{}

%	logos
\newcommand\logos{}
\def\xfoo#1\relax{\long\def\logos##1{#1}}
\newcommand\updatelogos[1]{%
   \expandafter\xfoo\logos{##1}##1#1\relax
}
\newcommand\logo[1]{
    \updatelogos{
		\hspace{20pt}\includegraphics[height=50pt]{#1}
	}
}

% 	Doctoral thesis (subsubtitle)
\newcommand\type[1]{\renewcommand\@type{#1}}
\newcommand\@type{Doctoral thesis}

% 	shoutouts
\newcommand\shoutouts[1]{\renewcommand\@shoutouts{#1}}
\newcommand\@shoutouts{}

% Dutch Fake title page
\newcommand{\rector}[1]{\newcommand{\@rector}{#1}}
\newcommand{\phdfaculty}[1]{\newcommand{\@phdfaculty}{#1}}
\newcommand{\defensedate}[1]{\newcommand{\@defensedate}{#1}}
\newcommand{\defenselocation}[1]{\newcommand{\@defenselocation}{#1}}

\newcommand{\@phdtext}{
ter verkrijging van de graad Doctor of Philosophy\\
aan de Vrije Universiteit Amsterdam,\\
op gezag van de rector magnificus\\
\@rector{},\\
volgens besluit van de decaan \\
van de \@phdfaculty{}\\
in het openbaar te verdedigen\\
op \@defensedate{}\\
in het openbaar te verdedigen\\
in de \@defenselocation{} van de universiteit,\\
De Boelelaan 1105
}

\newcommand{\birthplace}[1]{\newcommand{\@birthplace}{#1}}


% 	ACTUAL MAKETITLE (titlepage + "copyright" and dedication pages)
\newcommand\@maketitlebis{%
	\makeatletter
	\setstretch{1.0}
	\begin{titlepage}
		% \setcounter{page}{1}
		\hfill
		\begin{minipage}{.8\linewidth}
		\raggedleft

		{\large \sffamily \scshape  \MakeUppercase{\@university}%
				\bigskip
				% \MakeLowercase{\@lab}%  <- this percent is mandatory -- without it latex places and awkward space
		}

		\vskip 80pt

		{\LARGE\@author}

		\vskip 40 pt

		{%
			\huge \sffamily \scshape 
			\color{niceRed}
                % \color{niceBlue}
			\@title\par
			}%

		\vskip 8pt

		{\large\@subtitle\par}%

		\vskip 20pt

		% {\Large \@type}%

		\vskip 40pt

		% {\itshape\@date}

		\end{minipage}

		\vfill

		\raggedleft

		% \begin{tabular}{rll}
			% \people{}
		% \end{tabular}

		\vskip 40pt

		% \logos{}

	\end{titlepage}

		\hypersetup{
			% colorlinks = true,
			linkcolor = niceBlue,
			anchorcolor = niceBlue,
			citecolor = .,
			urlcolor = niceBlue,
		}

	%%%% copyright page
	\thispagestyle{empty}
        \noindent This thesis was typeset by the author using \LaTeX and the \texttt{tufte-latex-thesis} class.\\
        The cover was designed by \\
        % Printing: www.proefschriftmaken.nl.
	\hfill
	\vfill
	\makeatletter
	\noindent Copyright \copyright\ 2024 \@author \\
        \noindent ISBN: xxxxx\\
	\makeatother


        %%%% compulsory VU part
        \cleardoublepage
        \thispagestyle{empty}
        \noindent
        \begin{center}
         {\large  \sffamily \scshape \MakeUppercase{\@university}}
        
        \vfill
           {\huge \sffamily \scshape  \textbf{\@title}}%
             \if \@subtitle \relax \else \par \Large {\@subtitle} \par \fi
          \vfill
        \Large \MakeUppercase{academisch proefschrift}\\
        \normalsize
        \vspace{1cm}
        \@phdtext\\
        \vspace{1cm}
        door\\
        \vspace{1cm}
        {\LARGE \@author}\\
        \normalsize
        \vspace{1cm}
        geboren te \@birthplace
        \end{center}
        
        
        %%%% PhD commitee: to fill in
        \newpage
        % \thispagestyle{empty}
        \noindent \textbf{This dissertation was approved by}

        %% List the promotors (supervisors).
        \medskip\noindent
        \begin{tabular}{p{3cm}p{5cm}l}
            \mbox{\emph{Promoter:}} & 
            prof.dr.~A.E. Eiben & Vrije Universiteit Amsterdam, \\ 
                               & & The Netherlands \\
            \mbox{\emph{Copromoters:}} & 
            dr.~J.M.Tomczak & Eindhoven University of Technology, \\ 
                          & & The Netherlands \\
            & prof.dr.~M.Welling & Universiteit van Amsterdam, \\ 
                                & & The Netherlands \\
        \end{tabular}
        
        \bigskip
        \noindent \textbf{Dissertation Committee} 
        
        \medskip\noindent
        \begin{tabular}{p{3cm}p{5cm}l}
            \mbox{\emph{Chairman:}} & 
            Rector Magnificus, &   Vrije Universiteit Amsterdam, \\
                 & \@rector{}  & The Netherlands \\
            \medskip \\ 
            \mbox{\emph{Committee:}} 
            &dr.~Yingzhen Li & Uni \\
            && Location \\
            &prof.dr.~Mark Hoogendoorn & Uni \\
            && Location \\
            &dr.~Jes Frellsen & Uni \\
            && Location \\
            &prof.dr.~Stefan Mandt & Uni \\
            && Location \\
            &dr.~Efstration Gavves & Uni \\
            && Location \\
            % & Prof.~dr.~ & Vrije Universiteit Amsterdam, \\ 
            % & & The Netherlands \\
            % & Prof.~dr.~ & Vrije Universiteit Amsterdam, \\ 
            % & & The Netherlands \\
        \end{tabular}
        
	% dedication
	\cleardoublepage
	\thispagestyle{empty}
	~\vskip .3\textheight
	\begin{flushright}
	\large\itshape\@shoutouts
	\end{flushright}

	\setstretch{1.12}

        % decalaration of authorship
        \chapter*{Declaration of Authorship}
        \noindent I, \makeatletter \@author \makeatother, hereby declare that the thesis titled 
         "\makeatletter \@title \makeatother"  and its content are the result of my own work. 
        
        \noindent I confirm that:
        
        \begin{itemize} 
        
        \item This work was primarily conducted during my pursuit of a research degree at these universities.
        \item If any portion of this thesis has been previously submitted for an academic degree or any other qualification at these universities or any other educational institution, I have explicitly disclosed this information.
        \item I have consistently acknowledged the sources of published works by other authors that I consulted.
        \item In cases where I have included excerpts from the work of others, I have consistently provided proper source attributions. Aside from these quotations, the entirety of this thesis represents my independent effort.
        \item I have acknowledged all significant sources of assistance.
        \item In cases where this thesis draws upon collaborative efforts with others, I have provided a clear distinction between the contributions made by collaborators and my own individual contributions.
        \end{itemize}
        
        \vspace{15pt}
        \begin{flushright}
        \makeatletter \today \makeatother
        \end{flushright}
	\makeatother
}
\renewcommand\maketitlepage{
        \begingroup%
        \setlength{\parindent}{0pt}
        \newgeometry{left=2.4cm}
	\@maketitlebis
	\thispagestyle{empty}
        \endgroup
}

% abstract
\def\abstractpage{\cleardoublepage
% \noindent\large{\bf \@title} \\
% \hfill \\
% \newline \noindent\@author 
% \par
% \def\baselinestretch{1}\@normalsize
% \noindent
% {\setlength{\parindent}{0cm}Submitted to the \@department  \\
% on \@thesisdate, in partial fulfillment of the requirements for \\
% the \@degreeword\ of \@degree}
% \par
\begin{abstract}}

%% Changed from \unvbox to \unvcopy for use with multiple copies of abstract
%% page.
%% Krishna Sethuraman (1990)
\def\endabstractpage{\end{abstract}\noindent
% \unvcopy\@abstractsupervisor 
\newpage}
 
 % translated abstract
\def\trabstractpage{\cleardoublepage
% \noindent\large{\bf \@title} \\
% \hfill \\
% \newline \noindent\@author 
% \par
% \def\baselinestretch{1}\@normalsize
% \noindent
% {\setlength{\parindent}{0cm}Submitted to the \@department  \\
% on \@thesisdate, in partial fulfillment of the requirements for \\
% the \@degreeword\ of \@degree}
% \par
\begin{translatedabstract}}

%% Changed from \unvbox to \unvcopy for use with multiple copies of abstract
%% page.
%% Krishna Sethuraman (1990)
\def\endtrabstractpage{\end{translatedabstract}\noindent
 
%\unvcopy\@abstractsupervisor
 \newpage}

%% This counter is used to save the page number for the second copy of
%% the abstract.
\newcounter{savepage}

% You can use the titlepage environment to do it all yourself if you
% don't want to use \maketitle.  If the titlepage environment, the
% paragraph skip is infinitely stretchable, so if you leave a blank line
% between lines that you want space between, the space will stretch so
% that the title page fills up the entire page.
\def\titlepage{\cleardoublepage\centering
  \thispagestyle{empty}
  \parindent 0pt \parskip 10pt plus 1fil minus 1fil
  \def\baselinestretch{1}\@normalsize\vbox to \vsize\bgroup\vbox to 9in\bgroup}
% The \kern0pt pushes any depth into the height.  Thanks to Richard Stone.
\def\endtitlepage{\par\kern 0pt\egroup\vss\egroup\newpage}


\def\signature#1#2{\par\noindent#1\dotfill\null\\*
  {\raggedleft #2\par}}

% \def\abstract{\subsection*{Abstract}\small\def\baselinestretch{1}\@normalsize}
% \def\endabstract{\par}
\def\abstract{\chapter
    *{Summary}\small\def\baselinestretch{1}\@normalsize}
\def\endabstract{\par}

% You may want to change "Abstract" for the translated version in your local language (e.g. Résumé in French).

\def\translatedabstract{\chapter
    *{Samenvatting \\ Dutch Summary}\small\def\baselinestretch{1}\@normalsize}
\def\endtranslatedabstract{\par}

%% [AYB]
%% Add a page for reader signature
% Usage: \reader{name}{title}{dept}
% since there is almost more than one reader,
% we build the appropriate boxes for the readerpage
% as the user makes multiple calls to \reader
\newbox\@readers

\def\reader#1#2#3{\setbox\@readers\vbox
  {\unvbox\@readers \vskip 50pt  %% plus 1fil minus 1fil
  \def\baselinestretch{1}\large
  \signature{Thesis Reader}{#1 \\ #2 \\ #3}}
}

\def\readerpage{\newpage
{
\begin{flushleft}
\large
{\def\baselinestretch{1.2}\Large\bf \choosecase{\@title} \par}
\par

\@author \\[\baselineskip]}
\par
The following people served as readers for this thesis:\\
\par
\unvbox\@readers
\par
\end{flushleft}
\newpage
}

%%%
%	C O L O R  D E F I N I T I O N
\definecolor{niceRed}{HTML}{980326}
\definecolor{niceBlue}{HTML}{025472}
\definecolor{tooRed}{HTML}{cc0000}
% \renewcommand\thefootnote{\color{niceBlue}\arabic{footnote}}
% \renewcommand\thesidenote{\color{niceBlue}\arabic{sidenote}}
\newcommand\red[1]{\textcolor{niceRed}{#1}}



%%
% End of file
\endinput


