(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local vim _G.vim)

;; This tells the compiler that vim is a global

(fn dashboard-sections []
  (let [snacks (require :snacks)
        in-git? (not= nil (snacks.git.get_root))
        ;; Define the dynamic GitHub/Git sections for the right pane
        cmds [{:title :PRs
               :cmd "gh pr list --state all --json title,number,updatedAt,state,author -L 15 | jq -r 'sort_by(.state, .updatedAt) | reverse | .[0:5] | .[] | (if .state == \"OPEN\" then \" \" else \" \" end) + \" #\" + (.number|tostring) + \" \" + .title + \" @\" + (.author.login[0:5]) + \" (\" + (.updatedAt[0:10]) + \")\"'"
               :action (fn []
                         (let [snacks (require :snacks)]
                           (snacks.picker.git_prs)))
               :key :n
               :icon " "
               :height 10}
              {:title "Git Status"
               :cmd "git --no-pager diff --stat -B -M -C"
               :height 10}]]
    [;; --- PANE 1 (Left) ---
     {:section :keys :gap 1 :padding 1}
     {:section :startup}
     ;; --- PANE 2 (Right) ---
     {:pane 2
      :section :terminal
      :title "Git Context"
      :enabled in-git?
      :cmd "git branch --show-current | awk '{print \"  BRANCH: \" $0}' && git rev-list --count HEAD @{u}..HEAD 2>/dev/null | awk '{print \"  AHEAD:  \" $0 \" commits\"}'"
      :height 4
      :padding 1}
     (core.map (fn [cmd]
                 (core.merge {:pane 2
                              :section :terminal
                              :enabled in-git?
                              :padding 1
                              :ttl (* 5 60)
                              ; Refresh every 5 mins
                              :indent 3
                              :random 0} cmd)) cmds)]))

{1 :folke/snacks.nvim
 :priority 1000
 :lazy false
 :opts {:dashboard {:sections #(dashboard-sections)}
        :image {:enabled true
                ;; Keep previews "small" by limiting their window footprint
                :max_width_window_percentage 60
                :max_height_window_percentage 20}
        :picker {:enabled true
                 :projects {:dirs ["~/dev/ade" "~/dev/nu"]}
                 :previewers {:image {:enabled true :native_2d true}}}
        :bigfile {:enabled true}
        :indent {:enabled true}
        :input {:enabled false}
        :notifier {:enabled false}
        :words {:enabled false}}
 ;; Disable this so Noice/Notify can handle msgs}
 :keys [{1 :<leader>ff
         2 (fn []
             (let [snacks (require :snacks)]
               (snacks.picker.files)))
         :desc "Find Files"}
        {1 :<leader>fp
         2 (fn []
             (let [snacks (require :snacks)]
               (snacks.picker.projects)))
         :desc :Projects}
        {1 "<leader>;"
         2 (fn []
             (let [snacks (require :snacks)] (snacks.dashboard.open)))
         :desc "Open Dashboard"}]}
