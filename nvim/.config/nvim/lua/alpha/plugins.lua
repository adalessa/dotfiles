if require("alpha.packer_install")() then
	return
end

vim.cmd.packadd("packer.nvim")
vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

-- packer in MacOS  keeps being stuck at :PackerSync if jobs are not limited.
-- uncomment for OSX
--local packer = require('packer')
--packer.init {
--    max_jobs = 5,
--}

return require("packer").startup(function(use)
	local local_use = function(first, second, opts)
		opts = opts or {}

		local plug_path, home
		if second == nil then
			plug_path = first
			home = "adalessa"
		else
			plug_path = second
			home = first
		end

		if vim.fn.isdirectory(vim.fn.expand("~/code/plugins/" .. plug_path)) == 1 then
			opts[1] = "~/code/plugins/" .. plug_path
		else
			opts[1] = string.format("%s/%s", home, plug_path)
		end

		use(opts)
	end

	use("wbthomason/packer.nvim")
	use("lewis6991/impatient.nvim")

	use("jwalton512/vim-blade")

	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-refactor",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	})

	-- optional
	use({ "junegunn/fzf.vim" })
	use({
		"junegunn/fzf",
		run = function()
			vim.fn["fzf#install"]()
		end,
	})

	use({
		"ThePrimeagen/harpoon",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
		},
		keys = require('alpha.harpoon').keymaps,
		config = function ()
			require('alpha.harpoon').setup()
		end
	})

	use({
		"windwp/nvim-projectconfig",
		config = function()
			require("nvim-projectconfig").setup()
		end,
	})

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-git",
			"rcarriga/cmp-dap",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			{ "L3MON4D3/LuaSnip", tag = "v1.*" },
			"windwp/nvim-autopairs",
		},
	})

	-- Installation of LSP/Debuggers/Other
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	})

	-- Null ls
	use({
		"jose-elias-alvarez/null-ls.nvim",
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-telescope/telescope-fzy-native.nvim" },
			{ "kyazdani42/nvim-web-devicons" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-telescope/telescope-dap.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
	})

	use({
		"ThePrimeagen/git-worktree.nvim",
		config = function()
			require("git-worktree").setup({})
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use({
		"mfussenegger/nvim-dap",
		requires = {
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"mxsdev/nvim-dap-vscode-js",
		},
	})

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function ()
			require('trouble').setup({mode = "document_diagnostics"})
			vim.keymap.set('n', '<leader>oo', ':TroubleToggle<cr>')
		end,
		cmd = {"Trouble", "TroubleToggle"},
		keys = "<leader>oo",
	})

	use("vim-test/vim-test")
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
			"rouge8/neotest-rust",
			"nvim-neotest/neotest-plenary",
			"nvim-neotest/neotest-vim-test",
			-- "olimorris/neotest-phpunit",
		},
	})

	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	})

	-- Themes
	use("EdenEast/nightfox.nvim")
	use("folke/tokyonight.nvim")
	use("wuelnerdotexe/vim-enfocado")

	-- use("voldikss/vim-floaterm")

	-- Style
	use("stevearc/dressing.nvim")
	use({
		"rcarriga/nvim-notify",
		config = function ()
			require('notify').setup({background_colour = "#000000"})
		end
	})
	use("xiyaowong/nvim-transparent")

	use("Raimondi/delimitMate")
	use("lukas-reineke/indent-blankline.nvim")

	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("tpope/vim-dotenv")
	use("tpope/vim-eunuch")

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use("tpope/vim-sleuth")

	use("junegunn/vim-easy-align")


	use("jghauser/mkdir.nvim")

	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- Database client
	use({
		"kristijanhusak/vim-dadbod-ui",
		requires = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
			"tpope/vim-dotenv",
		},
		cmd = "DBUI",
		keys = "<leader><leader>db",
		config = function ()
			require('alpha.database')
		end
	})

	-- Rest client
	use({
		"NTBBloodbath/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		ft = "http",
		config = function()
			require("alpha.rest")
		end,
	})

	use({
		"anuvyklack/hydra.nvim",
		requires = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
	})

	use({
		"phaazon/mind.nvim",
		branch = "v2.2",
		requires = { "nvim-lua/plenary.nvim" },
		cmd = { "MindOpenMain", "MindOpenProject" },
		config = function ()
			local dirs = {}
			if vim.fn.isdirectory("/mnt/nas/alpha/mind/data") == 1 then
				dirs = {
					state_path = "/mnt/nas/alpha/mind/mind.json",
					data_dir = "/mnt/nas/alpha/mind/data",
				}
			end
			require('mind').setup({ persistence = dirs})
		end
	})

	use {
		"danymat/neogen",
		config = function()
			require('neogen').setup({ snippet_engine = "luasnip" })
		end,
		cmd = "Neogen",
		requires = "nvim-treesitter/nvim-treesitter",
	}

	-- Local plugins can be included
	local_use("telescope-projectionist.nvim")
	local_use("php-code-actions.nvim")
	local_use("laravel.nvim", nil, {
		config = function ()
			require('alpha.laravel')
		end,
	})
	local_use("composer.nvim")
	local_use("neotest-phpunit")
end)
