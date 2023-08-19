local builtin = require('telescope.builtin')
nmap('<leader>ff', builtin.find_files, "Find files")
nmap('<leader>fg', builtin.git_files, "Find files in git repo")
nmap('<leader>fs', builtin.live_grep, "find strings")
nmap('<leader>fh', builtin.help_tags, "Search help")
nmap('<leader>fk', builtin.keymaps, "Search key mappings")
nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

require('telescope').setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            "target"
        }
    }
})
