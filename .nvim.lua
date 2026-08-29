



local function project_workspace()
  -- Create a fresh tab with an empty editor buffer.
  vim.cmd("tabnew")

  -- Keep a reference to the main editor window.
  local editor_win = vim.api.nvim_get_current_win()

  -- Create the right-side Explore window.
  vim.cmd("vsplit")
  local explore_win = vim.api.nvim_get_current_win()
  vim.cmd("Explore")

  -- Return to the editor window.
  vim.api.nvim_set_current_win(editor_win)

  -- Create the bottom terminal.
  vim.cmd("belowright split")
  local terminal_win = vim.api.nvim_get_current_win()

  -- Start the terminal in the project root.
  vim.fn.jobstart(vim.o.shell, {
	cwd = vim.fn.getcwd(),
	term=true
  })

  vim.cmd("resize 12")

  -- Return focus to the editor.
  vim.api.nvim_set_current_win(editor_win)

  -- Useful window-local settings.
  vim.wo[explore_win].number = false
  vim.wo[explore_win].relativenumber = false
  vim.wo[terminal_win].number = false
  vim.wo[terminal_win].relativenumber = false

  vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("ProjectWorkspace", project_workspace, {})


vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      project_workspace()
    end
  end,
})
