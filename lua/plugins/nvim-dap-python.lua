return {
  'mfussenegger/nvim-dap-python',
  config = function()
    require('dap-python').setup '/Users/rhysgray/.virtualenvs/debugpy/bin/python'
  end,
}
