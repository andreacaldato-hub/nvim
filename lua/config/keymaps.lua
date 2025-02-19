-- Set leader key to space
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
local opts = { noremap = true, silent = true }

--save filg
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)
vim.keymap.set("n", "x", '"_x', opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "nzzzv", opts)
-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
-- Navigate buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>x", ":bd!<CR>", opts) -- close buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer
-- tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab
-- window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split window vertically
vim.keymap.set("n", "<leader>o", "<C-w>s", opts) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window
-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)
-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)
-- toggle line wrapping
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<CR>", opts)
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

vim.api.nvim_set_keymap("t", "<leader>q", "<C-\\><C-n>:q<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap(
  "n",
  "<leader>t",
  ":execute 'vsplit term://bash' | :cd %:p:h<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<leader>h", ":hide<CR>", { noremap = true, silent = true })

-- Set a keybinding for entering Normal mode in terminal
-- Map <Leader>t to open a terminal in the current file's directory
vim.api.nvim_set_keymap("n", "<Leader>t", ":lua OpenTerminalWithCWD()<CR>", { noremap = true, silent = true })

-- Function to open terminal with 'cd' to the current file's directory
function OpenTerminalWithCWD()
  local current_file_dir = vim.fn.expand("%:p:h") -- Get the current file's directory
  vim.cmd("vsplit | terminal") -- Open terminal in a split window
  vim.cmd("startinsert") -- Start in insert mode in terminal
  vim.fn.chansend(vim.b.terminal_job_id, "cd " .. current_file_dir .. "\n") -- Send 'cd' command
end

-- Set a keybinding for entering Normal mode in terminal
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
-- Map 'jj' to escape insert mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Map leader f a to search all files on the system
vim.api.nvim_set_keymap("n", "<leader>fq", ":Telescope find_files cwd=/<CR>", { noremap = true, silent = true })

-- Keybinding to open the PDF in a vertical split
vim.api.nvim_set_keymap("n", "<leader>lv", ":vsp | term zathura %:r.pdf<CR>", { noremap = true, silent = true })
-- Keybindings Configuration (keybind.lua)

-- Keybinding to toggle Neo-tree
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.tex", -- Trigger this for any .tex file
  callback = function()
    -- Save the current working directory
    local current_dir = vim.fn.expand("%:p:h")

    -- Change to the directory of the current .tex file
    vim.cmd("cd " .. current_dir)

    -- Run the latexmk command but suppress the output
    vim.cmd("!latexmk -pdf % > /dev/null 2>&1") -- Redirect stdout and stderr to null

    -- Optionally, return to the original directory after the compilation
    vim.cmd("cd -")
  end,
})
vim.api.nvim_set_keymap("n", "<C-w>", ":set wrap<CR>", { noremap = true, silent = true })
--
--
