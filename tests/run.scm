
(import chicken scheme extras)

(use test
     magickwand)

(magickwand-genesis) ;; why?

(test "magickwand? boolean"
      #t
      (let ((w (new-magickwand)))
        (magickwand? w)))

(magickwand-terminus) ;; why?
