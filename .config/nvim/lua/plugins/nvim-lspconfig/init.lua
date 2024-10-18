return {
  "neovim/nvim-lspconfig",
  name = "nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { "williamboman/mason.nvim",config = true },
    "williamboman/mason-lspconfig.nvim",
    { "folke/neodev.nvim",            opts = {} },
    { "kosorin/awesome-code-doc" },
    { "p00f/clangd_extensions.nvim",  opts = {} },
    { "nvim-telescope/telescope.nvim" },
  },
  init = function()
    local pickers = require("telescope.builtin")
    -- [[ Configure LSP ]]
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
      nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
      -- nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
      nmap("gr", pickers.lsp_references, "[G]oto [R]eferences")
      -- nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
      nmap("gI", pickers.lsp_implementations, "[G]oto [I]mplementation")
      -- nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
      nmap("<leader>D", pickers.lsp_type_definitions, "Type [D]efinition")
      -- nmap("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
      nmap("<leader>ds", pickers.lsp_document_symbols, "[D]ocument [S]ymbols")
      nmap("<leader>ws", pickers.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

      -- See `:help K` for why this keymap
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

      -- Lesser used LSP functionality
      nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "[W]orkspace [L]ist Folders")

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })
    end

    require("mason").setup()

    -- Enable the following language servers
    -- Add any additional override configuration in the following tables.
    -- They will be passed to the `settings` field of the server config.
    local servers = {
      bashls = {
        bashls = {
          name = "bash-language-server",
          cmd = { "bash-language-server", "start" },
        },
      },
      clangd = {
        clangd = {
          cmd = { "clangd" },
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
          single_file_support = { "true" },
        },
      },
      cmake = {},
      julials = {
        julia = {
        },
      },
      lua_ls = {
        Lua = {
          hint = {
            enable = true,
          },
          workspace = {
            checkThirdParty = false,
            library = {
              ["/home/air/.local/share/nvim/lazy/awesome-code-doc"] = true,
            },
          },
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
            },
          },
          telemetry = { enable = false },
        },
      },
      matlab_ls = {},
      pylsp = {
        pylsp = {
          filetypes = { 'py', 'pytxcode' },
          plugins = {
            autopep8 = {
              enabled = true,
            },
            flake8 = {
              enabled = false,
              executable = "flake8",
            },
            pylsp_isort = {
              enabled = true,
            },
            jedi_completion = {
              enabled = true,
              fuzzy = true,
            },
            mccabe = {
              enabled = true,
            },
            pylsp_mypy = {
              enabled = true,
            },
            pycodestyle = {
              enabled = true,
            },
            pydocstyle = {
              enabled = true,
              convention = "numpy",
            },
            pyflakes = {
              enabled = true,
            },
            pylint = {
              enabled = true,
              executable = "pylint"
            },
            rope_autoimport = {
              completions = { enabled = true },
              code_actions = { enabled = true },
            },
          },
        },
      },
      texlab = {
        texlab = {
          cmd = "texlab",
          fileypes = { "tex", "plaintex", "bib", "cls" },
          settings = {
            texlab = {
              auxDirectory = ".",
              bibtexFormatter = "texlab",
              build = {
                args = { "-lualatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
                executable = "latexmk",
                forwardSearchAfter = false,
                onSave = false
              },
              chktex = {
                onEdit = true,
                onOpenAndSave = true
              },
              diagnosticsDelay = 300,
              formatterLineLength = 80,
              forwardSearch = {
                args = {}
              },
              latexFormatter = "latexindent",
              latexindent = {
                modifyLineBreaks = false
              }
            }
          }
        },
      },
      tinymist = {
        command = "tinymist",
        single_file_support = true,
        root_dir = function()
          return vim.fn.getcwd()
        end,
        settings = {
          exportPdf = "onType"
          -- serverPath = ""
        }
      },
    }

    -- nvim-cmp supports additional completion capabilities,
    -- so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {

      function(server_name)
        if server_name == servers.julials then
          On_new_config = function(new_config, _)
            local julia = vim.fn.expand("~/.local/share/julia/environments/nvim-lspconfig/bin/julia")
            if require("lspconfig").util.path.is_file(julia) then
              new_config.cmd[1] = julia
            end
          end
        end
        require("lspconfig")[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end
    }
  end
}
