local Job = require("plenary.job") -- plenary.nvimが必要
local M = {}

-- サーバーのプロセスを保持
M.server_job = nil
M.wsl = false

-- サーバーを起動
function M.start_server(port)
    if M.server_job ~= nil then
        print("サーバーはすでに起動しています。")
        return
    end

    port = port or 8000 -- デフォルトのポート番号

    -- Python 3 の存在をチェック
    if vim.fn.executable("python3") == 0 then
        print("エラー: Python 3 がシステムにインストールされていません。")
        print("Python 3 をインストールしてください。詳細は https://www.python.org/ を参照してください。")
        return
    end

    M.server_job = Job:new({
        command = "python3",
        args = { "-m", "http.server", tostring(port) },
        cwd = vim.fn.getcwd(), -- 現在のディレクトリ
        on_start = function()
            print("サーバーがポート " .. port .. " で起動しました。")
        end,
        on_exit = function(_, return_val)
            if return_val == 0 then
                print("サーバーが正常に終了しました。")
            else
                print("サーバーの終了時にエラーが発生しました。")
            end
            M.server_job = nil
        end,
    })

    M.server_job:start()
end

-- サーバーを停止
function M.stop_server()
    if M.server_job == nil then
        print("サーバーは起動していません。")
        return
    end

    local pid = M.server_job.pid
    if pid then
        -- プロセス終了を試みる
        local success = vim.fn.system({ "kill", "-9", tostring(pid) })
        if success == 0 then
            print("サーバー (PID: " .. pid .. ") を停止しました。")
        else
            print("サーバー停止時にエラーが発生しました。")
        end
    else
        print("エラー: プロセスIDが見つかりませんでした。")
    end

    -- クリーンアップ
    M.server_job = nil
end

function M.setup(opts)
  M.wsl = opts["wsl"]
  return true
end

-- Neovim終了時にサーバーを停止する
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        if M.server_job ~= nil then
            vim.schedule(function()
                print("Neovimの終了中: サーバーを停止します...")
            end)
            M.stop_server()
        end
    end,
})

-- Neovimのコマンドを登録
vim.api.nvim_create_user_command("Serve", function(args)
    M.start_server(tonumber(args.args))
    if M.wsl then
      vim.fn.system("wslview http://localhost:" .. (args.args or "8000"))
    end
end, { nargs = "?" })

vim.api.nvim_create_user_command("ServeStop", function()
    M.stop_server()
end, {})

return M

