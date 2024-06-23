return {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      require('dapui').setup()
      require('nvim-dap-virtual-text').setup {}

      vim.keymap.set('n', '<leader>br', function()
        require('dap').continue()
      end, { desc = 'De[b]ug [r]un' })
      vim.keymap.set('n', '<leader>bp', function()
        require('dap').toggle_breakpoint()
      end, { desc = 'Toggle [b]reak[p]oint' })
      vim.keymap.set('n', '<leader>be', function()
        require('dap').restart()
      end, { desc = 'De[b]ug R[e]start' })
      vim.keymap.set('n', '<leader>bs', function()
        require('dap.ui.widgets').preview()
      end, { desc = 'De[b]ug [s]how' })

      local dap = require 'dap'
      local dapui = require 'dapui'
      dap.adapters.lldb = {
        type = 'executable',
        command = '/opt/homebrew/Cellar/llvm/18.1.6/bin/lldb-dap',
        name = 'lldb',
      }

      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }

      dap.configurations.c = dap.configurations.cpp

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  }
