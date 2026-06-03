return {
  -- dir = '~/NeovimProjects/wharfie.nvim',
  url = 'https://codeberg.org/Swindlers-Inc/wharfie.nvim.git',
  event = 'VeryLazy',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('telescope').load_extension 'wharfie'
    require('wharfie').setup {}
  end,

  keys = {
    {
      '<Leader>wdi',
      ':Telescope wharfie docker_images<CR>',
      desc = '[W]harfie [D]ocker [I]mages',
    },
  },
}
