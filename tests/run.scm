
(import chicken scheme extras)

(use
 srfi-13
 test
 magickwand)

(magickwand-genesis) ;; why?

(test "magickwand? boolean"
      #t
      (let ((w (new-magickwand)))
        (magickwand? w)))

(test "magick-get-copyright"
      #t
      (let ((s (magick-get-copyright)))
        (and (string-contains s "Copyright")
             (string-contains s "ImageMagick Studio LLC")
             #t)))

(magickwand-terminus) ;; why?
