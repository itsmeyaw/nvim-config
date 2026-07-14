-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  {
    "snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[
██╗████████╗███████╗███╗   ███╗███████╗██╗   ██╗ █████╗ ██╗    ██╗
██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝╚██╗ ██╔╝██╔══██╗██║    ██║
██║   ██║   ███████╗██╔████╔██║█████╗   ╚████╔╝ ███████║██║ █╗ ██║
██║   ██║   ╚════██║██║╚██╔╝██║██╔══╝    ╚██╔╝  ██╔══██║██║███╗██║
██║   ██║   ███████║██║ ╚═╝ ██║███████╗   ██║   ██║  ██║╚███╔███╔╝
╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚══╝╚══╝ 
]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
  },
  {
    "D0nw0r/dark2026.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("dark2026")
      local hl = vim.api.nvim_set_hl
      hl(0, "Normal", { bg = "none" })
      hl(0, "NormalNC", { bg = "none" })
      hl(0, "NormalFloat", { bg = "none" })
      hl(0, "SignColumn", { bg = "none" })
      hl(0, "StatusLine", { bg = "none" })
      hl(0, "StatusLineNC", { bg = "none" })
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = true,
          },
          explorer = {
            hidden = true,
            ignored = true,
            untracked = true,
          },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      snippets = {
        search_paths = { vim.fn.stdpath("config") .. "/snippets" },
      },
    },
  },
  {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  -- `cmd` lets lazy.nvim create command stubs that load the plugin on first use,
  -- so `:ClaudeCode` and friends work on a fresh start. Without it, a keys-only
  -- spec defers loading until a <leader>a* mapping is pressed and the commands
  -- would not exist yet.
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeSelectModel",
    "ClaudeCodeAdd",
    "ClaudeCodeSend",
    "ClaudeCodeTreeAdd",
    "ClaudeCodeStatus",
    "ClaudeCodeStart",
    "ClaudeCodeStop",
    "ClaudeCodeOpen",
    "ClaudeCodeClose",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
    "ClaudeCodeCloseAllDiffs",
  },
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
    },
    -- Diff management
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
}
}
