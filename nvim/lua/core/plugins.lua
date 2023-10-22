-- If you want to automatically install and set up packer.nvim on any machine you clone your configuration to, 
-- add the following snippet (which is due to @Iron-E and @khuedoan) somewhere in your config before your first 
-- usage of packer:

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here
	use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.3',
	-- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use( 'folke/zen-mode.nvim' )
    use( 'SidOfc/mkdx')
	use({ 'jacoborus/tender.vim' }) -- color scheme
    use 'navarasu/onedark.nvim'
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
	use('tpope/vim-commentary') -- key binding for commenting out lines
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

