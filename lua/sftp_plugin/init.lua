local M = {}

M.setup = function()
  -- Key mappings
  vim.api.nvim_set_keymap('n', '<leader>sp', ':lua require("sftp_plugin.sftp").choose_profile()<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>su', ':lua require("sftp_plugin.sftp").upload_file()<CR>', { noremap = true, silent = true })

  -- Autocommand to upload file on save
  vim.cmd([[
    augroup auto_upload
      autocmd!
      autocmd BufWritePost * :lua require('sftp_plugin.sftp').upload_file()
    augroup END
  ]])
end

return M

