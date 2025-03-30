-- environments with possible options
local function autoenv(trigger, name, has_option)
    if name == nil then
        name = "<>"
    end

    local pos = { nil, nil, nil }
    local i_count = 1

    if name == "<>" then
        pos[1] = i(i_count)
        i_count = i_count + 1
    else
        pos[1] = t(name)
    end

    if has_option then
        pos[2] = c(i_count, { sn(nil, { t("["), i(1), t("]") }), i(nil) })
        i_count = i_count + 1
    else
        pos[2] = t("")
    end

    pos[3] = i(i_count)

    local nodes = fmta([[
    \begin{<1>}<2>
        <3>
    \end{<1>}
    ]], pos, { repeat_duplicates = true })

    return s({ trig = trigger, snippetType = "autosnippet" }, nodes)
end

-- simple snippets
local function autosnip(trigger, value)
    return s({ trig = trigger, snippetType = "autosnippet" }, value)
end

-- simple command
local function autocmd(trigger, name)
    return autosnip(trigger, { t("\\" .. name .. "{"), i(1), t("}") })
end

-- list environemnts which recursively add new items
local function autolist(trigger, env)
    local function create_item()
        return sn(nil, c(1, {
            sn(nil, {
                i(1), t("\\end{" .. env .. "}")
            }),
            sn(nil, {
                t("\t\\item "), i(1), t({"", ""}), d(2, create_item)
            }),
        }))
    end

    return s({ trig = trigger, snippetType = "autosnippet" }, {
        t({ "\\begin{" .. env .. "}", "\t\\item " }),
        i(1),
        t({"", ""}),
        d(2, create_item)
    })
end

return {

    ------------
    -- General -
    ------------

    autocmd("snn", "section"),
    autocmd("ssnn", "subsection"),

    autosnip("nd", { t("\\noindent ") }),

    autocmd("txt", "text"),
    autocmd("tbf", "textbf"),

    -- figures
    autosnip("incg", { t("\\includegraphics[width="), i(1, "0.7"), t("\\textwidth]{"), i(2), t("}") }),
    autosnip("cpt", { t("\\captionof{"), i(1, "figure"), t("}{"), i(2), t("}") }),

    -- environments
    autoenv("bgn", nil, false),
    autoenv("dfn", "definition", true),
    autoenv("thm", "theorem", true),
    autoenv("lmm", "lemma", true),
    autoenv("prp", "proposition", true),
    autoenv("prf", "proof", false),
    autoenv("aln", "align*", false),
    autolist("izz", "itemize"),
    autolist("ett", "enumerate"),

    ---------
    -- Math -
    ---------
    autocmd("bb", "mathbb"),
    autocmd("vv", "vec"),

    autosnip("sseq", t("\\subseteq")),
    autosnip("...", t("\\ldots")),
    autosnip("css", {
        t({ "\\begin{cases}", "\t" }),
        i(1), t(" & \\text{if } "), i(2), t({ " \\\\", "\t" }),
        i(3), t({ " & \\text{otherwise}", "" }),
        t("\\end{cases}")
    }),
    autosnip("pdx", {
        t("\\frac{\\partial "), i(1), t("}{\\partial "), i(2, "x"), t("}")
    }),
    autosnip("ddx", {
        t("\\frac{d "), i(1), t("}{d "), i(2, "x"), t("}")
    }),
    autosnip("smm", {
        t("\\sum_{"), i(1), t("}^{"), i(2), t("}")
    }),

    -- expand fraction
    s({ trig = [[\(\S\+\)\/\(\S\+\)]], trigEngine = "vim", hidden = true }, f(
        function(_, parent, _)
            return string.format("\\frac{%s}{%s}", parent.captures[1], parent.captures[2])
        end, {}, {})),


    -----------------
    -- Problem Sets -
    -----------------

    -- RedNote
    autosnip("rn", { t("\\RedNote{"), i(1), t("}") }),

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
    s("newset", fmta([[
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
    \usepackage{caption}

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

    % theorem setup
    \theoremstyle{plain}
    \newtheorem{theorem}{Theorem}[section]
    \newtheorem{lemma}{Lemma}[section]
    \newtheorem{corollary}{Corollary}[section]
    \newtheorem{proposition}{Proposition}[section]
    \theoremstyle{definition}
    \newtheorem{definition}{Definition}[section]
    \numberwithin{figure}{section}


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
    }))
}
