# Installation

Use:
```bash
git clone https://github.com/XPerianer/dotfiles && cd dotfiles && ./install
```

# Powered by
[Dotbot](https://github.com/anishathalye/dotbot)

## Additional Setup

### For [fish-ai](https://github.com/Realiserad/fish-ai):
1. Install the fish-ai plugin:
   ```bash
   fisher install realiserad/fish-ai
   ```

2. Create `config/fish-ai.ini` with:
   ```ini
   [fish-ai]
   configuration = openai

   [openai]
   provider = openai
   model = gpt-4
   api_key = <your API key>
   organization = <your organization>
   ```

### Key Functions

| Shortcut | Description |
|----------|-------------|
| `Ctrl+P` | Convert natural language to shell command |
| `Ctrl+Space` | Auto-complete current command |
| `Ctrl+Space` | Get help with failed commands |

