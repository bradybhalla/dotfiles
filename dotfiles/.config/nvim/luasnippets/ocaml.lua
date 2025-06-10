local function snip(trigger, text, nodes)
    return s({ trig = trigger }, fmt(text, nodes))
end

return {
    snip("flw", "failwith \"{}\"", { i(1, "TODO") })
}
