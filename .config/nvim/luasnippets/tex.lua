return {

    ------------
    -- General -
    ------------

    s("no", t("\\noindent")),

    -- begin / end environment
    s("beg", fmt([[
    \begin{<env>}
        <todo>
    \end{<env>}
    ]], { env = i(1), todo = i(0) }, { delimiters = "<>", repeat_duplicates = true })),

    -- align environment
    s("ali", fmt([[
    \begin{align*}
        <todo>
    \end{align*}
    ]], { todo = i(0) }, { delimiters = "<>" })),

    -- expand fraction
    s({ trig = [[\(\S\+\)\/\(\S\+\)]], trigEngine = "vim", hidden = true }, f(
        function(_, parent, _)
            return string.format("\\frac{%s}{%s}", parent.captures[1], parent.captures[2])
        end, {}, {})),

    -----------------
    -- Problem Sets -
    -----------------

    -- RedNote
    s("rn", fmt([[
    \RedNote{<todo>}
    ]], { todo = i(1, "TODO") }, { delimiters = "<>" })),

    -- problem with parts
    s({ trig = [[prob\(\d\)\([a-z1-9]\)\?]], trigEngine = "vim", hidden = true }, f(
        function(_, parent, _)
            local parts = ""
            if parent.captures[2] == nil then
                -- single part
                parts = "\\RedNote{TODO}\n\n"
            else
                -- multiple parts
                parts = ""
                local one = parent.captures[2] <= '9' and string.byte('1') or string.byte('a')
                local count = string.byte(parent.captures[2])
                for i = one, count do
                    local symbol = string.char(i)
                    parts = parts .. "\\subsection*{" .. symbol .. "}\n"
                    parts = parts .. "\\RedNote{TODO}\n\n"
                end
            end

            return vim.split(string.format("\\section*{Exercise %s}\n%s\\newpage\n", parent.captures[1], parts), "\n")
        end, {}, {})),

    -- set template
    s("newset", fmt([[
    %%%%%%%%%%%%%%%%%%
    % Setup/Packages %
    %%%%%%%%%%%%%%%%%%

    \documentclass[a4paper, 11pt]{article}

    \usepackage{fullpage}
    \usepackage{amsmath}
    \usepackage{amssymb}
    \usepackage{amsthm}
    \usepackage{graphicx}
    \usepackage{xcolor}

    % hide page numbers
    \pagenumbering{gobble}


    %%%%%%%%%%%%
    % Commands %
    %%%%%%%%%%%%

    % dark mode
    \newcommand{\dark}{\pagecolor[rgb]{0.19,0.20,0.27}\color[rgb]{0.78,0.82,0.96}\definecolor{red}{HTML}{E78284}}

    % RedNote
    \newcommand{\RedNote}[1]{\begin{center}\textcolor{red}{\rule{0.2\textwidth}{2pt}\quad#1\quad\rule{0.2\textwidth}{2pt}}\end{center}}

    % fix spacing around left and right
    \let\originalleft\left
    \let\originalright\right
    \renewcommand{\left}{\mathopen{}\mathclose\bgroup\originalleft}
    \renewcommand{\right}{\aftergroup\egroup\originalright}

    % set of real numbers
    \newcommand{\R}{\mathbb{R}}


    %%%%%%%%%%%%
    % Document %
    %%%%%%%%%%%%

    \title{<title>}
    \author{<author>}
    \date{}

    \begin{document}

    \maketitle

    <content>

    \end{document}

    ]], {
        title = c(1, {
            sn(nil, { t("Set "), i(1) }),
            i(nil)
        }),
        author = i(2, "Brady Bhalla"),
        content = i(0),
    }, { delimiters = "<>" }))
}
