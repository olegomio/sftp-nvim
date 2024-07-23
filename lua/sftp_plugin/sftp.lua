local M = {}
local profile = nil

-- Function to choose a profile
function M.choose_profile()
  local cwd = vim.fn.getcwd()
  local repo = cwd:match("([^/]+)$")
  
  if repo == "repo1" then
    profiles = {"dev1", "dev2"}
  elseif repo == "repo2" then
    profiles = {"dev3", "dev4"}
  else
    print("Unknown repository: " .. repo)
    return
  end

  vim.ui.select(profiles, {prompt = 'Choose an SFTP profile:'}, function(choice)
    profile = choice
    if profile then
      print("Selected profile: " .. profile)
      vim.g.sftp_profile = profile
      vim.g.sftp_repo = repo
    else
      print("No profile selected")
    end
  end)
end

-- Function to upload the current file
function M.upload_file()
  if not profile then
    profile = vim.g.sftp_profile
  end

  if not vim.g.sftp_repo then
    local cwd = vim.fn.getcwd()
    vim.g.sftp_repo = cwd:match("([^/]+)$")
  end

  if not profile then
    print("No profile selected. Use :ChooseProfile to select one.")
    return
  end

  local file = vim.fn.expand('%:p')
  if file and file ~= "" then
    local cmd = string.format('~/.config/upload.sh %s %s %s', vim.g.sftp_repo, profile, file)
    os.execute(cmd)
    print("Uploaded " .. file .. " using profile " .. profile .. " for repo " .. vim.g.sftp_repo)
  else
    print("No file to upload")
  end
end

return M

