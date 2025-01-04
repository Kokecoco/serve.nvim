# serve.nvim

| [English](https://github.com/Kokecoco/serve.nvim/blob/main/README.md) | 日本語 |

`serve.nvim` は、Neovim からシンプルな HTTP サーバーを起動および停止できるプラグインです。デフォルトでは、Python の組み込み HTTP サーバーを使用します。

## 特徴

- Neovim 内から HTTP サーバーを簡単に起動・停止
- サーバープロセスを Neovim 終了時に自動で停止
- デフォルトでポート番号 `8000` を使用（カスタマイズ可能）

---

## 必要条件

- Neovim 0.5 以上
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- Python 3 (Python の HTTP サーバー機能を使用)

---

## インストール

### 使用例 (packer.nvim)

```lua
use {
    'Kokecoco/serve.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require("serve")
    end
}
```

### Lazy.nvim

```lua
return {
  "Kokecoco/serve.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
      require("serve")
  end
}
```

---

## 使用方法

### サーバーの起動

`:Serve [port]`

- HTTP サーバーを起動します。
- 引数 `port` を指定しない場合、デフォルトのポート `8000` が使用されます。

例:

```vim
:Serve
:Serve 8080
```

### サーバーの停止

`:ServeStop`

- 実行中の HTTP サーバーを停止します。

例:

```vim
:ServeStop
```

### Neovim 終了時の自動停止

- Neovim の終了時 (`:q` や `:qa`) にサーバープロセスが自動的に停止します。

---

## エラーとトラブルシューティング

### エラー: `Address already in use`

このエラーは、指定したポートが既に使用されている場合に発生します。以下の手順で問題を解決できます。

1. サーバープロセスが正しく停止されているか確認してください。
   ```bash
   lsof -i :<port>
   ```
2. 必要に応じて、該当プロセスを終了します。
   ```bash
   kill -9 <PID>
   ```

---

## 貢献

バグ報告や機能リクエストは [GitHub の Issues ページ](https://github.com/Kokecoco/serve.nvim/issues) までお願いします。

---

## ライセンス

このプラグインは [MIT ライセンス](LICENSE) のもとで公開されています。
