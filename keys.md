- Lualine
  - cwd / session-name (neotree?)
  - percentage (#lines) [line:col]
  - buffer filename [-+RO]
  - LSP Server running
  - Linter running?
  - DAP status?
  - tabs
  - diagnostics
  - hunks
  - pending-keys
  - treesitter node (neotree?)
  - updates
  - filetype/encoding
  - Model name
- Neotree
- fidget
  - CodeCompanion Searching?
- FZF
- Completion
  - C-j => down completion
  - C-k => up completion
  - C-n => page down completion list
  - C-p => page up completion list
  - C-u => halfpage up documentation
  - C-d => halfpage down documentation
  - C-space => trigger completion
  - C-q => stop completion
  - C-e => accept completion
  - C-w => delete backward word
- All modes
  M-h => left window
  M-j => bottom window
  M-k => top window
  M-l => right window
  M-Tab => rotate window
- Insert

  - C-s => Save Buffer
  - C-q => kill window

  - C-x C-s => add surroundings
  - C-x C-d => del surroundings

  - C-y => (set nopaste) C-r + (set paste)

  - C-u => Undo

  - C-t => neotree symbols
  - C-x C-t => buffers?

  - C-a => beginning of line
  - C-e => end of line

  - C-w => delete backward word
  - C-x C-w => delete backward Word
  - C-d C-w =>

  - C-f => delete forward word
  - C-x C-f => delete forward Word
  - C-b => treesj
  - C-d C-a => delete till beginning of line
  - C-d C-e => delete till end of line
  - C-d C-d => <C-o>d

  - C-x C-a => indent left
  - C-x C-e => indent right

  - C-j => down line
  - C-k => up line

  - C-x C-j => next hunk
  - C-x C-k => prev hunk

  - C-d C-j => prev jump
  - C-d C-k => next jump

  - C-x C-h => 1 char left
  - C-x C-l => 1 char right

  - C-d C-h => del 1 char left
  - C-d C-l => del 1 char right

  - C-/ => flash.nvim jump
  - C-l => flash.nvim delete

  - C-n => scroll down
  - C-p => scroll up

  - C-x C-n => move to next block
  - C-x C-p => move to prev block

  - C-d C-n => next node
  - C-d C-p => prev node

- Normal/Visual
  - Enter => textsubject visual mode
  - s => surround
  - gs
  - H => prev tab
  - L => next tab
  - \q => fzflua quickfix
  - \l => fzflua loclist
  - \j => fzflua jumps
  - \g => fzflua grep
  - \G => fzflua livegrep
  - \f => fzflua files cwd
  - \F => fzflua files
  - \g => git?
  - SPC g => neogit? vgit? diffview? gitsigns?
  - SPC G => octo? gh.nvim? octohub? gist? pipeline.nvim?
  - \d => dap?
  - \p => prompts?
  - \r => overseer?
    - c => check
    - b => build
    - t => test
    - r => run
    - d => deploy
  - \c => CodeCompanion
  - \C => CodeCompanion actions
  - \h => fzflua helptags
  - \H => fzflua highlights
  - \t => fzflua btags
  - \T => fzflua tags
  - \k => fzflua keymaps
  - \b => fzflua buffers
  - \B => fzflua tabs
  - \s => fzflua persisted sessions
  - \m => fzflua keymaps
  - \c => fzflua commands
  - \C => fzflua colorschemes
  - \\ => fzflua
  - SPC b => neotree action=show source=buffers toggle
  - SPC B => neotree action=focus source=buffers toggle
  - SPC f => neotree action=show source=filesystem toggle
  - SPC F => neotree action=focus source=filesystem toggle
  - SPC g => neotree action=show source=git_status toggle
  - SPC G => neotree action=focus source=git_status toggle
  - SPC d => neotree action=show source=document_symbols position=right toggle
  - SPC D => neotree action=focus source=document_symbols position=right toggle
  - SPC SPC => buffers
  - <C-Space> => floating toggleterm
  - C-t => Neotree symbols
  - C-x C-t => Neotree buffers
  - C-a => LSP Document symbols
  - C-e => LSP diagnostics
  - C-x C-a => LSP Workspace symbols
  - C-x C-a => LSP workspace diagnostics
- Command
- Operator
