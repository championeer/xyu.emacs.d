;;(require 'keycast)
;;(keycast-mode t)
;;(prelude-require-package 'keycast)
;;设置默认换行
(global-visual-line-mode 1)
;;设置ivy-rich，可以显示命令的解释
(require 'ivy-rich)
(ivy-rich-mode 1)
(setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
;;
;;Org-pomodoro
;;自动保存
(setq auto-save-visited-mode t)
(auto-save-visited-mode +1)
;;设置Emacs启动窗口大小，来自：http://kimi.im/2019-02-09-emacs-frame-dimention
(if (not (eq window-system nil))
    (progn
      ;; top, left ... must be integer
      (add-to-list 'default-frame-alist
                   (cons 'top  (/ (x-display-pixel-height) 10)))
      (add-to-list 'default-frame-alist
                   (cons 'left (/ (x-display-pixel-width) 10)))
      (add-to-list 'default-frame-alist
                   (cons 'height (/ (* 4 (x-display-pixel-height))
                                    (* 5 (frame-char-height)))))
      (add-to-list 'default-frame-alist
                   (cons 'width (/ (* 4 (x-display-pixel-width))
                                   (* 5 (frame-char-width)))))))
;;设置日历中的日出日落时间
;; location
(setq calendar-longitude 116.9962)
(setq calendar-latitude 39.91)
;;Sunrise and Sunset
;;日出而作, 日落而息
(defun diary-sunrise ()
  (let ((dss (diary-sunrise-sunset)))
    (with-temp-buffer
      (insert dss)
      (goto-char (point-min))
      (while (re-search-forward " ([^)]*)" nil t)
        (replace-match "" nil nil))
      (goto-char (point-min))
      (search-forward ",")
      (buffer-substring (point-min) (match-beginning 0)))))

(defun diary-sunset ()
  (let ((dss (diary-sunrise-sunset))
        start end)
    (with-temp-buffer
      (insert dss)
      (goto-char (point-min))
      (while (re-search-forward " ([^)]*)" nil t)
        (replace-match "" nil nil))
      (goto-char (point-min))
      (search-forward ", ")
      (setq start (match-end 0))
      (search-forward " at")
      (setq end (match-beginning 0))
      (goto-char start)
      (capitalize-word 1)
      (buffer-substring start end))))
;;绑定M-n和M-p，为半屏翻页
(defun previous-multilines ()
  "scroll down multiple lines"
  (interactive)
  (scroll-down (/ (window-body-height) 3)))


(defun next-multilines ()
  "scroll up multiple lines"
  (interactive)
  (scroll-up (/ (window-body-height) 3)))

(global-set-key "\M-n" 'next-multilines) ;;custom
(global-set-key "\M-p" 'previous-multilines) ;;custom
