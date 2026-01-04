vim.opt.ambiwidth = "single"
vim.opt.winblend = 20		-- windowの透過率
vim.opt.pumblend = 20		-- pop up menuの透過率
vim.opt.termguicolors = true	-- terminalのgui設定
vim.opt.swapfile = false
vim.opt.number = true  --行数表示
vim.opt.clipboard = 'unnamedplus'  --クリップボード共有
vim.o.expandtab = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- pdf typst
vim.api.nvim_create_user_command("OpenPdf", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath:match("%.typ$") then
    local pdf_path = filepath:gsub("%.typ$", ".pdf")
    vim.system({ "open", pdf_path })
  end
end, {})

