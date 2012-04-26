
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

(test "rose: characteristics"
      '("ROSE" "PPM" 46 70 TrueColorType)
      (let ((w (new-magickwand)))
        (magick-read-image w "rose:")
        (list (magick-get-image-filename w)
              (magick-get-image-format w)
              (magick-get-image-height w)
              (magick-get-image-width w)
              (magick-get-image-type w))))

(magickwand-terminus) ;; why?
