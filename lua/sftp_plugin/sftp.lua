local M = {}
local profile = nil

-- Load paths and profiles
local config = require('sftp_plugin.profiles')

-- Function to choose a profile
function M.choose_profile()
  local cwd = vim.fn.getcwd()
  
  -- Find profiles based on the current directory
  local available_profiles = {}
  for name, info in pairs(config.profiles) do
    if cwd == info.localPath then
      table.insert(available_profiles, name)
    end
  end
  
  -- Debugging information
  print("Current working directory: " .. cwd)

  if #available_profiles > 0 then
    vim.ui.select(available_profiles, {prompt = 'Choose an SFTP profile:'}, function(choice)
      profile = choice
      if profile then
        print("Selected profile: " .. profile)
        vim.g.sftp_profile = profile
        vim.g.sftp_repo = cwd
      else
        print("No profile selected")
      end
    end)
  else
    print("Unknown directory or no profiles available for the current directory: " .. cwd)
  end
end

-- Function to upload the current file
function M.upload_file()
  if not profile then
    profile = vim.g.sftp_profile
  end

  if not vim.g.sftp_repo then
    vim.g.sftp_repo = vim.fn.getcwd()
  end

  if not profile then
    print("No profile selected. Use :ChooseProfile to select one.")
    return
  end

  local file = vim.fn.expand('%:p')
  if file and file ~= "" then
    local profile_info = config.profiles[profile]
    local cmd = string.format(
      'sshpass -p %s sftp -oPort=%d %s@%s:%s <<< $\'put %s\'',
      profile_info.password, profile_info.port, profile_info.username, profile_info.host, profile_info.remotePath, file
    )
    os.execute(cmd)
    print("Uploaded " .. file .. " using profile " .. profile)
  else
    print("No file to upload")
  end
end

return M

