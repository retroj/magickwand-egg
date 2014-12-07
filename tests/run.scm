
(import chicken scheme)

(use (srfi 13)
     extras
     test
     magickwand)

(test "magickwand? boolean"
      #t
      (let ((w (make-magickwand)))
        (magickwand? w)))

(test "magick-get-copyright"
      #t
      (let ((s (magick-get-copyright)))
        (and (string-contains s "Copyright")
             (string-contains s "ImageMagick Studio LLC")
             #t)))

(test "rose: characteristics"
      '("ROSE" "PPM" 46 70 type/truecolor)
      (let ((w (make-magickwand)))
        (magick-read-image w "rose:")
        (list (magickwand-image-filename w)
              (magickwand-image-format w)
              (magick-get-image-height w)
              (magick-get-image-width w)
              (magickwand-image-type w))))
