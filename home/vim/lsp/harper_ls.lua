return {
  filetypes = { "markdown", "text" },
  settings = {
    ["harper-ls"] = {
      linters = {
        SpellCheck = true,
        LongSentences = true,
        RepeatedWords = true,
        UnclosedQuotes = true,
        WrongApostrophe = true,
      },
      markdown = { IgnoreLinkTitle = true },
    },
  },
}
