return {
  filetypes = { "markdown", "text" },
  settings = {
    ["harper-ls"] = {
      linters = {
        SpellCheck             = false,
        LongSentences          = true,
        RepeatedWords          = true,
        SentenceCapitalization = false,
        UnclosedQuotes         = true,
        WrongApostrophe        = true,
      },
      markdown = { IgnoreLinkTitle = true },
    },
  },
}
