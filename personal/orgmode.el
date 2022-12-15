;;增加行间距
;;(add-hook 'org-mode-hook
  ;;        (lambda()
;;        (setq-local line-spacing 0.45))
(add-hook 'org-mode-hook
          (lambda ()
            (kill-local-variable 'line-spacing) ;; 如果之前设置的 local 变量没有
            ;; 删除，可能会导致后面的设置无效。
            (setq-local default-text-properties
                        '(line-spacing 0.25     ;; 必须两项组合，
                                       line-height 1.45      ;; 才能起到效果。
                                       ))))
;;设置全局快捷键调用capture
(define-key global-map "\C-cc" 'org-capture)
;;设置默认目录
(setq org-directory "~/Org-Notes/")
;;
;;设置全局缩进模式
(setq org-startup-indented t)
;;
;;--美化orgmode--
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;;
;;(prelude-require-package 'org-bullets
  ;;           :custom
    ;;         (org-bullets-bullet-list '("◉" "☯" "○" "☯" "✸" "☯" "✿" "☯" "✜" "☯" "◆" "☯" "▶"))
      ;;       (org-ellipsis "⤵")
        ;;     :hook (org-mode . org-bullets-mode))
;;
(add-hook 'org-mode-hook
          (lambda ()
            (variable-pitch-mode 1)
            visual-line-mode))
;;
(setq org-hide-emphasis-markers t
      org-fontify-done-headline t
      org-odd-levels-only t
      ;;org-hide-leading-stars t
      org-pretty-entities t)

;;--END--
;;--设置TODO--
;;(t)代表快捷字母；!代表时间戳；@代表一个有时间戳的记录笔记
(setq org-todo-keywords
      '((sequence "TODO(t)" "IN-PROGRESS(i)" "WAITING(w)" "CANCELED(c@/!)" "|" "DONE(d@/!)" "DELEGATED(e!)")))
;;
;;任务完成时，记录时间及log
(setq org-log-done 'note)
;;
;;设置优先级
;;;;C-c , 设置优先级；A, B, C，SPC删除优先级；S-Up/Down，升级或降级
;;--END--
;;设置默认的标签列表，在org文件中可以快速选择常用标签
(setq org-tag-alist '(("@office" . ?o) ("@home" . ?h) ("@trip" . ?t)))
;;
;;--设置日程文件--
;;;;C-c C-s schedule
;;;;C-c C-d deadline
;;;;C-c [ 直接将当前文件加入到列表中
;;;;. 跳到今天
;;;;r 刷新视图
;;;;tab 在其他窗口打开对应条目; return 在当前窗口打开对应条目
;;;;A 互动式切换视图
;;;;v d 切换日视图
;;;;v w 切换周视图
;;;;v m 切换月视图
;;;;j 跳转到指定日期
;;;;t 切换todo状态
;;;;: 设置tags
;;;;, 设置优先级
;;;;i 插入日记内容
;;;;q 退出视图
;;;;x 退出视图（完全）
;;;;C-x C-w 将视图导出为一个文件
;;;;C-c C-x C-c 在视图中开启column模式
;;--END--
;;(setq org-agenda-files
  ;;    (quote ("~/Dropbox/Org-Notes/everyday.org" "~/Dropbox/Org-Notes/work/meeting.org" "~/Dropbox/Org-Notes/work/task.org" "~/Dropbox/Org-Notes/work/project.org" "~/Dropbox/Org-Notes/personal/habit.org" "~/Dropbox/Org-Notes/work/worklog.org")))
(setq org-agenda-files
      (quote ("~/Org-Notes/" "~/Org-Notes/work/" "~/Org-Notes/personal/")))

;;(setq org-agenda-span 'week)
(setq org-agenda-span 'day)
;;
;;更改Agenda时间间隔为3小时一单元
;;---------------------------------------------
;;org-agenda-time-grid
;;--------------------------------------------
(setq org-agenda-time-grid (quote ((daily today require-timed)
                                   (300
                                    600
                                    900
                                    1200
                                    1500
                                    1800
                                    2100
                                    2400)
                                   "......"
                                   "-----------------------------------------------------"
                                   )))
;;设置日记
(setq org-agenda-include-diary t)
(setq org-agenda-diary-file "~/Org-Notes/personal/mydiary") ;;2020-03-02 10:47:06
(setq diary-file "~/Org-Notes/personal/mydiary")
;;--END--
;;--设置capture模板--
;;(setq org-default-notes-file (concat org-directory "capture.org"))
;;(setq org-capture-templates
  ;;    '(("t" "TASK" entry (file+headline "work/task.org" "Tasks")
    ;;     "* TODO %?\n  %U\n From: %a\n" :clock-in t :clock-resume t)
      ;;  ("n" "NOTE" entry (file "note.org")
        ;; "* %? :NOTE:\n%U\n From: %a\n")
        ;;("w" "WORKLOG" entry (file+datetree "work/worklog.org")
;;         "* %?\n logged on %U\n %a\n")
       ;; ("l" "LIFELOG" entry (file+datetree "personal/lifelog.org")
  ;;       "* %?\n logged on %U\n %a\n")
;;        ("m" "MEETING" entry (file+headline "work/meeting.org" "Meetings")
  ;;       "* TODO %?\n logged on %U\n%a\n")))
;;--END--
;;--Drawer and Block--
;;;;C-c C-x d 插入drawer
;;;;C-c C-z Add a time-stamped note to the ‘LOGBOOK’ drawer
;;;;Block #+BEGIN’ . . . ‘#+END
;;--END--
;;设置habit
(add-to-list 'org-modules 'org-habit t)
(setq org-habit-graph-column t)
;;--项目相关--
;;;;使用[/]或[%]，统计项目相关联的任务完成情况
;;--END--
;; Org中插入图片
;;(setq org-download-method 'directory)
(require 'org-download)
(setq org-download-method 'directory
      org-download-image-dir (concat "img/"  (format-time-string "%Y") "/")
      org-download-image-org-width 600
      org-download-heading-lvl 1)
;;时间
;;C-c . 插入时间
;;C-c ! 插入不活跃的时间
;;
;;everyday模板;capture模板
(defun my-org-goto-last-worklog-headline ()
  "Move point to the last headline in file matching \"* WORKLOG\"."
  (end-of-buffer)
  (re-search-backward "\\* WORKLOG"))

(defun my-org-goto-last-event-headline ()
  "Move point to the last headline in file matching \"* EVENTS\"."
  (end-of-buffer)
  (re-search-backward "\\* EVENTS"))

(defun my-org-goto-last-lifelog-headline ()
  "Move point to the last headline in file matching \"* LIFELOG\"."
  (end-of-buffer)
  (re-search-backward "\\* LIFELOG"))


(setq org-capture-templates
      '(("t" "TASK" entry (file+headline "work/task.org" "Tasks")
         "* TODO %i%? [/] :@work: \n %U\n From: %a\n")
        ("n" "NOTE" entry (file "note.org")
         "* %i%? :NOTE: \n created on %T\n From: %a\n")
        ("m" "MEETING" entry (file+headline "work/meeting.org" "Meetings")
         "* TODO %i%? :MEETING:@work: \n created on %U\n")
        ("w" "WORKLOG" entry
         (file+function "everyday.org"
                        my-org-goto-last-worklog-headline)
         "* %i%? :@work: \n%T")
        ("l" "LIFELOG" entry
         (file+function "everyday.org"
                        my-org-goto-last-lifelog-headline)
         "* %i%? :@life: \n%T")
        ("e" "EVENT" entry
         (file+function "everyday.org"
                        my-org-goto-last-event-headline)
         "* %i%? \n%T")))

(defun newday ()
  (interactive)
  (progn
    (find-file "~/Org-Notes/everyday.org")
    (goto-char (point-max))
    (insert "*" ?\s (format-time-string "%Y-%m-%d %A") ?\n
            "** PLAN\n"
            "** WORKLOG\n"
            "** LIFELOG\n"
            "** EVENTS\n"
            "** REVIEW\n"
            "*** 今天最大的成果什么？ \n"
            "*** 今天有什么惊喜？ \n"
            "*** 今天有什么需要改进的地方？ \n"
            )))
