return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    {
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
        terminal = {},
      },
    },
  },
  config = function()
    vim.g.opencode_opts = {
      provider = {
        enabled = "snacks",
      },
    }

    vim.o.autoread = true

    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode" })
    vim.keymap.set({ "n", "x" }, "<leader>os", function()
      require("opencode").select()
    end, { desc = "Select opencode actions" })
    vim.keymap.set("n", "<leader>ot", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "<leader>ox", function()
      require("opencode").prompt("explain")
    end, { desc = "Explain code" })
    vim.keymap.set({ "n", "x" }, "<leader>od", function()
      require("opencode").prompt("document")
    end, { desc = "Document code" })
    vim.keymap.set({ "n", "x" }, "<leader>of", function()
      require("opencode").prompt("fix")
    end, { desc = "Fix diagnostics" })
    vim.keymap.set({ "n", "x" }, "<leader>oi", function()
      require("opencode").prompt("implement")
    end, { desc = "Implement code" })
    vim.keymap.set({ "n", "x" }, "<leader>op", function()
      require("opencode").prompt("optimize")
    end, { desc = "Optimize code" })
    vim.keymap.set({ "n", "x" }, "<leader>or", function()
      require("opencode").prompt("review")
    end, { desc = "Review code" })
    vim.keymap.set({ "n", "x" }, "<leader>on", function()
      require("opencode").prompt("test")
    end, { desc = "Add tests" })
    vim.keymap.set("n", "<leader>og", function()
      require("opencode").prompt("diff")
    end, { desc = "Review git diff" })

    vim.keymap.set({ "n", "x" }, "<C-a>", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode..." })
    vim.keymap.set({ "n", "x" }, "<C-x>", function()
      require("opencode").select()
    end, { desc = "Execute opencode action..." })
    vim.keymap.set({ "n", "t" }, "<C-.>", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "go", function()
      return require("opencode").operator("@this ")
    end, { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n", "goo", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "Scroll opencode down" })

    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
  end,
}