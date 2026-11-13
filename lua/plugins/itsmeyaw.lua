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
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh" },
    config = function()
      -- word-level inline diff (nvim 0.12+); replaces the default inline:char
      vim.opt.diffopt:remove("inline:char")
      vim.opt.diffopt:append("inline:word")
      local function hl()
        vim.api.nvim_set_hl(0, "DiffviewRemovedText", { fg = "#ffffff", bg = "#a31515", bold = true })
        vim.api.nvim_set_hl(0, "DiffviewChangedText", { fg = "#ffffff", bg = "#b35900", bold = true })
      end
      hl()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = hl })
      require("diffview").setup({
        hooks = {
          -- DiffText = word changed (both sides differ) -> orange.
          -- DiffTextAdd = word with no counterpart in the other pane; in the old ("a") pane that means removed -> red.
          diff_buf_win_enter = function(_, winid, ctx)
            local winhl = vim.wo[winid].winhl:gsub("DiffText:[^,]*", "DiffText:DiffviewChangedText")
            if ctx.symbol == "a" then
              winhl = winhl .. ",DiffTextAdd:DiffviewRemovedText"
            end
            vim.wo[winid].winhl = winhl
          end,
        },
      })
    end,
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
      { "<leader>gH", "<cmd>DiffviewOpen HEAD<cr>", desc = "Diffview vs HEAD" },
      { "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
      { "<leader>gF", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview file history" },
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
    { "<leader>ac", nil, desc = "AI/Claude Code" },
    { "<leader>acD", "<cmd>ClaudeCode --dangerously-skip-permissions<cr>", desc = "Claude Code Skip Permission" },
    { "<leader>acc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>acf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>acr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>acC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>acm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>acb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>acs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<leader>acs",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
    },
    -- Diff management
    { "<leader>aca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>acd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  },
  {
    "itsmeyaw/opencode.nvim",
    lazy = false,
    keys = {
      { "<leader>ao", nil, desc = "AI/OpenCode" },
      { "<leader>aot", "<cmd>OpenCode<cr>", desc = "Toggle OpenCode terminal" },
      { "<leader>aoa", function() require("opencode").ask("@this: ") end, mode = { "n", "x" }, desc = "Ask OpenCode" },
      { "<leader>aos", function() require("opencode").select() end, mode = { "n", "x" }, desc = "Select prompt" },
      { "<leader>aoc", function() require("opencode").attach_context() end, mode = { "n", "x" }, desc = "Attach context (no submit)" },
      { "<leader>aol", function() require("opencode").start_live_context() end, desc = "Start live context" },
      { "<leader>aoL", function() require("opencode").stop_live_context() end, desc = "Stop live context" },
    },
    init = function()
      vim.g.opencode_opts = {
        live_context = {
          enabled = true,
          port = 0,
        },
      }
    end,
  }
}
}
