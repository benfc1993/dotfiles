local builtin = require('telescope.builtin')
nmap('<leader>ff', function()
    builtin.find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' } })
end, "Find files")
nmap('<leader>b', builtin.buffers, "Find existing buffers")
nmap('<leader>fg', builtin.git_files, "Find files in git repo")
nmap('<leader>fa', builtin.live_grep, "find strings in all files")
nmap('<leader>fs', builtin.current_buffer_fuzzy_find, "find string in file")
nmap('<leader>fh', builtin.help_tags, "Search help")
nmap('<leader>fk', builtin.keymaps, "Search key mappings")
nmap('<leader>th', function()
    builtin.colorscheme({
        enable_preview = true
    })
end, "Change Color Scheme")
nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules/",
            "target/",
            "build/",
            "gradle/",
            "dist",
            "package-lock.json"
        }
    }
})
