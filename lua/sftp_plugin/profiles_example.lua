local M = {}

-- Define the base paths as variables
M.paths = {
  repo01 = "~/repos/main-page-child-theme",
  repo02 = "~/repos/blog-child-theme",
  repo03 = "~/repos/plugin_development", 
  -- Add more paths as needed
}

-- Define the profiles with all relevant SFTP information
M.profiles = {
  repo01_dev1 = {
    host = "ip.add.ress",
    protocol: "sftp",
    port = 22,
    secure = true,
    username = "dev1",
    remotePath = "/var/www/dev1/wp-content/themes/divi-child",
    password = "",
    uploadOnSave = true,
    localPath = M.paths.repo01
  },
  repo01_dev2 = {
    host = "ip.add.ress",
    protocol: "sftp",
    port = 22,
    secure = true,
    username = "dev2",
    remotePath = "/var/www/dev1/wp-content/themes/divi-child",
    password = "",
    uploadOnSave = true,
    localPath = M.paths.repo01
  },
  repo02_dev1 = {
    host = "ip.add.ress",
    protocol: "sftp",
    port = 22,
    secure = true,
    username = "dev1",
    remotePath = "/var/www/dev2/wp-content/themes/divi-blog-child",
    password = "",
    uploadOnSave = true,
    localPath = M.paths.repo02 
    },
  repo02_dev2 = {
    host = "ip.add.ress",
    protocol: "sftp",
    port = 22,
    secure = true,
    username = "dev2",
    remotePath = "/var/www/dev2/wp-content/themes/divi-blog-child",
    password = "",
    uploadOnSave = true,
    localPath = M.paths.repo02
    },
  -- Add more profiles as needed
}

return M

