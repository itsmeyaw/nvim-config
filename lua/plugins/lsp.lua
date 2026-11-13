return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Neovim 0.12.1 has a core bug in incremental LSP change-tracking
        -- (vim/lsp/sync.lua:136 "assertion failed!") that crashes when conform
        -- applies formatter text edits while texlab is attached. Forcing full
        -- document sync avoids the buggy compute_diff path entirely.
        texlab = {
          on_init = function(client)
            local sync = client.server_capabilities.textDocumentSync
            if type(sync) == "table" then
              sync.change = 1 -- TextDocumentSyncKind.Full
            else
              client.server_capabilities.textDocumentSync = { change = 1, openClose = true }
            end
          end,
        },
      },
    },
  },
}
