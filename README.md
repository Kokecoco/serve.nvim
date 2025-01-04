# serve.nvim

|English|[日本語](https://www.github.com/Kokecoco/serve.nvim/README-jp.md)

`serve.nvim` is a Neovim plugin that allows you to start and stop a simple HTTP server directly from Neovim. By default, it uses Python's built-in HTTP server.

## Features

- Start and stop an HTTP server easily from Neovim
- Automatically stop the server process when exiting Neovim
- Uses port `8000` by default (configurable)

---

## Requirements

- Neovim 0.5+
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- Python 3 (for HTTP server functionality)

---

## Installation

### Example (packer.nvim)

```lua
use {
    'yourusername/serve.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
}
```

---

## Usage

### Starting the server

`:Serve [port]`

- Starts the HTTP server.
- If no `port` is provided, the default port `8000` is used.

Examples:

```vim
:Serve
:Serve 8080
```

### Stopping the server

`:ServeStop`

- Stops the running HTTP server.

Examples:

```vim
:ServeStop
```

### Automatic stopping on Neovim exit

- The server process will be automatically stopped when Neovim exits (e.g., via `:q` or `:qa`).

---

## Errors and Troubleshooting

### Error: `Address already in use`

This error occurs if the specified port is already in use. You can resolve the issue by following these steps:

1. Check if the server process is properly stopped:

   ```bash
   lsof -i :<port>
   ```

2. Terminate the process if necessary:
   ```bash
   kill -9 <PID>
   ```

---

## Contributing

For bug reports or feature requests, please visit the [GitHub Issues page](https://github.com/yourusername/serve.nvim/issues).

---

## License

This plugin is licensed under the [MIT License](LICENSE).
