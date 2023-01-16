local icons = {
  diagnostics = require("craftzdog.icons").get("diagnostics", true),
  misc = require("craftzdog.icons").get("misc", true),
}

local function escape_status()
  local ok, m = pcall(require, "better_escape")
  return ok and m.waiting and icons.misc.EscapeST or ""
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local mini_sections = {
  lualine_a = { "filetype" },
  lualine_b = {},
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = {},
}
local outline = {
  sections = mini_sections,
  filetypes = { "lspsagaoutline" },
}

local function python_venv()
  local function env_cleanup(venv)
    if string.find(venv, "/") then
      local final_venv = venv
      for w in venv:gmatch("([^/]+)") do
        final_venv = w
      end
      venv = final_venv
    end
    return venv
  end

  if vim.bo.filetype == "python" then
    local venv = os.getenv("CONDA_DEFAULT_ENV")
    if venv then
      return string.format("%s", env_cleanup(venv))
    end
    venv = os.getenv("VIRTUAL_ENV")
    if venv then
      return string.format("%s", env_cleanup(venv))
    end
  end
  return ""
end

require("lualine").setup({
  options = {
    size = 2,
    icons_enabled = true,
    theme = "catppuccin",
    disabled_filetypes = {},
    component_separators = "|",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { { "branch" }, { "diff", source = diff_source } },
    lualine_c = {
      {
        colored = true,
        'filename',
        path = 1,
      }
    },
    lualine_x = {
      { escape_status },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warning,
          info = icons.diagnostics.Information,
        },
      },
    },
    lualine_y = {
      { "filetype", colored = true, icon_only = true },
      { python_venv },
      { "encoding" },
      -- {
      -- 	"fileformat",
      -- 	icons_enabled = true,
      -- 	symbols = {
      -- 		unix = "LF",
      -- 		dos = "CRLF",
      -- 		mac = "CR",
      -- 	},
      -- },
    },
    lualine_z = { "progress", "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {
    "quickfix",
    "nvim-tree",
    "nvim-dap-ui",
    "toggleterm",
    "fugitive",
    outline,
  },
})
