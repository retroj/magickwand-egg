#! /bin/sh
#| -*- scheme -*-
exec csi -s $0 "$@"
|#

(import chicken scheme)

(use magickwand)

(define an-svg (string->blob #<<END
<?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" 
  "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg width="12cm" height="4cm" viewBox="0 0 1200 400"
     xmlns="http://www.w3.org/2000/svg" version="1.1">
  <desc>Example polygon01 - star and hexagon</desc>

  <!-- Show outline of canvas using 'rect' element -->
  <rect x="1" y="1" width="1198" height="398"
        fill="none" stroke="blue" stroke-width="2" />

  <polygon fill="red" stroke="blue" stroke-width="10" 
            points="350,75  379,161 469,161 397,215
                    423,301 350,250 277,301 303,215
                    231,161 321,161" />
  <polygon fill="lime" stroke="blue" stroke-width="10" 
            points="850,75  958,137.5 958,262.5
                    850,325 742,262.6 742,137.5" />
</svg>
END
))

(magick-write-image (make-magickwand an-svg) "x:")