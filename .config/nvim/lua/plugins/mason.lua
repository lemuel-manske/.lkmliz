return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "INSTALLED",
          package_pending = "PENDING",
          package_uninstalled = "UNINSTALLED",
        },
      },
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "gopls",
        "jdtls",
        "jsonls",
        "lua_ls",
        "pyright",
        "ts_ls",
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint_d",
        "java-debug-adapter",
        "java-test",
        "prettier",
        "stylua",
      },
    },
  },

  {
    "mfussenegger/nvim-jdtls",

    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
}
