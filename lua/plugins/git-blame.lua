return {
  'f-person/git-blame.nvim',
  version = '*',
  config = function()
    require('gitblame').setup {
      message_template = '  <date> | <author> | <summary>',
      date_format = '%r',
      delay = 500,
    }
  end,
}
