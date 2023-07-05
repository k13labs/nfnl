(local autoload (require :nfnl.autoload))
(local fennel (autoload :nfnl.fennel))
(local core (autoload :nfnl.core))
(local fs (autoload :nfnl.fs))
(local nvim (autoload :nfnl.nvim))

(fn buf-write-post-callback [ev]
  (let [(ok res) (pcall
                   fennel.compileString
                   (nvim.get-buf-content-as-string (. ev :buf))
                   {:filename (. ev :file)})]
    (if ok
      (core.spit (fs.replace-extension (. ev :file) "lua") res)
      (error res))))

(local default-config
  {:compile_on_write true})

(fn cfg-fn [t]
  (fn [path]
    (core.get-in
      t path
      (core.get-in default-config path))))

(fn setup [config]
  (let [cfg (cfg-fn config)]
    (when (cfg [:compile_on_write])
      (let [agid (vim.api.nvim_create_augroup "nfnl" {})]
        (vim.api.nvim_create_autocmd
          ["BufWritePost"]
          {:group agid
           :pattern ["*.fnl"]
           :callback buf-write-post-callback})))))

(comment
  (setup))

{: setup
 : default-config}
