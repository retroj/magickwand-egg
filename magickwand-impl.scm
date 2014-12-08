;; Copyright 2012,2014 John J Foerch. All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions are
;; met:
;;
;;    1. Redistributions of source code must retain the above copyright
;;       notice, this list of conditions and the following disclaimer.
;;
;;    2. Redistributions in binary form must reproduce the above copyright
;;       notice, this list of conditions and the following disclaimer in
;;       the documentation and/or other materials provided with the
;;       distribution.
;;
;; THIS SOFTWARE IS PROVIDED BY JOHN J FOERCH ''AS IS'' AND ANY EXPRESS OR
;; IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
;; DISCLAIMED. IN NO EVENT SHALL JOHN J FOERCH OR CONTRIBUTORS BE LIABLE
;; FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
;; BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
;; WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
;; OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
;; ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

(define-foreign-type ssize_t long)

(define-foreign-type magicksize unsigned-long)

(define-foreign-type magickrealtype double)


;;;
;;; Main Object Types
;;;

;; magickwand
;;
(define-record-type :magickwand
  (%make-magickwand this)
  magickwand?
  (this magickwand-this))

(define (%magickwand-finalizer w)
  (when (magickwand-instantiated?)
    ((foreign-lambda c-pointer DestroyMagickWand magickwand) w)
    #t))

(define-foreign-type magickwand (c-pointer (struct _MagickWand))
  magickwand-this
  (lambda (p)
    (set-finalizer! p %magickwand-finalizer)
    (%make-magickwand p)))


;; drawingwand
;;
(define-record-type :drawingwand
  (%make-drawingwand this)
  drawingwand?
  (this drawingwand-this))

(define (%drawingwand-finalizer d)
  (when (magickwand-instantiated?)
    ((foreign-lambda c-pointer DestroyDrawingWand drawingwand) d)
    #t))

(define-foreign-type drawingwand (c-pointer (struct _DrawingWand))
  drawingwand-this
  (lambda (p)
    (set-finalizer! p %drawingwand-finalizer)
    (%make-drawingwand p)))


;; pixelwand
;;
(define-record-type :pixelwand
  (%make-pixelwand this)
  pixelwand?
  (this pixelwand-this))

(define (%pixelwand-finalizer p)
  (when (magickwand-instantiated?)
    ((foreign-lambda c-pointer DestroyPixelWand pixelwand) p)
    #t))

(define-foreign-type pixelwand (c-pointer (struct _PixelWand))
  pixelwand-this
  (lambda (p)
    (set-finalizer! p %pixelwand-finalizer)
    (%make-pixelwand p)))


;; pixelwands (array of pixelwands)
;;
;; (To-do)
;;


;; pixeliterator
;;
(define-foreign-type pixeliterator (c-pointer (struct _PixelIterator)))


;;;
;;; Auxiliary Object Types
;;;

;; typedef MagickBooleanType
;;   (*MagickProgressMonitor)(const char *,const MagickOffsetType,
;;     const MagickSizeType,void *);

(define-foreign-record-type (kernelinfo KernelInfo)
  (kernelinfotype type kernelinfo-type)
  (size_t width kernelinfo-width)
  (size_t height kernelinfo-height)
  (ssize_t x kernelinfo-x)
  (ssize_t y kernelinfo-y)
  ((c-pointer double) values kernelinfo-values)
  (double minimum kernelinfo-minimum)
  (double maximum kernelinfo-maximum)
  (double negative_range kernelinfo-negative-range)
  (double positive_range kernelinfo-positive-range)
  (double angle kernelinfo-angle)
  ((c-pointer kernelinfo) next kernelinfo-next)
  (size_t signature kernelinfo-signature))

(define-foreign-record-type (channelfeatures ChannelFeatures)
  (double (angular_second_moment 4) channelfeatures-angular-second-moment)
  (double (contrast 4) channelfeatures-contrast)
  (double (correlation 4) channelfeatures-correlation)
  (double (variance_sum_of_squares 4) channelfeatures-variance-sum-of-squares)
  (double (inverse_difference_moment 4) channelfeatures-inverse-difference-moment)
  (double (sum_average 4) channelfeatures-sum-average)
  (double (sum_variance 4) channelfeatures-sum-variance)
  (double (sum_entropy 4) channelfeatures-sum-entropy)
  (double (entropy 4) channelfeatures-entropy)
  (double (difference_variance 4) channelfeatures-difference-variance)
  (double (difference_entropy 4) channelfeatures-difference-entropy)
  (double (measure_of_correlation_1 4) channelfeatures-measure-of-correlation-1)
  (double (measure_of_correlation_2 4) channelfeatures-measure-of-correlation-2)
  (double (maximum_correlation_coefficient 4) channelfeatures-maximum-correlation-coefficient))

(define-foreign-record-type (channelstatistics ChannelStatistics)
  (size_t depth channelstatistics-depth)
  (double minima channelstatistics-minima)
  (double maxima channelstatistics-maxima)
  (double sum channelstatistics-sum)
  (double sum_squared channelstatistics-sum-squared)
  (double sum_cubed channelstatistics-sum-cubed)
  (double sum_fourth_power channelstatistics-sum-fourth-power)
  (double mean channelstatistics-mean)
  (double variance channelstatistics-variance)
  (double standard_deviation channelstatistics-standard-deviation)
  (double kurtosis channelstatistics-kurtosis)
  (double skewness channelstatistics-skewness))

(define-foreign-record-type (rectangleinfo RectangleInfo)
  (size_t width rectangleinfo-width)
  (size_t height rectangleinfo-height)
  (ssize_t x rectangleinfo-x)
  (ssize_t y rectangleinfo-y))

(define-foreign-record-type (magickpixelpacket MagickPixelPacket)
  (classtype storage_class magickpixelpacket-storage-class)
  (colorspace colorspace magickpixelpacket-colorspace)
  (bool matte magickpixelpacket-matte)
  (double fuzz magickpixelpacket-fuzz)
  (size_t depth magickpixelpacket-depth)
  (magickrealtype red magickpixelpacket-red)
  (magickrealtype green magickpixelpacket-green)
  (magickrealtype blue magickpixelpacket-blue)
  (magickrealtype opacity magickpixelpacket-opacity)
  (magickrealtype index magickpixelpacket-index))

;;XXX: would be nice to have a complete definition here
;; (define-foreign-type pixelpacket (c-pointer (struct _PixelPacket)))

;;XXX: would be nice to have a complete definition here
(define-foreign-type drawinfo (c-pointer (struct _DrawInfo)))

(define-foreign-type imageinfo (c-pointer (struct _ImageInfo)))

(define-foreign-type wandview (c-pointer (struct _WandView)))

(define-foreign-record-type (affinematrix AffineMatrix)
  (double sx affinematrix-sx)
  (double rx affinematrix-rx)
  (double ry affinematrix-ry)
  (double sy affinematrix-sy)
  (double tx affinematrix-tx)
  (double ty affinematrix-ty))

(define-foreign-record-type (pointinfo PointInfo)
  (double x pointinfo-x)
  (double y pointinfo-y))


;;;
;;; Binding Syntax
;;;

(define-syntax define-magick-image-op
  (syntax-rules ()
    ((define-magick-image-op (scheme-name object . rest)
                             (c-name . c-args))
     (define (scheme-name object . rest)
       (or ((foreign-lambda bool c-name . c-args) object . rest)
           (signal (%magick-get-exception object)))))))


;;;
;;; General
;;;

(define magickwand-instantiated?
  (foreign-lambda bool IsMagickWandInstantiated))

(define magickwand-genesis
  (foreign-lambda void MagickWandGenesis))

(define (magickwand-terminus)
  (when (magickwand-instantiated?)
    ((foreign-lambda void MagickWandTerminus))))

(define magick-query-configure-option
  (foreign-lambda c-string MagickQueryConfigureOption (const c-string)))

(define magick-query-configure-options
  (foreign-lambda c-string-list MagickQueryConfigureOptions
                  (const c-string) (c-pointer size_t)))

(define magick-query-fonts
  (foreign-lambda c-string-list MagickQueryFonts
                  (const c-string)
                  (c-pointer size_t)))

(define magick-get-copyright
  (foreign-lambda c-string MagickGetCopyright))

(define magick-get-home-url
  (foreign-lambda c-string MagickGetHomeURL))

(define magick-get-release-date
  (foreign-lambda c-string MagickGetReleaseDate))

(define (magick-get-version)
  (let-location ((ignored size_t))
    ((foreign-lambda c-string MagickGetVersion (c-pointer size_t))
     (location ignored))))

(define (magick-get-version-as-number)
  (let-location ((version size_t))
    ((foreign-lambda c-string MagickGetVersion (c-pointer size_t))
     (location version))
    version))

(define magick-get-package-name
  (foreign-lambda c-string MagickGetPackageName))

(define magick-relinquish-memory
  (foreign-lambda c-pointer MagickRelinquishMemory c-pointer))


;;;
;;; MagickWand methods
;;;

(define magickwand-clear
  (foreign-lambda void ClearMagickWand magickwand))

(define %magick-clear-exception
  (foreign-lambda bool MagickClearException magickwand))

(define (%magick-get-exception wand)
  (let-location ((typeout int))
    (let* ((str ((foreign-lambda c-string MagickGetException
                                 (const magickwand)
                                 (c-pointer "ExceptionType"))
                 wand (location typeout)))
           (str (if (string-null? str) str (string-append ": " str)))
           (type (int->exceptiontype typeout)))
      (make-composite-condition
       (make-property-condition 'exn 'message (sprintf "MagickWand ~A~A" type str))
       (make-property-condition 'magickwand 'type type)
       (make-property-condition type)))))

(define %magick-get-exception-type
  (foreign-lambda exceptiontype MagickGetExceptionType (const magickwand)))

(define make-magickwand
  (match-lambda*
   (((? string? str))
    (let ((w (make-magickwand)))
      (magick-read-image w str)
      w))
   (((? blob? b))
    (let ((w (make-magickwand)))
      (magick-read-image-blob w b)
      w))
   (((? magickwand? w))
    ((foreign-lambda magickwand CloneMagickWand (const magickwand)) w))
   (()
    ((foreign-lambda magickwand NewMagickWand)))))

(define magick-query-font-metrics
  (foreign-lambda (c-pointer double) MagickQueryFontMetrics magickwand
                  (const drawingwand) (const c-string)))

(define magick-query-multiline-font-metrics
  (foreign-lambda (c-pointer double) MagickQueryMultilineFontMetrics
                  magickwand (const drawingwand) (const c-string)))

(define magick-reset-iterator
  (foreign-lambda void MagickResetIterator magickwand))

(define magick-set-first-iterator
  (foreign-lambda void MagickSetFirstIterator magickwand))

(define magick-set-last-iterator
  (foreign-lambda void MagickSetLastIterator magickwand))

;; can return false, but does not raise an exception.
;; maybe we should use a continuable condition?
(define magick-set-iterator-index
  (foreign-lambda bool MagickSetIteratorIndex magickwand (const ssize_t)))

(define magick-get-iterator-index
  (foreign-lambda ssize_t MagickGetIteratorIndex magickwand))


;;;
;;; Magickwand Property Methods
;;;

(define magick-set-image-artifact
  (foreign-lambda bool MagickSetImageArtifact magickwand
                  (const c-string) (const c-string)))

(define magick-get-image-artifact
  (foreign-lambda c-string MagickGetImageArtifact magickwand
                  (const c-string)))

(define magick-get-image-artifacts
  (foreign-lambda c-string MagickGetImageArtifacts magickwand
                  (const c-string) (c-pointer size_t)))

(define magick-delete-image-artifact
  (foreign-lambda bool MagickDeleteImageArtifact magickwand
                  (const c-string)))

;; profiles should probably be a record type
(define (magic-set-image-profile wand name vec)
  (let* ((len (u8vector-length vec))
         (blob ((foreign-lambda* c-pointer ((u8vector fro) (size_t len))
                  "unsigned char *to = malloc(len);"
                  "size_t i;"
                  "for (i = 0; i < len; ++i) {"
                  "    to[i] = fro[i];"
                  "}"
                  "C_return(to);")
                vec len)))
    ((foreign-lambda bool MagickSetImageProfile magickwand
                     (const c-string) (const c-pointer) (const size_t))
     wand name blob len)))

(define (magick-get-image-profile wand name)
  (let-location ((len size_t))
    (let* ((p ((foreign-lambda unsigned-c-string MagickGetImageProfile
                               magickwand (const c-string) (c-pointer size_t))
               wand name (location len)))
           (result (make-u8vector len)))
      ((foreign-lambda* void ((unsigned-c-string fro) (u8vector to) (size_t len))
         "size_t i;"
         "for (i = 0; i < len; ++i) {"
         "    to[i] = fro[i];"
         "}")
       p result len)
      result)))

(define magick-get-image-profiles
  (foreign-lambda c-string MagickGetImageProfiles magickwand
                  (const c-string) (c-pointer size_t)))

(define magick-set-image-property
  (foreign-lambda bool MagickSetImageProperty magickwand
                  (const c-string) (const c-string)))

(define magick-get-image-property
  (foreign-lambda c-string MagickGetImageProperty magickwand
                  (const c-string)))

(define magick-get-image-properties
  (foreign-lambda c-string MagickGetImageProperties magickwand
                  (const c-string) (c-pointer size_t)))

(define magick-delete-image-property
  (foreign-lambda bool MagickDeleteImageProperty magickwand
                  (const c-string)))

(define magick-set-option
  (foreign-lambda bool MagickSetOption magickwand
                  (const c-string) (const c-string)))

(define magick-get-option
  (foreign-lambda c-string MagickGetOption magickwand
                  (const c-string)))

(define magick-get-options
  (foreign-lambda c-string MagickGetOptions magickwand
                  (const c-string) (c-pointer size_t)))

(define magick-delete-option
  (foreign-lambda bool MagickDeleteOption magickwand
                  (const c-string)))

(define magick-get-quantum-depth
  (foreign-lambda c-string MagickGetQuantumDepth (c-pointer size_t)))

(define magick-get-quantum-range
  (foreign-lambda c-string MagickGetQuantumRange (c-pointer size_t)))

(define magick-get-resource
  (foreign-lambda magicksize MagickGetResource (const resourcetype)))

(define magick-set-resource-limit
  (foreign-lambda bool MagickSetResourceLimit
                  (const resourcetype) (const magicksize)))

(define magick-get-resource-limit
  (foreign-lambda magicksize MagickGetResourceLimit (const resourcetype)))

(define magick-profile-image
  (foreign-lambda bool MagickProfileImage magickwand
                  (const c-string) (const c-pointer) (const size_t)))

(define magick-remove-image-profile
  (foreign-lambda unsigned-c-string MagickRemoveImageProfile magickwand
                  (const c-string) (c-pointer size_t)))

(define magick-set-depth
  (foreign-lambda bool MagickSetDepth magickwand (const size_t)))

(define magick-set-extract
  (foreign-lambda bool MagickSetExtract magickwand (const c-string)))

(define magick-set-passphrase
  (foreign-lambda bool MagickSetPassphrase magickwand (const c-string)))

;;(define magick-set-progress-monitor
;;  (foreign-lambda magickprogressmonitor MagickSetProgressMonitor
;;                  magickwand (const magickprogressmonitor) c-pointer))


;;;
;;; Magickwand Property Getters & Setters
;;;

(define magickwand-antialias-set!
  (foreign-lambda bool MagickSetAntialias magickwand
                  (const bool)))

(define magickwand-antialias
  (getter-with-setter
   (foreign-lambda bool MagickGetAntialias magickwand)
   magickwand-antialias-set!))

(define magickwand-background-color-set!
  (foreign-lambda bool MagickSetBackgroundColor magickwand
                  (const pixelwand)))

(define magickwand-background-color
  (getter-with-setter
   (foreign-lambda pixelwand MagickGetBackgroundColor magickwand)
   magickwand-background-color-set!))

(define magickwand-colorspace-set!
  (foreign-lambda bool MagickSetColorspace magickwand
                  (const colorspace)))

(define magickwand-colorspace
  (getter-with-setter
   (foreign-lambda colorspace MagickGetColorspace magickwand)
   magickwand-colorspace-set!))

(define magickwand-compression-set!
  (foreign-lambda bool MagickSetCompression magickwand
                  (const compressiontype)))

(define magickwand-compression
  (getter-with-setter
   (foreign-lambda compressiontype MagickGetCompression magickwand)
   magickwand-compression-set!))

(define magick-get-compression-quality-set!
  (foreign-lambda bool MagickSetCompressionQuality magickwand
                  (const size_t)))

(define magick-get-compression-quality
  (getter-with-setter
   (foreign-lambda size_t MagickGetCompressionQuality magickwand)
   magick-get-compression-quality-set!))

(define magickwand-filename-set!
  (foreign-lambda bool MagickSetFilename magickwand (const c-string)))

(define magickwand-filename
  (getter-with-setter
   (foreign-lambda c-string MagickGetFilename magickwand)
   magickwand-filename-set!))

(define magickwand-font-set!
  (foreign-lambda bool MagickSetFont magickwand (const c-string)))

(define magickwand-font
  (getter-with-setter
   (foreign-lambda c-string MagickGetFont magickwand)
   magickwand-font-set!))

(define magickwand-format-set!
  (foreign-lambda bool MagickSetFormat magickwand (const c-string)))

(define magickwand-format
  (getter-with-setter
   (foreign-lambda char MagickGetFormat magickwand)
   magickwand-format-set!))

(define magickwand-gravity-set!
  (foreign-lambda bool MagickSetGravity magickwand (const gravity)))

(define magickwand-gravity
  (getter-with-setter
   (foreign-lambda gravity MagickGetGravity magickwand)
   magickwand-gravity-set!))

(define magickwand-interlace-scheme-set!
  (foreign-lambda bool MagickSetInterlaceScheme magickwand
                  (const interlacetype)))

(define magickwand-interlace-scheme
  (getter-with-setter
   (foreign-lambda interlacetype MagickGetInterlaceScheme magickwand)
   magickwand-interlace-scheme-set!))

(define magickwand-interpolate-method-set!
  (foreign-lambda bool MagickSetInterpolateMethod magickwand
                  (const interpolatepixelmethod)))

(define magickwand-interpolate-method
  (getter-with-setter
   (foreign-lambda interpolatepixelmethod MagickGetInterpolateMethod magickwand)
   magickwand-interpolate-method-set!))

(define magickwand-orientation-set!
  (foreign-lambda bool MagickSetOrientation magickwand
                  (const orientation)))

(define magickwand-orientation
  (getter-with-setter
   (foreign-lambda orientation MagickGetOrientation magickwand)
   magickwand-orientation-set!))

(define magickwand-page-set!
  (foreign-lambda bool MagickSetPage magickwand
                  (const size_t) (const size_t)
                  (const ssize_t) (const ssize_t)))

(define magickwand-page
  (getter-with-setter
   (lambda (wand)
     (let-location ((width size_t)
                    (height size_t)
                    (x ssize_t)
                    (y ssize_t))
       ((foreign-lambda bool MagickGetPage magickwand
                        (c-pointer size_t) (c-pointer size_t)
                        (c-pointer ssize_t) (c-pointer ssize_t))
        wand (location width) (location height) (location x) (location y))
       (list width height x y)))
   (lambda (wand args) (apply magickwand-page-set! wand args))))

(define magickwand-pointsize-set!
  (foreign-lambda bool MagickSetPointsize magickwand (const double)))

(define magickwand-pointsize
  (getter-with-setter
   (foreign-lambda double MagickGetPointsize magickwand)
   magickwand-pointsize-set!))

(define magickwand-resolution-set!
  (foreign-lambda bool MagickSetResolution magickwand
                  (const double) (const double)))

(define magickwand-resolution
  (getter-with-setter
   (lambda (wand)
     (let-location ((x-res double)
                    (y-res double))
       ((foreign-lambda bool MagickGetResolution magickwand
                        (c-pointer double) (c-pointer double))
        wand (location x-res) (location y-res))
       (list x-res y-res)))
   (lambda (wand args) (apply magickwand-resolution-set! wand args))))

(define magickwand-size-set!
  (foreign-lambda bool MagickSetSize magickwand
                  (const size_t) (const size_t)))

(define magickwand-size
  (getter-with-setter
   (lambda (wand)
     (let-location ((columns size_t)
                    (rows size_t))
       ((foreign-lambda bool MagickGetSize magickwand
                        (c-pointer size_t) (c-pointer size_t))
        wand (location columns) (location rows))
       (list columns rows)))
   (lambda (wand args) (apply magickwand-size-set! wand args))))

;;XXX: the size-offset setter sets 3 values, but the getter gets only one.
(define magick-set-size-offset
  (foreign-lambda bool MagickSetSizeOffset magickwand
                  (const size_t) (const size_t) (const ssize_t)))

(define magick-get-size-offset
  (foreign-lambda bool MagickGetSizeOffset magickwand
                  (c-pointer ssize_t)))

(define magickwand-type-set!
  (foreign-lambda bool MagickSetType magickwand (const imagetype)))

(define magickwand-type
  (getter-with-setter
   (foreign-lambda imagetype MagickGetType magickwand)
   magickwand-type-set!))

(define (magick-sampling-factors-set! wand factors)
  ((foreign-lambda bool MagickSetSamplingFactors magickwand
                   (const size_t) (const f64vector))
   wand (length factors) (list->f64vector factors)))

(define magick-sampling-factors
  (getter-with-setter
   (lambda (wand)
     (let-location ((count size_t))
       (let ((p ((foreign-lambda (c-pointer double) MagickGetSamplingFactors
                                 magickwand (c-pointer size_t))
                 wand (location count)))
             (result (make-f64vector count)))
         ((foreign-lambda* void (((c-pointer double) fro) (f64vector to) (size_t len))
            "size_t i;"
            "for (i = 0; i < len; ++i) {"
            "    to[i] = fro[i];"
            "}")
          p result count)
         ;;XXX: need to free p?
         (f64vector->list result))))
   magick-sampling-factors-set!))


;;;
;;; Magickwand Image Getters/Setters
;;;

(define magickwand-image-set!
  (foreign-lambda bool MagickSetImage magickwand (const magickwand)))

(define magickwand-image
  (getter-with-setter
   (foreign-lambda magickwand MagickGetImage magickwand)
   magickwand-image-set!))

(define magickwand-image-alpha-channel-set!
  (foreign-lambda bool MagickSetImageAlphaChannel magickwand
                  (const alphachanneltype)))

(define magickwand-image-alpha-channel
  (getter-with-setter
   (foreign-lambda bool MagickGetImageAlphaChannel magickwand)
   magickwand-image-alpha-channel-set!))

(define magickwand-image-clip-mask-set!
  (foreign-lambda bool MagickSetImageClipMask magickwand
                  (const magickwand)))

(define magickwand-image-clip-mask
  (getter-with-setter
   (foreign-lambda magickwand MagickGetImageClipMask magickwand)
   magickwand-image-clip-mask-set!))

(define magickwand-image-background-color-set!
  (foreign-lambda bool MagickSetImageBackgroundColor magickwand
                  (const pixelwand)))

(define magickwand-image-background-color
  (getter-with-setter
   (lambda (wand)
     (let ((p (make-pixelwand)))
       ((foreign-lambda bool MagickGetImageBackgroundColor magickwand
                        pixelwand)
        wand p)
       p))
   magickwand-image-background-color-set!))

(define magickwand-image-blue-primary-set!
  (foreign-lambda bool MagickSetImageBluePrimary magickwand
                  (const double) (const double)))

(define magickwand-image-blue-primary
  (getter-with-setter
   (lambda (wand)
     (let-location ((x double)
                    (y double))
       ((foreign-lambda bool MagickGetImageBluePrimary magickwand
                        (c-pointer double) (c-pointer double))
        wand (location x) (location y))
       (list x y)))
   (lambda (wand args) (apply magickwand-image-blue-primary-set! wand args))))

(define magickwand-image-border-color-set!
  (foreign-lambda bool MagickSetImageBorderColor magickwand
                  (const pixelwand)))

(define magickwand-image-border-color
  (getter-with-setter
   (lambda (wand)
     (let ((p (make-pixelwand)))
       ((foreign-lambda bool MagickGetImageBorderColor magickwand
                        pixelwand)
        wand p)
       p))
   magickwand-image-border-color-set!))

(define magickwand-image-channel-depth-set!
  (foreign-lambda bool MagickSetImageChannelDepth magickwand
                  (const channeltype) (const size_t)))

(define magickwand-image-channel-depth
  (getter-with-setter
   (foreign-lambda size_t MagickGetImageChannelDepth magickwand
                   (const channeltype))
   magickwand-image-channel-depth-set!))

(define magickwand-image-colormap-color-set!
  (foreign-lambda bool MagickSetImageColormapColor magickwand
                  (const size_t) (const pixelwand)))

(define magickwand-image-colormap-color
  (getter-with-setter
   (lambda (wand index)
     (let ((p (make-pixelwand)))
       ((foreign-lambda bool MagickGetImageColormapColor magickwand
                        (const size_t) pixelwand)
        wand index p)
       p))
   magickwand-image-colormap-color-set!))

(define magickwand-image-colorspace-set!
  (foreign-lambda bool MagickSetImageColorspace magickwand
                  (const colorspace)))

(define magickwand-image-colorspace
  (getter-with-setter
   (foreign-lambda colorspace MagickGetImageColorspace magickwand)
   magickwand-image-colorspace-set!))

(define magickwand-image-compose-set!
  (foreign-lambda bool MagickSetImageCompose magickwand
                  (const compositeoperator)))

(define magickwand-image-compose
  (getter-with-setter
   (foreign-lambda compositeoperator MagickGetImageCompose magickwand)
   magickwand-image-compose-set!))

(define magickwand-image-compression-set!
  (foreign-lambda bool MagickSetImageCompression magickwand
                  (const compressiontype)))

(define magickwand-image-compression
  (getter-with-setter
   (foreign-lambda compressiontype MagickGetImageCompression magickwand)
   magickwand-image-compression-set!))

(define magickwand-image-compression-quality-set!
  (foreign-lambda bool MagickSetImageCompressionQuality magickwand
                  (const size_t)))

(define magickwand-image-compression-quality
  (getter-with-setter
   (foreign-lambda size_t MagickGetImageCompressionQuality magickwand)
   magickwand-image-compression-quality-set!))

(define magickwand-image-delay-set!
  (foreign-lambda bool MagickSetImageDelay magickwand
                  (const size_t)))

(define magickwand-image-delay
  (getter-with-setter
   (foreign-lambda size_t MagickGetImageDelay magickwand)
   magickwand-image-delay-set!))

(define magickwand-image-depth-set!
  (foreign-lambda bool MagickSetImageDepth magickwand
                  (const size_t)))

(define magickwand-image-depth
  (getter-with-setter
   (foreign-lambda size_t MagickGetImageDepth magickwand)
   magickwand-image-depth-set!))

(define magickwand-image-dispose-set!
  (foreign-lambda bool MagickSetImageDispose magickwand
                  (const disposetype)))

(define magickwand-image-dispose
  (getter-with-setter
   (foreign-lambda disposetype MagickGetImageDispose magickwand)
   magickwand-image-dispose-set!))

(define magickwand-image-filename-set!
  (foreign-lambda bool MagickSetImageFilename magickwand
                  (const c-string)))

(define magickwand-image-filename
  (getter-with-setter
   (foreign-lambda c-string MagickGetImageFilename magickwand)
   magickwand-image-filename-set!))

(define magickwand-image-format-set!
  (foreign-lambda bool MagickSetImageFormat magickwand
                  (const c-string)))

(define magickwand-image-format
  (getter-with-setter
   (foreign-lambda c-string MagickGetImageFormat magickwand)
   magickwand-image-format-set!))

(define magickwand-image-fuzz-set!
  (foreign-lambda bool MagickSetImageFuzz magickwand
                  (const double)))

(define magickwand-image-fuzz
  (getter-with-setter
   (foreign-lambda double MagickGetImageFuzz magickwand)
   magickwand-image-fuzz-set!))

(define magickwand-image-gamma-set!
  (foreign-lambda bool MagickSetImageGamma magickwand
                  (const double)))

(define magickwand-image-gamma
  (getter-with-setter
   (foreign-lambda double MagickGetImageGamma magickwand)
   magickwand-image-gamma-set!))

(define magickwand-image-gravity-set!
  (foreign-lambda bool MagickSetImageGravity magickwand
                  (const gravity)))

(define magickwand-image-gravity
  (getter-with-setter
   (foreign-lambda gravity MagickGetImageGravity magickwand)
   magickwand-image-gravity-set!))

(define magickwand-image-green-primary-set!
  (foreign-lambda bool MagickSetImageGreenPrimary magickwand
                  (const double) (const double)))

(define magickwand-image-green-primary
  (getter-with-setter
   (lambda (wand)
     (let-location ((x double)
                    (y double))
       ((foreign-lambda bool MagickGetImageGreenPrimary magickwand
                        (c-pointer double) (c-pointer double))
        wand (location x) (location y))
       (list x y)))
   (lambda (wand args) (apply magickwand-image-green-primary-set! wand args))))

(define magickwand-image-interlace-scheme-set!
  (foreign-lambda bool MagickSetImageInterlaceScheme magickwand
                  (const interlacetype)))

(define magickwand-image-interlace-scheme
  (getter-with-setter
   (foreign-lambda interlacetype MagickGetImageInterlaceScheme magickwand)
   magickwand-image-interlace-scheme-set!))

(define magickwand-image-interpolate-method-set!
  (foreign-lambda bool MagickSetImageInterpolateMethod magickwand
                  (const interpolatepixelmethod)))

(define magickwand-image-interpolate-method
  (getter-with-setter
   (foreign-lambda interpolatepixelmethod MagickGetImageInterpolateMethod
                   magickwand)
   magickwand-image-interpolate-method-set!))

(define magickwand-image-iterations-set!
  (foreign-lambda bool MagickSetImageIterations magickwand
                  (const size_t)))

(define magickwand-image-iterations
  (getter-with-setter
   (foreign-lambda size_t MagickGetImageIterations magickwand)
   magickwand-image-iterations-set!))

(define magickwand-image-matte-color-set!
  (foreign-lambda bool MagickSetImageMatteColor magickwand
                  (const pixelwand)))

(define magickwand-image-matte-color
  (getter-with-setter
   (lambda (wand)
     (let ((p (make-pixelwand)))
       ((foreign-lambda bool MagickGetImageMatteColor magickwand
                        pixelwand)
        wand p)
       p))
   magickwand-image-matte-color-set!))

(define magickwand-image-orientation-set!
  (foreign-lambda bool MagickSetImageOrientation magickwand
                  (const orientation)))

(define magickwand-image-orientation
  (getter-with-setter
   (foreign-lambda orientation MagickGetImageOrientation magickwand)
   magickwand-image-orientation-set!))

(define magickwand-image-page-set!
  (foreign-lambda bool MagickSetImagePage magickwand
                  (const size_t) (const size_t)
                  (const ssize_t) (const ssize_t)))

(define magickwand-image-page
  (getter-with-setter
   (lambda (wand)
     (let-location ((width size_t)
                    (height size_t)
                    (x ssize_t)
                    (y ssize_t))
       ((foreign-lambda bool MagickGetImagePage magickwand
                        (c-pointer size_t) (c-pointer size_t)
                        (c-pointer ssize_t) (c-pointer ssize_t))
        wand (location width) (location height) (location x) (location y))
       (list width height x y)))
   (lambda (wand args) (apply magickwand-image-page-set! wand args))))

(define magickwand-image-red-primary-set!
  (foreign-lambda bool MagickSetImageRedPrimary magickwand
                  (const double) (const double)))

(define magickwand-image-red-primary
  (getter-with-setter
   (lambda (wand)
     (let-location ((x double)
                    (y double))
       ((foreign-lambda bool MagickGetImageRedPrimary magickwand
                        (c-pointer double) (c-pointer double))
        wand x y)
       (list x y)))
   (lambda (wand args) (apply magickwand-image-red-primary-set! wand args))))

(define magickwand-image-rendering-intent-set!
  (foreign-lambda bool MagickSetImageRenderingIntent magickwand
                  (const renderingintent)))

(define magickwand-image-rendering-intent
  (getter-with-setter
   (foreign-lambda renderingintent MagickGetImageRenderingIntent magickwand)
   magickwand-image-rendering-intent-set!))

(define magickwand-image-resolution-set!
  (foreign-lambda bool MagickSetImageResolution magickwand
                  (const double) (const double)))

(define magickwand-image-resolution
  (getter-with-setter
   (lambda (wand)
     (let-location ((x-res double)
                    (y-res double))
       ((foreign-lambda bool MagickGetImageResolution magickwand
                        (c-pointer double) (c-pointer double))
        wand (location x-res) (location y-res))
       (list x-res y-res)))
   (lambda (wand args) (apply magickwand-image-resolution-set! wand args))))

(define magickwand-image-scene-set!
  (foreign-lambda bool MagickSetImageScene magickwand (const size_t)))

(define magickwand-image-scene
  (getter-with-setter
   (foreign-lambda size_t MagickGetImageScene magickwand)
   magickwand-image-scene-set!))

(define magickwand-image-ticks-per-second-set!
  (foreign-lambda bool MagickSetImageTicksPerSecond magickwand
                  (const ssize_t)))

(define magickwand-image-ticks-per-second
  (getter-with-setter
   (foreign-lambda size_t MagickGetImageTicksPerSecond magickwand)
   magickwand-image-ticks-per-second-set!))

(define magickwand-image-type-set!
  (foreign-lambda bool MagickSetImageType magickwand
                  (const imagetype)))

(define magickwand-image-type
  (getter-with-setter
   (foreign-lambda imagetype MagickGetImageType magickwand)
   magickwand-image-type-set!))

(define magickwand-image-units-set!
  (foreign-lambda bool MagickSetImageUnits magickwand
                  (const resolutiontype)))

(define magickwand-image-units
  (getter-with-setter
   (foreign-lambda resolutiontype MagickGetImageUnits magickwand)
   magickwand-image-units-set!))

(define magickwand-image-virtual-pixel-method-set!
  (foreign-lambda virtualpixelmethod MagickSetImageVirtualPixelMethod
                  magickwand (const virtualpixelmethod)))

(define magickwand-image-virtual-pixel-method
  (getter-with-setter
   (foreign-lambda virtualpixelmethod MagickGetImageVirtualPixelMethod magickwand)
   magickwand-image-virtual-pixel-method-set!))

(define magickwand-image-white-point-set!
  (foreign-lambda bool MagickSetImageWhitePoint magickwand
                  (const double) (const double)))

(define magickwand-image-white-point
  (getter-with-setter
   (lambda (wand)
     (let-location ((x double)
                    (y double))
       ((foreign-lambda bool MagickGetImageWhitePoint magickwand
                        (c-pointer double) (c-pointer double))
        wand (location x) (location y))
       (list x y)))
   (lambda (wand args) (apply magickwand-image-white-point-set! wand args))))


;;;
;;; Magickwand Image Getters/Setters, Unpaired
;;;

(define (magick-get-image-blob magickwand)
  (let-location ((ignored size_t))
    ((foreign-lambda unsigned-c-string MagickGetImageBlob magickwand
                     (c-pointer size_t))
     magickwand (location ignored))))

(define magick-get-images-blob
  (foreign-lambda unsigned-c-string MagickGetImagesBlob magickwand
                  (c-pointer size_t)))

(define magick-get-image-channel-distortion
  (foreign-lambda bool MagickGetImageChannelDistortion
                  magickwand (const magickwand) (const channeltype)
                  (const metrictype) (c-pointer double)))

(define magick-get-image-channel-distortions
  (foreign-lambda (c-pointer double) MagickGetImageChannelDistortions
                  magickwand (const magickwand) (const metrictype)))

(define magick-get-image-channel-features
  (foreign-lambda channelfeatures MagickGetImageChannelFeatures
                  magickwand (const size_t)))

(define magick-get-image-channel-kurtosis
  (foreign-lambda bool MagickGetImageChannelKurtosis magickwand
                  (const channeltype) (c-pointer double)
                  (c-pointer double)))

(define magick-get-image-channel-mean
  (foreign-lambda bool MagickGetImageChannelMean magickwand
                  (const channeltype) (c-pointer double)
                  (c-pointer double)))

(define magick-get-image-channel-range
  (foreign-lambda bool MagickGetImageChannelRange magickwand
                  (const channeltype) (c-pointer double)
                  (c-pointer double)))

(define magick-get-image-channel-statistics
  (foreign-lambda channelstatistics MagickGetImageChannelStatistics magickwand))

(define magick-get-image-colors
  (foreign-lambda size_t MagickGetImageColors magickwand))

(define magick-get-image-distortion
  (foreign-lambda bool MagickGetImageDistortion magickwand
                  (const magickwand) (const metrictype)
                  (c-pointer double)))

(define magick-get-image-height
  (foreign-lambda size_t MagickGetImageHeight magickwand))

(define magick-get-image-histogram
  (foreign-lambda (c-pointer pixelwand) MagickGetImageHistogram
                  magickwand (c-pointer size_t)))

(define magick-get-image-length
  (foreign-lambda bool MagickGetImageLength magickwand
                  (c-pointer "MagickSizeType")))

(define magick-get-image-pixel-color
  (foreign-lambda bool MagickGetImagePixelColor magickwand
                  (const ssize_t) (const ssize_t)
                  pixelwand))

(define magick-get-image-region
  (foreign-lambda magickwand MagickGetImageRegion magickwand
                  (const size_t) (const size_t)
                  (const ssize_t) (const ssize_t)))

(define magick-get-image-signature
  (foreign-lambda c-string MagickGetImageSignature magickwand))

(define magick-get-image-width
  (foreign-lambda size_t MagickGetImageWidth magickwand))

(define magick-get-number-images
  (foreign-lambda size_t MagickGetNumberImages magickwand))

(define magick-get-image-total-ink-density
  (foreign-lambda double MagickGetImageTotalInkDensity magickwand))

(define-magick-image-op (magick-set-image-bias wand bias)
  (MagickSetImageBias magickwand (const double)))

(define-magick-image-op (magick-set-image-color wand color)
  (MagickSetImageColor magickwand (const pixelwand)))

(define-magick-image-op (magick-set-image-extent wand columns rows)
  (MagickSetImageExtent magickwand (const size_t) (const size_t)))

(define-magick-image-op (magick-set-image-matte wand matte)
  (MagickSetImageMatte magickwand (const bool)))

(define-magick-image-op (magick-set-image-opacity wand alpha)
  (MagickSetImageOpacity magickwand (const double)))

;;(define magick-set-image-progress-monitor
;;  (foreign-lambda magickprogressmonitor MagickSetImageProgressMonitor
;;                  magickwand (const magickprogressmonitor) c-pointer))


;;;
;;; Magick-image methods
;;;

(define-magick-image-op (magick-adaptive-blur-image wand radius sigma)
  (MagickAdaptiveBlurImage magickwand (const double) (const double)))

(define-magick-image-op (magick-adaptive-blur-image-channel wand channel radius sigma)
  (MagickAdaptiveBlurImageChannel magickwand (const channeltype) (const double) (const double)))

(define-magick-image-op (magick-adaptive-resize-image wand columns rows)
  (MagickAdaptiveResizeImage magickwand (const size_t) (const size_t)))

(define-magick-image-op (magick-adaptive-sharpen-image wand radius sigma)
  (MagickAdaptiveSharpenImage magickwand (const double) (const double)))

(define-magick-image-op (magick-adaptive-sharpen-image-channel wand channel radius sigma)
  (MagickAdaptiveSharpenImageChannel magickwand (const channeltype) (const double) (const double)))

(define-magick-image-op (magick-adaptive-threshold-image wand width height offset)
  (MagickAdaptiveThresholdImage magickwand (const size_t) (const size_t) (const ssize_t)))

(define-magick-image-op (magick-add-image wand add_wand)
  (MagickAddImage magickwand (const magickwand)))

(define-magick-image-op (magick-add-noise-image wand noise-type)
  (MagickAddNoiseImage magickwand (const noisetype)))

(define-magick-image-op (magick-add-noise-image-channel wand channel noise-type)
  (MagickAddNoiseImageChannel magickwand (const channeltype) (const noisetype)))

(define-magick-image-op (magick-affine-transform-image wand drawing-wand)
  (MagickAffineTransformImage magickwand (const drawingwand)))

(define-magick-image-op (magick-annotate-image wand drawing-wand x y angle text)
  (MagickAnnotateImage magickwand (const drawingwand) (const double) (const double)
                       (const double) (const c-string)))

(define-magick-image-op (magick-animate-images wand server-name)
  (MagickAnimateImages magickwand (const c-string)))

(define magick-append-images
  (foreign-lambda magickwand MagickAppendImages magickwand (const bool)))

(define-magick-image-op (magick-auto-gamma-image wand)
  (MagickAutoGammaImage magickwand))

(define-magick-image-op (magick-auto-gamma-image-channel wand channel)
  (MagickAutoGammaImageChannel magickwand (const channeltype)))

(define-magick-image-op (magick-auto-level-image wand)
  (MagickAutoLevelImage magickwand))

(define-magick-image-op (magick-auto-level-image-channel wand channel)
  (MagickAutoLevelImageChannel magickwand (const channeltype)))

(define-magick-image-op (magick-black-threshold-image wand threshold)
  (MagickBlackThresholdImage magickwand (const pixelwand)))

(define-magick-image-op (magick-blue-shift-image wand factor)
  (MagickBlueShiftImage magickwand (const double)))

(define-magick-image-op (magick-blur-image wand radius sigma)
  (MagickBlurImage magickwand (const double) (const double)))

(define-magick-image-op (magick-blur-image-channel wand channel radius sigma)
  (MagickBlurImageChannel magickwand (const channeltype) (const double) (const double)))

(define-magick-image-op (magick-border-image wand bordercolor width height)
  (MagickBorderImage magickwand (const pixelwand) (const size_t) (const size_t)))

(define-magick-image-op (magick-brightness-contrast-image wand brightness contrast)
  (MagickBrightnessContrastImage magickwand (const double) (const double)))

(define-magick-image-op (magick-brightness-contrast-image-channel wand channel brightness contrast)
  (MagickBrightnessContrastImageChannel magickwand (const channeltype) (const double) (const double)))

(define-magick-image-op (magick-charcoal-image wand radius sigma)
  (MagickCharcoalImage magickwand (const double) (const double)))

(define-magick-image-op (magick-chop-image wand width height x y)
  (MagickChopImage magickwand (const size_t) (const size_t)
                   (const ssize_t) (const ssize_t)))

(define-magick-image-op (magick-clamp-image wand)
  (MagickClampImage magickwand))

(define-magick-image-op (magick-clamp-image-channel wand channel)
  (MagickClampImageChannel magickwand (const channeltype)))

(define-magick-image-op (magick-clip-image wand)
  (MagickClipImage magickwand))

(define-magick-image-op (magick-clip-image-path wand pathname inside)
  (MagickClipImagePath magickwand (const c-string) (const bool)))

(define-magick-image-op (magick-clut-image wand clut-wand)
  (MagickClutImage magickwand (const magickwand)))

(define-magick-image-op (magick-clut-image-channel wand channel clut-wand)
  (MagickClutImageChannel magickwand (const channeltype) (const magickwand)))

(define magick-coalesce-images
  (foreign-lambda magickwand MagickCoalesceImages magickwand))

(define-magick-image-op (magick-color-decision-list-image wand color-correction-collection)
  (MagickColorDecisionListImage magickwand (const c-string)))

(define-magick-image-op (magick-colorize-image wand colorize opacity)
  (MagickColorizeImage magickwand (const pixelwand) (const pixelwand)))

(define-magick-image-op (magick-color-matrix-image wand color-matrix)
  (MagickColorMatrixImage magickwand (const kernelinfo)))

(define magick-combine-images
  (foreign-lambda magickwand MagickCombineImages
                  magickwand (const channeltype)))

(define-magick-image-op (magick-comment-image wand comment)
  (MagickCommentImage magickwand (const c-string)))

(define magick-compare-image-channels
  (foreign-lambda magickwand MagickCompareImageChannels
                  magickwand (const magickwand) (const channeltype)
                  (const metrictype) (c-pointer double)))

(define magick-compare-image-layers
  (foreign-lambda magickwand MagickCompareImageLayers
                  magickwand (const imagelayermethod)))

(define magick-compare-images
  (foreign-lambda magickwand MagickCompareImages
                  magickwand (const magickwand)
                  (const metrictype) (c-pointer double)))

(define-magick-image-op (magick-composite-image wand source-wand compose x y)
  (MagickCompositeImage magickwand (const magickwand) (const compositeoperator)
                        (const ssize_t) (const ssize_t)))

(define-magick-image-op (magick-composite-image-channel wand channel source-wand compose x y)
  (MagickCompositeImageChannel magickwand (const channeltype) (const magickwand)
                               (const compositeoperator) (const ssize_t) (const ssize_t)))

(define-magick-image-op (magick-composite-layers wand source-wand compose x y)
  (MagickCompositeLayers magickwand (const magickwand) (const compositeoperator)
                         (const ssize_t) (const ssize_t)))

(define-magick-image-op (magick-contrast-image wand sharpen)
  (MagickContrastImage magickwand (const bool)))

(define-magick-image-op (magick-contrast-stretch-image wand black-point white-point)
  (MagickContrastStretchImage magickwand (const double) (const double)))

(define-magick-image-op (magick-contrast-stretch-image-channel wand channel black-point white-point)
  (MagickContrastStretchImageChannel magickwand (const channeltype) (const double) (const double)))

(define-magick-image-op (magick-convolve-image wand order kernel)
  (MagickConvolveImage magickwand (const size_t) (const (c-pointer double))))

(define-magick-image-op (magick-convolve-image-channel wand channel order kernel)
  (MagickConvolveImageChannel magickwand (const channeltype) (const size_t)
                              (const (c-pointer double))))

(define-magick-image-op (magick-crop-image wand width height x y)
  (MagickCropImage magickwand (const size_t) (const size_t)
                   (const ssize_t) (const ssize_t)))

(define-magick-image-op (magick-cycle-colormap-image wand displace)
  (MagickCycleColormapImage magickwand (const ssize_t)))

(define-magick-image-op (magick-constitute-image wand columns rows map storage pixels)
  (MagickConstituteImage magickwand (const size_t) (const size_t) (const c-string)
                         (const storagetype) c-pointer))

(define-magick-image-op (magick-decipher-image wand passphrase)
  (MagickDecipherImage magickwand (const c-string)))

(define magick-deconstruct-images
  (foreign-lambda magickwand MagickDeconstructImages magickwand))

(define-magick-image-op (magick-deskew-image wand threshold)
  (MagickDeskewImage magickwand (const double)))

(define-magick-image-op (magick-despeckle-image wand)
  (MagickDespeckleImage magickwand))

(define-magick-image-op (magick-display-image wand server-name)
  (MagickDisplayImage magickwand (const c-string)))

(define-magick-image-op (magick-display-images wand server-name)
  (MagickDisplayImages magickwand (const c-string)))

(define-magick-image-op (magick-distort-image wand method number-arguments arguments bestfit)
  (MagickDistortImage magickwand (const distortimagemethod) (const size_t)
                      (const (c-pointer double)) (const bool)))

(define-magick-image-op (magick-draw-image wand drawing-wand)
  (MagickDrawImage magickwand (const drawingwand)))

(define-magick-image-op (magick-edge-image wand radius)
  (MagickEdgeImage magickwand (const double)))

(define-magick-image-op (magick-emboss-image wand radius sigma)
  (MagickEmbossImage magickwand (const double) (const double)))

(define-magick-image-op (magick-encipher-image wand passphrase)
  (MagickEncipherImage magickwand (const c-string)))

(define-magick-image-op (magick-enhance-image wand)
  (MagickEnhanceImage magickwand))

(define-magick-image-op (magick-equalize-image wand)
  (MagickEqualizeImage magickwand))

(define-magick-image-op (magick-equalize-image-channel wand channel)
  (MagickEqualizeImageChannel magickwand (const channeltype)))

(define-magick-image-op (magick-evaluate-image wand operator value)
  (MagickEvaluateImage magickwand (const magickevaluateoperator) (const double)))

(define-magick-image-op (magick-evaluate-images wand operator)
  (MagickEvaluateImages magickwand (const magickevaluateoperator)))

(define-magick-image-op (magick-evaluate-image-channel wand channel operator value)
  (MagickEvaluateImageChannel magickwand (const channeltype)
                              (const magickevaluateoperator)
                              (const double)))

(define (magick-export-image-pixels wand x y columns rows map storage pixels)
  (or ((foreign-lambda bool MagickExportImagePixels magickwand (const ssize_t) (const ssize_t) (const size_t)
                       (const size_t) (const c-string) (const storagetype) nonnull-blob)
       wand x y columns rows map (storagetype->int storage) pixels)
      (signal (%magick-get-exception wand))))

(define-magick-image-op (magick-extent-image wand width height x y)
  (MagickExtentImage magickwand (const size_t) (const size_t)
                     (const ssize_t) (const ssize_t)))

(define-magick-image-op (magick-filter-image wand kernel)
  (MagickFilterImage magickwand (const kernelinfo)))

(define-magick-image-op (magick-filter-image-channel wand channel kernel)
  (MagickFilterImageChannel magickwand (const channeltype) (const kernelinfo)))

(define-magick-image-op (magick-flip-image wand)
  (MagickFlipImage magickwand))

(define-magick-image-op (magick-floodfill-paint-image wand channel fill fuzz bordercolor x y invert)
  (MagickFloodfillPaintImage magickwand (const channeltype) (const pixelwand) (const double)
                             (const pixelwand) (const ssize_t) (const ssize_t) (const bool)))

(define-magick-image-op (magick-flop-image wand)
  (MagickFlopImage magickwand))

(define-magick-image-op (magick-forward-fourier-transform-image wand magnitude)
  (MagickForwardFourierTransformImage magickwand (const bool)))

(define-magick-image-op (magick-frame-image wand matte-color width height inner-bevel outer-bevel)
  (MagickFrameImage magickwand (const pixelwand) (const size_t) (const size_t)
                    (const ssize_t) (const ssize_t)))

(define-magick-image-op (magick-function-image wand function number-arguments arguments)
  (MagickFunctionImage magickwand (const magickfunction) (const size_t)
                       (const (c-pointer double))))

(define-magick-image-op (magick-function-image-channel wand channel function number-arguments arguments)
  (MagickFunctionImageChannel magickwand (const channeltype) (const magickfunction) (const size_t)
                              (const (c-pointer double))))

(define-magick-image-op (magick-fx-image wand expression)
  (MagickFxImage magickwand (const c-string)))

(define-magick-image-op (magick-fx-image-channel wand channel expression)
  (MagickFxImageChannel magickwand (const channeltype) (const c-string)))

(define-magick-image-op (magick-gamma-image wand gamma)
  (MagickGammaImage magickwand (const double)))

(define-magick-image-op (magick-gamma-image-channel wand channel gamma)
  (MagickGammaImageChannel magickwand (const channeltype) (const double)))

(define-magick-image-op (magick-gaussian-blur-image wand radius sigma)
  (MagickGaussianBlurImage magickwand (const double) (const double)))

(define-magick-image-op (magick-gaussian-blur-image-channel wand channel radius sigmap)
  (MagickGaussianBlurImageChannel magickwand (const channeltype) (const double)
                                  (const double)))

(define-magick-image-op (magick-hald-clut-image wand hald-wand)
  (MagickHaldClutImage magickwand (const magickwand)))

(define-magick-image-op (magick-hald-clut-image-channel wand channel hald-wand)
  (MagickHaldClutImageChannel magickwand (const channeltype) (const magickwand)))

(define magick-has-next-image
  (foreign-lambda bool MagickHasNextImage magickwand))

(define magick-has-previous-image
  (foreign-lambda bool MagickHasPreviousImage magickwand))

(define magick-identify-image
  (foreign-lambda c-string MagickIdentifyImage magickwand))

(define-magick-image-op (magick-implode-image wand amount)
  (MagickImplodeImage magickwand (const double)))

;; docs say this returns MagickFalse on success, MagickTrue on failure!?
(define magick-import-image-pixels
  (foreign-lambda bool MagickImportImagePixels
                  magickwand (const ssize_t) (const ssize_t)
                  (const size_t) (const size_t)
                  (const c-string) (const storagetype)
                  (const c-pointer)))

(define-magick-image-op (magick-inverse-fourier-transform-image magnitude-wand phase-wand magnitude)
  (MagickInverseFourierTransformImage magickwand magickwand (const bool)))

(define-magick-image-op (magick-label-image wand label)
  (MagickLabelImage magickwand (const c-string)))

(define-magick-image-op (magick-level-image wand black-point gamma white-point)
  (MagickLevelImage magickwand (const double) (const double) (const double)))

(define-magick-image-op (magick-level-image-channel wand channel black-point gamma white-point)
  (MagickLevelImageChannel magickwand (const channeltype) (const double) (const double)
                           (const double)))

(define-magick-image-op (magick-linear-stretch-image wand black-point white-point)
  (MagickLinearStretchImage magickwand (const double) (const double)))

(define-magick-image-op (magick-liquid-rescale-image wand columns rows delta-x rigidity)
  (MagickLiquidRescaleImage magickwand (const size_t) (const size_t)
                            (const double) (const double)))

(define-magick-image-op (magick-magnify-image wand)
  (MagickMagnifyImage magickwand))

(define magick-merge-image-layers
  (foreign-lambda magickwand MagickMergeImageLayers
                  magickwand (const imagelayermethod)))

(define-magick-image-op (magick-minify-image wand)
  (MagickMinifyImage magickwand))

(define-magick-image-op (magick-modulate-image wand brightness saturation hue)
  (MagickModulateImage magickwand (const double) (const double) (const double)))

(define magick-montage-image
  (foreign-lambda magickwand MagickMontageImage
                  magickwand (const drawingwand)
                  (const c-string) (const c-string)
                  (const montagemode) (const c-string)))

(define magick-morph-images
  (foreign-lambda magickwand MagickMorphImages
                  magickwand (const size_t)))

(define-magick-image-op (magick-morphology-image wand method iterations kernel)
  (MagickMorphologyImage magickwand morphologymethod (const ssize_t) kernelinfo))

(define-magick-image-op (magick-morphology-image-channel wand channel method iterations kernel)
  (MagickMorphologyImageChannel magickwand channeltype morphologymethod (const ssize_t) kernelinfo))

(define-magick-image-op (magick-motion-blur-image wand radius sigma angle)
  (MagickMotionBlurImage magickwand (const double) (const double) (const double)))

(define-magick-image-op (magick-motion-blur-image-channel wand channel radius sigma angle)
  (MagickMotionBlurImageChannel magickwand (const channeltype) (const double)
                                (const double) (const double)))

(define-magick-image-op (magick-negate-image wand gray)
  (MagickNegateImage magickwand (const bool)))

(define-magick-image-op (magick-negate-image-channel wand channel gray)
  (MagickNegateImageChannel magickwand (const channeltype) (const bool)))

(define-magick-image-op (magick-new-image wand columns rows background)
  (MagickNewImage magickwand (const size_t) (const size_t) (const pixelwand)))

(define magick-next-image
  (foreign-lambda bool MagickNextImage magickwand))

(define-magick-image-op (magick-normalize-image wand)
  (MagickNormalizeImage magickwand))

(define-magick-image-op (magick-normalize-image-channel wand channel)
  (MagickNormalizeImageChannel magickwand (const channeltype)))

(define-magick-image-op (magick-oil-paint-image wand radius)
  (MagickOilPaintImage magickwand (const double)))

(define-magick-image-op (magick-opaque-paint-image wand target fill fuzz invert)
  (MagickOpaquePaintImage magickwand (const pixelwand) (const pixelwand)
                          (const double) (const bool)))

(define-magick-image-op (magick-opaque-paint-image-channel wand channel target fill fuzz invert)
  (MagickOpaquePaintImageChannel magickwand (const channeltype) (const pixelwand)
                                 (const pixelwand) (const double) (const bool)))

(define magick-optimize-image-layers
  (foreign-lambda magickwand MagickOptimizeImageLayers magickwand))

(define-magick-image-op (magick-ordered-posterize-image wand threshold-map)
  (MagickOrderedPosterizeImage magickwand (const c-string)))

(define-magick-image-op (magick-ordered-posterize-image-channel wand channel threshold-map)
  (MagickOrderedPosterizeImageChannel magickwand (const channeltype) (const c-string)))

(define-magick-image-op (magick-ping-image wand filename)
  (MagickPingImage magickwand (const c-string)))

(define-magick-image-op (magick-ping-image-blob wand blob length)
  (MagickPingImageBlob magickwand (const c-pointer) (const size_t)))

;;(define magick-ping-image-file
;;  (foreign-lambda bool MagickPingImageFile
;;                  magickwand (c-pointer FILE)))

(define-magick-image-op (magick-polaroid-image wand drawing-wand angle)
  (MagickPolaroidImage magickwand (const drawingwand) (const double)))

(define-magick-image-op (magick-posterize-image wand levels dither)
  (MagickPosterizeImage magickwand (const size_t) (const bool)))

(define magick-preview-images
  (foreign-lambda magickwand MagickPreviewImages
                  magickwand (const previewtype)))

(define magick-previous-image
  (foreign-lambda bool MagickPreviousImage magickwand))

(define-magick-image-op (magick-quantize-image wand number-colors colorspace treedepth dither measure-error)
  (MagickQuantizeImage magickwand (const size_t) (const colorspace) (const size_t) (const bool) (const bool)))

(define-magick-image-op (magick-quantize-images wand number-colors colorspace treedepth dither measure-error)
  (MagickQuantizeImages magickwand (const size_t) (const colorspace) (const size_t) (const bool) (const bool)))

(define-magick-image-op (magick-raise-image wand width height x y raise)
  (MagickRaiseImage magickwand (const size_t) (const size_t)
                    (const ssize_t) (const ssize_t) (const bool)))

(define-magick-image-op (magick-random-threshold-image wand low high)
  (MagickRandomThresholdImage magickwand (const double) (const double)))

(define-magick-image-op (magick-random-threshold-image-channel wand channel low high)
  (MagickRandomThresholdImageChannel magickwand (const channeltype)
                                     (const double) (const double)))

(define-magick-image-op (magick-read-image wand filename)
  (MagickReadImage magickwand (const c-string)))

(define (magick-read-image-blob wand blob)
  (or ((foreign-lambda bool MagickReadImageBlob magickwand
                       (const blob) (const size_t))
       wand blob (blob-size blob))
      (signal (%magick-get-exception wand))))

;;(define magick-read-image-file
;;  (foreign-lambda bool MagickReadImageFile
;;                  magickwand (c-pointer FILE)))

(define-magick-image-op (magick-remap-image wand remap-wand method)
  (MagickRemapImage magickwand (const magickwand) (const dithermethod)))

(define-magick-image-op (magick-remove-image wand)
  (MagickRemoveImage magickwand))

(define-magick-image-op (magick-resample-image wand x-resolution y-resolution filter blur)
  (MagickResampleImage magickwand (const double) (const double)
                       (const filtertype) (const double)))

(define-magick-image-op (magick-reset-image-page wand page)
  (MagickResetImagePage magickwand (const c-string)))

(define (magick-resize-image wand columns rows filter #!optional (blur 1.0))
  ;; convert chooses a default filter as follows: Mitchell for colormapped
  ;; images, images with a matte channel, or if the image is enlarged.
  ;; Otherwise Lanczos.
  (or ((foreign-lambda bool MagickResizeImage
                       magickwand (const size_t) (const size_t)
                       (const filtertype) (const double))
       wand columns rows (filtertype->int filter) blur)
      (signal (%magick-get-exception wand))))

(define-magick-image-op (magick-roll-image wand x y)
  (MagickRollImage magickwand (const ssize_t) (const ssize_t)))

(define-magick-image-op (magick-rotate-image wand background degrees)
  (MagickRotateImage magickwand (const pixelwand) (const double)))

(define-magick-image-op (magick-sample-image wand columns rows)
  (MagickSampleImage magickwand (const size_t) (const size_t)))

(define-magick-image-op (magick-scale-image wand columns rows)
  (MagickScaleImage magickwand (const size_t) (const size_t)))

(define-magick-image-op (magick-segment-image wand colorspace verbose cluster-threshold smooth-threshold)
  (MagickSegmentImage magickwand (const colorspace) (const bool) (const double) (const double)))

(define-magick-image-op (magick-selective-blur-image wand radius sigma threshold)
  (MagickSelectiveBlurImage magickwand (const double) (const double) (const double)))

(define-magick-image-op (magick-selective-blur-image-channel wand channel radius sigma threshold)
  (MagickSelectiveBlurImageChannel magickwand (const channeltype) (const double)
                                   (const double) (const double)))

(define-magick-image-op (magick-separate-image-channel wand channel)
  (MagickSeparateImageChannel magickwand (const channeltype)))

(define-magick-image-op (magick-sepia-tone-image wand threshold)
  (MagickSepiaToneImage magickwand (const double)))

(define-magick-image-op (magick-shade-image wand gray azimuth elevation)
  (MagickShadeImage magickwand (const bool) (const double) (const double)))

(define-magick-image-op (magick-shadow-image wand opacity sigma x y)
  (MagickShadowImage magickwand (const double) (const double)
                     (const ssize_t) (const ssize_t)))

(define-magick-image-op (magick-sharpen-image wand radius sigma)
  (MagickSharpenImage magickwand (const double) (const double)))

(define-magick-image-op (magick-sharpen-image-channel wand channel radius sigma)
  (MagickSharpenImageChannel magickwand (const channeltype)
                             (const double) (const double)))

(define-magick-image-op (magick-shave-image wand columns rows)
  (MagickShaveImage magickwand (const size_t) (const size_t)))

(define-magick-image-op (magick-shear-image wand background x-shear y-shear)
  (MagickShearImage magickwand (const pixelwand) (const double) (const double)))

(define-magick-image-op (magick-sigmoidal-contrast-image wand sharpen alpha beta)
  (MagickSigmoidalContrastImage magickwand (const bool) (const double) (const double)))

(define-magick-image-op (magick-sigmoidal-contrast-image-channel wand channel sharpen alpha beta)
  (MagickSigmoidalContrastImageChannel magickwand (const channeltype) (const bool)
                                       (const double) (const double)))

(define magick-similarity-image
  (foreign-lambda magickwand MagickSimilarityImage
                  magickwand (const magickwand) rectangleinfo
                  (c-pointer double)))

(define-magick-image-op (magick-sketch-image wand radius sigma angle)
  (MagickSketchImage magickwand (const double) (const double) (const double)))

(define magick-smush-images
  (foreign-lambda magickwand MagickSmushImages
                  magickwand (const bool) (const ssize_t)))

(define-magick-image-op (magick-solarize-image wand threshold)
  (MagickSolarizeImage magickwand (const double)))

(define-magick-image-op (magick-sparse-color-image wand channel method number-arguments arguments)
  (MagickSparseColorImage magickwand (const channeltype) (const sparsecolormethod)
                          (const size_t) (const (c-pointer double))))

(define-magick-image-op (magick-splice-image wand width height x y)
  (MagickSpliceImage magickwand (const size_t) (const size_t)
                     (const ssize_t) (const ssize_t)))

(define-magick-image-op (magick-spread-image wand radius)
  (MagickSpreadImage magickwand (const double)))

;;;XXX: type signature wrong in ImageMagick 6.7.4-0
;; (define magick-statistic-image
;;  (foreign-lambda bool MagickStatisticImage
;;                  magickwand (const statistictype)
;;                  (const size_t) (const size_t)))

;;;XXX: type signature wrong in ImageMagick 6.7.4-0
;; (define magick-statistic-image-channel
;;  (foreign-lambda bool MagickStatisticImageChannel
;;                  magickwand (const channeltype) (const statistictype)
;;                  (const size_t) (const size_t)))

(define magick-stegano-image
  (foreign-lambda magickwand MagickSteganoImage
                  magickwand (const magickwand) (const ssize_t)))

(define magick-stereo-image
  (foreign-lambda magickwand MagickStereoImage
                  magickwand (const magickwand)))

(define-magick-image-op (magick-strip-image wand)
  (MagickStripImage magickwand))

(define-magick-image-op (magick-swirl-image wand degrees)
  (MagickSwirlImage magickwand (const double)))

(define magick-texture-image
  (foreign-lambda magickwand MagickTextureImage
                  magickwand (const magickwand)))

(define-magick-image-op (magick-threshold-image wand threshold)
  (MagickThresholdImage magickwand (const double)))

(define-magick-image-op (magick-threshold-image-channel wand channel threshold)
  (MagickThresholdImageChannel magickwand (const channeltype) (const double)))

(define-magick-image-op (magick-thumbnail-image wand columns rows)
  (MagickThumbnailImage magickwand (const size_t) (const size_t)))

(define-magick-image-op (magick-tint-image wand tint opacity)
  (MagickTintImage magickwand (const pixelwand) (const pixelwand)))

(define magick-transform-image
  (foreign-lambda magickwand MagickTransformImage
                  magickwand (const c-string) (const c-string)))

(define-magick-image-op (magick-transform-image-colorspace wand colorspace)
  (MagickTransformImageColorspace magickwand (const colorspace)))

(define-magick-image-op (magick-transparent-paint-image wand target alpha fuzz invert)
  (MagickTransparentPaintImage magickwand (const pixelwand) (const double)
                               (const double) (const bool)))

(define-magick-image-op (magick-transpose-image wand)
  (MagickTransposeImage magickwand))

(define-magick-image-op (magick-transverse-image wand)
  (MagickTransverseImage magickwand))

(define-magick-image-op (magick-trim-image wand fuzz)
  (MagickTrimImage magickwand (const double)))

(define-magick-image-op (magick-unique-image-colors wand)
  (MagickUniqueImageColors magickwand))

(define-magick-image-op (magick-unsharp-mask-image wand radius sigma amount threshold)
  (MagickUnsharpMaskImage magickwand (const double) (const double)
                          (const double) (const double)))

(define-magick-image-op (magick-unsharp-mask-image-channel wand channel radius sigma amount threshold)
  (MagickUnsharpMaskImageChannel magickwand (const channeltype) (const double)
                                 (const double) (const double) (const double)))

(define-magick-image-op (magick-vignette-image wand black-point white-point x y)
  (MagickVignetteImage magickwand (const double) (const double)
                       (const ssize_t) (const ssize_t)))

(define-magick-image-op (magick-wave-image wand amplitude wave-length)
  (MagickWaveImage magickwand (const double) (const double)))

(define-magick-image-op (magick-white-threshold-image wand threshold)
  (MagickWhiteThresholdImage magickwand (const pixelwand)))

(define-magick-image-op (magick-write-image wand filename)
  (MagickWriteImage magickwand (const c-string)))

;;(define magick-write-image-file
;;  (foreign-lambda bool MagickWriteImageFile
;;                  magickwand (c-pointer FILE)))

(define-magick-image-op (magick-write-images wand filename adjoin)
  (MagickWriteImages magickwand (const c-string) (const bool)))

;;(define magick-write-images-file
;;  (foreign-lambda bool MagickWriteImagesFile
;;                  magickwand (c-pointer FILE)))


;;;
;;; Pixel-iterator methods
;;;

(define pixel-iterator-clear
  (foreign-lambda void ClearPixelIterator pixeliterator))

(define pixel-iterator-clone
  (foreign-lambda pixeliterator ClonePixelIterator (const pixeliterator)))

(define pixel-iterator-destroy
  (foreign-lambda pixeliterator DestroyPixelIterator pixeliterator))

(define pixel-iterator?
  (foreign-lambda bool IsPixelIterator (const pixeliterator)))

;; NewPixelIterator may return NULL, in which case we should check for an
;; exception with MagickGetException
(define (make-pixel-iterator wand)
  (let ((iterator
         ((foreign-lambda pixeliterator NewPixelIterator magickwand)
          wand)))
    (set-finalizer! iterator pixel-iterator-destroy)
    iterator))

(define pixel-iterator-clear-exception
  (foreign-lambda bool PixelClearIteratorException pixeliterator))

(define make-pixel-region-iterator
  (foreign-lambda pixeliterator NewPixelRegionIterator
                  magickwand (const ssize_t) (const ssize_t)
                  (const size_t) (const size_t)))

(define pixel-iterator-get-current-row
  (foreign-lambda (c-pointer pixelwand) PixelGetCurrentIteratorRow
                  pixeliterator (c-pointer size_t)))

(define (pixel-iterator-get-exception iterator)
  (let-location ((typeout int))
    (let ((str ((foreign-lambda c-string PixelGetIteratorException
                                (const pixeliterator)
                                (c-pointer "ExceptionType"))
                iterator (location typeout))))
      (values str (int->exceptiontype typeout)))))

(define pixel-iterator-get-exception-type
  (foreign-lambda exceptiontype PixelGetIteratorExceptionType
                  (const pixeliterator)))

(define pixel-iterator-get-row
  (foreign-lambda bool PixelGetIteratorRow pixeliterator))

(define pixel-iterator-get-next-row
  (foreign-lambda (c-pointer pixelwand) PixelGetNextIteratorRow
                  pixeliterator (c-pointer size_t)))

(define pixel-iterator-get-previous-row
  (foreign-lambda (c-pointer pixelwand) PixelGetPreviousIteratorRow
                  pixeliterator (c-pointer size_t)))

(define pixel-iterator-reset
  (foreign-lambda void PixelResetIterator pixeliterator))

(define pixel-iterator-set-first-row
  (foreign-lambda void PixelSetFirstIteratorRow pixeliterator))

(define pixel-iterator-set-row
  (foreign-lambda bool PixelSetIteratorRow
                  pixeliterator (const ssize_t)))

(define pixel-iterator-set-last-row
  (foreign-lambda void PixelSetLastIteratorRow pixeliterator))

(define pixel-iterator-sync
  (foreign-lambda bool PixelSyncIterator pixeliterator))


;;;
;;; Pixelwand methods
;;;

(define (pixelwand-get-exception wand)
  (let-location ((typeout int))
    (let ((str ((foreign-lambda c-string PixelGetException
                                (const pixelwand)
                                (c-pointer "ExceptionType"))
                wand (location typeout))))
      (values str (int->exceptiontype typeout)))))

(define pixelwand-get-exception-type
  (foreign-lambda exceptiontype PixelGetExceptionType (const pixelwand)))

(define pixelwand-clear
  (foreign-lambda void ClearPixelWand pixelwand))

(define pixelwand-clone
  (foreign-lambda pixelwand ClonePixelWand (const pixelwand)))

(define clone-pixelwands
  (foreign-lambda (c-pointer pixelwand) ClonePixelWands
                  (const (c-pointer pixelwand)) (const size_t)))

(define destroy-pixelwands
  (foreign-lambda (c-pointer pixelwand) DestroyPixelWands
                  (c-pointer pixelwand) (const size_t)))

(define is-pixelwand-similar
  (foreign-lambda bool IsPixelWandSimilar
                  pixelwand pixelwand (const double)))

;; fuzz
;; hsl color, given by 3 doubles
;; colormap index
;; color by magickpixelpacket
(define make-pixelwand
  (match-lambda*
   (((? string? x))
    (let ((p (make-pixelwand)))
      (set! (pixelwand-color p) x)
      p))
   (()
    ((foreign-lambda pixelwand NewPixelWand)))))

(define new-pixelwands
  (foreign-lambda (c-pointer pixelwand) NewPixelWands (const size_t)))

(define pixel-clear-exception
  (foreign-lambda bool PixelClearException pixelwand))

(define pixelwand-alpha-set!
  (foreign-lambda void PixelSetAlpha pixelwand (const double)))

(define pixelwand-alpha
  (foreign-lambda double PixelGetAlpha (const pixelwand)))

(set! (setter pixelwand-alpha) pixelwand-alpha-set!)

;;(define pixelwand-alpha-quantum-set!
;;  (foreign-lambda void PixelSetAlphaQuantum pixelwand (const quantum)))

;;(define pixelwand-alpha-quantum
;;  (foreign-lambda quantum PixelGetAlphaQuantum (const pixelwand)))

;;(set! (setter pixelwand-alpha-quantum) pixelwand-alpha-quantum-set!)

(define pixelwand-black-set!
  (foreign-lambda void PixelSetBlack pixelwand (const double)))

(define pixelwand-black
  (foreign-lambda double PixelGetBlack (const pixelwand)))

(set! (setter pixelwand-black) pixelwand-black-set!)

;;(define pixelwand-black-quantum-set!
;;  (foreign-lambda void PixelSetBlackQuantum pixelwand (const quantum)))

;;(define pixelwand-black-quantum
;;  (foreign-lambda quantum PixelGetBlackQuantum (const pixelwand)))

;;(set! (setter pixelwand-black-quantum) pixelwand-black-quantum-set!)

(define pixelwand-blue-set!
  (foreign-lambda void PixelSetBlue pixelwand (const double)))

(define pixelwand-blue
  (foreign-lambda double PixelGetBlue (const pixelwand)))

(set! (setter pixelwand-blue) pixelwand-blue-set!)

;;(define pixelwand-blue-quantum-set!
;;  (foreign-lambda void PixelSetBlueQuantum pixelwand (const quantum)))

;;(define pixelwand-blue-quantum
;;  (foreign-lambda quantum PixelGetBlueQuantum (const pixelwand)))

;;(set! (setter pixelwand-blue-quantum) pixelwand-blue-quantum-set!)

(define pixelwand-color-set!
  (foreign-lambda bool PixelSetColor pixelwand (const c-string)))

(define pixelwand-color
  (foreign-lambda c-string PixelGetColorAsString pixelwand))

(set! (setter pixelwand-color) pixelwand-color-set!)

;;XXX: awkward name, probably means we need an abstraction with pixelwand-color-set!
(define pixelwand-color-from-wand-set!
  (foreign-lambda void PixelSetColorFromWand pixelwand (const pixelwand)))

(define pixelwand-color/normalized
  (foreign-lambda c-string PixelGetColorAsNormalizedString pixelwand))

(define pixelwand-color-count-set!
  (foreign-lambda void PixelSetColorCount pixelwand (const size_t)))

;; color-count is set by MagickGetImageHistogram
(define pixelwand-color-count
  (foreign-lambda size_t PixelGetColorCount (const pixelwand)))

(set! (setter pixelwand-color-count) pixelwand-color-count-set!)

(define pixelwand-cyan-set!
  (foreign-lambda void PixelSetCyan pixelwand (const double)))

(define pixelwand-cyan
  (foreign-lambda double PixelGetCyan (const pixelwand)))

(set! (setter pixelwand-cyan) pixelwand-cyan-set!)

;;(define pixelwand-cyan-quantum-set!
;;  (foreign-lambda void PixelSetCyanQuantum pixelwand (const quantum)))

;;(define pixelwand-cyan-quantum
;;  (foreign-lambda quantum PixelGetCyanQuantum (const pixelwand)))

;;(set! (setter pixelwand-cyan-quantum) pixelwand-cyan-quantum-set!)

(define pixelwand-fuzz-set!
  (foreign-lambda void PixelSetFuzz pixelwand (const double)))

(define pixelwand-fuzz
  (foreign-lambda double PixelGetFuzz (const pixelwand)))

(set! (setter pixelwand-fuzz) pixelwand-fuzz-set!)

(define pixelwand-green-set!
  (foreign-lambda void PixelSetGreen pixelwand (const double)))

(define pixelwand-green
  (foreign-lambda double PixelGetGreen (const pixelwand)))

(set! (setter pixelwand-green) pixelwand-green-set!)

;;(define pixelwand-green-quantum-set!
;;  (foreign-lambda void PixelSetGreenQuantum pixelwand (const quantum)))

;;(define pixelwand-green-quantum
;;  (foreign-lambda quantum PixelGetGreenQuantum (const pixelwand)))

;;(set! (setter pixelwand-green-quantum) pixelwand-green-quantum-set!)

;;XXX: will need an hsl-color object if want a generalized setter
(define pixelwand-hsl-set!
  (foreign-lambda void PixelSetHSL
                  pixelwand (const double) (const double) (const double)))

(define pixelwand-hsl
  (foreign-lambda void PixelGetHSL
                  (const pixelwand) (c-pointer double)
                  (c-pointer double) (c-pointer double)))

;;(define pixelwand-index-set!
;;  (foreign-lambda void PixelSetIndex pixelwand (const indexpacket)))

;;(define pixelwand-index
;;  (foreign-lambda indexpacket PixelGetIndex (c-pointer double)))

;;(set! (setter pixelwand-index) pixelwand-index-set!)

(define pixelwand-magenta-set!
  (foreign-lambda void PixelSetMagenta pixelwand (const double)))

(define pixelwand-magenta
  (foreign-lambda double PixelGetMagenta (const pixelwand)))

(set! (setter pixelwand-magenta) pixelwand-magenta-set!)

;;(define pixelwand-magenta-quantum-set!
;;  (foreign-lambda void PixelSetMagentaQuantum pixelwand (const quantum)))

;;(define pixelwand-magenta-quantum
;;  (foreign-lambda quantum PixelGetMagentaQuantum (const pixelwand)))

;;(set! (setter pixelwand-magenta-quantum) pixelwand-magenta-quantum-set!)

;; perhaps magickcolor should be grouped with the normal color
;; setter.. type dispatch
(define pixelwand-magick-color-set!
  (foreign-lambda void PixelSetMagickColor pixelwand (const magickpixelpacket)))

(define pixelwand-magick-color
  (foreign-lambda void PixelGetMagickColor
                  pixelwand magickpixelpacket))

(set! (setter pixelwand-magick-color) pixelwand-magick-color-set!)

(define pixelwand-opacity-set!
  (foreign-lambda void PixelSetOpacity pixelwand (const double)))

(define pixelwand-opacity
  (foreign-lambda double PixelGetOpacity (const pixelwand)))

(set! (setter pixelwand-opacity) pixelwand-opacity-set!)

;;(define pixelwand-opacity-quantum-set!
;;  (foreign-lambda void PixelSetOpacityQuantum pixelwand (const quantum)))

;;(define pixelwand-opacity-quantum
;;  (foreign-lambda quantum PixelGetOpacityQuantum (const pixelwand)))

;;(set! (setter pixelwand-opacity-quantum) pixelwand-opacity-quantum-set!)

;; (define pixelwand-quantum-color-set!
;;   (foreign-lambda void PixelSetQuantumColor pixelwand (const pixelpacket)))

;; (define pixelwand-quantum-color
;;   (foreign-lambda void PixelGetQuantumColor pixelwand pixelpacket))

;; (set! (setter pixelwand-quantum-color) pixelwand-quantum-color-set!)

(define pixelwand-red-set!
  (foreign-lambda void PixelSetRed pixelwand (const double)))

(define pixelwand-red
  (foreign-lambda double PixelGetRed (const pixelwand)))

(set! (setter pixelwand-red) pixelwand-red-set!)

;;(define pixelwand-red-quantum-set!
;;  (foreign-lambda void PixelSetRedQuantum pixelwand (const quantum)))

;;(define pixelwand-red-quantum
;;  (foreign-lambda quantum PixelGetRedQuantum (const pixelwand)))

;;(set! (setter pixelwand-red-quantum) pixelwand-red-quantum-set!)

(define pixelwand-yellow-set!
  (foreign-lambda void PixelSetYellow pixelwand (const double)))

(define pixelwand-yellow
  (foreign-lambda double PixelGetYellow (const pixelwand)))

(set! (setter pixelwand-yellow) pixelwand-yellow-set!)

;;(define pixelwand-yellow-quantum-set!
;;  (foreign-lambda void PixelSetYellowQuantum pixelwand (const quantum)))

;;(define pixelwand-yellow-quantum
;;  (foreign-lambda quantum PixelGetYellowQuantum (const pixelwand)))

;;(set! (setter pixelwand-yellow-quantum) pixelwand-yellow-quantum-set!)


;;;
;;; Drawingwand methods
;;;

(define (draw-get-exception wand)
  (let-location ((typeout int))
    (let ((str ((foreign-lambda c-string DrawGetException
                                (const drawingwand)
                                (c-pointer "ExceptionType"))
                wand (location typeout))))
      (values str (int->exceptiontype typeout)))))

(define draw-get-exception-type
  (foreign-lambda exceptiontype DrawGetExceptionType (const drawingwand)))

(define draw-clear-exception
  (foreign-lambda bool DrawClearException drawingwand))

(define drawingwand-clear
  (foreign-lambda void ClearDrawingWand drawingwand))

(define drawingwand-clone
  (foreign-lambda drawingwand CloneDrawingWand (const drawingwand)))

(define drawingwand-border-color-set!
  (foreign-lambda void DrawSetBorderColor
                   drawingwand (const pixelwand)))

(define drawingwand-border-color
  (getter-with-setter
   (lambda (wand)
     (let ((p (make-pixelwand)))
       ((foreign-lambda void DrawGetBorderColor
                        (const drawingwand) pixelwand)
        wand p)
       p))
   drawingwand-border-color-set!))

(define drawingwand-clip-path-set!
  (foreign-lambda bool DrawSetClipPath drawingwand (const c-string)))

(define drawingwand-clip-path
  (getter-with-setter
   (foreign-lambda c-string DrawGetClipPath (const drawingwand))
   drawingwand-clip-path-set!))

(define drawingwand-clip-rule-set!
  (foreign-lambda void DrawSetClipRule drawingwand (const fillrule)))

(define drawingwand-clip-rule
  (getter-with-setter
   (foreign-lambda fillrule DrawGetClipRule (const drawingwand))
   drawingwand-clip-rule-set!))

(define drawingwand-clip-units-set!
  (foreign-lambda void DrawSetClipUnits drawingwand (const clippathunits)))

(define drawingwand-clip-units
  (getter-with-setter
   (foreign-lambda clippathunits DrawGetClipUnits (const drawingwand))
   drawingwand-clip-units-set!))

(define drawingwand-fill-color-set!
  (foreign-lambda void DrawSetFillColor drawingwand (const pixelwand)))

(define drawingwand-fill-color
  (getter-with-setter
   (lambda (wand)
     (let ((p (make-pixelwand)))
       ((foreign-lambda void DrawGetFillColor (const drawingwand) pixelwand)
        wand p)
       p))
   drawingwand-fill-color-set!))

(define drawingwand-fill-opacity-set!
  (foreign-lambda void DrawSetFillOpacity drawingwand (const double)))

(define drawingwand-fill-opacity
  (getter-with-setter
   (foreign-lambda double DrawGetFillOpacity (const drawingwand))
   drawingwand-fill-opacity-set!))

(define drawingwand-fill-rule-set!
  (foreign-lambda void DrawSetFillRule drawingwand (const fillrule)))

(define drawingwand-fill-rule
  (getter-with-setter
   (foreign-lambda fillrule DrawGetFillRule (const drawingwand))
   drawingwand-fill-rule-set!))

(define drawingwand-font-set!
  (foreign-lambda bool DrawSetFont drawingwand (const c-string)))

(define drawingwand-font
  (getter-with-setter
   (foreign-lambda c-string DrawGetFont (const drawingwand))
   drawingwand-font-set!))

(define drawingwand-font-family-set!
  (foreign-lambda bool DrawSetFontFamily drawingwand (const c-string)))

(define drawingwand-font-family
  (getter-with-setter
   (foreign-lambda c-string DrawGetFontFamily (const drawingwand))
   drawingwand-font-family-set!))

;;XXX: two numbers for resolution... give as list?
;; (define %drawingwand-font-resolution-set!
;;   (foreign-lambda bool DrawSetFontResolution
;;                   drawingwand (const double) (const double)))

;; (define %drawingwand-font-resolution
;;   (foreign-lambda bool DrawGetFontResolution
;;                   (const drawingwand) (c-pointer double) (c-pointer double)))

;; (define drawingwand-font-resolution
;;   (getter-with-setter %drawingwand-font-resolution
;;                       %drawingwand-font-resolution-set!))

(define drawingwand-font-size-set!
  (foreign-lambda void DrawSetFontSize drawingwand (const double)))

(define drawingwand-font-size
  (getter-with-setter
   (foreign-lambda double DrawGetFontSize (const drawingwand))
   drawingwand-font-size-set!))

(define drawingwand-font-stretch-set!
  (foreign-lambda void DrawSetFontStretch drawingwand (const stretchtype)))

(define drawingwand-font-stretch
  (getter-with-setter
   (foreign-lambda stretchtype DrawGetFontStretch (const drawingwand))
   drawingwand-font-stretch-set!))

(define drawingwand-font-style-set!
  (foreign-lambda void DrawSetFontStyle drawingwand (const styletype)))

(define drawingwand-font-style
  (getter-with-setter
   (foreign-lambda styletype DrawGetFontStyle (const drawingwand))
   drawingwand-font-style-set!))

(define drawingwand-font-weight-set!
  (foreign-lambda void DrawSetFontWeight drawingwand (const size_t)))

(define drawingwand-font-weight
  (getter-with-setter
   (foreign-lambda size_t DrawGetFontWeight (const drawingwand))
   drawingwand-font-weight-set!))

(define drawingwand-gravity-set!
  (foreign-lambda void DrawSetGravity drawingwand (const gravity)))

(define drawingwand-gravity
  (getter-with-setter
   (foreign-lambda gravity DrawGetGravity (const drawingwand))
   drawingwand-gravity-set!))

(define drawingwand-opacity-set!
  (foreign-lambda void DrawSetOpacity drawingwand (const double)))

(define drawingwand-opacity
  (getter-with-setter
   (foreign-lambda double DrawGetOpacity (const drawingwand))
   drawingwand-opacity-set!))

(define drawingwand-stroke-antialias-set!
  (foreign-lambda void DrawSetStrokeAntialias drawingwand (const bool)))

(define drawingwand-stroke-antialias
  (getter-with-setter
   (foreign-lambda bool DrawGetStrokeAntialias (const drawingwand))
   drawingwand-stroke-antialias-set!))

(define drawingwand-stroke-color-set!
  (foreign-lambda void DrawSetStrokeColor drawingwand (const pixelwand)))

(define drawingwand-stroke-color
  (getter-with-setter
   (lambda (wand)
     (let ((p (make-pixelwand)))
       ((foreign-lambda void DrawGetStrokeColor (const drawingwand) pixelwand)
        wand p)
       p))
   drawingwand-stroke-color-set!))

(define drawingwand-stroke-dash-array-set!
  (lambda (wand dash-array)
     ((foreign-lambda bool DrawSetStrokeDashArray
                      drawingwand (const size_t)
                      (const f64vector))
      wand (length dash-array) (list->f64vector dash-array))))

(define drawingwand-stroke-dash-array
  (getter-with-setter
   (lambda (wand)
     (let-location ((n size_t))
       (let* ((p ((foreign-lambda (c-pointer double) DrawGetStrokeDashArray
                                  (const drawingwand) (c-pointer size_t))
                  wand (location n)))
              (result (make-f64vector n)))
         ((foreign-lambda* void (((c-pointer double) fro) (f64vector to) (size_t len))
            "size_t i;"
            "for (i = 0; i < len; ++i) {"
            "    to[i] = fro[i];"
            "}")
          p result n)
         (f64vector->list result))))
   drawingwand-stroke-dash-array-set!))

(define drawingwand-stroke-dash-offset-set!
  (foreign-lambda void DrawSetStrokeDashOffset drawingwand (const double)))

(define drawingwand-stroke-dash-offset
  (getter-with-setter
   (foreign-lambda double DrawGetStrokeDashOffset (const drawingwand))
   drawingwand-stroke-dash-offset-set!))

(define drawingwand-stroke-line-cap-set!
  (foreign-lambda void DrawSetStrokeLineCap drawingwand (const linecap)))

(define drawingwand-stroke-line-cap
  (getter-with-setter
   (foreign-lambda linecap DrawGetStrokeLineCap (const drawingwand))
   drawingwand-stroke-line-cap-set!))

(define drawingwand-stroke-line-join-set!
  (foreign-lambda void DrawSetStrokeLineJoin drawingwand (const linejoin)))

(define drawingwand-stroke-line-join
  (getter-with-setter
   (foreign-lambda linejoin DrawGetStrokeLineJoin (const drawingwand))
   drawingwand-stroke-line-join-set!))

(define drawingwand-stroke-miter-limit-set!
  (foreign-lambda void DrawSetStrokeMiterLimit drawingwand (const size_t)))

(define drawingwand-stroke-miter-limit
  (getter-with-setter
   (foreign-lambda size_t DrawGetStrokeMiterLimit (const drawingwand))
   drawingwand-stroke-miter-limit-set!))

(define drawingwand-stroke-opacity-set!
  (foreign-lambda void DrawSetStrokeOpacity drawingwand (const double)))

(define drawingwand-stroke-opacity
  (getter-with-setter
   (foreign-lambda double DrawGetStrokeOpacity (const drawingwand))
   drawingwand-stroke-opacity-set!))

(define drawingwand-stroke-width-set!
  (foreign-lambda void DrawSetStrokeWidth drawingwand (const double)))

(define drawingwand-stroke-width
  (getter-with-setter
   (foreign-lambda double DrawGetStrokeWidth (const drawingwand))
   drawingwand-stroke-width-set!))

(define drawingwand-text-alignment-set!
  (foreign-lambda void DrawSetTextAlignment drawingwand (const aligntype)))

(define drawingwand-text-alignment
  (getter-with-setter
   (foreign-lambda aligntype DrawGetTextAlignment (const drawingwand))
   drawingwand-text-alignment-set!))

(define drawingwand-text-antialias-set!
  (foreign-lambda void DrawSetTextAntialias drawingwand (const bool)))

(define drawingwand-text-antialias
  (getter-with-setter
   (foreign-lambda bool DrawGetTextAntialias (const drawingwand))
   drawingwand-text-antialias-set!))

(define drawingwand-text-decoration-set!
  (foreign-lambda void DrawSetTextDecoration drawingwand (const decorationtype)))

(define drawingwand-text-decoration
  (getter-with-setter
   (foreign-lambda decorationtype DrawGetTextDecoration (const drawingwand))
   drawingwand-text-decoration-set!))

(define drawingwand-text-encoding-set!
  (foreign-lambda void DrawSetTextEncoding drawingwand (const c-string)))

(define drawingwand-text-encoding
  (getter-with-setter
   (foreign-lambda c-string DrawGetTextEncoding (const drawingwand))
   drawingwand-text-encoding-set!))

(define drawingwand-text-kerning-set!
  (foreign-lambda void DrawSetTextKerning drawingwand (const double)))

(define drawingwand-text-kerning
  (getter-with-setter
   (foreign-lambda double DrawGetTextKerning drawingwand)
   drawingwand-text-kerning-set!))

(define drawingwand-text-interline-spacing-set!
  (foreign-lambda void DrawSetTextInterlineSpacing drawingwand (const double)))

(define drawingwand-text-interline-spacing
  (getter-with-setter
   (foreign-lambda double DrawGetTextInterlineSpacing drawingwand)
   drawingwand-text-interline-spacing-set!))

(define drawingwand-text-interword-spacing-set!
  (foreign-lambda void DrawSetTextInterwordSpacing drawingwand (const double)))

(define drawingwand-text-interword-spacing
  (getter-with-setter
   (foreign-lambda double DrawGetTextInterwordSpacing drawingwand)
   drawingwand-text-interword-spacing-set!))

(define drawingwand-vector-graphics-set!
  (foreign-lambda bool DrawSetVectorGraphics drawingwand (const c-string)))

(define drawingwand-vector-graphics
  (getter-with-setter
   (foreign-lambda c-string DrawGetVectorGraphics drawingwand)
   drawingwand-vector-graphics-set!))

(define drawingwand-text-under-color-set!
  (foreign-lambda void DrawSetTextUnderColor drawingwand (const pixelwand)))

(define drawingwand-text-under-color
  (getter-with-setter
   (lambda (wand)
     (let ((p (make-pixelwand)))
       ((foreign-lambda void DrawGetTextUnderColor (const drawingwand) pixelwand)
        wand p)
       p))
   drawingwand-text-under-color-set!))

(define draw-affine
  (foreign-lambda void DrawAffine drawingwand (const affinematrix)))

(define draw-annotation
  (foreign-lambda void DrawAnnotation
                  drawingwand (const double) (const double)
                  (const unsigned-c-string)))

(define draw-arc
  (foreign-lambda void DrawArc
                  drawingwand (const double) (const double)
                  (const double) (const double)
                  (const double) (const double)))

(define draw-bezier
  (foreign-lambda void DrawBezier
                  drawingwand (const size_t) (const pointinfo)))

(define draw-circle
  (foreign-lambda void DrawCircle
                  drawingwand (const double) (const double)
                  (const double) (const double)))

(define draw-composite
  (foreign-lambda bool DrawComposite
                  drawingwand (const compositeoperator)
                  (const double) (const double)
                  (const double) (const double)
                  magickwand))

(define draw-color
  (foreign-lambda void DrawColor
                  drawingwand (const double)
                  (const double) (const paintmethod)))

(define draw-comment
  (foreign-lambda void DrawComment drawingwand (const c-string)))

(define draw-ellipse
  (foreign-lambda void DrawEllipse
                  drawingwand (const double) (const double)
                  (const double) (const double)
                  (const double) (const double)))

(define draw-line
  (foreign-lambda void DrawLine
                  drawingwand (const double) (const double)
                  (const double) (const double)))

(define draw-matte
  (foreign-lambda void DrawMatte
                  drawingwand (const double) (const double)
                  (const paintmethod)))

(define draw-path-close
  (foreign-lambda void DrawPathClose drawingwand))

(define draw-path-curve-to-absolute
  (foreign-lambda void DrawPathCurveToAbsolute
                  drawingwand (const double) (const double)
                  (const double) (const double)
                  (const double) (const double)))

(define draw-path-curve-to-relative
  (foreign-lambda void DrawPathCurveToRelative
                  drawingwand (const double) (const double)
                  (const double) (const double)
                  (const double) (const double)))

(define draw-path-curve-to-quadratic-bezier-absolute
  (foreign-lambda void DrawPathCurveToQuadraticBezierAbsolute
                  drawingwand (const double) (const double)
                  (const double) (const double)))

(define draw-path-curve-to-quadratic-bezier-relative
  (foreign-lambda void DrawPathCurveToQuadraticBezierRelative
                  drawingwand (const double) (const double)
                  (const double) (const double)))

(define draw-path-curve-to-quadratic-bezier-smooth-absolute
  (foreign-lambda void DrawPathCurveToQuadraticBezierSmoothAbsolute
                  drawingwand (const double) (const double)))

(define draw-path-curve-to-quadratic-bezier-smooth-relative
  (foreign-lambda void DrawPathCurveToQuadraticBezierSmoothRelative
                  drawingwand (const double) (const double)))

(define draw-path-curve-to-smooth-absolute
  (foreign-lambda void DrawPathCurveToSmoothAbsolute
                  drawingwand (const double) (const double)
                  (const double) (const double)))

(define draw-path-curve-to-smooth-relative
  (foreign-lambda void DrawPathCurveToSmoothRelative
                  drawingwand (const double) (const double)
                  (const double) (const double)))

(define draw-path-elliptic-arc-absolute
  (foreign-lambda void DrawPathEllipticArcAbsolute
                  drawingwand (const double) (const double) (const double)
                  (const bool) (const bool)
                  (const double)  (const double)))

(define draw-path-elliptic-arc-relative
  (foreign-lambda void DrawPathEllipticArcRelative
                  drawingwand (const double) (const double) (const double)
                  (const bool) (const bool)
                  (const double)  (const double)))

(define draw-path-finish
  (foreign-lambda void DrawPathFinish drawingwand))

(define draw-path-line-to-absolute
  (foreign-lambda void DrawPathLineToAbsolute
                  drawingwand (const double) (const double)))

(define draw-path-line-to-relative
  (foreign-lambda void DrawPathLineToRelative
                  drawingwand (const double) (const double)))

(define draw-path-line-to-horizontal-absolute
  (foreign-lambda void DrawPathLineToHorizontalAbsolute
                  drawingwand (const double)))

(define draw-path-line-to-horizontal-relative
  (foreign-lambda void DrawPathLineToHorizontalRelative
                  drawingwand (const double)))

(define draw-path-line-to-vertical-absolute
  (foreign-lambda void DrawPathLineToVerticalAbsolute
                  drawingwand (const double)))

(define draw-path-line-to-vertical-relative
  (foreign-lambda void DrawPathLineToVerticalRelative
                  drawingwand (const double)))

(define draw-path-move-to-absolute
  (foreign-lambda void DrawPathMoveToAbsolute
                  drawingwand (const double) (const double)))

(define draw-path-move-to-relative
  (foreign-lambda void DrawPathMoveToRelative
                  drawingwand (const double) (const double)))

(define draw-path-start
  (foreign-lambda void DrawPathStart drawingwand))

(define draw-point
  (foreign-lambda void DrawPoint
                  drawingwand (const double) (const double)))

(define draw-polygon
  (foreign-lambda void DrawPolygon
                  drawingwand (const size_t) (const pointinfo)))

(define draw-polyline
  (foreign-lambda void DrawPolyline
                  drawingwand (const size_t) (const pointinfo)))

(define draw-pop-clip-path
  (foreign-lambda void DrawPopClipPath drawingwand))

(define draw-pop-defs
  (foreign-lambda void DrawPopDefs drawingwand))

(define draw-pop-pattern
  (foreign-lambda bool DrawPopPattern drawingwand))

(define draw-push-clip-path
  (foreign-lambda void DrawPushClipPath drawingwand (const c-string)))

(define draw-push-defs
  (foreign-lambda void DrawPushDefs drawingwand))

(define draw-push-pattern
  (foreign-lambda bool DrawPushPattern
                  drawingwand (const c-string)
                  (const double) (const double)
                  (const double) (const double)))

(define draw-rectangle
  (foreign-lambda void DrawRectangle
                  drawingwand (const double) (const double)
                  (const double) (const double)))

(define draw-reset-vector-graphics
  (foreign-lambda void DrawResetVectorGraphics drawingwand))

(define draw-rotate
  (foreign-lambda void DrawRotate drawingwand (const double)))

(define draw-round-rectangle
  (foreign-lambda void DrawRoundRectangle
                  drawingwand double double
                  double double double double))

(define draw-scale
  (foreign-lambda void DrawScale
                  drawingwand (const double) (const double)))

(define draw-set-fill-pattern-url
  (foreign-lambda bool DrawSetFillPatternURL
                  drawingwand (const c-string)))

(define draw-set-stroke-pattern-url
  (foreign-lambda bool DrawSetStrokePatternURL
                  drawingwand (const c-string)))

(define draw-skew-x
  (foreign-lambda void DrawSkewX drawingwand (const double)))

(define draw-skew-y
  (foreign-lambda void DrawSkewY drawingwand (const double)))

(define draw-translate
  (foreign-lambda void DrawTranslate
                  drawingwand (const double) (const double)))

(define draw-set-viewbox
  (foreign-lambda void DrawSetViewbox
                  drawingwand ssize_t ssize_t ssize_t ssize_t))

(define make-drawingwand
  (foreign-lambda drawingwand NewDrawingWand))

(define peek-drawingwand
  (foreign-lambda drawinfo PeekDrawingWand (const drawingwand)))

(define pop-drawingwand
  (foreign-lambda bool PopDrawingWand drawingwand))

(define push-drawingwand
  (foreign-lambda bool PushDrawingWand drawingwand))


;;;
;;; Command-line methods
;;;

;;(define magick-command-genesis
;;  (foreign-lambda bool MagickCommandGenesis
;;                  imageinfo                   ;; *image_info
;;                  magickcommand               ;; command
;;                  int                         ;; argc
;;                  (c-pointer c-string)        ;; argv
;;                  (c-pointer c-string)        ;; metadata
;;                  (c-pointer exceptioninfo))) ;; exception


;;;
;;; Wand-view methods
;;;

(define clone-wand-view
  (foreign-lambda wandview CloneWandView (const wandview)))

(define destroy-wand-view
  (foreign-lambda wandview DestroyWandView wandview))

;;(define duplex-transfer-wand-view-iterator
;;  (foreign-lambda bool DuplexTransferWandViewIterator
;;                  wandview wandview wandview
;;                  duplextransferwandviewmethod
;;                  c-pointer))

(define (get-wand-view-exception wv)
  (let-location ((typeout int))
    (let ((str ((foreign-lambda c-string GetWandViewException
                                (const wandview)
                                (c-pointer "ExceptionType"))
                wv (location typeout))))
      (values str (int->exceptiontype typeout)))))

(define get-wand-view-extent
  (foreign-lambda* rectangleinfo (((const wandview) w))
    "RectangleInfo r = GetWandViewExtent(w);"
    "C_return(&r);"))

;;(define get-wand-view-iterator
;;  (foreign-lambda bool GetWandViewIterator
;;                  wandview getwandviewmethod c-pointer))

(define get-wand-view-pixels
  (foreign-lambda pixelwand GetWandViewPixels (const wandview)))

(define get-wand-view-wand
  (foreign-lambda magickwand GetWandViewWand (const wandview)))

(define wand-view?
  (foreign-lambda bool IsWandView (const wandview)))

;; NewWandView may return NULL, in which case we check for an exception
;; with ThrowWandException
(define new-wand-view
  (foreign-lambda wandview NewWandView magickwand))

(define new-wand-view-extent
  (foreign-lambda wandview NewWandViewExtent
                  magickwand (const ssize_t) (const ssize_t)
                  (const size_t) (const size_t)))

(define set-wand-view-description
  (foreign-lambda void SetWandViewDescription
                  wandview (const c-string)))

;;(define set-wand-view-iterator
;;  (foreign-lambda bool SetWandViewIterator
;;                  wandview setwandviewmethod c-pointer))

(define set-wand-view-threads
  (foreign-lambda void SetWandViewThreads
                  wandview (const size_t)))

;;(define transfer-wand-view-iterator
;;  (foreign-lambda bool TransferWandViewIterator
;;                  wandview wandview
;;                  transferwandviewmethod
;;                  c-pointer))

;; MagickGetException on false
;;(define update-wand-view-iterator
;;  (foreign-lambda bool UpdateWandViewIterator
;;                  wandview updatewandviewmethod c-pointer))


;;;
;;; Init
;;;

(magickwand-genesis)

(on-exit magickwand-terminus)
