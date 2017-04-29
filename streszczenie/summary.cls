%% start of file `moderncv.cls'.
%% Copyright 2006-2013 Xavier Danaux (xdanaux@gmail.com).
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License version 1.3c,
% available at http://www.latex-project.org/lppl/.


%-------------------------------------------------------------------------------
%                identification
%-------------------------------------------------------------------------------\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{summary}[2017/04/28 v1.0.0 thesis summary document class]

%-------------------------------------------------------------------------------
%                class options
%
% (need to be done before the external package loading, for example because
% we need \paperwidth, \paperheight and \@ptsize to be defined before loading
% geometry and fancyhdr)
%-------------------------------------------------------------------------------
% paper size option
\DeclareOption{a4paper}{
	\setlength\paperheight{297mm}
	\setlength\paperwidth{210mm}}
\DeclareOption{a5paper}{
	\setlength\paperheight{210mm}
	\setlength\paperwidth{148mm}}
\DeclareOption{b5paper}{
	\setlength\paperheight{250mm}
	\setlength\paperwidth{176mm}}
\DeclareOption{letterpaper}{
	\setlength\paperheight{11in}
	\setlength\paperwidth{8.5in}}
\DeclareOption{legalpaper}{
	\setlength\paperheight{14in}
	\setlength\paperwidth{8.5in}}
\DeclareOption{executivepaper}{
	\setlength\paperheight{10.5in}
	\setlength\paperwidth{7.25in}}
\DeclareOption{landscape}{
	\setlength\@tempdima{\paperheight}
	\setlength\paperheight{\paperwidth}
	\setlength\paperwidth{\@tempdima}}

% font size options
\newcommand\@ptsize{}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}

% font type options
\DeclareOption{sans}{\AtBeginDocument{\renewcommand{\familydefault}{\sfdefault}}}
\DeclareOption{roman}{\AtBeginDocument{\renewcommand{\familydefault}{\rmdefault}}}

% draft/final option
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}

% execute default options
\ExecuteOptions{a4paper,11pt,final}

% process given options
\ProcessOptions\relax
\input{size1\@ptsize.clo}

%-------------------------------------------------------------------------------
%                required packages
%-------------------------------------------------------------------------------
\RequirePackage{etoolbox}
\RequirePackage[utf8]{inputenc}
\RequirePackage[OT4]{fontenc}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{ragged2e}
\newcommand*\pdfpagemode{UseNone}% 
\RequirePackage{url}
\urlstyle{tt}
\AtEndPreamble{
	\pagenumbering{arabic}% has to be issued before loading hyperref, as to set \thepage and hence to avoid hyperref issuing a warning and setting pdfpagelabels=false
	\RequirePackage[unicode]{hyperref}% unicode is required for unicode pdf metadata
	\hypersetup{
		breaklinks,
		baseurl       = http://,
		pdfborder     = 0 0 0,
		pdfpagemode   = \pdfpagemode,
		pdfstartpage  = 1,
		pdfcreator    = {\LaTeX{} with 'summary' package},
		bookmarksopen = true,
		bookmarksdepth= 2,% to show sections and subsections
		pdfauthor     = {\@studentFirstname{}~\@studentLastname{}},
		pdftitle      = {\@studentFirstname{}~\@studentLastname{} -- \@title{}},
		pdfsubject    = {Streszczenie rozprawy doktorskiej},
		pdfkeywords   = {\@studentFirstname{}~\@studentLastname{}, summary, phd, thesis}}}
	
	% graphics
	\RequirePackage{graphicx}
	
	% headers and footers
	\RequirePackage{fancyhdr}
	\fancypagestyle{plain}{
		\renewcommand{\headrulewidth}{0pt}
		\renewcommand{\footrulewidth}{0pt}
		\fancyhf{}}
	% page numbers in footer if more than 1 page
	\newif\if@displaypagenumbers\@displaypagenumberstrue
	\newcommand*{\nopagenumbers}{\@displaypagenumbersfalse}
	\AtEndPreamble{%
		\AtBeginDocument{%
			\if@displaypagenumbers%
			\@ifundefined{r@lastpage}{}{%
				\ifthenelse{\pageref{lastpage}>1}{%
					\newlength{\pagenumberwidth}%
					\settowidth{\pagenumberwidth}{\color{color2}\addressfont\itshape\strut\thepage/\pageref{lastpage}}%
					\fancypagestyle{plain}{%
						\fancyfoot[r]{\parbox[b]{\pagenumberwidth}{\color{color2}\pagenumberfont\strut\thepage/\pageref{lastpage}}}}% the parbox is required to ensure alignment with a possible center footer (e.g., as in the casual style)
					\pagestyle{plain}}{}}%
			\AtEndDocument{\label{lastpage}}\else\fi}}
	\pagestyle{plain}
	
	% reduced list spacing
	% package providing hooks into lists
	%   originally developped by Jakob Schiøtz (see http://dcwww.camd.dtu.dk/~schiotz/comp/LatexTips/tweaklist.sty)
	%   modified and distributed with moderncv(not available otherwise on ctan)
	\RequirePackage{tweaklist}
	\renewcommand*{\itemhook}{%
		\@minipagetrue% removes spacing before lists as they use \addvspace, which doesn't add vertical space inside minipages
		\@noparlisttrue% removes spacing at end of lists, caused by \par
		\setlength{\topsep}{0pt}% normally not required thanks to \@minipagetrue
		\setlength{\partopsep}{0pt}% normally not required thanks to \@minipagetrue
		\setlength{\parsep}{0pt}% not required when \itemsep and \parskip are set to 0pt (?)
		\setlength{\parskip}{0pt}%
		\setlength{\itemsep}{0pt}}
	\renewcommand*{\enumhook}{\itemhook{}}
	\renewcommand*{\deschook}{\itemhook{}}
	
	% lengths calculations
	\RequirePackage{calc}
	
	% advanced command arguments (LaTeX 3)
	\RequirePackage{xparse}
	% TODO (?): replace all \newcommand by \NewDocumentCommand
	
	% micro-typography (e.g., character protrusion, font expansion, hyphenatable letterspacing)
	\RequirePackage{microtype}
	
	\RequirePackage[short]{datetime}
	
	%-------------------------------------------------------------------------------
	%                class definition
	%-------------------------------------------------------------------------------
	% minimal base settings
	\setlength\lineskip{1\p@}
	\setlength\normallineskip{1\p@}
	\renewcommand\baselinestretch{}
	\setlength{\parindent}{0\p@}
	\setlength{\parskip}{0\p@}
	\setlength\columnsep{10\p@}
	\setlength\columnseprule{0\p@}
	\setlength\fboxsep{3\p@}
	\setlength\fboxrule{.4\p@}
	\setlength\arrayrulewidth{.4\p@}
	\setlength\doublerulesep{2\p@}
	
	% not set on purpose
	%\setlength\arraycolsep{5\p@}
	%\setlength\tabcolsep{6\p@}
	%\setlength\tabbingsep{\labelsep}
	
	\raggedbottom
	\onecolumn
	
	
	
	
	%-------------------------------------------------------------------------------
	%                overall design commands definitions
	%-------------------------------------------------------------------------------
	% symbols
	%   enumerate labels
	\renewcommand{\theenumi}{\@arabic\c@enumi}
	\renewcommand{\theenumii}{\@alph\c@enumii}
	\renewcommand{\theenumiii}{\@roman\c@enumiii}
	\renewcommand{\theenumiv}{\@Alph\c@enumiv}
	%   other symbols
	\newcommand*{\listitemsymbol}{\labelitemi~}
	\newcommand*{\addresssymbol}{}
	\newcommand*{\mobilephonesymbol}{}
	\newcommand*{\fixedphonesymbol}{}
	\newcommand*{\faxphonesymbol}{}
	\newcommand*{\emailsymbol}{}
	\newcommand*{\homepagesymbol}{}
	
	\newcommand*{\student}[3]{\def\@studentTitle{#1}\def\@studentFirstname{#2}\def\@studentLastname{#3}}
	\newcommand*{\supervisor}[3]{\def\@supervisorTitle{#1}\def\@supervisorFirstname{#2}\def\@supervisorLastname{#3}}
	\renewcommand*{\title}[1]{\def\@title{#1}}
	\newcommand*{\thesisTitle}[1]{\def\@thesisTitle{#1}}
	\newcommand*{\thesis}[1]{\def\@thesis{#1}}
	\newcommand*{\location}[1]{\def\@location{#1}}
	
	%-------------------------------------------------------------------------------
	%                Commands for elements of CV structure
	%-------------------------------------------------------------------------------
	\newcommand*{\makeheader}{
			\begin{FlushLeft}
						\@studentTitle{} \@studentFirstname{} \@studentLastname{} \hfill 	\@location{}, \today \\					
					Promotor: \@supervisorTitle{} \@supervisorFirstname{} \@supervisorLastname{} 
								\end{FlushLeft}
	
	\vspace*{2cm}
	\Centering
		\@title{}\\
		\vspace*{0.5cm}
		\textbf{\@thesisTitle{}}\\

\vspace*{1.5cm}
\justify
\textbf{\underline{Teza:}} \textbf{\@thesis{}}
	}