(local autoload (require :nfnl.autoload))
(local core (autoload :nfnl.core))
(local fs (autoload :nfnl.fs))
(local str (autoload :nfnl.string))
(local fennel (autoload :nfnl.fennel))
(local notify (autoload :nfnl.notify))

(local config-file-name ".nfnl.fnl")

(local default-config
  {:compiler-options {}
   :fennel-path (str.join
                  ";"
                  ["./?.fnl"
                   "./?/init.fnl"
                   "./fnl/?.fnl"
                   "./fnl/?/init.fnl"])
   :fennel-macro-path (str.join
                        ";"
                        ["./?.fnl"
                         "./?/init-macros.fnl"
                         "./?/init.fnl"
                         "./fnl/?.fnl"
                         "./fnl/?/init-macros.fnl"
                         "./fnl/?/init.fnl"])
   :source-file-patterns [(fs.join-path ["fnl" "**" "*.fnl"])]})

(fn cfg-fn [t]
  "Builds a cfg fetcher for the config table t. Returns a function that takes a
  path sequential table, it looks up the value from the config with core.get-in
  and falls back to a matching value in default-config if not found."

  (fn [path]
    (core.get-in
      t path
      (core.get-in default-config path))))

(fn find-and-load [dir]
  "Attempt to find and load the .nfnl.fnl config file relative to the given dir.
  Returns an empty table when there's issues or if there isn't a config file.
  If there's some valid config you'll get table containing config, cfg (fn) and
  root-dir back."

  (let [found (fs.findfile config-file-name (.. dir ";"))]
    (when found
      (let [config-file-path (fs.full-path found)
            root-dir (fs.basename config-file-path)
            config-source (vim.secure.read config-file-path)

            (ok config)
            (if
              (core.nil? config-source)
              (values false (.. config-file-path " is not trusted, refusing to compile."))

              (or (str.blank? config-source)
                  (= "{}" (str.trim config-source)))
              (values true {})

              (pcall
                fennel.eval
                config-source
                {:filename config-file-path}))]
        (if ok
          {: config
           : root-dir
           :cfg (cfg-fn config)}
          (do
            (notify.error config)
            {}))))))

{: find-and-load
 : default-config}
