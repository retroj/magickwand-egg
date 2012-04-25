;; Copyright 2012 John J Foerch. All rights reserved.
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

(module magickwand
        *

(import chicken scheme foreign foreigners)

(foreign-declare "#include <wand/MagickWand.h>")

(define-foreign-type ssize_t long)

(define-foreign-enum-type (magickboolean (enum MagickBooleanType))
  (magickboolean->int int->magickboolean)
  ((magickfalse) MagickFalse #f)
  ((magicktrue) MagickTrue #t))

(define-foreign-enum-type (exceptiontype (enum ExceptionType))
  (exceptiontype->int int->exceptiontype)
  ((UndefinedException) UndefinedException)
  ((WarningException) WarningException)
  ((ResourceLimitWarning) ResourceLimitWarning)
  ((TypeWarning) TypeWarning)
  ((OptionWarning) OptionWarning)
  ((DelegateWarning) DelegateWarning)
  ((MissingDelegateWarning) MissingDelegateWarning)
  ((CorruptImageWarning) CorruptImageWarning)
  ((FileOpenWarning) FileOpenWarning)
  ((BlobWarning) BlobWarning)
  ((StreamWarning) StreamWarning)
  ((CacheWarning) CacheWarning)
  ((CoderWarning) CoderWarning)
  ((FilterWarning) FilterWarning)
  ((ModuleWarning) ModuleWarning)
  ((DrawWarning) DrawWarning)
  ((ImageWarning) ImageWarning)
  ((WandWarning) WandWarning)
  ((RandomWarning) RandomWarning)
  ((XServerWarning) XServerWarning)
  ((MonitorWarning) MonitorWarning)
  ((RegistryWarning) RegistryWarning)
  ((ConfigureWarning) ConfigureWarning)
  ((PolicyWarning) PolicyWarning)
  ((ErrorException) ErrorException)
  ((ResourceLimitError) ResourceLimitError)
  ((TypeError) TypeError)
  ((OptionError) OptionError)
  ((DelegateError) DelegateError)
  ((MissingDelegateError) MissingDelegateError)
  ((CorruptImageError) CorruptImageError)
  ((FileOpenError) FileOpenError)
  ((BlobError) BlobError)
  ((StreamError) StreamError)
  ((CacheError) CacheError)
  ((CoderError) CoderError)
  ((FilterError) FilterError)
  ((ModuleError) ModuleError)
  ((DrawError) DrawError)
  ((ImageError) ImageError)
  ((WandError) WandError)
  ((RandomError) RandomError)
  ((XServerError) XServerError)
  ((MonitorError) MonitorError)
  ((RegistryError) RegistryError)
  ((ConfigureError) ConfigureError)
  ((PolicyError) PolicyError)
  ((FatalErrorException) FatalErrorException)
  ((ResourceLimitFatalError) ResourceLimitFatalError)
  ((TypeFatalError) TypeFatalError)
  ((OptionFatalError) OptionFatalError)
  ((DelegateFatalError) DelegateFatalError)
  ((MissingDelegateFatalError) MissingDelegateFatalError)
  ((CorruptImageFatalError) CorruptImageFatalError)
  ((FileOpenFatalError) FileOpenFatalError)
  ((BlobFatalError) BlobFatalError)
  ((StreamFatalError) StreamFatalError)
  ((CacheFatalError) CacheFatalError)
  ((CoderFatalError) CoderFatalError)
  ((FilterFatalError) FilterFatalError)
  ((ModuleFatalError) ModuleFatalError)
  ((DrawFatalError) DrawFatalError)
  ((ImageFatalError) ImageFatalError)
  ((WandFatalError) WandFatalError)
  ((RandomFatalError) RandomFatalError)
  ((XServerFatalError) XServerFatalError)
  ((MonitorFatalError) MonitorFatalError)
  ((RegistryFatalError) RegistryFatalError)
  ((ConfigureFatalError) ConfigureFatalError)
  ((PolicyFatalError) PolicyFatalError))

(define-foreign-enum-type (colorspace (enum ColorspaceType))
  (colorspace->int int->colorspace)
  ((UndefinedColorspace) UndefinedColorspace)
  ((RGBColorspace) RGBColorspace)
  ((GRAYColorspace) GRAYColorspace)
  ((TransparentColorspace) TransparentColorspace)
  ((OHTAColorspace) OHTAColorspace)
  ((LabColorspace) LabColorspace)
  ((XYZColorspace) XYZColorspace)
  ((YCbCrColorspace) YCbCrColorspace)
  ((YCCColorspace) YCCColorspace)
  ((YIQColorspace) YIQColorspace)
  ((YPbPrColorspace) YPbPrColorspace)
  ((YUVColorspace) YUVColorspace)
  ((CMYKColorspace) CMYKColorspace)
  ((sRGBColorspace) sRGBColorspace)
  ((HSBColorspace) HSBColorspace)
  ((HSLColorspace) HSLColorspace)
  ((HWBColorspace) HWBColorspace)
  ((Rec601LumaColorspace) Rec601LumaColorspace)
  ((Rec601YCbCrColorspace) Rec601YCbCrColorspace)
  ((Rec709LumaColorspace) Rec709LumaColorspace)
  ((Rec709YCbCrColorspace) Rec709YCbCrColorspace)
  ((LogColorspace) LogColorspace)
  ((CMYColorspace) CMYColorspace))

(define-foreign-enum-type (compressiontype (enum CompressionType))
  (compressiontype->int int->compressiontype)
  ((UndefinedCompression) UndefinedCompression)
  ((NoCompression) NoCompression)
  ((BZipCompression) BZipCompression)
  ((DXT1Compression) DXT1Compression)
  ((DXT3Compression) DXT3Compression)
  ((DXT5Compression) DXT5Compression)
  ((FaxCompression) FaxCompression)
  ((Group4Compression) Group4Compression)
  ((JPEGCompression) JPEGCompression)
  ((JPEG2000Compression) JPEG2000Compression)
  ((LosslessJPEGCompression) LosslessJPEGCompression)
  ((LZWCompression) LZWCompression)
  ((RLECompression) RLECompression)
  ((ZipCompression) ZipCompression)
  ((ZipSCompression) ZipSCompression)
  ((PizCompression) PizCompression)
  ((Pxr24Compression) Pxr24Compression)
  ((B44Compression) B44Compression)
  ((B44ACompression) B44ACompression)
  ((LZMACompression) LZMACompression)
  ((JBIG1Compression) JBIG1Compression)
  ((JBIG2Compression) JBIG2Compression))

(define-foreign-enum-type (gravity (enum GravityType))
  (gravity->int int->gravity)
  ((UndefinedGravity) UndefinedGravity)
  ((ForgetGravity) ForgetGravity)
  ((NorthWestGravity) NorthWestGravity)
  ((NorthGravity) NorthGravity)
  ((NorthEastGravity) NorthEastGravity)
  ((WestGravity) WestGravity)
  ((CenterGravity) CenterGravity)
  ((EastGravity) EastGravity)
  ((SouthWestGravity) SouthWestGravity)
  ((SouthGravity) SouthGravity)
  ((SouthEastGravity) SouthEastGravity)
  ((StaticGravity) StaticGravity))

(define-foreign-enum-type (interlacetype (enum InterlaceType))
  (interlacetype->int int->interlacetype)
  ((UndefinedInterlace) UndefinedInterlace)
  ((NoInterlace) NoInterlace)
  ((LineInterlace) LineInterlace)
  ((PlaneInterlace) PlaneInterlace)
  ((PartitionInterlace) PartitionInterlace)
  ((GIFInterlace) GIFInterlace)
  ((JPEGInterlace) JPEGInterlace)
  ((PNGInterlace) PNGInterlace))

(define-foreign-enum-type (interpolatepixelmethod (enum InterpolatePixelMethod))
  (interpolatepixelmethod->int int->interpolatepixelmethod)
  ((UndefinedInterpolatePixel) UndefinedInterpolatePixel)
  ((AverageInterpolatePixel) AverageInterpolatePixel)
  ((BicubicInterpolatePixel) BicubicInterpolatePixel)
  ((BilinearInterpolatePixel) BilinearInterpolatePixel)
  ((FilterInterpolatePixel) FilterInterpolatePixel)
  ((IntegerInterpolatePixel) IntegerInterpolatePixel)
  ((MeshInterpolatePixel) MeshInterpolatePixel)
  ((NearestNeighborInterpolatePixel) NearestNeighborInterpolatePixel)
  ((SplineInterpolatePixel) SplineInterpolatePixel))

(define-foreign-enum-type (orientation (enum OrientationType))
  (orientation->int int->orientation)
  ((UndefinedOrientation) UndefinedOrientation)
  ((TopLeftOrientation) TopLeftOrientation)
  ((TopRightOrientation) TopRightOrientation)
  ((BottomRightOrientation) BottomRightOrientation)
  ((BottomLeftOrientation) BottomLeftOrientation)
  ((LeftTopOrientation) LeftTopOrientation)
  ((RightTopOrientation) RightTopOrientation)
  ((RightBottomOrientation) RightBottomOrientation)
  ((LeftBottomOrientation) LeftBottomOrientation))

(define-foreign-type magicksize unsigned-long)

(define-foreign-enum-type (resourcetype (enum ResourceType))
  (resourcetype->int int->resourcetype)
  ((UndefinedResource) UndefinedResource)
  ((AreaResource) AreaResource)
  ((DiskResource) DiskResource)
  ((FileResource) FileResource)
  ((MapResource) MapResource)
  ((MemoryResource) MemoryResource)
  ((ThreadResource) ThreadResource)
  ((TimeResource) TimeResource)
  ((ThrottleResource) ThrottleResource))

(define-foreign-enum-type (imagetype (enum ImageType))
  (imagetype->int int->imagetype)
  ((UndefinedType) UndefinedType)
  ((BilevelType) BilevelType)
  ((GrayscaleType) GrayscaleType)
  ((GrayscaleMatteType) GrayscaleMatteType)
  ((PaletteType) PaletteType)
  ((PaletteMatteType) PaletteMatteType)
  ((TrueColorType) TrueColorType)
  ((TrueColorMatteType) TrueColorMatteType)
  ((ColorSeparationType) ColorSeparationType)
  ((ColorSeparationMatteType) ColorSeparationMatteType)
  ((OptimizeType) OptimizeType)
  ((PaletteBilevelMatteType) PaletteBilevelMatteType))

(define-foreign-enum-type (channeltype (enum ChannelType))
  (channeltype->int int->channeltype)
  ((UndefinedChannel) UndefinedChannel)
  ((RedChannel) RedChannel)
  ((GrayChannel) GrayChannel)
  ((CyanChannel) CyanChannel)
  ((GreenChannel) GreenChannel)
  ((MagentaChannel) MagentaChannel)
  ((BlueChannel) BlueChannel)
  ((YellowChannel) YellowChannel)
  ((AlphaChannel) AlphaChannel)
  ((OpacityChannel) OpacityChannel)
  ((MatteChannel) MatteChannel)
  ((BlackChannel) BlackChannel)
  ((IndexChannel) IndexChannel)
  ((CompositeChannels) CompositeChannels)
  ((AllChannels) AllChannels)
  ((TrueAlphaChannel) TrueAlphaChannel)
  ((RGBChannels) RGBChannels)
  ((GrayChannels) GrayChannels)
  ((SyncChannels) SyncChannels)
  ((DefaultChannels) DefaultChannels))

(define-foreign-enum-type (noisetype (enum NoiseType))
  (noisetype->int int->noisetype)
  ((UndefinedNoise) UndefinedNoise)
  ((UniformNoise) UniformNoise)
  ((GaussianNoise) GaussianNoise)
  ((MultiplicativeGaussianNoise) MultiplicativeGaussianNoise)
  ((ImpulseNoise) ImpulseNoise)
  ((LaplacianNoise) LaplacianNoise)
  ((PoissonNoise) PoissonNoise)
  ((RandomNoise) RandomNoise))

(define-foreign-enum-type (kernelinfotype (enum KernelInfoType))
  (kernelinfotype->int int->kernelinfotype)
  ((UndefinedKernel) UndefinedKernel)
  ((UnityKernel) UnityKernel)
  ((GaussianKernel) GaussianKernel)
  ((DoGKernel) DoGKernel)
  ((LoGKernel) LoGKernel)
  ((BlurKernel) BlurKernel)
  ((CometKernel) CometKernel)
  ((LaplacianKernel) LaplacianKernel)
  ((SobelKernel) SobelKernel)
  ((FreiChenKernel) FreiChenKernel)
  ((RobertsKernel) RobertsKernel)
  ((PrewittKernel) PrewittKernel)
  ((CompassKernel) CompassKernel)
  ((KirschKernel) KirschKernel)
  ((DiamondKernel) DiamondKernel)
  ((SquareKernel) SquareKernel)
  ((RectangleKernel) RectangleKernel)
  ((OctagonKernel) OctagonKernel)
  ((DiskKernel) DiskKernel)
  ((PlusKernel) PlusKernel)
  ((CrossKernel) CrossKernel)
  ((RingKernel) RingKernel)
  ((PeaksKernel) PeaksKernel)
  ((EdgesKernel) EdgesKernel)
  ((CornersKernel) CornersKernel)
  ((DiagonalsKernel) DiagonalsKernel)
  ((LineEndsKernel) LineEndsKernel)
  ((LineJunctionsKernel) LineJunctionsKernel)
  ((RidgesKernel) RidgesKernel)
  ((ConvexHullKernel) ConvexHullKernel)
  ((ThinSEKernel) ThinSEKernel)
  ((SkeletonKernel) SkeletonKernel)
  ((ChebyshevKernel) ChebyshevKernel)
  ((ManhattanKernel) ManhattanKernel)
  ((OctagonalKernel) OctagonalKernel)
  ((EuclideanKernel) EuclideanKernel)
  ((UserDefinedKernel) UserDefinedKernel))

(define-foreign-enum-type (metrictype (enum MetricType))
  (metrictype->int int->metrictype)
  ((UndefinedMetric) UndefinedMetric)
  ((AbsoluteErrorMetric) AbsoluteErrorMetric)
  ((MeanAbsoluteErrorMetric) MeanAbsoluteErrorMetric)
  ((MeanErrorPerPixelMetric) MeanErrorPerPixelMetric)
  ((MeanSquaredErrorMetric) MeanSquaredErrorMetric)
  ((PeakAbsoluteErrorMetric) PeakAbsoluteErrorMetric)
  ((PeakSignalToNoiseRatioMetric) PeakSignalToNoiseRatioMetric)
  ((RootMeanSquaredErrorMetric) RootMeanSquaredErrorMetric)
  ((NormalizedCrossCorrelationErrorMetric) NormalizedCrossCorrelationErrorMetric)
  ((FuzzErrorMetric) FuzzErrorMetric))

(define-foreign-enum-type (imagelayermethod (enum ImageLayerMethod))
  (imagelayermethod->int int->imagelayermethod)
  ((UndefinedLayer) UndefinedLayer)
  ((CoalesceLayer) CoalesceLayer)
  ((CompareAnyLayer) CompareAnyLayer)
  ((CompareClearLayer) CompareClearLayer)
  ((CompareOverlayLayer) CompareOverlayLayer)
  ((DisposeLayer) DisposeLayer)
  ((OptimizeLayer) OptimizeLayer)
  ((OptimizeImageLayer) OptimizeImageLayer)
  ((OptimizePlusLayer) OptimizePlusLayer)
  ((OptimizeTransLayer) OptimizeTransLayer)
  ((RemoveDupsLayer) RemoveDupsLayer)
  ((RemoveZeroLayer) RemoveZeroLayer)
  ((CompositeLayer) CompositeLayer)
  ((MergeLayer) MergeLayer)
  ((FlattenLayer) FlattenLayer)
  ((MosaicLayer) MosaicLayer)
  ((TrimBoundsLayer) TrimBoundsLayer))

(define-foreign-enum-type (compositeoperator (enum CompositeOperator))
  (compositeoperator->int int->compositeoperator)
  ((UndefinedCompositeOp) UndefinedCompositeOp)
  ((NoCompositeOp) NoCompositeOp)
  ((ModulusAddCompositeOp) ModulusAddCompositeOp)
  ((AtopCompositeOp) AtopCompositeOp)
  ((BlendCompositeOp) BlendCompositeOp)
  ((BumpmapCompositeOp) BumpmapCompositeOp)
  ((ChangeMaskCompositeOp) ChangeMaskCompositeOp)
  ((ClearCompositeOp) ClearCompositeOp)
  ((ColorBurnCompositeOp) ColorBurnCompositeOp)
  ((ColorDodgeCompositeOp) ColorDodgeCompositeOp)
  ((ColorizeCompositeOp) ColorizeCompositeOp)
  ((CopyBlackCompositeOp) CopyBlackCompositeOp)
  ((CopyBlueCompositeOp) CopyBlueCompositeOp)
  ((CopyCompositeOp) CopyCompositeOp)
  ((CopyCyanCompositeOp) CopyCyanCompositeOp)
  ((CopyGreenCompositeOp) CopyGreenCompositeOp)
  ((CopyMagentaCompositeOp) CopyMagentaCompositeOp)
  ((CopyOpacityCompositeOp) CopyOpacityCompositeOp)
  ((CopyRedCompositeOp) CopyRedCompositeOp)
  ((CopyYellowCompositeOp) CopyYellowCompositeOp)
  ((DarkenCompositeOp) DarkenCompositeOp)
  ((DstAtopCompositeOp) DstAtopCompositeOp)
  ((DstCompositeOp) DstCompositeOp)
  ((DstInCompositeOp) DstInCompositeOp)
  ((DstOutCompositeOp) DstOutCompositeOp)
  ((DstOverCompositeOp) DstOverCompositeOp)
  ((DifferenceCompositeOp) DifferenceCompositeOp)
  ((DisplaceCompositeOp) DisplaceCompositeOp)
  ((DissolveCompositeOp) DissolveCompositeOp)
  ((ExclusionCompositeOp) ExclusionCompositeOp)
  ((HardLightCompositeOp) HardLightCompositeOp)
  ((HueCompositeOp) HueCompositeOp)
  ((InCompositeOp) InCompositeOp)
  ((LightenCompositeOp) LightenCompositeOp)
  ((LinearLightCompositeOp) LinearLightCompositeOp)
  ((LuminizeCompositeOp) LuminizeCompositeOp)
  ((MinusDstCompositeOp) MinusDstCompositeOp)
  ((ModulateCompositeOp) ModulateCompositeOp)
  ((MultiplyCompositeOp) MultiplyCompositeOp)
  ((OutCompositeOp) OutCompositeOp)
  ((OverCompositeOp) OverCompositeOp)
  ((OverlayCompositeOp) OverlayCompositeOp)
  ((PlusCompositeOp) PlusCompositeOp)
  ((ReplaceCompositeOp) ReplaceCompositeOp)
  ((SaturateCompositeOp) SaturateCompositeOp)
  ((ScreenCompositeOp) ScreenCompositeOp)
  ((SoftLightCompositeOp) SoftLightCompositeOp)
  ((SrcAtopCompositeOp) SrcAtopCompositeOp)
  ((SrcCompositeOp) SrcCompositeOp)
  ((SrcInCompositeOp) SrcInCompositeOp)
  ((SrcOutCompositeOp) SrcOutCompositeOp)
  ((SrcOverCompositeOp) SrcOverCompositeOp)
  ((ModulusSubtractCompositeOp) ModulusSubtractCompositeOp)
  ((ThresholdCompositeOp) ThresholdCompositeOp)
  ((XorCompositeOp) XorCompositeOp)
  ((DivideDstCompositeOp) DivideDstCompositeOp)
  ((DistortCompositeOp) DistortCompositeOp)
  ((BlurCompositeOp) BlurCompositeOp)
  ((PegtopLightCompositeOp) PegtopLightCompositeOp)
  ((VividLightCompositeOp) VividLightCompositeOp)
  ((PinLightCompositeOp) PinLightCompositeOp)
  ((LinearDodgeCompositeOp) LinearDodgeCompositeOp)
  ((LinearBurnCompositeOp) LinearBurnCompositeOp)
  ((MathematicsCompositeOp) MathematicsCompositeOp)
  ((DivideSrcCompositeOp) DivideSrcCompositeOp)
  ((MinusSrcCompositeOp) MinusSrcCompositeOp)
  ((DarkenIntensityCompositeOp) DarkenIntensityCompositeOp)
  ((LightenIntensityCompositeOp) LightenIntensityCompositeOp))

(define-foreign-enum-type (storagetype (enum StorageType))
  (storagetype->int int->storagetype)
  ((UndefinedPixel) UndefinedPixel)
  ((CharPixel) CharPixel)
  ((DoublePixel) DoublePixel)
  ((FloatPixel) FloatPixel)
  ((IntegerPixel) IntegerPixel)
  ((LongPixel) LongPixel)
  ((QuantumPixel) QuantumPixel)
  ((ShortPixel) ShortPixel))

(define-foreign-enum-type (distortimagemethod (enum DistortImageMethod))
  (distortimagemethod-> int->distortimagemethod)
  ((UndefinedDistortion) UndefinedDistortion)
  ((AffineDistortion) AffineDistortion)
  ((AffineProjectionDistortion) AffineProjectionDistortion)
  ((ScaleRotateTranslateDistortion) ScaleRotateTranslateDistortion)
  ((PerspectiveDistortion) PerspectiveDistortion)
  ((PerspectiveProjectionDistortion) PerspectiveProjectionDistortion)
  ((BilinearForwardDistortion) BilinearForwardDistortion)
  ((BilinearDistortion) BilinearDistortion)
  ((BilinearReverseDistortion) BilinearReverseDistortion)
  ((PolynomialDistortion) PolynomialDistortion)
  ((ArcDistortion) ArcDistortion)
  ((PolarDistortion) PolarDistortion)
  ((DePolarDistortion) DePolarDistortion)
  ((Cylinder2PlaneDistortion) Cylinder2PlaneDistortion)
  ((Plane2CylinderDistortion) Plane2CylinderDistortion)
  ((BarrelDistortion) BarrelDistortion)
  ((BarrelInverseDistortion) BarrelInverseDistortion)
  ((ShepardsDistortion) ShepardsDistortion)
  ((ResizeDistortion) ResizeDistortion)
  ((SentinelDistortion) SentinelDistortion))

(define-foreign-enum-type (magickevaluateoperator (enum MagickEvaluateOperator))
  (magickevaluateoperator->int int->magickevaluateoperator)
  ((UndefinedEvaluateOperator) UndefinedEvaluateOperator)
  ((AddEvaluateOperator) AddEvaluateOperator)
  ((AndEvaluateOperator) AndEvaluateOperator)
  ((DivideEvaluateOperator) DivideEvaluateOperator)
  ((LeftShiftEvaluateOperator) LeftShiftEvaluateOperator)
  ((MaxEvaluateOperator) MaxEvaluateOperator)
  ((MinEvaluateOperator) MinEvaluateOperator)
  ((MultiplyEvaluateOperator) MultiplyEvaluateOperator)
  ((OrEvaluateOperator) OrEvaluateOperator)
  ((RightShiftEvaluateOperator) RightShiftEvaluateOperator)
  ((SetEvaluateOperator) SetEvaluateOperator)
  ((SubtractEvaluateOperator) SubtractEvaluateOperator)
  ((XorEvaluateOperator) XorEvaluateOperator)
  ((PowEvaluateOperator) PowEvaluateOperator)
  ((LogEvaluateOperator) LogEvaluateOperator)
  ((ThresholdEvaluateOperator) ThresholdEvaluateOperator)
  ((ThresholdBlackEvaluateOperator) ThresholdBlackEvaluateOperator)
  ((ThresholdWhiteEvaluateOperator) ThresholdWhiteEvaluateOperator)
  ((GaussianNoiseEvaluateOperator) GaussianNoiseEvaluateOperator)
  ((ImpulseNoiseEvaluateOperator) ImpulseNoiseEvaluateOperator)
  ((LaplacianNoiseEvaluateOperator) LaplacianNoiseEvaluateOperator)
  ((MultiplicativeNoiseEvaluateOperator) MultiplicativeNoiseEvaluateOperator)
  ((PoissonNoiseEvaluateOperator) PoissonNoiseEvaluateOperator)
  ((UniformNoiseEvaluateOperator) UniformNoiseEvaluateOperator)
  ((CosineEvaluateOperator) CosineEvaluateOperator)
  ((SineEvaluateOperator) SineEvaluateOperator)
  ((AddModulusEvaluateOperator) AddModulusEvaluateOperator)
  ((MeanEvaluateOperator) MeanEvaluateOperator)
  ((AbsEvaluateOperator) AbsEvaluateOperator)
  ((ExponentialEvaluateOperator) ExponentialEvaluateOperator)
  ((MedianEvaluateOperator) MedianEvaluateOperator))

(define-foreign-enum-type (magickfunction (enum MagickFunction))
  (magickfunction->int int->magickfunction)
  ((UndefinedFunction) UndefinedFunction)
  ((PolynomialFunction) PolynomialFunction)
  ((SinusoidFunction) SinusoidFunction)
  ((ArcsinFunction) ArcsinFunction)
  ((ArctanFunction) ArctanFunction))

(define-foreign-enum-type (disposetype (enum DisposeType))
  (disposetype-> int->disposetype)
  ((UnrecognizedDispose) UnrecognizedDispose)
  ((UndefinedDispose) UndefinedDispose)
  ((NoneDispose) NoneDispose)
  ((BackgroundDispose) BackgroundDispose)
  ((PreviousDispose) PreviousDispose))

(define-foreign-enum-type (renderingintent (enum RenderingIntent))
  (renderingintent->int int->renderingintent)
  ((UndefinedIntent) UndefinedIntent)
  ((SaturationIntent) SaturationIntent)
  ((PerceptualIntent) PerceptualIntent)
  ((AbsoluteIntent) AbsoluteIntent)
  ((RelativeIntent) RelativeIntent))

(define-foreign-enum-type (resolutiontype (enum ResolutionType))
  (resolutiontype->int int->resolutiontype)
  ((UndefinedResolution) UndefinedResolution)
  ((PixelsPerInchResolution) PixelsPerInchResolution)
  ((PixelsPerCentimeterResolution) PixelsPerCentimeterResolution))

(define-foreign-enum-type (virtualpixelmethod (enum VirtualPixelMethod))
  (virtualpixelmethod->int int->virtualpixelmethod)
  ((UndefinedVirtualPixelMethod) UndefinedVirtualPixelMethod)
  ((BackgroundVirtualPixelMethod) BackgroundVirtualPixelMethod)
  ((ConstantVirtualPixelMethod) ConstantVirtualPixelMethod)
  ((DitherVirtualPixelMethod) DitherVirtualPixelMethod)
  ((EdgeVirtualPixelMethod) EdgeVirtualPixelMethod)
  ((MirrorVirtualPixelMethod) MirrorVirtualPixelMethod)
  ((RandomVirtualPixelMethod) RandomVirtualPixelMethod)
  ((TileVirtualPixelMethod) TileVirtualPixelMethod)
  ((TransparentVirtualPixelMethod) TransparentVirtualPixelMethod)
  ((MaskVirtualPixelMethod) MaskVirtualPixelMethod)
  ((BlackVirtualPixelMethod) BlackVirtualPixelMethod)
  ((GrayVirtualPixelMethod) GrayVirtualPixelMethod)
  ((WhiteVirtualPixelMethod) WhiteVirtualPixelMethod)
  ((HorizontalTileVirtualPixelMethod) HorizontalTileVirtualPixelMethod)
  ((VerticalTileVirtualPixelMethod) VerticalTileVirtualPixelMethod)
  ((HorizontalTileEdgeVirtualPixelMethod) HorizontalTileEdgeVirtualPixelMethod)
  ((VerticalTileEdgeVirtualPixelMethod) VerticalTileEdgeVirtualPixelMethod)
  ((CheckerTileVirtualPixelMethod) CheckerTileVirtualPixelMethod))

(define-foreign-enum-type (montagemode (enum MontageMode))
  (montagemode->int int->montagemode)
  ((UndefinedMode) UndefinedMode)
  ((FrameMode) FrameMode)
  ((UnframeMode) UnframeMode)
  ((ConcatenateMode) ConcatenateMode))

(define-foreign-enum-type (morphologymethod (enum MorphologyMethod))
  (morphologymethod->int int->morphologymethod)
  ((UndefinedMorphology) UndefinedMorphology)
  ((ConvolveMorphology) ConvolveMorphology)
  ((CorrelateMorphology) CorrelateMorphology)
  ((ErodeMorphology) ErodeMorphology)
  ((DilateMorphology) DilateMorphology)
  ((ErodeIntensityMorphology) ErodeIntensityMorphology)
  ((DilateIntensityMorphology) DilateIntensityMorphology)
  ((DistanceMorphology) DistanceMorphology)
  ((OpenMorphology) OpenMorphology)
  ((CloseMorphology) CloseMorphology)
  ((OpenIntensityMorphology) OpenIntensityMorphology)
  ((CloseIntensityMorphology) CloseIntensityMorphology)
  ((SmoothMorphology) SmoothMorphology)
  ((EdgeInMorphology) EdgeInMorphology)
  ((EdgeOutMorphology) EdgeOutMorphology)
  ((EdgeMorphology) EdgeMorphology)
  ((TopHatMorphology) TopHatMorphology)
  ((BottomHatMorphology) BottomHatMorphology)
  ((HitAndMissMorphology) HitAndMissMorphology)
  ((ThinningMorphology) ThinningMorphology)
  ((ThickenMorphology) ThickenMorphology)
  ((VoronoiMorphology) VoronoiMorphology))

(define-foreign-enum-type (previewtype (enum PreviewType))
  (previewtype->int int->previewtype)
  ((UndefinedPreview) UndefinedPreview)
  ((RotatePreview) RotatePreview)
  ((ShearPreview) ShearPreview)
  ((RollPreview) RollPreview)
  ((HuePreview) HuePreview)
  ((SaturationPreview) SaturationPreview)
  ((BrightnessPreview) BrightnessPreview)
  ((GammaPreview) GammaPreview)
  ((SpiffPreview) SpiffPreview)
  ((DullPreview) DullPreview)
  ((GrayscalePreview) GrayscalePreview)
  ((QuantizePreview) QuantizePreview)
  ((DespecklePreview) DespecklePreview)
  ((ReduceNoisePreview) ReduceNoisePreview)
  ((AddNoisePreview) AddNoisePreview)
  ((SharpenPreview) SharpenPreview)
  ((BlurPreview) BlurPreview)
  ((ThresholdPreview) ThresholdPreview)
  ((EdgeDetectPreview) EdgeDetectPreview)
  ((SpreadPreview) SpreadPreview)
  ((SolarizePreview) SolarizePreview)
  ((ShadePreview) ShadePreview)
  ((RaisePreview) RaisePreview)
  ((SegmentPreview) SegmentPreview)
  ((SwirlPreview) SwirlPreview)
  ((ImplodePreview) ImplodePreview)
  ((WavePreview) WavePreview)
  ((OilPaintPreview) OilPaintPreview)
  ((CharcoalDrawingPreview) CharcoalDrawingPreview)
  ((JPEGPreview) JPEGPreview))

(define-foreign-enum-type (dithermethod (enum DitherMethod))
  (dithermethod->int int->dithermethod)
  ((UndefinedDitherMethod) UndefinedDitherMethod)
  ((NoDitherMethod) NoDitherMethod)
  ((RiemersmaDitherMethod) RiemersmaDitherMethod)
  ((FloydSteinbergDitherMethod) FloydSteinbergDitherMethod))

(define-foreign-enum-type (filtertypes (enum FilterTypes))
  (filtertypes->int int->filtertypes)
  ((UndefinedFilter) UndefinedFilter)
  ((PointFilter) PointFilter)
  ((BoxFilter) BoxFilter)
  ((TriangleFilter) TriangleFilter)
  ((HermiteFilter) HermiteFilter)
  ((HanningFilter) HanningFilter)
  ((HammingFilter) HammingFilter)
  ((BlackmanFilter) BlackmanFilter)
  ((GaussianFilter) GaussianFilter)
  ((QuadraticFilter) QuadraticFilter)
  ((CubicFilter) CubicFilter)
  ((CatromFilter) CatromFilter)
  ((MitchellFilter) MitchellFilter)
  ((JincFilter) JincFilter)
  ((SincFilter) SincFilter)
  ((SincFastFilter) SincFastFilter)
  ((KaiserFilter) KaiserFilter)
  ((WelshFilter) WelshFilter)
  ((ParzenFilter) ParzenFilter)
  ((BohmanFilter) BohmanFilter)
  ((BartlettFilter) BartlettFilter)
  ((LagrangeFilter) LagrangeFilter)
  ((LanczosFilter) LanczosFilter)
  ((LanczosSharpFilter) LanczosSharpFilter)
  ((Lanczos2Filter) Lanczos2Filter)
  ((Lanczos2SharpFilter) Lanczos2SharpFilter)
  ((RobidouxFilter) RobidouxFilter)
  ((SentinelFilter) SentinelFilter))

(define-foreign-type magickwand (c-pointer (struct _MagickWand)))

(define-foreign-type drawingwand (c-pointer (struct _DrawingWand)))

(define-foreign-type image (c-pointer (struct _Image)))

(define-foreign-type pixelwand (c-pointer (struct _PixelWand)))

;; typedef MagickBooleanType
;;   (*MagickProgressMonitor)(const char *,const MagickOffsetType,
;;     const MagickSizeType,void *);

(define-foreign-record-type (struct KernelInfo)
  ((enum KernelInfoType) type kernelinfo-type)
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
  ((c-pointer (struct KernelInfo)) next kernelinfo-next)
  (size_t signature kernelinfo-signature))

(define-foreign-record-type ChannelFeatures
  (double (angular_second_moment 4) channelfeatures-angular_second_moment)
  (double (contrast 4) channelfeatures-contrast)
  (double (correlation 4) channelfeatures-correlation)
  (double (variance_sum_of_squares 4) channelfeatures-variance_sum_of_squares)
  (double (inverse_difference_moment 4) channelfeatures-inverse_difference_moment)
  (double (sum_average 4) channelfeatures-sum_average)
  (double (sum_variance 4) channelfeatures-sum_variance)
  (double (sum_entropy 4) channelfeatures-sum_entropy)
  (double (entropy 4) channelfeatures-entropy)
  (double (difference_variance 4) channelfeatures-difference_variance)
  (double (difference_entropy 4) channelfeatures-difference_entropy)
  (double (measure_of_correlation_1 4) channelfeatures-measure_of_correlation_1)
  (double (measure_of_correlation_2 4) channelfeatures-measure_of_correlation_2)
  (double (maximum_correlation_coefficient 4) channelfeatures-maximum_correlation_coefficient))

(define-foreign-record-type ChannelStatistics
  (size_t depth channelstatistics-depth)
  (double minima channelstatistics-minima)
  (double maxima channelstatistics-maxima)
  (double sum channelstatistics-sum)
  (double sum_squared channelstatistics-sum_squared)
  (double sum_cubed channelstatistics-sum_cubed)
  (double sum_fourth_power channelstatistics-sum_fourth_power)
  (double mean channelstatistics-mean)
  (double variance channelstatistics-variance)
  (double standard_deviation channelstatistics-standard_deviation)
  (double kurtosis channelstatistics-kurtosis)
  (double skewness channelstatistics-skewness))


;;;
;;; MagickWand methods
;;;

(define magickwand-clear
  (foreign-lambda void ClearMagickWand magickwand))

(define magickwand-clone
  (foreign-lambda magickwand CloneMagickWand (const magickwand)))

(define magickwand-destroy
  (foreign-lambda magickwand DestroyMagickWand magickwand))

(define magickwand?
  (foreign-lambda magickboolean IsMagickWand (const magickwand)))

(define magick-clear-exception
  (foreign-lambda magickboolean MagickClearException magickwand))

;;(define magick-get-exception
;;  (foreign-lambda c-string MagickGetException
;;                  (const magickwand)
;;                  (c-pointer exceptiontype)))

(define magick-get-exception-type
  (foreign-lambda exceptiontype MagickGetExceptionType (const magickwand)))

(define magick-get-iterator-index
  (foreign-lambda ssize_t MagickGetIteratorIndex magickwand))

(define magick-query-configure-option
  (foreign-lambda c-string MagickQueryConfigureOption (const c-string)))

(define magick-query-configure-options
  (foreign-lambda c-string-list MagickQueryConfigureOptions
                  (const c-string) (c-pointer size_t)))

(define magick-query-font-metrics
  (foreign-lambda (c-pointer double) MagickQueryFontMetrics
                  magickwand (const drawingwand) (const c-string)))

(define magick-query-multiline-font-metrics
  (foreign-lambda (c-pointer double) MagickQueryMultilineFontMetrics
                  magickwand (const drawingwand) (const c-string)))

(define magick-query-fonts
  (foreign-lambda c-string-list MagickQueryFonts
                  (const c-string)
                  (c-pointer size_t)))

(define magick-relinquish-memory
  (foreign-lambda c-pointer MagickRelinquishMemory c-pointer))

(define magick-reset-iterator
  (foreign-lambda void MagickResetIterator magickwand))

(define magick-set-first-iterator
  (foreign-lambda void MagickSetFirstIterator magickwand))

(define magick-set-iterator-index
  (foreign-lambda magickboolean MagickSetIteratorIndex magickwand (const ssize_t)))

(define magick-set-last-iterator
  (foreign-lambda void MagickSetLastIterator magickwand))

(define magickwand-genesis
  (foreign-lambda void MagickWandGenesis))

(define magickwand-terminus
  (foreign-lambda void MagickWandTerminus))

(define new-magickwand
  (foreign-lambda magickwand NewMagickWand))

(define new-magickwand-from-image
  (foreign-lambda magickwand NewMagickWandFromImage (const image)))


;;;
;;; Magick-property methods
;;;

(define magick-delete-image-artifact
  (foreign-lambda magickboolean MagickDeleteImageArtifact
                  magickwand (const c-string)))

(define magick-delete-image-property
  (foreign-lambda magickboolean MagickDeleteImageProperty
                  magickwand (const c-string)))

(define magick-delete-option
  (foreign-lambda magickboolean MagickDeleteOption
                  magickwand (const c-string)))

(define magick-get-antialias
  (foreign-lambda magickboolean MagickGetAntialias magickwand))

(define magick-get-background-color
  (foreign-lambda pixelwand MagickGetBackgroundColor magickwand))

(define magick-get-colorspace
  (foreign-lambda colorspace MagickGetColorspace magickwand))

(define magick-get-compression
  (foreign-lambda compressiontype MagickGetCompression magickwand))

(define magick-get-compression-quality
  (foreign-lambda size_t MagickGetCompressionQuality magickwand))

(define magick-get-copyright
  (foreign-lambda c-string MagickGetCopyright))

(define magick-get-filename
  (foreign-lambda c-string MagickGetFilename magickwand))

(define magick-get-font
  (foreign-lambda c-string MagickGetFont magickwand))

(define magick-get-format
  (foreign-lambda char MagickGetFormat magickwand))

(define magick-get-gravity
  (foreign-lambda gravity MagickGetGravity magickwand))

(define magick-get-home-url
  (foreign-lambda c-string MagickGetHomeURL))

(define magick-get-image-artifact
  (foreign-lambda c-string MagickGetImageArtifact magickwand (const c-string)))

(define magick-get-image-artifacts
  (foreign-lambda c-string MagickGetImageArtifacts
                  magickwand (const c-string) (c-pointer size_t)))

(define magick-get-image-profile
  (foreign-lambda unsigned-c-string MagickGetImageProfile
                  magickwand (const c-string) (c-pointer size_t)))

(define magick-get-image-profiles
  (foreign-lambda c-string MagickGetImageProfiles
                  magickwand (const c-string) (c-pointer size_t)))

(define magick-get-image-property
  (foreign-lambda c-string MagickGetImageProperty magickwand (const c-string)))

(define magick-get-image-properties
  (foreign-lambda c-string MagickGetImageProperties
                  magickwand (const c-string) (c-pointer size_t)))

(define magick-get-interlace-scheme
  (foreign-lambda interlacetype MagickGetInterlaceScheme magickwand))

(define magick-get-interpolate-method
  (foreign-lambda interpolatepixelmethod MagickGetInterpolateMethod magickwand))

(define magick-get-option
  (foreign-lambda c-string MagickGetOption magickwand (const c-string)))

(define magick-get-options
  (foreign-lambda c-string MagickGetOptions
                  magickwand (const c-string) (c-pointer size_t)))

(define magick-get-orientation
  (foreign-lambda orientation MagickGetOrientation magickwand))

(define magick-get-package-name
  (foreign-lambda c-string MagickGetPackageName))

(define magick-get-page
  (foreign-lambda magickboolean MagickGetPage
                  magickwand (c-pointer size_t) (c-pointer size_t)
                  (c-pointer size_t) (c-pointer size_t)))

(define magick-get-pointsize
  (foreign-lambda double MagickGetPointsize magickwand))

(define magick-get-quantum-depth
  (foreign-lambda c-string MagickGetQuantumDepth (c-pointer size_t)))

(define magick-get-quantum-range
  (foreign-lambda c-string MagickGetQuantumRange (c-pointer size_t)))

(define magick-get-release-date
  (foreign-lambda c-string MagickGetReleaseDate))

(define magick-get-resolution
  (foreign-lambda magickboolean MagickGetResolution
                  magickwand (c-pointer double) (c-pointer double)))

;;(define magick-get-resource
;;  (foreign-lambda magicksize MagickGetResource (const resourcetype)))

;;(define magick-get-resource-limit
;;  (foreign-lambda magicksize MagickGetResourceLimit (const resourcetype)))

(define magick-get-sampling-factors
  (foreign-lambda (c-pointer double) MagickGetSamplingFactors
                  magickwand (c-pointer size_t)))

(define magick-get-size
  (foreign-lambda magickboolean MagickGetSize
                  magickwand (c-pointer size_t) (c-pointer size_t)))

(define magick-get-size-offset
  (foreign-lambda magickboolean MagickGetSizeOffset
                  magickwand (c-pointer ssize_t)))

(define magick-get-type
  (foreign-lambda imagetype MagickGetType magickwand))

(define magick-get-version
  (foreign-lambda c-string MagickGetVersion (c-pointer size_t)))

(define magick-profile-image
  (foreign-lambda magickboolean MagickProfileImage
                  magickwand (const c-string) (const c-pointer) (const size_t)))

(define magick-remove-image-profile
  (foreign-lambda unsigned-c-string MagickRemoveImageProfile
                  magickwand (const c-string) (c-pointer size_t)))

;;(define magick-set-antialias
;;  (foreign-lambda magickboolean MagickSetAntialias magickwand (const magickboolean)))

(define magick-set-background-color
  (foreign-lambda magickboolean MagickSetBackgroundColor magickwand (const pixelwand)))

;;(define magick-set-colorspace
;;  (foreign-lambda magickboolean MagickSetColorspace magickwand (const colorspace)))

;;(define magick-set-compression
;;  (foreign-lambda magickboolean MagickSetCompression magickwand (const compressiontype)))

(define magick-set-compression-quality
  (foreign-lambda magickboolean MagickSetCompressionQuality magickwand (const size_t)))

(define magick-set-depth
  (foreign-lambda magickboolean MagickSetDepth magickwand (const size_t)))

(define magick-set-extract
  (foreign-lambda magickboolean MagickSetExtract magickwand (const c-string)))

(define magick-set-filename
  (foreign-lambda magickboolean MagickSetFilename magickwand (const c-string)))

(define magick-set-font
  (foreign-lambda magickboolean MagickSetFont magickwand (const c-string)))

(define magick-set-format
  (foreign-lambda magickboolean MagickSetFormat magickwand (const c-string)))

;;(define magick-set-gravity
;;  (foreign-lambda magickboolean MagickSetGravity magickwand (const gravity)))

(define magick-set-image-artifact
  (foreign-lambda magickboolean MagickSetImageArtifact
                  magickwand (const c-string) (const c-string)))

(define magick-set-image-profile
  (foreign-lambda magickboolean MagickSetImageProfile
                  magickwand (const c-string) (const c-pointer) (const size_t)))

(define magick-set-image-property
  (foreign-lambda magickboolean MagickSetImageProperty
                  magickwand (const c-string) (const c-string)))

;;(define magick-set-interlace-scheme
;;  (foreign-lambda magickboolean MagickSetInterlaceScheme magickwand (const interlacetype)))

;;(define magick-set-interpolate-method
;;  (foreign-lambda magickboolean MagickSetInterpolateMethod magickwand (const interpolatepixelmethod)))

(define magick-set-option
  (foreign-lambda magickboolean MagickSetOption
                  magickwand (const c-string) (const c-string)))

;;(define magick-set-orientation
;;  (foreign-lambda magickboolean MagickSetOrientation
;;                  magickwand (const orientation)))

(define magick-set-page
  (foreign-lambda magickboolean MagickSetPage
                  magickwand (const size_t) (const size_t)
                  (const size_t) (const size_t)))

(define magick-set-passphrase
  (foreign-lambda magickboolean MagickSetPassphrase magickwand (const c-string)))

(define magick-set-pointsize
  (foreign-lambda magickboolean MagickSetPointsize magickwand (const double)))

;;(define magick-set-progress-monitor
;;  (foreign-lambda magickprogressmonitor MagickSetProgressMonitor
;;                  magickwand (const magickprogressmonitor) c-pointer))

;;(define magick-set-resource-limit
;;  (foreign-lambda magickboolean MagickSetResourceLimit
;;                  (const resourcetype) (const magicksize)))

(define magick-set-resolution
  (foreign-lambda magickboolean MagickSetResolution
                  magickwand (const double) (const double)))

(define magick-set-sampling-factors
  (foreign-lambda magickboolean MagickSetSamplingFactors
                  magickwand (const size_t) (const (c-pointer double))))

(define magick-set-size
  (foreign-lambda magickboolean MagickSetSize
                  magickwand (const size_t) (const size_t)))

(define magick-set-size-offset
  (foreign-lambda magickboolean MagickSetSizeOffset
                  magickwand (const size_t) (const size_t)
                  (const ssize_t)))

;;(define magick-set-type
;;  (foreign-lambda magickboolean MagickSetType
;;                  magickwand (const imagetype)))


;;;
;;; Magick-image methods
;;;

(define get-image-from-magick-wand
  (foreign-lambda image GetImageFromMagickWand magickwand))

(define magick-adaptive-blur-image
  (foreign-lambda magickboolean MagickAdaptiveBlurImage
                  magickwand (const double) (const double)))

;;(define magick-adaptive-blur-image-channel
;;  (foreign-lambda magickboolean MagickAdaptiveBlurImageChannel
;;                  magickwand (const channeltype) (const double) (const double)))

(define magick-adaptive-resize-image
  (foreign-lambda magickboolean MagickAdaptiveResizeImage
                  magickwand (const size_t) (const size_t)))

(define magick-adaptive-sharpen-image
  (foreign-lambda magickboolean MagickAdaptiveSharpenImage
                  magickwand (const double) (const double)))

;;(define magick-adaptive-sharpen-image-channel
;;  (foreign-lambda magickboolean MagickAdaptiveSharpenImageChannel
;;                  magickwand (const channeltype) (const double) (const double)))

(define magick-adaptive-threshold-image
  (foreign-lambda magickboolean MagickAdaptiveThresholdImage
                  magickwand (const size_t) (const size_t) (const ssize_t)))

(define magick-add-image
  (foreign-lambda magickboolean MagickAddImage
                  magickwand (const magickwand)))

;;(define magick-add-noise-image
;;  (foreign-lambda magickboolean MagickAddNoiseImage
;;                  magickwand (const noisetype)))

;;(define magick-add-noise-image-channel
;;  (foreign-lambda magickboolean MagickAddNoiseImageChannel
;;                  magickwand (const channeltype) (const noisetype)))

(define magick-affine-transform-image
  (foreign-lambda magickboolean MagickAffineTransformImage
                  magickwand (const drawingwand)))

(define magick-annotate-image
  (foreign-lambda magickboolean MagickAnnotateImage
                  magickwand (const drawingwand) (const double) (const double)
                  (const double) (const c-string)))

(define magick-animate-images
  (foreign-lambda magickboolean MagickAnimateImages magickwand (const c-string)))

;;(define magick-append-images
;;  (foreign-lambda magickwand MagickAppendImages magickwand (const magickboolean)))

(define magick-auto-gamma-image
  (foreign-lambda magickboolean MagickAutoGammaImage magickwand))

;;(define magick-auto-gamma-image-channel
;;  (foreign-lambda magickboolean MagickAutoGammaImageChannel
;;                  magickwand (const channeltype)))

(define magick-auto-level-image
  (foreign-lambda magickboolean MagickAutoLevelImage magickwand))

;;(define magick-auto-level-image-channel
;;  (foreign-lambda magickboolean MagickAutoLevelImageChannel
;;                  magickwand (const channeltype)))

(define magick-black-threshold-image
  (foreign-lambda magickboolean MagickBlackThresholdImage
                  magickwand (const pixelwand)))

(define magick-blue-shift-image
  (foreign-lambda magickboolean MagickBlueShiftImage magickwand (const double)))

(define magick-blur-image
  (foreign-lambda magickboolean MagickBlurImage
                  magickwand (const double) (const double)))

;;(define magick-blur-image-channel
;;  (foreign-lambda magickboolean MagickBlurImageChannel
;;                  magickwand (const channeltype)
;;                  (const double) (const double)))

(define magick-border-image
  (foreign-lambda magickboolean MagickBorderImage
                  magickwand (const pixelwand) (const size_t) (const size_t)))

(define magick-brightness-contrast-image
  (foreign-lambda magickboolean MagickBrightnessContrastImage
                  magickwand (const double) (const double)))

;;(define magick-brightness-contrast-image-channel
;;  (foreign-lambda magickboolean MagickBrightnessContrastImageChannel
;;                  magickwand (const channeltype) (const double) (const double)))

(define magick-charcoal-image
  (foreign-lambda magickboolean MagickCharcoalImage
                  magickwand (const double) (const double)))

(define magick-chop-image
  (foreign-lambda magickboolean MagickChopImage
                  magickwand (const size_t) (const size_t)
                  (const ssize_t) (const ssize_t)))

(define magick-clamp-image
  (foreign-lambda magickboolean MagickClampImage magickwand))

;;(define magick-clamp-image-channel
;;  (foreign-lambda magickboolean MagickClampImageChannel magickwand (const channeltype)))

(define magick-clip-image
  (foreign-lambda magickboolean MagickClipImage magickwand))

;;(define magick-clip-image-path
;;  (foreign-lambda magickboolean MagickClipImagePath
;;                  magickwand (const c-string) (const magickboolean)))

(define magick-clut-image
  (foreign-lambda magickboolean MagickClutImage
                  magickwand (const magickwand)))

;;(define magick-clut-image-channel
;;  (foreign-lambda magickboolean MagickClutImageChannel
;;                  magickwand (const channeltype) (const magickwand)))

(define magick-coalesce-images
  (foreign-lambda magickwand MagickCoalesceImages magickwand))

(define magick-color-decision-list-image
  (foreign-lambda magickboolean MagickColorDecisionListImage
                  magickwand (const c-string)))

(define magick-colorize-image
  (foreign-lambda magickboolean MagickColorizeImage
                  magickwand (const pixelwand) (const pixelwand)))

;;(define magick-color-matrix-image
;;  (foreign-lambda magickboolean MagickColorMatrixImage
;;                  magickwand (const KernelInfo)))

;;(define magick-combine-images
;;  (foreign-lambda magickwand MagickCombineImages
;;                  magickwand (const channeltype)))

(define magick-comment-image
  (foreign-lambda magickboolean MagickCommentImage
                  magickwand (const c-string)))

;;(define magick-compare-image-channels
;;  (foreign-lambda magickwand MagickCompareImageChannels
;;                  magickwand (const magickwand) (const channeltype)
;;                  (const metrictype) (c-pointer double)))

;;(define magick-compare-image-layers
;;  (foreign-lambda magickwand MagickCompareImageLayers
;;                  magickwand (const imagelayermethod)))

;;(define magick-compare-images
;;  (foreign-lambda magickwand MagickCompareImages
;;                  magickwand (const magickwand)
;;                  (const metrictype) (c-pointer double)))

;;(define magick-composite-image
;;  (foreign-lambda magickboolean MagickCompositeImage
;;                  magickwand (const magickwand)
;;                  (const compositeoperator)
;;                  (const ssize_t) (const ssize_t)))

;;(define magick-composite-image-channel
;;  (foreign-lambda magickboolean MagickCompositeImageChannel
;;                  magickwand (const channeltype) (const magickwand)
;;                  (const compositeoperator)
;;                  (const ssize_t) (const ssize_t)))

;;(define magick-composite-layers
;;  (foreign-lambda magickboolean MagickCompositeLayers
;;                  magickwand (const magickwand)
;;                  (const compositeoperator)
;;                  (const ssize_t) (const ssize_t)))

;;(define magick-contrast-image
;;  (foreign-lambda magickboolean MagickContrastImage
;;                  magickwand (const magickboolean)))

(define magick-contrast-stretch-image
  (foreign-lambda magickboolean MagickContrastStretchImage
                  magickwand (const double) (const double)))

;;(define magick-contrast-stretch-image-channel
;;  (foreign-lambda magickboolean MagickContrastStretchImageChannel
;;                  magickwand (const channeltype)
;;                  (const double) (const double)))

(define magick-convolve-image
  (foreign-lambda magickboolean MagickConvolveImage
                  magickwand (const size_t) (const (c-pointer double))))

;;(define magick-convolve-image-channel
;;  (foreign-lambda magickboolean MagickConvolveImageChannel
;;                  magickwand (const channeltype)
;;                  (const size_t) (const (c-pointer double))))

(define magick-crop-image
  (foreign-lambda magickboolean MagickCropImage
                  magickwand (const size_t) (const size_t)
                  (const ssize_t) (const ssize_t)))

(define magick-cycle-colormap-image
  (foreign-lambda magickboolean MagickCycleColormapImage
                  magickwand (const ssize_t)))

;;(define magick-constitute-image
;;  (foreign-lambda magickboolean MagickConstituteImage
;;                  magickwand (const size_t) (const size_t)
;;                  (const c-string) (const storagetype) c-pointer))

(define magick-decipher-image
  (foreign-lambda magickboolean MagickDecipherImage
                  magickwand (const c-string)))

(define magick-deconstruct-images
  (foreign-lambda magickwand MagickDeconstructImages magickwand))

(define magick-deskew-image
  (foreign-lambda magickboolean MagickDeskewImage
                  magickwand (const double)))

(define magick-despeckle-image
  (foreign-lambda magickboolean MagickDespeckleImage magickwand))

(define magick-destroy-image
  (foreign-lambda image MagickDestroyImage image))

(define magick-display-image
  (foreign-lambda magickboolean MagickDisplayImage magickwand (const c-string)))

(define magick-display-images
  (foreign-lambda magickboolean MagickDisplayImages magickwand (const c-string)))

;;(define magick-distort-image
;;  (foreign-lambda magickboolean MagickDistortImage
;;                  magickwand (const distortimagemethod)
;;                  (const size_t) (const (c-pointer double))
;;                  (const magickboolean)))

(define magick-draw-image
  (foreign-lambda magickboolean MagickDrawImage
                  magickwand (const drawingwand)))

(define magick-edge-image
  (foreign-lambda magickboolean MagickEdgeImage
                  magickwand (const double)))

(define magick-emboss-image
  (foreign-lambda magickboolean MagickEmbossImage
                  magickwand (const double) (const double)))

(define magick-encipher-image
  (foreign-lambda magickboolean MagickEncipherImage
                  magickwand (const c-string)))

(define magick-enhance-image
  (foreign-lambda magickboolean MagickEnhanceImage magickwand))

(define magick-equalize-image
  (foreign-lambda magickboolean MagickEqualizeImage magickwand))

;;(define magick-equalize-image-channel
;;  (foreign-lambda magickboolean MagickEqualizeImageChannel
;;                  magickwand (const channeltype)))

;;(define magick-evaluate-image
;;  (foreign-lambda magickboolean MagickEvaluateImage
;;                  magickwand (const magickevaluateoperator)
;;                  (const double)))

;;(define magick-evaluate-images
;;  (foreign-lambda magickboolean MagickEvaluateImages
;;                  magickwand (const magickevaluateoperator)))

;;(define magick-evaluate-image-channel
;;  (foreign-lambda magickboolean MagickEvaluateImageChannel
;;                  magickwand (const channeltype)
;;                  (const magickevaluateoperator)
;;                  (const double)))

;;(define magick-export-image-pixels
;;  (foreign-lambda magickboolean MagickExportImagePixels
;;                  magickwand (const ssize_t) (const ssize_t)
;;                  (const size_t) (const size_t)
;;                  (const c-string) (const storagetype)
;;                  c-pointer))

(define magick-extent-image
  (foreign-lambda magickboolean MagickExtentImage
                  magickwand (const size_t) (const size_t)
                  (const ssize_t) (const ssize_t)))

;;(define magick-filter-image
;;  (foreign-lambda magickboolean MagickFilterImage
;;                  magickwand (const kernelinfo)))

;;(define magick-filter-image-channel
;;  (foreign-lambda magickboolean MagickFilterImageChannel
;;                  magickwand (const channeltype) (const kernelinfo)))

(define magick-flip-image
  (foreign-lambda magickboolean MagickFlipImage magickwand))

;;(define magick-floodfill-paint-image
;;  (foreign-lambda magickboolean MagickFloodfillPaintImage
;;                  magickwand (const channeltype) (const pixelwand)
;;                  (const double) (const pixelwand)
;;                  (const ssize_t) (const ssize_t)
;;                  (const magickboolean)))

(define magick-flop-image
  (foreign-lambda magickboolean MagickFlopImage magickwand))

;;(define magick-forward-fourier-transform-image
;;  (foreign-lambda magickboolean MagickForwardFourierTransformImage
;;                  magickwand (const magickboolean)))

(define magick-frame-image
  (foreign-lambda magickboolean MagickFrameImage
                  magickwand (const pixelwand)
                  (const size_t) (const size_t)
                  (const ssize_t) (const ssize_t)))

;;(define magick-function-image
;;  (foreign-lambda magickboolean MagickFunctionImage
;;                  magickwand (const magickfunction)
;;                  (const size_t) (const (c-pointer double))))

;;(define magick-function-image-channel
;;  (foreign-lambda magickboolean MagickFunctionImageChannel
;;                  magickwand (const channeltype) (const magickfunction)
;;                  (const size_t) (const (c-pointer double))))

(define magick-fx-image
  (foreign-lambda magickwand MagickFxImage magickwand (const c-string)))

;;(define magick-fx-image-channel
;;  (foreign-lambda magickwand MagickFxImageChannel
;;                  magickwand (const channeltype) (const c-string)))

(define magick-gamma-image
  (foreign-lambda magickboolean MagickGammaImage magickwand (const double)))

;;(define magick-gamma-image-channel
;;  (foreign-lambda magickboolean MagickGammaImageChannel
;;                  magickwand (const channeltype) (const double)))

(define magick-gaussian-blur-image
  (foreign-lambda magickboolean MagickGaussianBlurImage
                  magickwand (const double) (const double)))

;;(define magick-gaussian-blur-image-channel
;;  (foreign-lambda magickboolean MagickGaussianBlurImageChannel
;;                  magickwand (const channeltype)
;;                  (const double) (const double)))

(define magick-get-image
  (foreign-lambda magickwand MagickGetImage magickwand))

(define magick-get-image-alpha-channel
  (foreign-lambda magickboolean MagickGetImageAlphaChannel magickwand))

(define magick-get-image-clip-mask
  (foreign-lambda magickwand MagickGetImageClipMask magickwand))

(define magick-get-image-background-color
  (foreign-lambda magickboolean MagickGetImageBackgroundColor magickwand pixelwand))

(define magick-get-image-blob
  (foreign-lambda unsigned-c-string MagickGetImageBlob magickwand (c-pointer size_t)))

(define magick-get-images-blob
  (foreign-lambda unsigned-c-string MagickGetImagesBlob magickwand (c-pointer size_t)))

(define magick-get-image-blue-primary
  (foreign-lambda magickboolean MagickGetImageBluePrimary
                  magickwand (c-pointer double) (c-pointer double)))

(define magick-get-image-border-color
  (foreign-lambda magickboolean MagickGetImageBorderColor magickwand pixelwand))

;;(define magick-get-image-channel-depth
;;  (foreign-lambda size_t MagickGetImageChannelDepth magickwand (const channeltype)))

;;(define magick-get-image-channel-distortion
;;  (foreign-lambda magickboolean MagickGetImageChannelDistortion
;;                  magickwand (const magickwand) (const channeltype)
;;                  (const metrictype) (c-pointer double)))

;;(define magick-get-image-channel-distortions
;;  (foreign-lambda (c-pointer double) MagickGetImageChannelDistortions
;;                  magickwand (const magickwand) (const metrictype)))

(define magick-get-image-channel-features
  (foreign-lambda ChannelFeatures MagickGetImageChannelFeatures
                  magickwand (const size_t)))

;;(define magick-get-image-channel-kurtosis
;;  (foreign-lambda magickboolean MagickGetImageChannelKurtosis
;;                  magickwand (const channeltype)
;;                  (c-pointer double) (c-pointer double)))

;;(define magick-get-image-channel-mean
;;  (foreign-lambda magickboolean MagickGetImageChannelMean
;;                  magickwand (const channeltype)
;;                  (c-pointer double) (c-pointer double)))

;;(define magick-get-image-channel-range
;;  (foreign-lambda magickboolean MagickGetImageChannelRange
;;                  magickwand (const channeltype)
;;                  (c-pointer double) (c-pointer double)))

(define magick-get-image-channel-statistics
  (foreign-lambda ChannelStatistics MagickGetImageChannelStatistics magickwand))

(define magick-get-image-colormap-color
  (foreign-lambda magickboolean MagickGetImageColormapColor
                  magickwand (const size_t) pixelwand))

(define magick-get-image-colors
  (foreign-lambda size_t MagickGetImageColors magickwand))

(define magick-get-image-colorspace
  (foreign-lambda colorspace MagickGetImageColorspace magickwand))

(define magick-get-image-compose
  (foreign-lambda compositeoperator MagickGetImageCompose magickwand))

(define magick-get-image-compression
  (foreign-lambda compressiontype MagickGetImageCompression magickwand))

(define magick-get-image-compression-quality
  (foreign-lambda size_t MagickGetImageCompressionQuality magickwand))

(define magick-get-image-delay
  (foreign-lambda size_t MagickGetImageDelay magickwand))

(define magick-get-image-depth
  (foreign-lambda size_t MagickGetImageDepth magickwand))

;;(define magick-get-image-distortion
;;  (foreign-lambda magickboolean MagickGetImageDistortion
;;                  magickwand (const magickwand) (const metrictype)
;;                  (c-pointer double)))

(define magick-get-image-dispose
  (foreign-lambda disposetype MagickGetImageDispose magickwand))

(define magick-get-image-filename
  (foreign-lambda c-string MagickGetImageFilename magickwand))

(define magick-get-image-format
  (foreign-lambda c-string MagickGetImageFormat magickwand))

(define magick-get-image-fuzz
  (foreign-lambda double MagickGetImageFuzz magickwand))

(define magick-get-image-gamma
  (foreign-lambda double MagickGetImageGamma magickwand))

(define magick-get-image-gravity
  (foreign-lambda gravity MagickGetImageGravity magickwand))

(define magick-get-image-green-primary
  (foreign-lambda magickboolean MagickGetImageGreenPrimary
                  magickwand (c-pointer double) (c-pointer double)))

(define magick-get-image-height
  (foreign-lambda size_t MagickGetImageHeight magickwand))

(define magick-get-image-histogram
  (foreign-lambda (c-pointer pixelwand) MagickGetImageHistogram
                  magickwand (c-pointer size_t)))

(define magick-get-image-interlace-scheme
  (foreign-lambda interlacetype MagickGetImageInterlaceScheme magickwand))

(define magick-get-image-interpolate-method
  (foreign-lambda interpolatepixelmethod MagickGetImageInterpolateMethod
                  magickwand))

(define magick-get-image-iterations
  (foreign-lambda size_t MagickGetImageIterations magickwand))

;;(define magick-get-image-length
;;  (foreign-lambda magickboolean MagickGetImageLength magickwand (c-pointer magicksize)))

(define magick-get-image-matte-color
  (foreign-lambda magickboolean MagickGetImageMatteColor
                  magickwand pixelwand))

(define magick-get-image-orientation
  (foreign-lambda orientation MagickGetImageOrientation magickwand))

(define magick-get-image-page
  (foreign-lambda magickboolean MagickGetImagePage
                  magickwand
                  (c-pointer size_t) (c-pointer size_t)
                  (c-pointer ssize_t) (c-pointer ssize_t)))

(define magick-get-image-pixel-color
  (foreign-lambda magickboolean MagickGetImagePixelColor
                  magickwand (const ssize_t) (const ssize_t)
                  pixelwand))

(define magick-get-image-red-primary
  (foreign-lambda magickboolean MagickGetImageRedPrimary
                  magickwand (c-pointer double) (c-pointer double)))

(define magick-get-image-region
  (foreign-lambda magickwand MagickGetImageRegion
                  magickwand (const size_t) (const size_t)
                  (const ssize_t) (const ssize_t)))

(define magick-get-image-rendering-intent
  (foreign-lambda renderingintent MagickGetImageRenderingIntent magickwand))

(define magick-get-image-resolution
  (foreign-lambda magickboolean MagickGetImageResolution
                  magickwand (c-pointer double) (c-pointer double)))

(define magick-get-image-scene
  (foreign-lambda size_t MagickGetImageScene magickwand))

(define magick-get-image-signature
  (foreign-lambda c-string MagickGetImageSignature magickwand))

(define magick-get-image-ticks-per-second
  (foreign-lambda size_t MagickGetImageTicksPerSecond magickwand))

(define magick-get-image-type
  (foreign-lambda imagetype MagickGetImageType magickwand))

(define magick-get-image-units
  (foreign-lambda resolutiontype MagickGetImageUnits magickwand))

(define magick-get-image-virtual-pixel-method
  (foreign-lambda virtualpixelmethod MagickGetImageVirtualPixelMethod magickwand))

(define magick-get-image-white-point
  (foreign-lambda magickboolean MagickGetImageWhitePoint
                  magickwand (c-pointer double) (c-pointer double)))

(define magick-get-image-width
  (foreign-lambda size_t MagickGetImageWidth magickwand))

(define magick-get-number-images
  (foreign-lambda size_t MagickGetNumberImages magickwand))

(define magick-get-image-total-ink-density
  (foreign-lambda double MagickGetImageTotalInkDensity magickwand))

(define magick-hald-clut-image
  (foreign-lambda magickboolean MagickHaldClutImage magickwand (const magickwand)))

;;(define magick-hald-clut-image-channel
;;  (foreign-lambda magickboolean MagickHaldClutImageChannel
;;                  magickwand (const channeltype) (const magickwand)))

(define magick-has-next-image
  (foreign-lambda magickboolean MagickHasNextImage magickwand))

(define magick-has-previous-image
  (foreign-lambda magickboolean MagickHasPreviousImage magickwand))

(define magick-identify-image
  (foreign-lambda c-string MagickIdentifyImage magickwand))

(define magick-implode-image
  (foreign-lambda magickboolean MagickImplodeImage magickwand (const double)))

;;(define magick-import-image-pixels
;;  (foreign-lambda magickboolean MagickImportImagePixels
;;                  magickwand (const ssize_t) (const ssize_t)
;;                  (const size_t) (const size_t)
;;                  (const c-string) (const storagetype)
;;                  (const c-pointer)))

;;(define magick-inverse-fourier-transform-image
;;  (foreign-lambda magickboolean MagickInverseFourierTransformImage
;;                  magickwand magickwand (const magickboolean)))

(define magick-label-image
  (foreign-lambda magickboolean MagickLabelImage
                  magickwand (const c-string)))

(define magick-level-image
  (foreign-lambda magickboolean MagickLevelImage
                  magickwand (const double) (const double)
                  (const double)))

;;(define magick-level-image-channel
;;  (foreign-lambda magickboolean MagickLevelImageChannel
;;                  magickwand (const channeltype)
;;                  (const double) (const double)
;;                  (const double)))

(define magick-linear-stretch-image
  (foreign-lambda magickboolean MagickLinearStretchImage
                  magickwand (const double) (const double)))

(define magick-liquid-rescale-image
  (foreign-lambda magickboolean MagickLiquidRescaleImage
                  magickwand (const size_t) (const size_t)
                  (const double) (const double)))

(define magick-magnify-image
  (foreign-lambda magickboolean MagickMagnifyImage magickwand))

;;(define magick-merge-image-layers
;;  (foreign-lambda magickwand MagickMergeImageLayers
;;                  magickwand (const imagelayermethod)))

(define magick-minify-image
  (foreign-lambda magickboolean MagickMinifyImage magickwand))

(define magick-modulate-image
  (foreign-lambda magickboolean MagickModulateImage
                  magickwand (const double) (const double) (const double)))

;;(define magick-montage-image
;;  (foreign-lambda magickwand MagickMontageImage
;;                  magickwand (const drawingwand)
;;                  (const c-string) (const c-string)
;;                  (const montagemode) (const c-string)))

(define magick-morph-images
  (foreign-lambda magickwand MagickMorphImages
                  magickwand (const size_t)))

;;(define magick-morphology-image
;;  (foreign-lambda magickboolean MagickMorphologyImage
;;                  magickwand morphologymethod
;;                  (const ssize_t) KernelInfo))

;;(define magick-morphology-image-channel
;;  (foreign-lambda magickboolean MagickMorphologyImageChannel
;;                  magickwand channeltype morphologymethod
;;                  (const ssize_t) KernelInfo))

(define magick-motion-blur-image
  (foreign-lambda magickboolean MagickMotionBlurImage
                  magickwand
                  (const double) (const double) (const double)))

;;(define magick-motion-blur-image-channel
;;  (foreign-lambda magickboolean MagickMotionBlurImageChannel
;;                  magickwand (const channeltype)
;;                  (const double) (const double) (const double)))

;;(define magick-negate-image
;;  (foreign-lambda magickboolean MagickNegateImage
;;                  magickwand (const magickboolean)))

;;(define magick-negate-image-channel
;;  (foreign-lambda magickboolean MagickNegateImageChannel
;;                  magickwand (const channeltype)
;;                  (const magickboolean)))

(define magick-new-image
  (foreign-lambda magickboolean MagickNewImage
                  magickwand (const size_t) (const size_t)
                  (const pixelwand)))

(define magick-next-image
  (foreign-lambda magickboolean MagickNextImage magickwand))

(define magick-normalize-image
  (foreign-lambda magickboolean MagickNormalizeImage magickwand))

;;(define magick-normalize-image-channel
;;  (foreign-lambda magickboolean MagickNormalizeImageChannel
;;                  magickwand (const channeltype)))

(define magick-oil-paint-image
  (foreign-lambda magickboolean MagickOilPaintImage
                  magickwand (const double)))

;;(define magick-opaque-paint-image
;;  (foreign-lambda magickboolean MagickOpaquePaintImage
;;                  magickwand (const pixelwand) (const pixelwand)
;;                  (const double) (const magickboolean)))

;;(define magick-opaque-paint-image-channel
;;  (foreign-lambda magickboolean MagickOpaquePaintImageChannel
;;                  magickwand (const channeltype)
;;                  (const pixelwand) (const pixelwand)
;;                  (const double) (const magickboolean)))

(define magick-optimize-image-layers
  (foreign-lambda magickwand MagickOptimizeImageLayers magickwand))

(define magick-ordered-posterize-image
  (foreign-lambda magickboolean MagickOrderedPosterizeImage
                  magickwand (const c-string)))

;;(define magick-ordered-posterize-image-channel
;;  (foreign-lambda magickboolean MagickOrderedPosterizeImageChannel
;;                  magickwand (const channeltype) (const c-string)))

(define magick-ping-image
  (foreign-lambda magickboolean MagickPingImage magickwand (const c-string)))

(define magick-ping-image-blob
  (foreign-lambda magickboolean MagickPingImageBlob
                  magickwand (const c-pointer) (const size_t)))

;;(define magick-ping-image-file
;;  (foreign-lambda magickboolean MagickPingImageFile
;;                  magickwand (c-pointer FILE)))

(define magick-polaroid-image
  (foreign-lambda magickboolean MagickPolaroidImage
                  magickwand (const drawingwand) (const double)))

;;(define magick-posterize-image
;;  (foreign-lambda magickboolean MagickPosterizeImage
;;                  magickwand (const size_t) (const magickboolean)))

;;(define magick-preview-images
;;  (foreign-lambda magickwand MagickPreviewImages
;;                  magickwand (const previewtype)))

(define magick-previous-image
  (foreign-lambda magickboolean MagickPreviousImage magickwand))

;;(define magick-quantize-image
;;  (foreign-lambda magickboolean MagickQuantizeImage
;;                  magickwand (const size_t) (const colorspace)
;;                  (const size_t) (const magickboolean)
;;                  (const magickboolean)))

;;(define magick-quantize-images
;;  (foreign-lambda magickboolean MagickQuantizeImages
;;                  magickwand (const size_t) (const colorspace)
;;                  (const size_t) (const magickboolean)
;;                  (const magickboolean)))

(define magick-radial-blur-image
  (foreign-lambda magickboolean MagickRadialBlurImage
                  magickwand (const double)))

;;(define magick-radial-blur-image-channel
;;  (foreign-lambda magickboolean MagickRadialBlurImageChannel
;;                  magickwand (const channeltype) (const double)))

;;(define magick-raise-image
;;  (foreign-lambda magickboolean MagickRaiseImage
;;                  magickwand (const size_t) (const size_t)
;;                  (const ssize_t) (const ssize_t) (const magickboolean)))

(define magick-random-threshold-image
  (foreign-lambda magickboolean MagickRandomThresholdImage
                  magickwand (const double) (const double)))

;;(define magick-random-threshold-image-channel
;;  (foreign-lambda magickboolean MagickRandomThresholdImageChannel
;;                  magickwand (const channeltype)
;;                  (const double) (const double)))

(define magick-read-image
  (foreign-lambda magickboolean MagickReadImage
                  magickwand (const c-string)))

(define magick-read-image-blob
  (foreign-lambda magickboolean MagickReadImageBlob
                  magickwand (const c-pointer) (const size_t)))

;;(define magick-read-image-file
;;  (foreign-lambda magickboolean MagickReadImageFile
;;                  magickwand (c-pointer FILE)))

;;(define magick-remap-image
;;  (foreign-lambda magickboolean MagickRemapImage
;;                  magickwand (const magickwand) (const dithermethod)))

(define magick-remove-image
  (foreign-lambda magickboolean MagickRemoveImage magickwand))

;;(define magick-resample-image
;;  (foreign-lambda magickboolean MagickResampleImage
;;                  magickwand (const double) (const double)
;;                  (const filtertypes) (const double)))

(define magick-reset-image-page
  (foreign-lambda magickboolean MagickResetImagePage
                  magickwand (const c-string)))

;;(define magick-resize-image
;;  (foreign-lambda magickboolean MagickResizeImage
;;                  magickwand (const size_t) (const size_t)
;;                  (const filtertypes) (const double)))

(define magick-roll-image
  (foreign-lambda magickboolean MagickRollImage
                  magickwand (const ssize_t) (const ssize_t)))

(define magick-rotate-image
  (foreign-lambda magickboolean MagickRotateImage
                  magickwand (const pixelwand) (const double)))

(define magick-sample-image
  (foreign-lambda magickboolean MagickSampleImage
                  magickwand (const size_t) (const size_t)))

(define magick-scale-image
  (foreign-lambda magickboolean MagickScaleImage
                  magickwand (const size_t) (const size_t)))

;;(define magick-segment-image
;;  (foreign-lambda magickboolean MagickSegmentImage
;;                  magickwand (const colorspace) (const magickboolean)
;;                  (const double) (const double)))

(define magick-selective-blur-image
  (foreign-lambda magickboolean MagickSelectiveBlurImage
                  magickwand (const double) (const double) (const double)))

;;(define magick-selective-blur-image-channel
;;  (foreign-lambda magickboolean MagickSelectiveBlurImageChannel
;;                  magickwand (const channeltype)
;;                  (const double) (const double) (const double)))

;;(define magick-separate-image-channel
;;  (foreign-lambda magickboolean MagickSeparateImageChannel
;;                  magickwand (const channeltype)))

(define magick-sepia-tone-image
  (foreign-lambda magickboolean MagickSepiaToneImage
                  magickwand (const double)))

#|
(define magick-set-image
  (foreign-lambda void MagickSetImage))

(define magick-set-image-alpha-channel
  (foreign-lambda void MagickSetImageAlphaChannel))

(define magick-set-image-background-color
  (foreign-lambda void MagickSetImageBackgroundColor))

(define magick-set-image-bias
  (foreign-lambda void MagickSetImageBias))

(define magick-set-image-blue-primary
  (foreign-lambda void MagickSetImageBluePrimary))

(define magick-set-image-border-color
  (foreign-lambda void MagickSetImageBorderColor))

(define magick-set-image-channel-depth
  (foreign-lambda void MagickSetImageChannelDepth))

(define magick-set-image-clip-mask
  (foreign-lambda void MagickSetImageClipMask))

(define magick-set-image-color
  (foreign-lambda void MagickSetImageColor))

(define magick-set-image-colormap-color
  (foreign-lambda void MagickSetImageColormapColor))

(define magick-set-image-colorspace
  (foreign-lambda void MagickSetImageColorspace))

(define magick-set-image-compose
  (foreign-lambda void MagickSetImageCompose))

(define magick-set-image-compression
  (foreign-lambda void MagickSetImageCompression))

(define magick-set-image-compression-quality
  (foreign-lambda void MagickSetImageCompressionQuality))

(define magick-set-image-delay
  (foreign-lambda void MagickSetImageDelay))

(define magick-set-image-depth
  (foreign-lambda void MagickSetImageDepth))

(define magick-set-image-dispose
  (foreign-lambda void MagickSetImageDispose))

(define magick-set-image-extent
  (foreign-lambda void MagickSetImageExtent))

(define magick-set-image-filename
  (foreign-lambda void MagickSetImageFilename))

(define magick-set-image-format
  (foreign-lambda void MagickSetImageFormat))

(define magick-set-image-fuzz
  (foreign-lambda void MagickSetImageFuzz))

(define magick-set-image-gamma
  (foreign-lambda void MagickSetImageGamma))

(define magick-set-image-gravity
  (foreign-lambda void MagickSetImageGravity))

(define magick-set-image-green-primary
  (foreign-lambda void MagickSetImageGreenPrimary))

(define magick-set-image-interlace-scheme
  (foreign-lambda void MagickSetImageInterlaceScheme))

(define magick-set-image-interpolate-method
  (foreign-lambda void MagickSetImageInterpolateMethod))

(define magick-set-image-iterations
  (foreign-lambda void MagickSetImageIterations))

(define magick-set-image-matte
  (foreign-lambda void MagickSetImageMatte))

(define magick-set-image-matte-color
  (foreign-lambda void MagickSetImageMatteColor))

(define magick-set-image-opacity
  (foreign-lambda void MagickSetImageOpacity))

(define magick-set-image-orientation
  (foreign-lambda void MagickSetImageOrientation))

(define magick-set-image-page
  (foreign-lambda void MagickSetImagePage))

(define magick-set-image-progress-monitor
  (foreign-lambda void MagickSetImageProgressMonitor))

(define magick-set-image-red-primary
  (foreign-lambda void MagickSetImageRedPrimary))

(define magick-set-image-rendering-intent
  (foreign-lambda void MagickSetImageRenderingIntent))

(define magick-set-image-resolution
  (foreign-lambda void MagickSetImageResolution))

(define magick-set-image-scene
  (foreign-lambda void MagickSetImageScene))

(define magick-set-image-ticks-per-second
  (foreign-lambda void MagickSetImageTicksPerSecond))

(define magick-set-image-type
  (foreign-lambda void MagickSetImageType))

(define magick-set-image-units
  (foreign-lambda void MagickSetImageUnits))

(define magick-set-image-virtual-pixel-method
  (foreign-lambda void MagickSetImageVirtualPixelMethod))

(define magick-set-image-white-point
  (foreign-lambda void MagickSetImageWhitePoint))

(define magick-shade-image
  (foreign-lambda void MagickShadeImage))

(define magick-shadow-image
  (foreign-lambda void MagickShadowImage))

(define magick-sharpen-image
  (foreign-lambda void MagickSharpenImage))

(define magick-shave-image
  (foreign-lambda void MagickShaveImage))

(define magick-shear-image
  (foreign-lambda void MagickShearImage))

(define magick-sigmoidal-contrast-image
  (foreign-lambda void MagickSigmoidalContrastImage))

(define magick-similarity-image
  (foreign-lambda void MagickSimilarityImage))

(define magick-sketch-image
  (foreign-lambda void MagickSketchImage))

(define magick-smush-images
  (foreign-lambda void MagickSmushImages))

(define magick-solarize-image
  (foreign-lambda void MagickSolarizeImage))

(define magick-sparse-color-image
  (foreign-lambda void MagickSparseColorImage))

(define magick-splice-image
  (foreign-lambda void MagickSpliceImage))

(define magick-spread-image
  (foreign-lambda void MagickSpreadImage))

(define magick-statistic-image
  (foreign-lambda void MagickStatisticImage))

(define magick-stegano-image
  (foreign-lambda void MagickSteganoImage))

(define magick-stereo-image
  (foreign-lambda void MagickStereoImage))

(define magick-strip-image
  (foreign-lambda void MagickStripImage))

(define magick-swirl-image
  (foreign-lambda void MagickSwirlImage))

(define magick-texture-image
  (foreign-lambda void MagickTextureImage))

(define magick-threshold-image
  (foreign-lambda void MagickThresholdImage))

(define magick-thumbnail-image
  (foreign-lambda void MagickThumbnailImage))

(define magick-tint-image
  (foreign-lambda void MagickTintImage))

(define magick-transform-image
  (foreign-lambda void MagickTransformImage))

(define magick-transform-image-colorspace
  (foreign-lambda void MagickTransformImageColorspace))

(define magick-transparent-paint-image
  (foreign-lambda void MagickTransparentPaintImage))

(define magick-transpose-image
  (foreign-lambda void MagickTransposeImage))

(define magick-transverse-image
  (foreign-lambda void MagickTransverseImage))

(define magick-trim-image
  (foreign-lambda void MagickTrimImage))

(define magick-unique-image-colors
  (foreign-lambda void MagickUniqueImageColors))

(define magick-unsharp-mask-image
  (foreign-lambda void MagickUnsharpMaskImage))

(define magick-vignette-image
  (foreign-lambda void MagickVignetteImage))

(define magick-wave-image
  (foreign-lambda void MagickWaveImage))

(define magick-white-threshold-image
  (foreign-lambda void MagickWhiteThresholdImage))

(define magick-write-image
  (foreign-lambda void MagickWriteImage))

(define magick-write-image-file
  (foreign-lambda void MagickWriteImageFile))

(define magick-write-images
  (foreign-lambda void MagickWriteImages))

(define magick-write-images-file
  (foreign-lambda void MagickWriteImagesFile))
|#


;;;
;;; Pixel-iterator methods
;;;

#|
(define clear-pixel-iterator
  (foreign-lambda void ClearPixelIterator))

(define clone-pixel-iterator
  (foreign-lambda void ClonePixelIterator))

(define destroy-pixel-iterator
  (foreign-lambda void DestroyPixelIterator))

(define pixel-iterator?
  (foreign-lambda void IsPixelIterator))

(define new-pixel-iterator
  (foreign-lambda void NewPixelIterator))

(define pixel-clear-iterator-exception
  (foreign-lambda void PixelClearIteratorException))

(define new-pixel-region-iterator
  (foreign-lambda void NewPixelRegionIterator))

(define pixel-get-current-iterator-row
  (foreign-lambda void PixelGetCurrentIteratorRow))

(define pixel-get-iterator-exception
  (foreign-lambda void PixelGetIteratorException))

(define pixel-get-iterator-exception-type
  (foreign-lambda void PixelGetIteratorExceptionType))

(define pixel-get-iterator-row
  (foreign-lambda void PixelGetIteratorRow))

(define pixel-get-next-iterator-row
  (foreign-lambda void PixelGetNextIteratorRow))

(define pixel-get-previous-iterator-row
  (foreign-lambda void PixelGetPreviousIteratorRow))

(define pixel-reset-iterator
  (foreign-lambda void PixelResetIterator))

(define pixel-set-first-iterator-row
  (foreign-lambda void PixelSetFirstIteratorRow))

(define pixel-set-iterator-row
  (foreign-lambda void PixelSetIteratorRow))

(define pixel-set-last-iterator-row
  (foreign-lambda void PixelSetLastIteratorRow))

(define pixel-sync-iterator
  (foreign-lambda void PixelSyncIterator))
|#


;;;
;;; Pixel-wand methods
;;;

#|
(define clear-pixel-wand
  (foreign-lambda void ClearPixelWand))

(define clone-pixel-wand
  (foreign-lambda void ClonePixelWand))

(define clone-pixel-wands
  (foreign-lambda void ClonePixelWands))

(define destroy-pixel-wand
  (foreign-lambda void DestroyPixelWand))

(define destroy-pixel-wands
  (foreign-lambda void DestroyPixelWands))

(define is-pixel-wand-similar
  (foreign-lambda void IsPixelWandSimilar))

(define pixel-wand?
  (foreign-lambda void IsPixelWand))

(define new-pixel-wand
  (foreign-lambda void NewPixelWand))

(define new-pixel-wands
  (foreign-lambda void NewPixelWands))

(define pixel-clear-exception
  (foreign-lambda void PixelClearException))

(define pixel-get-alpha
  (foreign-lambda void PixelGetAlpha))

(define pixel-get-alpha-quantum
  (foreign-lambda void PixelGetAlphaQuantum))

(define pixel-get-black
  (foreign-lambda void PixelGetBlack))

(define pixel-get-black-quantum
  (foreign-lambda void PixelGetBlackQuantum))

(define pixel-get-blue
  (foreign-lambda void PixelGetBlue))

(define pixel-get-blue-quantum
  (foreign-lambda void PixelGetBlueQuantum))

(define pixel-get-color-as-string
  (foreign-lambda void PixelGetColorAsString))

(define pixel-get-color-as-normalized-string
  (foreign-lambda void PixelGetColorAsNormalizedString))

(define pixel-get-color-count
  (foreign-lambda void PixelGetColorCount))

(define pixel-get-cyan
  (foreign-lambda void PixelGetCyan))

(define pixel-get-cyan-quantum
  (foreign-lambda void PixelGetCyanQuantum))

(define pixel-get-exception
  (foreign-lambda void PixelGetException))

(define pixel-get-exception-type
  (foreign-lambda void PixelGetExceptionType))

(define pixel-get-fuzz
  (foreign-lambda void PixelGetFuzz))

(define pixel-get-green
  (foreign-lambda void PixelGetGreen))

(define pixel-get-green-quantum
  (foreign-lambda void PixelGetGreenQuantum))

(define pixel-get-hsl
  (foreign-lambda void PixelGetHSL))

(define pixel-get-index
  (foreign-lambda void PixelGetIndex))

(define pixel-get-magenta
  (foreign-lambda void PixelGetMagenta))

(define pixel-get-magenta-quantum
  (foreign-lambda void PixelGetMagentaQuantum))

(define pixel-get-magick-color
  (foreign-lambda void PixelGetMagickColor))

(define pixel-get-opacity
  (foreign-lambda void PixelGetOpacity))

(define pixel-get-opacity-quantum
  (foreign-lambda void PixelGetOpacityQuantum))

(define pixel-get-quantum-color
  (foreign-lambda void PixelGetQuantumColor))

(define pixel-get-red
  (foreign-lambda void PixelGetRed))

(define pixel-get-red-quantum
  (foreign-lambda void PixelGetRedQuantum))

(define pixel-get-yellow
  (foreign-lambda void PixelGetYellow))

(define pixel-get-yellow-quantum
  (foreign-lambda void PixelGetYellowQuantum))

(define pixel-set-alpha
  (foreign-lambda void PixelSetAlpha))

(define pixel-set-alpha-quantum
  (foreign-lambda void PixelSetAlphaQuantum))

(define pixel-set-black
  (foreign-lambda void PixelSetBlack))

(define pixel-set-black-quantum
  (foreign-lambda void PixelSetBlackQuantum))

(define pixel-set-blue
  (foreign-lambda void PixelSetBlue))

(define pixel-set-blue-quantum
  (foreign-lambda void PixelSetBlueQuantum))

(define pixel-set-color
  (foreign-lambda void PixelSetColor))

(define pixel-set-color-count
  (foreign-lambda void PixelSetColorCount))

(define pixel-set-color-from-wand
  (foreign-lambda void PixelSetColorFromWand))

(define pixel-set-cyan
  (foreign-lambda void PixelSetCyan))

(define pixel-set-cyan-quantum
  (foreign-lambda void PixelSetCyanQuantum))

(define pixel-set-fuzz
  (foreign-lambda void PixelSetFuzz))

(define pixel-set-green
  (foreign-lambda void PixelSetGreen))

(define pixel-set-green-quantum
  (foreign-lambda void PixelSetGreenQuantum))

(define pixel-set-hsl
  (foreign-lambda void PixelSetHSL))

(define pixel-set-index
  (foreign-lambda void PixelSetIndex))

(define pixel-set-magenta
  (foreign-lambda void PixelSetMagenta))

(define pixel-set-magenta-quantum
  (foreign-lambda void PixelSetMagentaQuantum))

(define pixel-set-magick-color
  (foreign-lambda void PixelSetMagickColor))

(define pixel-set-opacity
  (foreign-lambda void PixelSetOpacity))

(define pixel-set-opacity-quantum
  (foreign-lambda void PixelSetOpacityQuantum))

(define pixel-set-quantum-color
  (foreign-lambda void PixelSetQuantumColor))

(define pixel-set-red
  (foreign-lambda void PixelSetRed))

(define pixel-set-red-quantum
  (foreign-lambda void PixelSetRedQuantum))

(define pixel-set-yellow
  (foreign-lambda void PixelSetYellow))

(define pixel-set-yellow-quantum
  (foreign-lambda void PixelSetYellowQuantum))
|#


;;;
;;; Drawing-wand methods
;;;

#|
(define clear-drawing-wand
  (foreign-lambda void ClearDrawingWand))

(define clone-drawing-wand
  (foreign-lambda void CloneDrawingWand))

(define destroy-drawing-wand
  (foreign-lambda void DestroyDrawingWand))

(define draw-affine
  (foreign-lambda void DrawAffine))

(define draw-annotation
  (foreign-lambda void DrawAnnotation))

(define draw-arc
  (foreign-lambda void DrawArc))

(define draw-bezier
  (foreign-lambda void DrawBezier))

(define draw-circle
  (foreign-lambda void DrawCircle))

(define draw-clear-exception
  (foreign-lambda void DrawClearException))

(define draw-composite
  (foreign-lambda void DrawComposite))

(define draw-color
  (foreign-lambda void DrawColor))

(define draw-comment
  (foreign-lambda void DrawComment))

(define draw-ellipse
  (foreign-lambda void DrawEllipse))

(define draw-get-border-color
  (foreign-lambda void DrawGetBorderColor))

(define draw-get-clip-path
  (foreign-lambda void DrawGetClipPath))

(define draw-get-clip-rule
  (foreign-lambda void DrawGetClipRule))

(define draw-get-clip-units
  (foreign-lambda void DrawGetClipUnits))

(define draw-get-exception
  (foreign-lambda void DrawGetException))

(define draw-get-exception-type
  (foreign-lambda void DrawGetExceptionType))

(define draw-get-fill-color
  (foreign-lambda void DrawGetFillColor))

(define draw-get-fill-opacity
  (foreign-lambda void DrawGetFillOpacity))

(define draw-get-fill-rule
  (foreign-lambda void DrawGetFillRule))

(define draw-get-font
  (foreign-lambda void DrawGetFont))

(define draw-get-font-family
  (foreign-lambda void DrawGetFontFamily))

(define draw-get-font-resolution
  (foreign-lambda void DrawGetFontResolution))

(define draw-get-font-size
  (foreign-lambda void DrawGetFontSize))

(define draw-get-font-stretch
  (foreign-lambda void DrawGetFontStretch))

(define draw-get-font-style
  (foreign-lambda void DrawGetFontStyle))

(define draw-get-font-weight
  (foreign-lambda void DrawGetFontWeight))

(define draw-get-gravity
  (foreign-lambda void DrawGetGravity))

(define draw-get-opacity
  (foreign-lambda void DrawGetOpacity))

(define draw-get-stroke-antialias
  (foreign-lambda void DrawGetStrokeAntialias))

(define draw-get-stroke-color
  (foreign-lambda void DrawGetStrokeColor))

(define draw-get-stroke-dash-array
  (foreign-lambda void DrawGetStrokeDashArray))

(define draw-get-stroke-dash-offset
  (foreign-lambda void DrawGetStrokeDashOffset))

(define draw-get-stroke-line-cap
  (foreign-lambda void DrawGetStrokeLineCap))

(define draw-get-stroke-line-join
  (foreign-lambda void DrawGetStrokeLineJoin))

(define draw-get-stroke-miter-limit
  (foreign-lambda void DrawGetStrokeMiterLimit))

(define draw-get-stroke-opacity
  (foreign-lambda void DrawGetStrokeOpacity))

(define draw-get-stroke-width
  (foreign-lambda void DrawGetStrokeWidth))

(define draw-get-text-alignment
  (foreign-lambda void DrawGetTextAlignment))

(define draw-get-text-antialias
  (foreign-lambda void DrawGetTextAntialias))

(define draw-get-text-decoration
  (foreign-lambda void DrawGetTextDecoration))

(define draw-get-text-encoding
  (foreign-lambda void DrawGetTextEncoding))

(define draw-get-text-kerning
  (foreign-lambda void DrawGetTextKerning))

(define draw-get-text-interword-spacing
  (foreign-lambda void DrawGetTextInterwordSpacing))

(define draw-get-text-interword-spacing
  (foreign-lambda void DrawGetTextInterwordSpacing))

(define draw-get-vector-graphics
  (foreign-lambda void DrawGetVectorGraphics))

(define draw-get-text-under-color
  (foreign-lambda void DrawGetTextUnderColor))

(define draw-line
  (foreign-lambda void DrawLine))

(define draw-matte
  (foreign-lambda void DrawMatte))

(define draw-path-close
  (foreign-lambda void DrawPathClose))

(define draw-path-curve-to-absolute
  (foreign-lambda void DrawPathCurveToAbsolute))

(define draw-path-curve-to-relative
  (foreign-lambda void DrawPathCurveToRelative))

(define draw-path-curve-to-quadratic-bezier-absolute
  (foreign-lambda void DrawPathCurveToQuadraticBezierAbsolute))

(define draw-path-curve-to-quadratic-bezier-relative
  (foreign-lambda void DrawPathCurveToQuadraticBezierRelative))

(define draw-path-curve-to-quadratic-bezier-smooth-absolute
  (foreign-lambda void DrawPathCurveToQuadraticBezierSmoothAbsolute))

(define draw-path-curve-to-quadratic-bezier-smooth-absolute
  (foreign-lambda void DrawPathCurveToQuadraticBezierSmoothAbsolute))

(define draw-path-curve-to-smooth-absolute
  (foreign-lambda void DrawPathCurveToSmoothAbsolute))

(define draw-path-curve-to-smooth-relative
  (foreign-lambda void DrawPathCurveToSmoothRelative))

(define draw-path-elliptic-arc-absolute
  (foreign-lambda void DrawPathEllipticArcAbsolute))

(define draw-path-elliptic-arc-relative
  (foreign-lambda void DrawPathEllipticArcRelative))

(define draw-path-finish
  (foreign-lambda void DrawPathFinish))

(define draw-path-line-to-absolute
  (foreign-lambda void DrawPathLineToAbsolute))

(define draw-path-line-to-relative
  (foreign-lambda void DrawPathLineToRelative))

(define draw-path-line-to-horizontal-absolute
  (foreign-lambda void DrawPathLineToHorizontalAbsolute))

(define draw-path-line-to-horizontal-relative
  (foreign-lambda void DrawPathLineToHorizontalRelative))

(define draw-path-line-to-vertical-absolute
  (foreign-lambda void DrawPathLineToVerticalAbsolute))

(define draw-path-line-to-vertical-relative
  (foreign-lambda void DrawPathLineToVerticalRelative))

(define draw-path-move-to-absolute
  (foreign-lambda void DrawPathMoveToAbsolute))

(define draw-path-move-to-relative
  (foreign-lambda void DrawPathMoveToRelative))

(define draw-path-start
  (foreign-lambda void DrawPathStart))

(define draw-point
  (foreign-lambda void DrawPoint))

(define draw-polygon
  (foreign-lambda void DrawPolygon))

(define draw-polyline
  (foreign-lambda void DrawPolyline))

(define draw-pop-clip-path
  (foreign-lambda void DrawPopClipPath))

(define draw-pop-defs
  (foreign-lambda void DrawPopDefs))

(define draw-pop-pattern
  (foreign-lambda void DrawPopPattern))

(define draw-push-clip-path
  (foreign-lambda void DrawPushClipPath))

(define draw-push-defs
  (foreign-lambda void DrawPushDefs))

(define draw-push-pattern
  (foreign-lambda void DrawPushPattern))

(define draw-rectangle
  (foreign-lambda void DrawRectangle))

(define draw-reset-vector-graphics
  (foreign-lambda void DrawResetVectorGraphics))

(define draw-rotate
  (foreign-lambda void DrawRotate))

(define draw-round-rectangle
  (foreign-lambda void DrawRoundRectangle))

(define draw-scale
  (foreign-lambda void DrawScale))

(define draw-set-border-color
  (foreign-lambda void DrawSetBorderColor))

(define draw-set-clip-path
  (foreign-lambda void DrawSetClipPath))

(define draw-set-clip-rule
  (foreign-lambda void DrawSetClipRule))

(define draw-set-clip-units
  (foreign-lambda void DrawSetClipUnits))

(define draw-set-fill-color
  (foreign-lambda void DrawSetFillColor))

(define draw-set-fill-opacity
  (foreign-lambda void DrawSetFillOpacity))

(define draw-set-font-resolution
  (foreign-lambda void DrawSetFontResolution))

(define draw-set-opacity
  (foreign-lambda void DrawSetOpacity))

(define draw-set-fill-pattern-url
  (foreign-lambda void DrawSetFillPatternURL))

(define draw-set-fill-rule
  (foreign-lambda void DrawSetFillRule))

(define draw-set-font
  (foreign-lambda void DrawSetFont))

(define draw-set-font-family
  (foreign-lambda void DrawSetFontFamily))

(define draw-set-font-size
  (foreign-lambda void DrawSetFontSize))

(define draw-set-font-stretch
  (foreign-lambda void DrawSetFontStretch))

(define draw-set-font-style
  (foreign-lambda void DrawSetFontStyle))

(define draw-set-font-weight
  (foreign-lambda void DrawSetFontWeight))

(define draw-set-gravity
  (foreign-lambda void DrawSetGravity))

(define draw-set-stroke-color
  (foreign-lambda void DrawSetStrokeColor))

(define draw-set-stroke-pattern-url
  (foreign-lambda void DrawSetStrokePatternURL))

(define draw-set-stroke-antialias
  (foreign-lambda void DrawSetStrokeAntialias))

(define draw-set-stroke-dash-array
  (foreign-lambda void DrawSetStrokeDashArray))

(define draw-set-stroke-dash-offset
  (foreign-lambda void DrawSetStrokeDashOffset))

(define draw-set-stroke-line-cap
  (foreign-lambda void DrawSetStrokeLineCap))

(define draw-set-stroke-line-join
  (foreign-lambda void DrawSetStrokeLineJoin))

(define draw-set-stroke-miter-limit
  (foreign-lambda void DrawSetStrokeMiterLimit))

(define draw-set-stroke-opacity
  (foreign-lambda void DrawSetStrokeOpacity))

(define draw-set-stroke-width
  (foreign-lambda void DrawSetStrokeWidth))

(define draw-set-text-alignment
  (foreign-lambda void DrawSetTextAlignment))

(define draw-set-text-antialias
  (foreign-lambda void DrawSetTextAntialias))

(define draw-set-text-decoration
  (foreign-lambda void DrawSetTextDecoration))

(define draw-set-text-encoding
  (foreign-lambda void DrawSetTextEncoding))

(define draw-set-text-kerning
  (foreign-lambda void DrawSetTextKerning))

(define draw-set-text-interword-spacing
  (foreign-lambda void DrawSetTextInterwordSpacing))

(define draw-set-text-interword-spacing
  (foreign-lambda void DrawSetTextInterwordSpacing))

(define draw-set-text-under-color
  (foreign-lambda void DrawSetTextUnderColor))

(define draw-set-vector-graphics
  (foreign-lambda void DrawSetVectorGraphics))

(define draw-skew-x
  (foreign-lambda void DrawSkewX))

(define draw-skew-y
  (foreign-lambda void DrawSkewY))

(define draw-translate
  (foreign-lambda void DrawTranslate))

(define draw-set-viewbox
  (foreign-lambda void DrawSetViewbox))

(define drawing-wand?
  (foreign-lambda void IsDrawingWand))

(define new-drawing-wand
  (foreign-lambda void NewDrawingWand))

(define peek-drawing-wand
  (foreign-lambda void PeekDrawingWand))

(define pop-drawing-wand
  (foreign-lambda void PopDrawingWand))

(define push-drawing-wand
  (foreign-lambda void PushDrawingWand))
|#


;;;
;;; Command-line methods
;;;

#|
(define magick-command-genesis
  (foreign-lambda magickboolean MagickCommandGenesis
                  imageinfo                   ;; *image_info
                  magickcommand               ;; command
                  int                         ;; argc
                  (c-pointer c-string)        ;; argv
                  (c-pointer c-string)        ;; metadata
                  (c-pointer exceptioninfo))) ;; exception
|#


;;;
;;; Wand-view methods
;;;

#|
(define clone-wand-view
  (foreign-lambda void CloneWandView))

(define destroy-wand-view
  (foreign-lambda void DestroyWandView))

(define duplex-transfer-wand-view-iterator
  (foreign-lambda void DuplexTransferWandViewIterator))

(define get-wand-view-exception
  (foreign-lambda void GetWandViewException))

(define get-wand-view-extent
  (foreign-lambda void GetWandViewExtent))

(define get-wand-view-iterator
  (foreign-lambda void GetWandViewIterator))

(define get-wand-view-pixels
  (foreign-lambda void GetWandViewPixels))

(define get-wand-view-wand
  (foreign-lambda void GetWandViewWand))

(define wand-view?
  (foreign-lambda void IsWandView))

(define new-wand-view
  (foreign-lambda void NewWandView))

(define new-wand-view-extent
  (foreign-lambda void NewWandViewExtent))

(define set-wand-view-description
  (foreign-lambda void SetWandViewDescription))

(define set-wand-view-iterator
  (foreign-lambda void SetWandViewIterator))

(define set-wand-view-threads
  (foreign-lambda void SetWandViewThreads))

(define transfer-wand-view-iterator
  (foreign-lambda void TransferWandViewIterator))

(define update-wand-view-iterator
  (foreign-lambda void UpdateWandViewIterator))
|#

)
