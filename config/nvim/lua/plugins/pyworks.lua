return {
  {
    "jeryldev/pyworks.nvim",
    dependencies = {
      {
        "GCBallesteros/jupytext.nvim",
        config = true,
      },
      {
        "benlubas/molten-nvim",
        build = ":UpdateRemotePlugins",
      },
      "3rd/image.nvim",
    },
    config = function()
      require("pyworks").setup({
        python = {
          use_uv = true,
        },
        image_backend = "kitty",
      })
    end,
    lazy = false,
    priority = 100,
  },
}