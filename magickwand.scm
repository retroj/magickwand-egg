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

(define-foreign-enum-type (exceptiontype int)
  (exceptiontype->int int->exceptiontype)
  UndefinedException WarningException ResourceLimitWarning TypeWarning
  OptionWarning DelegateWarning MissingDelegateWarning CorruptImageWarning
  FileOpenWarning BlobWarning StreamWarning CacheWarning CoderWarning
  FilterWarning ModuleWarning DrawWarning ImageWarning WandWarning
  RandomWarning XServerWarning MonitorWarning RegistryWarning
  ConfigureWarning PolicyWarning ErrorException ResourceLimitError
  TypeError OptionError DelegateError MissingDelegateError CorruptImageError
  FileOpenError BlobError StreamError CacheError CoderError FilterError
  ModuleError DrawError ImageError WandError RandomError XServerError
  MonitorError RegistryError ConfigureError PolicyError FatalErrorException
  ResourceLimitFatalError TypeFatalError OptionFatalError DelegateFatalError
  MissingDelegateFatalError CorruptImageFatalError FileOpenFatalError
  BlobFatalError StreamFatalError CacheFatalError CoderFatalError
  FilterFatalError ModuleFatalError DrawFatalError ImageFatalError
  WandFatalError RandomFatalError XServerFatalError MonitorFatalError
  RegistryFatalError ConfigureFatalError PolicyFatalError)

(define-foreign-enum-type (colorspace int)
  (colorspace->int int->colorspace)
  UndefinedColorspace RGBColorspace GRAYColorspace TransparentColorspace
  OHTAColorspace LabColorspace XYZColorspace YCbCrColorspace YCCColorspace
  YIQColorspace YPbPrColorspace YUVColorspace CMYKColorspace sRGBColorspace
  HSBColorspace HSLColorspace HWBColorspace Rec601LumaColorspace
  Rec601YCbCrColorspace Rec709LumaColorspace Rec709YCbCrColorspace
  LogColorspace CMYColorspace)

(define-foreign-enum-type (compressiontype int)
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

(define-foreign-enum-type (gravity int)
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

(define-foreign-enum-type (resourcetype int)
  (resourcetype->int int->resourcetype)
  UndefinedResource AreaResource DiskResource FileResource MapResource
  MemoryResource ThreadResource TimeResource ThrottleResource)

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

(define-foreign-enum-type (alphachanneltype (enum AlphaChannelType))
  (alphachanneltype->int int->alphachanneltype)
  ((UndefinedAlphaChannel) UndefinedAlphaChannel)
  ((ActivateAlphaChannel) ActivateAlphaChannel)
  ((BackgroundAlphaChannel) BackgroundAlphaChannel)
  ((CopyAlphaChannel) CopyAlphaChannel)
  ((DeactivateAlphaChannel) DeactivateAlphaChannel)
  ((ExtractAlphaChannel) ExtractAlphaChannel)
  ((OpaqueAlphaChannel) OpaqueAlphaChannel)
  ((ResetAlphaChannel) ResetAlphaChannel)
  ((SetAlphaChannel) SetAlphaChannel)
  ((ShapeAlphaChannel) ShapeAlphaChannel)
  ((TransparentAlphaChannel) TransparentAlphaChannel))

(define-foreign-enum-type (sparsecolormethod (enum SparseColorMethod))
  (sparsecolormethod->int int->sparsecolormethod)
  ((UndefinedColorInterpolate) UndefinedColorInterpolate)
  ((BarycentricColorInterpolate) BarycentricColorInterpolate)
  ((BilinearColorInterpolate) BilinearColorInterpolate)
  ((PolynomialColorInterpolate) PolynomialColorInterpolate)
  ((ShepardsColorInterpolate) ShepardsColorInterpolate)
  ((VoronoiColorInterpolate) VoronoiColorInterpolate)
  ((InverseColorInterpolate) InverseColorInterpolate))

(define-foreign-enum-type (statistictype (enum StatisticType))
  (statistictype->int int->statistictype)
  ((UndefinedStatistic) UndefinedStatistic)
  ((GradientStatistic) GradientStatistic)
  ((MaximumStatistic) MaximumStatistic)
  ((MeanStatistic) MeanStatistic)
  ((MedianStatistic) MedianStatistic)
  ((MinimumStatistic) MinimumStatistic)
  ((ModeStatistic) ModeStatistic)
  ((NonpeakStatistic) NonpeakStatistic)
  ((StandardDeviationStatistic) StandardDeviationStatistic))

(define-foreign-enum-type (classtype (enum ClassType))
  (classtype->int int->classtype)
  ((UndefinedClass) UndefinedClass)
  ((DirectClass) DirectClass)
  ((PseudoClass) PseudoClass))

(define-foreign-enum-type (paintmethod (enum PaintMethod))
  (paintmethod->int int->paintmethod)
  ((UndefinedMethod) UndefinedMethod)
  ((PointMethod) PointMethod)
  ((ReplaceMethod) ReplaceMethod)
  ((FloodfillMethod) FloodfillMethod)
  ((FillToBorderMethod) FillToBorderMethod)
  ((ResetMethod) ResetMethod))

(define-foreign-enum-type (fillrule (enum FillRule))
  (fillrule->int int->fillrule)
  ((UndefinedRule) UndefinedRule)
  ((EvenOddRule) EvenOddRule)
  ((NonZeroRule) NonZeroRule))

(define-foreign-enum-type (clippathunits (enum ClipPathUnits))
  (clippathunits->int int->clippathunits)
  ((UndefinedPathUnits) UndefinedPathUnits)
  ((UserSpace) UserSpace)
  ((UserSpaceOnUse) UserSpaceOnUse)
  ((ObjectBoundingBox) ObjectBoundingBox))

(define-foreign-enum-type (stretchtype (enum StretchType))
  (stretchtype->int int->stretchtype)
  ((UndefinedStretch) UndefinedStretch)
  ((NormalStretch) NormalStretch)
  ((UltraCondensedStretch) UltraCondensedStretch)
  ((ExtraCondensedStretch) ExtraCondensedStretch)
  ((CondensedStretch) CondensedStretch)
  ((SemiCondensedStretch) SemiCondensedStretch)
  ((SemiExpandedStretch) SemiExpandedStretch)
  ((ExpandedStretch) ExpandedStretch)
  ((ExtraExpandedStretch) ExtraExpandedStretch)
  ((UltraExpandedStretch) UltraExpandedStretch)
  ((AnyStretch) AnyStretch))

(define-foreign-enum-type (styletype (enum StyleType))
  (styletype->int int->styletype)
  ((UndefinedStyle) UndefinedStyle)
  ((NormalStyle) NormalStyle)
  ((ItalicStyle) ItalicStyle)
  ((ObliqueStyle) ObliqueStyle)
  ((AnyStyle) AnyStyle))

(define-foreign-enum-type (linecap (enum LineCap))
  (linecap->int int->linecap)
  ((UndefinedCap) UndefinedCap)
  ((ButtCap) ButtCap)
  ((RoundCap) RoundCap)
  ((SquareCap) SquareCap))

(define-foreign-enum-type (linejoin (enum LineJoin))
  (linejoin->int int->linejoin)
  ((UndefinedJoin) UndefinedJoin)
  ((MiterJoin) MiterJoin)
  ((RoundJoin) RoundJoin)
  ((BevelJoin) BevelJoin))

(define-foreign-enum-type (aligntype (enum AlignType))
  (aligntype->int int->aligntype)
  ((UndefinedAlign) UndefinedAlign)
  ((LeftAlign) LeftAlign)
  ((CenterAlign) CenterAlign)
  ((RightAlign) RightAlign))

(define-foreign-enum-type (decorationtype (enum DecorationType))
  (decorationtype->int int->decorationtype)
  ((UndefinedDecoration) UndefinedDecoration)
  ((NoDecoration) NoDecoration)
  ((UnderlineDecoration) UnderlineDecoration)
  ((OverlineDecoration) OverlineDecoration)
  ((LineThroughDecoration) LineThroughDecoration))

(define-foreign-type magickwand (c-pointer (struct _MagickWand)))

(define-foreign-type drawingwand (c-pointer (struct _DrawingWand)))

(define-foreign-type image (c-pointer (struct _Image)))

(define-foreign-type pixelwand (c-pointer (struct _PixelWand)))

(define-foreign-type pixeliterator (c-pointer (struct _PixelIterator)))

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

(define-foreign-record-type RectangleInfo
  (size_t width rectangleinfo-width)
  (size_t height rectangleinfo-height)
  (ssize_t x rectangleinfo-x)
  (ssize_t y rectangleinfo-y))

(define-foreign-type magickrealtype double)

;;(define-foreign-record-type MagickPixelPacket
;;  (classtype storage_class magickpixelpacket-storage_class)
;;  (colorspace colorspace magickpixelpacket-colorspace)
;;  (bool matte magickpixelpacket-matte)
;;  (double fuzz magickpixelpacket-fuzz)
;;  (size_t depth magickpixelpacket-depth)
;;  (magickrealtype red magickpixelpacket-red)
;;  (magickrealtype green magickpixelpacket-green)
;;  (magickrealtype blue magickpixelpacket-blue)
;;  (magickrealtype opacity magickpixelpacket-opacity)
;;  (magickrealtype index magickpixelpacket-index))

;;XXX: would be nice to have a complete definition here
(define-foreign-type pixelpacket (c-pointer (struct _PixelPacket)))

;;XXX: would be nice to have a complete definition here
(define-foreign-type drawinfo (c-pointer (struct _DrawInfo)))

(define-foreign-type imageinfo (c-pointer (struct _ImageInfo)))

(define-foreign-type wandview (c-pointer (struct _WandView)))

(define-foreign-record-type AffineMatrix
  (double sx affinematrix-sx)
  (double rx affinematrix-rx)
  (double ry affinematrix-ry)
  (double sy affinematrix-sy)
  (double tx affinematrix-tx)
  (double ty affinematrix-ty))

(define-foreign-record-type PointInfo
  (double x pointinfo-x)
  (double y pointinfo-y))


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
  (foreign-lambda bool IsMagickWand (const magickwand)))

(define magick-clear-exception
  (foreign-lambda bool MagickClearException magickwand))

(define (magick-get-exception wand)
  (let-location ((typeout int))
    (let ((str ((foreign-lambda c-string MagickGetException
                                (const magickwand)
                                (c-pointer "ExceptionType"))
                wand (location typeout))))
      (values str (int->exceptiontype typeout)))))

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
  (foreign-lambda bool MagickSetIteratorIndex magickwand (const ssize_t)))

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
  (foreign-lambda bool MagickDeleteImageArtifact
                  magickwand (const c-string)))

(define magick-delete-image-property
  (foreign-lambda bool MagickDeleteImageProperty
                  magickwand (const c-string)))

(define magick-delete-option
  (foreign-lambda bool MagickDeleteOption
                  magickwand (const c-string)))

(define magick-get-antialias
  (foreign-lambda bool MagickGetAntialias magickwand))

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
  (foreign-lambda bool MagickGetPage
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
  (foreign-lambda bool MagickGetResolution
                  magickwand (c-pointer double) (c-pointer double)))

(define magick-get-resource
  (foreign-lambda magicksize MagickGetResource (const resourcetype)))

(define magick-get-resource-limit
  (foreign-lambda magicksize MagickGetResourceLimit (const resourcetype)))

(define magick-get-sampling-factors
  (foreign-lambda (c-pointer double) MagickGetSamplingFactors
                  magickwand (c-pointer size_t)))

(define magick-get-size
  (foreign-lambda bool MagickGetSize
                  magickwand (c-pointer size_t) (c-pointer size_t)))

(define magick-get-size-offset
  (foreign-lambda bool MagickGetSizeOffset
                  magickwand (c-pointer ssize_t)))

(define magick-get-type
  (foreign-lambda imagetype MagickGetType magickwand))

(define magick-get-version
  (foreign-lambda c-string MagickGetVersion (c-pointer size_t)))

(define magick-profile-image
  (foreign-lambda bool MagickProfileImage
                  magickwand (const c-string) (const c-pointer) (const size_t)))

(define magick-remove-image-profile
  (foreign-lambda unsigned-c-string MagickRemoveImageProfile
                  magickwand (const c-string) (c-pointer size_t)))

(define magick-set-antialias
  (foreign-lambda bool MagickSetAntialias magickwand (const bool)))

(define magick-set-background-color
  (foreign-lambda bool MagickSetBackgroundColor magickwand (const pixelwand)))

(define magick-set-colorspace
  (foreign-lambda bool MagickSetColorspace magickwand (const colorspace)))

(define magick-set-compression
  (foreign-lambda bool MagickSetCompression magickwand (const compressiontype)))

(define magick-set-compression-quality
  (foreign-lambda bool MagickSetCompressionQuality magickwand (const size_t)))

(define magick-set-depth
  (foreign-lambda bool MagickSetDepth magickwand (const size_t)))

(define magick-set-extract
  (foreign-lambda bool MagickSetExtract magickwand (const c-string)))

(define magick-set-filename
  (foreign-lambda bool MagickSetFilename magickwand (const c-string)))

(define magick-set-font
  (foreign-lambda bool MagickSetFont magickwand (const c-string)))

(define magick-set-format
  (foreign-lambda bool MagickSetFormat magickwand (const c-string)))

(define magick-set-gravity
  (foreign-lambda bool MagickSetGravity magickwand (const gravity)))

(define magick-set-image-artifact
  (foreign-lambda bool MagickSetImageArtifact
                  magickwand (const c-string) (const c-string)))

(define magick-set-image-profile
  (foreign-lambda bool MagickSetImageProfile
                  magickwand (const c-string) (const c-pointer) (const size_t)))

(define magick-set-image-property
  (foreign-lambda bool MagickSetImageProperty
                  magickwand (const c-string) (const c-string)))

;;(define magick-set-interlace-scheme
;;  (foreign-lambda bool MagickSetInterlaceScheme magickwand (const interlacetype)))

;;(define magick-set-interpolate-method
;;  (foreign-lambda bool MagickSetInterpolateMethod magickwand (const interpolatepixelmethod)))

(define magick-set-option
  (foreign-lambda bool MagickSetOption
                  magickwand (const c-string) (const c-string)))

;;(define magick-set-orientation
;;  (foreign-lambda bool MagickSetOrientation
;;                  magickwand (const orientation)))

(define magick-set-page
  (foreign-lambda bool MagickSetPage
                  magickwand (const size_t) (const size_t)
                  (const size_t) (const size_t)))

(define magick-set-passphrase
  (foreign-lambda bool MagickSetPassphrase magickwand (const c-string)))

(define magick-set-pointsize
  (foreign-lambda bool MagickSetPointsize magickwand (const double)))

;;(define magick-set-progress-monitor
;;  (foreign-lambda magickprogressmonitor MagickSetProgressMonitor
;;                  magickwand (const magickprogressmonitor) c-pointer))

(define magick-set-resource-limit
  (foreign-lambda bool MagickSetResourceLimit
                  (const resourcetype) (const magicksize)))

(define magick-set-resolution
  (foreign-lambda bool MagickSetResolution
                  magickwand (const double) (const double)))

(define magick-set-sampling-factors
  (foreign-lambda bool MagickSetSamplingFactors
                  magickwand (const size_t) (const (c-pointer double))))

(define magick-set-size
  (foreign-lambda bool MagickSetSize
                  magickwand (const size_t) (const size_t)))

(define magick-set-size-offset
  (foreign-lambda bool MagickSetSizeOffset
                  magickwand (const size_t) (const size_t)
                  (const ssize_t)))

;;(define magick-set-type
;;  (foreign-lambda bool MagickSetType
;;                  magickwand (const imagetype)))


;;;
;;; Magick-image methods
;;;

(define get-image-from-magick-wand
  (foreign-lambda image GetImageFromMagickWand magickwand))

(define magick-adaptive-blur-image
  (foreign-lambda bool MagickAdaptiveBlurImage
                  magickwand (const double) (const double)))

;;(define magick-adaptive-blur-image-channel
;;  (foreign-lambda bool MagickAdaptiveBlurImageChannel
;;                  magickwand (const channeltype) (const double) (const double)))

(define magick-adaptive-resize-image
  (foreign-lambda bool MagickAdaptiveResizeImage
                  magickwand (const size_t) (const size_t)))

(define magick-adaptive-sharpen-image
  (foreign-lambda bool MagickAdaptiveSharpenImage
                  magickwand (const double) (const double)))

;;(define magick-adaptive-sharpen-image-channel
;;  (foreign-lambda bool MagickAdaptiveSharpenImageChannel
;;                  magickwand (const channeltype) (const double) (const double)))

(define magick-adaptive-threshold-image
  (foreign-lambda bool MagickAdaptiveThresholdImage
                  magickwand (const size_t) (const size_t) (const ssize_t)))

(define magick-add-image
  (foreign-lambda bool MagickAddImage
                  magickwand (const magickwand)))

;;(define magick-add-noise-image
;;  (foreign-lambda bool MagickAddNoiseImage
;;                  magickwand (const noisetype)))

;;(define magick-add-noise-image-channel
;;  (foreign-lambda bool MagickAddNoiseImageChannel
;;                  magickwand (const channeltype) (const noisetype)))

(define magick-affine-transform-image
  (foreign-lambda bool MagickAffineTransformImage
                  magickwand (const drawingwand)))

(define magick-annotate-image
  (foreign-lambda bool MagickAnnotateImage
                  magickwand (const drawingwand) (const double) (const double)
                  (const double) (const c-string)))

(define magick-animate-images
  (foreign-lambda bool MagickAnimateImages magickwand (const c-string)))

(define magick-append-images
  (foreign-lambda magickwand MagickAppendImages magickwand (const bool)))

(define magick-auto-gamma-image
  (foreign-lambda bool MagickAutoGammaImage magickwand))

;;(define magick-auto-gamma-image-channel
;;  (foreign-lambda bool MagickAutoGammaImageChannel
;;                  magickwand (const channeltype)))

(define magick-auto-level-image
  (foreign-lambda bool MagickAutoLevelImage magickwand))

;;(define magick-auto-level-image-channel
;;  (foreign-lambda bool MagickAutoLevelImageChannel
;;                  magickwand (const channeltype)))

(define magick-black-threshold-image
  (foreign-lambda bool MagickBlackThresholdImage
                  magickwand (const pixelwand)))

(define magick-blue-shift-image
  (foreign-lambda bool MagickBlueShiftImage magickwand (const double)))

(define magick-blur-image
  (foreign-lambda bool MagickBlurImage
                  magickwand (const double) (const double)))

;;(define magick-blur-image-channel
;;  (foreign-lambda bool MagickBlurImageChannel
;;                  magickwand (const channeltype)
;;                  (const double) (const double)))

(define magick-border-image
  (foreign-lambda bool MagickBorderImage
                  magickwand (const pixelwand) (const size_t) (const size_t)))

(define magick-brightness-contrast-image
  (foreign-lambda bool MagickBrightnessContrastImage
                  magickwand (const double) (const double)))

;;(define magick-brightness-contrast-image-channel
;;  (foreign-lambda bool MagickBrightnessContrastImageChannel
;;                  magickwand (const channeltype) (const double) (const double)))

(define magick-charcoal-image
  (foreign-lambda bool MagickCharcoalImage
                  magickwand (const double) (const double)))

(define magick-chop-image
  (foreign-lambda bool MagickChopImage
                  magickwand (const size_t) (const size_t)
                  (const ssize_t) (const ssize_t)))

(define magick-clamp-image
  (foreign-lambda bool MagickClampImage magickwand))

;;(define magick-clamp-image-channel
;;  (foreign-lambda bool MagickClampImageChannel magickwand (const channeltype)))

(define magick-clip-image
  (foreign-lambda bool MagickClipImage magickwand))

(define magick-clip-image-path
  (foreign-lambda bool MagickClipImagePath
                  magickwand (const c-string) (const bool)))

(define magick-clut-image
  (foreign-lambda bool MagickClutImage
                  magickwand (const magickwand)))

;;(define magick-clut-image-channel
;;  (foreign-lambda bool MagickClutImageChannel
;;                  magickwand (const channeltype) (const magickwand)))

(define magick-coalesce-images
  (foreign-lambda magickwand MagickCoalesceImages magickwand))

(define magick-color-decision-list-image
  (foreign-lambda bool MagickColorDecisionListImage
                  magickwand (const c-string)))

(define magick-colorize-image
  (foreign-lambda bool MagickColorizeImage
                  magickwand (const pixelwand) (const pixelwand)))

;;(define magick-color-matrix-image
;;  (foreign-lambda bool MagickColorMatrixImage
;;                  magickwand (const KernelInfo)))

;;(define magick-combine-images
;;  (foreign-lambda magickwand MagickCombineImages
;;                  magickwand (const channeltype)))

(define magick-comment-image
  (foreign-lambda bool MagickCommentImage
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
;;  (foreign-lambda bool MagickCompositeImage
;;                  magickwand (const magickwand)
;;                  (const compositeoperator)
;;                  (const ssize_t) (const ssize_t)))

;;(define magick-composite-image-channel
;;  (foreign-lambda bool MagickCompositeImageChannel
;;                  magickwand (const channeltype) (const magickwand)
;;                  (const compositeoperator)
;;                  (const ssize_t) (const ssize_t)))

;;(define magick-composite-layers
;;  (foreign-lambda bool MagickCompositeLayers
;;                  magickwand (const magickwand)
;;                  (const compositeoperator)
;;                  (const ssize_t) (const ssize_t)))

(define magick-contrast-image
  (foreign-lambda bool MagickContrastImage
                  magickwand (const bool)))

(define magick-contrast-stretch-image
  (foreign-lambda bool MagickContrastStretchImage
                  magickwand (const double) (const double)))

;;(define magick-contrast-stretch-image-channel
;;  (foreign-lambda bool MagickContrastStretchImageChannel
;;                  magickwand (const channeltype)
;;                  (const double) (const double)))

(define magick-convolve-image
  (foreign-lambda bool MagickConvolveImage
                  magickwand (const size_t) (const (c-pointer double))))

;;(define magick-convolve-image-channel
;;  (foreign-lambda bool MagickConvolveImageChannel
;;                  magickwand (const channeltype)
;;                  (const size_t) (const (c-pointer double))))

(define magick-crop-image
  (foreign-lambda bool MagickCropImage
                  magickwand (const size_t) (const size_t)
                  (const ssize_t) (const ssize_t)))

(define magick-cycle-colormap-image
  (foreign-lambda bool MagickCycleColormapImage
                  magickwand (const ssize_t)))

;;(define magick-constitute-image
;;  (foreign-lambda bool MagickConstituteImage
;;                  magickwand (const size_t) (const size_t)
;;                  (const c-string) (const storagetype) c-pointer))

(define magick-decipher-image
  (foreign-lambda bool MagickDecipherImage
                  magickwand (const c-string)))

(define magick-deconstruct-images
  (foreign-lambda magickwand MagickDeconstructImages magickwand))

(define magick-deskew-image
  (foreign-lambda bool MagickDeskewImage
                  magickwand (const double)))

(define magick-despeckle-image
  (foreign-lambda bool MagickDespeckleImage magickwand))

(define magick-destroy-image
  (foreign-lambda image MagickDestroyImage image))

(define magick-display-image
  (foreign-lambda bool MagickDisplayImage magickwand (const c-string)))

(define magick-display-images
  (foreign-lambda bool MagickDisplayImages magickwand (const c-string)))

;;(define magick-distort-image
;;  (foreign-lambda bool MagickDistortImage
;;                  magickwand (const distortimagemethod)
;;                  (const size_t) (const (c-pointer double))
;;                  (const bool)))

(define magick-draw-image
  (foreign-lambda bool MagickDrawImage
                  magickwand (const drawingwand)))

(define magick-edge-image
  (foreign-lambda bool MagickEdgeImage
                  magickwand (const double)))

(define magick-emboss-image
  (foreign-lambda bool MagickEmbossImage
                  magickwand (const double) (const double)))

(define magick-encipher-image
  (foreign-lambda bool MagickEncipherImage
                  magickwand (const c-string)))

(define magick-enhance-image
  (foreign-lambda bool MagickEnhanceImage magickwand))

(define magick-equalize-image
  (foreign-lambda bool MagickEqualizeImage magickwand))

;;(define magick-equalize-image-channel
;;  (foreign-lambda bool MagickEqualizeImageChannel
;;                  magickwand (const channeltype)))

;;(define magick-evaluate-image
;;  (foreign-lambda bool MagickEvaluateImage
;;                  magickwand (const magickevaluateoperator)
;;                  (const double)))

;;(define magick-evaluate-images
;;  (foreign-lambda bool MagickEvaluateImages
;;                  magickwand (const magickevaluateoperator)))

;;(define magick-evaluate-image-channel
;;  (foreign-lambda bool MagickEvaluateImageChannel
;;                  magickwand (const channeltype)
;;                  (const magickevaluateoperator)
;;                  (const double)))

;;(define magick-export-image-pixels
;;  (foreign-lambda bool MagickExportImagePixels
;;                  magickwand (const ssize_t) (const ssize_t)
;;                  (const size_t) (const size_t)
;;                  (const c-string) (const storagetype)
;;                  c-pointer))

(define magick-extent-image
  (foreign-lambda bool MagickExtentImage
                  magickwand (const size_t) (const size_t)
                  (const ssize_t) (const ssize_t)))

;;(define magick-filter-image
;;  (foreign-lambda bool MagickFilterImage
;;                  magickwand (const kernelinfo)))

;;(define magick-filter-image-channel
;;  (foreign-lambda bool MagickFilterImageChannel
;;                  magickwand (const channeltype) (const kernelinfo)))

(define magick-flip-image
  (foreign-lambda bool MagickFlipImage magickwand))

;;(define magick-floodfill-paint-image
;;  (foreign-lambda bool MagickFloodfillPaintImage
;;                  magickwand (const channeltype) (const pixelwand)
;;                  (const double) (const pixelwand)
;;                  (const ssize_t) (const ssize_t)
;;                  (const bool)))

(define magick-flop-image
  (foreign-lambda bool MagickFlopImage magickwand))

(define magick-forward-fourier-transform-image
  (foreign-lambda bool MagickForwardFourierTransformImage
                  magickwand (const bool)))

(define magick-frame-image
  (foreign-lambda bool MagickFrameImage
                  magickwand (const pixelwand)
                  (const size_t) (const size_t)
                  (const ssize_t) (const ssize_t)))

;;(define magick-function-image
;;  (foreign-lambda bool MagickFunctionImage
;;                  magickwand (const magickfunction)
;;                  (const size_t) (const (c-pointer double))))

;;(define magick-function-image-channel
;;  (foreign-lambda bool MagickFunctionImageChannel
;;                  magickwand (const channeltype) (const magickfunction)
;;                  (const size_t) (const (c-pointer double))))

(define magick-fx-image
  (foreign-lambda magickwand MagickFxImage magickwand (const c-string)))

;;(define magick-fx-image-channel
;;  (foreign-lambda magickwand MagickFxImageChannel
;;                  magickwand (const channeltype) (const c-string)))

(define magick-gamma-image
  (foreign-lambda bool MagickGammaImage magickwand (const double)))

;;(define magick-gamma-image-channel
;;  (foreign-lambda bool MagickGammaImageChannel
;;                  magickwand (const channeltype) (const double)))

(define magick-gaussian-blur-image
  (foreign-lambda bool MagickGaussianBlurImage
                  magickwand (const double) (const double)))

;;(define magick-gaussian-blur-image-channel
;;  (foreign-lambda bool MagickGaussianBlurImageChannel
;;                  magickwand (const channeltype)
;;                  (const double) (const double)))

(define magick-get-image
  (foreign-lambda magickwand MagickGetImage magickwand))

(define magick-get-image-alpha-channel
  (foreign-lambda bool MagickGetImageAlphaChannel magickwand))

(define magick-get-image-clip-mask
  (foreign-lambda magickwand MagickGetImageClipMask magickwand))

(define magick-get-image-background-color
  (foreign-lambda bool MagickGetImageBackgroundColor magickwand pixelwand))

(define magick-get-image-blob
  (foreign-lambda unsigned-c-string MagickGetImageBlob magickwand (c-pointer size_t)))

(define magick-get-images-blob
  (foreign-lambda unsigned-c-string MagickGetImagesBlob magickwand (c-pointer size_t)))

(define magick-get-image-blue-primary
  (foreign-lambda bool MagickGetImageBluePrimary
                  magickwand (c-pointer double) (c-pointer double)))

(define magick-get-image-border-color
  (foreign-lambda bool MagickGetImageBorderColor magickwand pixelwand))

;;(define magick-get-image-channel-depth
;;  (foreign-lambda size_t MagickGetImageChannelDepth magickwand (const channeltype)))

;;(define magick-get-image-channel-distortion
;;  (foreign-lambda bool MagickGetImageChannelDistortion
;;                  magickwand (const magickwand) (const channeltype)
;;                  (const metrictype) (c-pointer double)))

;;(define magick-get-image-channel-distortions
;;  (foreign-lambda (c-pointer double) MagickGetImageChannelDistortions
;;                  magickwand (const magickwand) (const metrictype)))

(define magick-get-image-channel-features
  (foreign-lambda ChannelFeatures MagickGetImageChannelFeatures
                  magickwand (const size_t)))

;;(define magick-get-image-channel-kurtosis
;;  (foreign-lambda bool MagickGetImageChannelKurtosis
;;                  magickwand (const channeltype)
;;                  (c-pointer double) (c-pointer double)))

;;(define magick-get-image-channel-mean
;;  (foreign-lambda bool MagickGetImageChannelMean
;;                  magickwand (const channeltype)
;;                  (c-pointer double) (c-pointer double)))

;;(define magick-get-image-channel-range
;;  (foreign-lambda bool MagickGetImageChannelRange
;;                  magickwand (const channeltype)
;;                  (c-pointer double) (c-pointer double)))

(define magick-get-image-channel-statistics
  (foreign-lambda ChannelStatistics MagickGetImageChannelStatistics magickwand))

(define magick-get-image-colormap-color
  (foreign-lambda bool MagickGetImageColormapColor
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
;;  (foreign-lambda bool MagickGetImageDistortion
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
  (foreign-lambda bool MagickGetImageGreenPrimary
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
;;  (foreign-lambda bool MagickGetImageLength magickwand (c-pointer magicksize)))

(define magick-get-image-matte-color
  (foreign-lambda bool MagickGetImageMatteColor
                  magickwand pixelwand))

(define magick-get-image-orientation
  (foreign-lambda orientation MagickGetImageOrientation magickwand))

(define magick-get-image-page
  (foreign-lambda bool MagickGetImagePage
                  magickwand
                  (c-pointer size_t) (c-pointer size_t)
                  (c-pointer ssize_t) (c-pointer ssize_t)))

(define magick-get-image-pixel-color
  (foreign-lambda bool MagickGetImagePixelColor
                  magickwand (const ssize_t) (const ssize_t)
                  pixelwand))

(define magick-get-image-red-primary
  (foreign-lambda bool MagickGetImageRedPrimary
                  magickwand (c-pointer double) (c-pointer double)))

(define magick-get-image-region
  (foreign-lambda magickwand MagickGetImageRegion
                  magickwand (const size_t) (const size_t)
                  (const ssize_t) (const ssize_t)))

(define magick-get-image-rendering-intent
  (foreign-lambda renderingintent MagickGetImageRenderingIntent magickwand))

(define magick-get-image-resolution
  (foreign-lambda bool MagickGetImageResolution
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
  (foreign-lambda bool MagickGetImageWhitePoint
                  magickwand (c-pointer double) (c-pointer double)))

(define magick-get-image-width
  (foreign-lambda size_t MagickGetImageWidth magickwand))

(define magick-get-number-images
  (foreign-lambda size_t MagickGetNumberImages magickwand))

(define magick-get-image-total-ink-density
  (foreign-lambda double MagickGetImageTotalInkDensity magickwand))

(define magick-hald-clut-image
  (foreign-lambda bool MagickHaldClutImage magickwand (const magickwand)))

;;(define magick-hald-clut-image-channel
;;  (foreign-lambda bool MagickHaldClutImageChannel
;;                  magickwand (const channeltype) (const magickwand)))

(define magick-has-next-image
  (foreign-lambda bool MagickHasNextImage magickwand))

(define magick-has-previous-image
  (foreign-lambda bool MagickHasPreviousImage magickwand))

(define magick-identify-image
  (foreign-lambda c-string MagickIdentifyImage magickwand))

(define magick-implode-image
  (foreign-lambda bool MagickImplodeImage magickwand (const double)))

;;(define magick-import-image-pixels
;;  (foreign-lambda bool MagickImportImagePixels
;;                  magickwand (const ssize_t) (const ssize_t)
;;                  (const size_t) (const size_t)
;;                  (const c-string) (const storagetype)
;;                  (const c-pointer)))

(define magick-inverse-fourier-transform-image
  (foreign-lambda bool MagickInverseFourierTransformImage
                  magickwand magickwand (const bool)))

(define magick-label-image
  (foreign-lambda bool MagickLabelImage
                  magickwand (const c-string)))

(define magick-level-image
  (foreign-lambda bool MagickLevelImage
                  magickwand (const double) (const double)
                  (const double)))

;;(define magick-level-image-channel
;;  (foreign-lambda bool MagickLevelImageChannel
;;                  magickwand (const channeltype)
;;                  (const double) (const double)
;;                  (const double)))

(define magick-linear-stretch-image
  (foreign-lambda bool MagickLinearStretchImage
                  magickwand (const double) (const double)))

(define magick-liquid-rescale-image
  (foreign-lambda bool MagickLiquidRescaleImage
                  magickwand (const size_t) (const size_t)
                  (const double) (const double)))

(define magick-magnify-image
  (foreign-lambda bool MagickMagnifyImage magickwand))

;;(define magick-merge-image-layers
;;  (foreign-lambda magickwand MagickMergeImageLayers
;;                  magickwand (const imagelayermethod)))

(define magick-minify-image
  (foreign-lambda bool MagickMinifyImage magickwand))

(define magick-modulate-image
  (foreign-lambda bool MagickModulateImage
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
;;  (foreign-lambda bool MagickMorphologyImage
;;                  magickwand morphologymethod
;;                  (const ssize_t) KernelInfo))

;;(define magick-morphology-image-channel
;;  (foreign-lambda bool MagickMorphologyImageChannel
;;                  magickwand channeltype morphologymethod
;;                  (const ssize_t) KernelInfo))

(define magick-motion-blur-image
  (foreign-lambda bool MagickMotionBlurImage
                  magickwand
                  (const double) (const double) (const double)))

;;(define magick-motion-blur-image-channel
;;  (foreign-lambda bool MagickMotionBlurImageChannel
;;                  magickwand (const channeltype)
;;                  (const double) (const double) (const double)))

(define magick-negate-image
  (foreign-lambda bool MagickNegateImage
                  magickwand (const bool)))

;;(define magick-negate-image-channel
;;  (foreign-lambda bool MagickNegateImageChannel
;;                  magickwand (const channeltype)
;;                  (const bool)))

(define magick-new-image
  (foreign-lambda bool MagickNewImage
                  magickwand (const size_t) (const size_t)
                  (const pixelwand)))

(define magick-next-image
  (foreign-lambda bool MagickNextImage magickwand))

(define magick-normalize-image
  (foreign-lambda bool MagickNormalizeImage magickwand))

;;(define magick-normalize-image-channel
;;  (foreign-lambda bool MagickNormalizeImageChannel
;;                  magickwand (const channeltype)))

(define magick-oil-paint-image
  (foreign-lambda bool MagickOilPaintImage
                  magickwand (const double)))

(define magick-opaque-paint-image
 (foreign-lambda bool MagickOpaquePaintImage
                 magickwand (const pixelwand) (const pixelwand)
                 (const double) (const bool)))

;;(define magick-opaque-paint-image-channel
;;  (foreign-lambda bool MagickOpaquePaintImageChannel
;;                  magickwand (const channeltype)
;;                  (const pixelwand) (const pixelwand)
;;                  (const double) (const bool)))

(define magick-optimize-image-layers
  (foreign-lambda magickwand MagickOptimizeImageLayers magickwand))

(define magick-ordered-posterize-image
  (foreign-lambda bool MagickOrderedPosterizeImage
                  magickwand (const c-string)))

;;(define magick-ordered-posterize-image-channel
;;  (foreign-lambda bool MagickOrderedPosterizeImageChannel
;;                  magickwand (const channeltype) (const c-string)))

(define magick-ping-image
  (foreign-lambda bool MagickPingImage magickwand (const c-string)))

(define magick-ping-image-blob
  (foreign-lambda bool MagickPingImageBlob
                  magickwand (const c-pointer) (const size_t)))

;;(define magick-ping-image-file
;;  (foreign-lambda bool MagickPingImageFile
;;                  magickwand (c-pointer FILE)))

(define magick-polaroid-image
  (foreign-lambda bool MagickPolaroidImage
                  magickwand (const drawingwand) (const double)))

(define magick-posterize-image
 (foreign-lambda bool MagickPosterizeImage
                 magickwand (const size_t) (const bool)))

;;(define magick-preview-images
;;  (foreign-lambda magickwand MagickPreviewImages
;;                  magickwand (const previewtype)))

(define magick-previous-image
  (foreign-lambda bool MagickPreviousImage magickwand))

(define magick-quantize-image
 (foreign-lambda bool MagickQuantizeImage
                 magickwand (const size_t) (const colorspace)
                 (const size_t) (const bool)
                 (const bool)))

(define magick-quantize-images
 (foreign-lambda bool MagickQuantizeImages
                 magickwand (const size_t) (const colorspace)
                 (const size_t) (const bool)
                 (const bool)))

(define magick-radial-blur-image
  (foreign-lambda bool MagickRadialBlurImage
                  magickwand (const double)))

;;(define magick-radial-blur-image-channel
;;  (foreign-lambda bool MagickRadialBlurImageChannel
;;                  magickwand (const channeltype) (const double)))

(define magick-raise-image
 (foreign-lambda bool MagickRaiseImage
                 magickwand (const size_t) (const size_t)
                 (const ssize_t) (const ssize_t) (const bool)))

(define magick-random-threshold-image
  (foreign-lambda bool MagickRandomThresholdImage
                  magickwand (const double) (const double)))

;;(define magick-random-threshold-image-channel
;;  (foreign-lambda bool MagickRandomThresholdImageChannel
;;                  magickwand (const channeltype)
;;                  (const double) (const double)))

(define magick-read-image
  (foreign-lambda bool MagickReadImage
                  magickwand (const c-string)))

(define magick-read-image-blob
  (foreign-lambda bool MagickReadImageBlob
                  magickwand (const c-pointer) (const size_t)))

;;(define magick-read-image-file
;;  (foreign-lambda bool MagickReadImageFile
;;                  magickwand (c-pointer FILE)))

;;(define magick-remap-image
;;  (foreign-lambda bool MagickRemapImage
;;                  magickwand (const magickwand) (const dithermethod)))

(define magick-remove-image
  (foreign-lambda bool MagickRemoveImage magickwand))

;;(define magick-resample-image
;;  (foreign-lambda bool MagickResampleImage
;;                  magickwand (const double) (const double)
;;                  (const filtertypes) (const double)))

(define magick-reset-image-page
  (foreign-lambda bool MagickResetImagePage
                  magickwand (const c-string)))

;;(define magick-resize-image
;;  (foreign-lambda bool MagickResizeImage
;;                  magickwand (const size_t) (const size_t)
;;                  (const filtertypes) (const double)))

(define magick-roll-image
  (foreign-lambda bool MagickRollImage
                  magickwand (const ssize_t) (const ssize_t)))

(define magick-rotate-image
  (foreign-lambda bool MagickRotateImage
                  magickwand (const pixelwand) (const double)))

(define magick-sample-image
  (foreign-lambda bool MagickSampleImage
                  magickwand (const size_t) (const size_t)))

(define magick-scale-image
  (foreign-lambda bool MagickScaleImage
                  magickwand (const size_t) (const size_t)))

(define magick-segment-image
 (foreign-lambda bool MagickSegmentImage
                 magickwand (const colorspace) (const bool)
                 (const double) (const double)))

(define magick-selective-blur-image
  (foreign-lambda bool MagickSelectiveBlurImage
                  magickwand (const double) (const double) (const double)))

;;(define magick-selective-blur-image-channel
;;  (foreign-lambda bool MagickSelectiveBlurImageChannel
;;                  magickwand (const channeltype)
;;                  (const double) (const double) (const double)))

;;(define magick-separate-image-channel
;;  (foreign-lambda bool MagickSeparateImageChannel
;;                  magickwand (const channeltype)))

(define magick-sepia-tone-image
  (foreign-lambda bool MagickSepiaToneImage
                  magickwand (const double)))

(define magick-set-image
  (foreign-lambda bool MagickSetImage
                  magickwand (const magickwand)))

;;(define magick-set-image-alpha-channel
;;  (foreign-lambda bool MagickSetImageAlphaChannel
;;                  magickwand (const alphachanneltype)))

(define magick-set-image-background-color
  (foreign-lambda bool MagickSetImageBackgroundColor
                  magickwand (const pixelwand)))

(define magick-set-image-bias
  (foreign-lambda bool MagickSetImageBias
                  magickwand (const double)))

(define magick-set-image-blue-primary
  (foreign-lambda bool MagickSetImageBluePrimary
                  magickwand (const double) (const double)))

(define magick-set-image-border-color
  (foreign-lambda bool MagickSetImageBorderColor
                  magickwand (const pixelwand)))

;;(define magick-set-image-channel-depth
;;  (foreign-lambda bool MagickSetImageChannelDepth
;;                  magickwand (const channeltype) (const size_t)))

(define magick-set-image-clip-mask
  (foreign-lambda bool MagickSetImageClipMask
                  magickwand (const magickwand)))

(define magick-set-image-color
  (foreign-lambda bool MagickSetImageColor
                  magickwand (const pixelwand)))

(define magick-set-image-colormap-color
  (foreign-lambda bool MagickSetImageColormapColor
                  magickwand (const size_t) (const pixelwand)))

(define magick-set-image-colorspace
 (foreign-lambda bool MagickSetImageColorspace
                 magickwand (const colorspace)))

;;(define magick-set-image-compose
;;  (foreign-lambda bool MagickSetImageCompose
;;                  magickwand (const compositeoperator)))

(define magick-set-image-compression
 (foreign-lambda bool MagickSetImageCompression
                 magickwand (const compressiontype)))

(define magick-set-image-compression-quality
  (foreign-lambda bool MagickSetImageCompressionQuality
                  magickwand (const size_t)))

(define magick-set-image-delay
  (foreign-lambda bool MagickSetImageDelay
                  magickwand (const size_t)))

(define magick-set-image-depth
  (foreign-lambda bool MagickSetImageDepth
                  magickwand (const size_t)))

;;(define magick-set-image-dispose
;;  (foreign-lambda bool MagickSetImageDispose
;;                  magickwand (const disposetype)))

(define magick-set-image-extent
  (foreign-lambda bool MagickSetImageExtent
                  magickwand (const size_t) (const size_t)))

(define magick-set-image-filename
  (foreign-lambda bool MagickSetImageFilename
                  magickwand (const c-string)))

(define magick-set-image-format
  (foreign-lambda bool MagickSetImageFormat
                  magickwand (const c-string)))

(define magick-set-image-fuzz
  (foreign-lambda bool MagickSetImageFuzz
                  magickwand (const double)))

(define magick-set-image-gamma
  (foreign-lambda bool MagickSetImageGamma
                  magickwand (const double)))

(define magick-set-image-gravity
 (foreign-lambda bool MagickSetImageGravity
                 magickwand (const gravity)))

(define magick-set-image-green-primary
  (foreign-lambda bool MagickSetImageGreenPrimary
                  magickwand (const double) (const double)))

;;(define magick-set-image-interlace-scheme
;;  (foreign-lambda bool MagickSetImageInterlaceScheme
;;                  magickwand (const interlacetype)))

;;(define magick-set-image-interpolate-method
;;  (foreign-lambda bool MagickSetImageInterpolateMethod
;;                  magickwand (const interpolatepixelmethod)))

(define magick-set-image-iterations
  (foreign-lambda bool MagickSetImageIterations
                  magickwand (const size_t)))

(define magick-set-image-matte
 (foreign-lambda bool MagickSetImageMatte
                 magickwand (const bool)))

(define magick-set-image-matte-color
  (foreign-lambda bool MagickSetImageMatteColor
                  magickwand (const pixelwand)))

(define magick-set-image-opacity
  (foreign-lambda bool MagickSetImageOpacity
                  magickwand (const double)))

;;(define magick-set-image-orientation
;;  (foreign-lambda bool MagickSetImageOrientation
;;                  magickwand (const orientation)))

(define magick-set-image-page
  (foreign-lambda bool MagickSetImagePage
                  magickwand (const size_t) (const size_t)
                  (const ssize_t) (const ssize_t)))

;;(define magick-set-image-progress-monitor
;;  (foreign-lambda magickprogressmonitor MagickSetImageProgressMonitor
;;                  magickwand (const magickprogressmonitor) c-pointer))

(define magick-set-image-red-primary
  (foreign-lambda bool MagickSetImageRedPrimary
                  magickwand (const double) (const double)))

;;(define magick-set-image-rendering-intent
;;  (foreign-lambda bool MagickSetImageRenderingIntent
;;                  magickwand (const renderingintent)))

(define magick-set-image-resolution
  (foreign-lambda bool MagickSetImageResolution
                  magickwand (const double) (const double)))

(define magick-set-image-scene
  (foreign-lambda bool MagickSetImageScene
                  magickwand (const size_t)))

(define magick-set-image-ticks-per-second
  (foreign-lambda bool MagickSetImageTicksPerSecond
                  magickwand (const ssize_t)))

;;(define magick-set-image-type
;;  (foreign-lambda bool MagickSetImageType
;;                  magickwand (const imagetype)))

;;(define magick-set-image-units
;;  (foreign-lambda bool MagickSetImageUnits
;;                  magickwand (const resolutiontype)))

;;(define magick-set-image-virtual-pixel-method
;;  (foreign-lambda virtualpixelmethod MagickSetImageVirtualPixelMethod
;;                  magickwand (const virtualpixelmethod)))

(define magick-set-image-white-point
  (foreign-lambda bool MagickSetImageWhitePoint
                  magickwand (const double) (const double)))

(define magick-shade-image
 (foreign-lambda bool MagickShadeImage
                 magickwand (const bool)
                 (const double) (const double)))

(define magick-shadow-image
  (foreign-lambda bool MagickShadowImage
                  magickwand (const double) (const double)
                  (const ssize_t) (const ssize_t)))

(define magick-sharpen-image
  (foreign-lambda bool MagickSharpenImage
                  magickwand (const double) (const double)))

;;(define magick-sharpen-image-channel
;;  (foreign-lambda bool MagickSharpenImageChannel
;;                  magickwand (const channeltype)
;;                  (const double) (const double)))

(define magick-shave-image
  (foreign-lambda bool MagickShaveImage
                  magickwand (const size_t) (const size_t)))

(define magick-shear-image
  (foreign-lambda bool MagickShearImage
                  magickwand (const pixelwand)
                  (const double) (const double)))

(define magick-sigmoidal-contrast-image
 (foreign-lambda bool MagickSigmoidalContrastImage
                 magickwand (const bool)
                 (const double) (const double)))

;;(define magick-sigmoidal-contrast-image-channel
;;  (foreign-lambda bool MagickSigmoidalContrastImageChannel
;;                  magickwand (const channeltype) (const bool)
;;                  (const double) (const double)))

;;(define magick-similarity-image
;;  (foreign-lambda magickwand MagickSimilarityImage
;;                  magickwand (const magickwand) RectangleInfo
;;                  (c-pointer double)))

(define magick-sketch-image
  (foreign-lambda bool MagickSketchImage
                  magickwand (const double) (const double) (const double)))

(define magick-smush-images
 (foreign-lambda magickwand MagickSmushImages
                 magickwand (const bool) (const ssize_t)))

(define magick-solarize-image
  (foreign-lambda bool MagickSolarizeImage
                  magickwand (const double)))

;;(define magick-sparse-color-image
;;  (foreign-lambda bool MagickSparseColorImage
;;                  magickwand (const channeltype) (const sparsecolormethod)
;;                  (const size_t) (const (c-pointer double))))

(define magick-splice-image
  (foreign-lambda bool MagickSpliceImage
                  magickwand (const size_t) (const size_t)
                  (const ssize_t) (const ssize_t)))

(define magick-spread-image
  (foreign-lambda bool MagickSpreadImage
                  magickwand (const double)))

;;(define magick-statistic-image
;;  (foreign-lambda bool MagickStatisticImage
;;                  magickwand (const statistictype) (const double)
;;                  (const size_t)))

;;(define magick-statistic-image-channel
;;  (foreign-lambda bool MagickStatisticImageChannel
;;                  magickwand (const channeltype) (const statistictype)
;;                  (const double) (const size_t)))

(define magick-stegano-image
  (foreign-lambda magickwand MagickSteganoImage
                  magickwand (const magickwand) (const ssize_t)))

(define magick-stereo-image
  (foreign-lambda magickwand MagickStereoImage
                  magickwand (const magickwand)))

(define magick-strip-image
  (foreign-lambda bool MagickStripImage magickwand))

(define magick-swirl-image
  (foreign-lambda bool MagickSwirlImage
                  magickwand (const double)))

(define magick-texture-image
  (foreign-lambda magickwand MagickTextureImage
                  magickwand (const magickwand)))

(define magick-threshold-image
  (foreign-lambda bool MagickThresholdImage
                  magickwand (const double)))

;;(define magick-threshold-image-channel
;;  (foreign-lambda bool MagickThresholdImageChannel
;;                  magickwand (const channeltype) (const double)))

(define magick-thumbnail-image
  (foreign-lambda bool MagickThumbnailImage
                  magickwand (const size_t) (const size_t)))

(define magick-tint-image
  (foreign-lambda bool MagickTintImage
                  magickwand (const pixelwand) (const pixelwand)))

(define magick-transform-image
  (foreign-lambda magickwand MagickTransformImage
                  magickwand (const c-string) (const c-string)))

(define magick-transform-image-colorspace
 (foreign-lambda bool MagickTransformImageColorspace
                 magickwand (const colorspace)))

(define magick-transparent-paint-image
 (foreign-lambda bool MagickTransparentPaintImage
                 magickwand (const pixelwand) (const double)
                 (const double) (const bool)))

(define magick-transpose-image
  (foreign-lambda bool MagickTransposeImage magickwand))

(define magick-transverse-image
  (foreign-lambda bool MagickTransverseImage magickwand))

(define magick-trim-image
  (foreign-lambda bool MagickTrimImage
                  magickwand (const double)))

(define magick-unique-image-colors
  (foreign-lambda bool MagickUniqueImageColors magickwand))

(define magick-unsharp-mask-image
  (foreign-lambda bool MagickUnsharpMaskImage
                  magickwand (const double) (const double)
                  (const double) (const double)))

;;(define magick-unsharp-mask-image-channel
;;  (foreign-lambda bool MagickUnsharpMaskImageChannel
;;                  magickwand (const channeltype) (const double)
;;                  (const double) (const double) (const double)))

(define magick-vignette-image
  (foreign-lambda bool MagickVignetteImage
                  magickwand (const double) (const double)
                  (const ssize_t) (const ssize_t)))

(define magick-wave-image
  (foreign-lambda bool MagickWaveImage
                  magickwand (const double) (const double)))

(define magick-white-threshold-image
  (foreign-lambda bool MagickWhiteThresholdImage
                  magickwand (const pixelwand)))

(define magick-write-image
  (foreign-lambda bool MagickWriteImage
                  magickwand (const c-string)))

;;(define magick-write-image-file
;;  (foreign-lambda bool MagickWriteImageFile
;;                  magickwand (c-pointer FILE)))

(define magick-write-images
 (foreign-lambda bool MagickWriteImages
                 magickwand (const c-string) (const bool)))

;;(define magick-write-images-file
;;  (foreign-lambda bool MagickWriteImagesFile
;;                  magickwand (c-pointer FILE)))


;;;
;;; Pixel-iterator methods
;;;

(define clear-pixel-iterator
  (foreign-lambda void ClearPixelIterator pixeliterator))

(define clone-pixel-iterator
  (foreign-lambda pixeliterator ClonePixelIterator (const pixeliterator)))

(define destroy-pixel-iterator
  (foreign-lambda pixeliterator DestroyPixelIterator pixeliterator))

(define pixel-iterator?
  (foreign-lambda bool IsPixelIterator (const pixeliterator)))

(define new-pixel-iterator
  (foreign-lambda pixeliterator NewPixelIterator magickwand))

(define pixel-clear-iterator-exception
  (foreign-lambda bool PixelClearIteratorException pixeliterator))

(define new-pixel-region-iterator
  (foreign-lambda pixeliterator NewPixelRegionIterator
                  magickwand (const ssize_t) (const ssize_t)
                  (const size_t) (const size_t)))

(define pixel-get-current-iterator-row
  (foreign-lambda (c-pointer pixelwand) PixelGetCurrentIteratorRow
                  pixeliterator (c-pointer size_t)))

(define (pixel-get-iterator-exception iterator)
  (let-location ((typeout int))
    (let ((str ((foreign-lambda c-string PixelGetIteratorException
                                (const pixeliterator)
                                (c-pointer "ExceptionType"))
                iterator (location typeout))))
      (values str (int->exceptiontype typeout)))))

(define pixel-get-iterator-exception-type
  (foreign-lambda exceptiontype PixelGetIteratorExceptionType
                  (const pixeliterator)))

(define pixel-get-iterator-row
  (foreign-lambda bool PixelGetIteratorRow pixeliterator))

(define pixel-get-next-iterator-row
  (foreign-lambda (c-pointer pixelwand) PixelGetNextIteratorRow
                  pixeliterator (c-pointer size_t)))

(define pixel-get-previous-iterator-row
  (foreign-lambda (c-pointer pixelwand) PixelGetPreviousIteratorRow
                  pixeliterator (c-pointer size_t)))

(define pixel-reset-iterator
  (foreign-lambda void PixelResetIterator pixeliterator))

(define pixel-set-first-iterator-row
  (foreign-lambda void PixelSetFirstIteratorRow pixeliterator))

(define pixel-set-iterator-row
  (foreign-lambda bool PixelSetIteratorRow
                  pixeliterator (const ssize_t)))

(define pixel-set-last-iterator-row
  (foreign-lambda void PixelSetLastIteratorRow pixeliterator))

(define pixel-sync-iterator
  (foreign-lambda bool PixelSyncIterator pixeliterator))


;;;
;;; Pixel-wand methods
;;;

(define clear-pixel-wand
  (foreign-lambda void ClearPixelWand pixelwand))

(define clone-pixel-wand
  (foreign-lambda pixelwand ClonePixelWand (const pixelwand)))

(define clone-pixel-wands
  (foreign-lambda (c-pointer pixelwand) ClonePixelWands
                  (const (c-pointer pixelwand)) (const size_t)))

(define destroy-pixel-wand
  (foreign-lambda pixelwand DestroyPixelWand pixelwand))

(define destroy-pixel-wands
  (foreign-lambda (c-pointer pixelwand) DestroyPixelWands
                  (c-pointer pixelwand) (const size_t)))

(define is-pixel-wand-similar
  (foreign-lambda bool IsPixelWandSimilar
                  pixelwand pixelwand (const double)))

(define pixel-wand?
  (foreign-lambda bool IsPixelWand (const pixelwand)))

(define new-pixel-wand
  (foreign-lambda pixelwand NewPixelWand))

(define new-pixel-wands
  (foreign-lambda (c-pointer pixelwand) NewPixelWands (const size_t)))

(define pixel-clear-exception
  (foreign-lambda bool PixelClearException pixelwand))

(define pixel-get-alpha
  (foreign-lambda double PixelGetAlpha (const pixelwand)))

;;(define pixel-get-alpha-quantum
;;  (foreign-lambda quantum PixelGetAlphaQuantum (const pixelwand)))

(define pixel-get-black
  (foreign-lambda double PixelGetBlack (const pixelwand)))

;;(define pixel-get-black-quantum
;;  (foreign-lambda quantum PixelGetBlackQuantum (const pixelwand)))

(define pixel-get-blue
  (foreign-lambda double PixelGetBlue (const pixelwand)))

;;(define pixel-get-blue-quantum
;;  (foreign-lambda quantum PixelGetBlueQuantum (const pixelwand)))

(define pixel-get-color-as-string
  (foreign-lambda c-string PixelGetColorAsString pixelwand))

(define pixel-get-color-as-normalized-string
  (foreign-lambda c-string PixelGetColorAsNormalizedString pixelwand))

(define pixel-get-color-count
  (foreign-lambda size_t PixelGetColorCount (const pixelwand)))

(define pixel-get-cyan
  (foreign-lambda double PixelGetCyan (const pixelwand)))

;;(define pixel-get-cyan-quantum
;;  (foreign-lambda quantum PixelGetCyanQuantum (const pixelwand)))

(define (pixel-get-exception wand)
  (let-location ((typeout int))
    (let ((str ((foreign-lambda c-string PixelGetException
                                (const pixelwand)
                                (c-pointer "ExceptionType"))
                wand (location typeout))))
      (values str (int->exceptiontype typeout)))))

(define pixel-get-exception-type
  (foreign-lambda exceptiontype PixelGetExceptionType (const pixelwand)))

(define pixel-get-fuzz
  (foreign-lambda double PixelGetFuzz (const pixelwand)))

(define pixel-get-green
  (foreign-lambda double PixelGetGreen (const pixelwand)))

;;(define pixel-get-green-quantum
;;  (foreign-lambda quantum PixelGetGreenQuantum (const pixelwand)))

(define pixel-get-hsl
  (foreign-lambda void PixelGetHSL
                  (const pixelwand) (c-pointer double)
                  (c-pointer double) (c-pointer double)))

;;(define pixel-get-index
;;  (foreign-lambda indexpacket PixelGetIndex (c-pointer double)))

(define pixel-get-magenta
  (foreign-lambda double PixelGetMagenta (const pixelwand)))

;;(define pixel-get-magenta-quantum
;;  (foreign-lambda quantum PixelGetMagentaQuantum (const pixelwand)))

;;(define pixel-get-magick-color
;;  (foreign-lambda void PixelGetMagickColor
;;                  pixelwand magickpixelpacket))

(define pixel-get-opacity
  (foreign-lambda double PixelGetOpacity (const pixelwand)))

;;(define pixel-get-opacity-quantum
;;  (foreign-lambda quantum PixelGetOpacityQuantum (const pixelwand)))

(define pixel-get-quantum-color
  (foreign-lambda void PixelGetQuantumColor pixelwand pixelpacket))

(define pixel-get-red
  (foreign-lambda double PixelGetRed (const pixelwand)))

;;(define pixel-get-red-quantum
;;  (foreign-lambda quantum PixelGetRedQuantum (const pixelwand)))

(define pixel-get-yellow
  (foreign-lambda double PixelGetYellow (const pixelwand)))

;;(define pixel-get-yellow-quantum
;;  (foreign-lambda quantum PixelGetYellowQuantum (const pixelwand)))

(define pixel-set-alpha
  (foreign-lambda void PixelSetAlpha pixelwand (const double)))

;;(define pixel-set-alpha-quantum
;;  (foreign-lambda void PixelSetAlphaQuantum pixelwand (const quantum)))

(define pixel-set-black
  (foreign-lambda void PixelSetBlack pixelwand (const double)))

;;(define pixel-set-black-quantum
;;  (foreign-lambda void PixelSetBlackQuantum pixelwand (const quantum)))

(define pixel-set-blue
  (foreign-lambda void PixelSetBlue pixelwand (const double)))

;;(define pixel-set-blue-quantum
;;  (foreign-lambda void PixelSetBlueQuantum pixelwand (const quantum)))

(define pixel-set-color
  (foreign-lambda bool PixelSetColor pixelwand (const c-string)))

(define pixel-set-color-count
  (foreign-lambda void PixelSetColorCount pixelwand (const size_t)))

(define pixel-set-color-from-wand
  (foreign-lambda void PixelSetColorFromWand pixelwand (const pixelwand)))

(define pixel-set-cyan
  (foreign-lambda void PixelSetCyan pixelwand (const double)))

;;(define pixel-set-cyan-quantum
;;  (foreign-lambda void PixelSetCyanQuantum pixelwand (const quantum)))

(define pixel-set-fuzz
  (foreign-lambda void PixelSetFuzz pixelwand (const double)))

(define pixel-set-green
  (foreign-lambda void PixelSetGreen pixelwand (const double)))

;;(define pixel-set-green-quantum
;;  (foreign-lambda void PixelSetGreenQuantum pixelwand (const quantum)))

(define pixel-set-hsl
  (foreign-lambda void PixelSetHSL
                  pixelwand (const double) (const double) (const double)))

;;(define pixel-set-index
;;  (foreign-lambda void PixelSetIndex pixelwand (const indexpacket)))

(define pixel-set-magenta
  (foreign-lambda void PixelSetMagenta pixelwand (const double)))

;;(define pixel-set-magenta-quantum
;;  (foreign-lambda void PixelSetMagentaQuantum pixelwand (const quantum)))

;;(define pixel-set-magick-color
;;  (foreign-lambda void PixelSetMagickColor pixelwand (const magickpixelpacket)))

(define pixel-set-opacity
  (foreign-lambda void PixelSetOpacity pixelwand (const double)))

;;(define pixel-set-opacity-quantum
;;  (foreign-lambda void PixelSetOpacityQuantum pixelwand (const quantum)))

(define pixel-set-quantum-color
  (foreign-lambda void PixelSetQuantumColor pixelwand (const pixelpacket)))

(define pixel-set-red
  (foreign-lambda void PixelSetRed pixelwand (const double)))

;;(define pixel-set-red-quantum
;;  (foreign-lambda void PixelSetRedQuantum pixelwand (const quantum)))

(define pixel-set-yellow
  (foreign-lambda void PixelSetYellow pixelwand (const double)))

;;(define pixel-set-yellow-quantum
;;  (foreign-lambda void PixelSetYellowQuantum pixelwand (const quantum)))


;;;
;;; Drawing-wand methods
;;;

(define clear-drawing-wand
  (foreign-lambda void ClearDrawingWand drawingwand))

(define clone-drawing-wand
  (foreign-lambda drawingwand CloneDrawingWand (const drawingwand)))

(define destroy-drawing-wand
  (foreign-lambda drawingwand DestroyDrawingWand drawingwand))

;;(define draw-affine
;;  (foreign-lambda void DrawAffine drawingwand (const AffineMatrix)))

(define draw-annotation
  (foreign-lambda void DrawAnnotation
                  drawingwand (const double) (const double)
                  (const unsigned-c-string)))

(define draw-arc
  (foreign-lambda void DrawArc
                  drawingwand (const double) (const double)
                  (const double) (const double)
                  (const double) (const double)))

;;(define draw-bezier
;;  (foreign-lambda void DrawBezier
;;                  drawingwand (const size_t) (const PointInfo)))

(define draw-circle
  (foreign-lambda void DrawCircle
                  drawingwand (const double) (const double)
                  (const double) (const double)))

(define draw-clear-exception
  (foreign-lambda bool DrawClearException drawingwand))

;;(define draw-composite
;;  (foreign-lambda bool DrawComposite
;;                  drawingwand (const compositeoperator)
;;                  (const double) (const double)
;;                  (const double) (const double)
;;                  magickwand))

;;(define draw-color
;;  (foreign-lambda void DrawColor
;;                  drawingwand (const double)
;;                  (const double) (const paintmethod)))

(define draw-comment
  (foreign-lambda void DrawComment drawingwand (const c-string)))

(define draw-ellipse
  (foreign-lambda void DrawEllipse
                  drawingwand (const double) (const double)
                  (const double) (const double)
                  (const double) (const double)))

(define draw-get-border-color
  (foreign-lambda void DrawGetBorderColor
                  (const drawingwand) pixelwand))

(define draw-get-clip-path
  (foreign-lambda c-string DrawGetClipPath (const drawingwand)))

(define draw-get-clip-rule
  (foreign-lambda fillrule DrawGetClipRule (const drawingwand)))

(define draw-get-clip-units
  (foreign-lambda clippathunits DrawGetClipUnits (const drawingwand)))

(define (draw-get-exception wand)
  (let-location ((typeout int))
    (let ((str ((foreign-lambda c-string DrawGetException
                                (const drawingwand)
                                (c-pointer "ExceptionType"))
                wand (location typeout))))
      (values str (int->exceptiontype typeout)))))

(define draw-get-exception-type
  (foreign-lambda exceptiontype DrawGetExceptionType (const drawingwand)))

(define draw-get-fill-color
  (foreign-lambda void DrawGetFillColor (const drawingwand) pixelwand))

(define draw-get-fill-opacity
  (foreign-lambda double DrawGetFillOpacity (const drawingwand)))

(define draw-get-fill-rule
  (foreign-lambda fillrule DrawGetFillRule (const drawingwand)))

(define draw-get-font
  (foreign-lambda c-string DrawGetFont (const drawingwand)))

(define draw-get-font-family
  (foreign-lambda c-string DrawGetFontFamily (const drawingwand)))

(define draw-get-font-resolution
  (foreign-lambda bool DrawGetFontResolution
                  (const drawingwand) (c-pointer double) (c-pointer double)))

(define draw-get-font-size
  (foreign-lambda double DrawGetFontSize (const drawingwand)))

(define draw-get-font-stretch
  (foreign-lambda stretchtype DrawGetFontStretch (const drawingwand)))

(define draw-get-font-style
  (foreign-lambda styletype DrawGetFontStyle (const drawingwand)))

(define draw-get-font-weight
  (foreign-lambda size_t DrawGetFontWeight (const drawingwand)))

(define draw-get-gravity
  (foreign-lambda gravity DrawGetGravity (const drawingwand)))

(define draw-get-opacity
  (foreign-lambda double DrawGetOpacity (const drawingwand)))

(define draw-get-stroke-antialias
  (foreign-lambda bool DrawGetStrokeAntialias (const drawingwand)))

(define draw-get-stroke-color
  (foreign-lambda void DrawGetStrokeColor (const drawingwand) pixelwand))

(define draw-get-stroke-dash-array
  (foreign-lambda (c-pointer double) DrawGetStrokeDashArray
                  (const drawingwand) (c-pointer size_t)))

(define draw-get-stroke-dash-offset
  (foreign-lambda double DrawGetStrokeDashOffset (const drawingwand)))

(define draw-get-stroke-line-cap
  (foreign-lambda linecap DrawGetStrokeLineCap (const drawingwand)))

(define draw-get-stroke-line-join
  (foreign-lambda linejoin DrawGetStrokeLineJoin (const drawingwand)))

(define draw-get-stroke-miter-limit
  (foreign-lambda size_t DrawGetStrokeMiterLimit (const drawingwand)))

(define draw-get-stroke-opacity
  (foreign-lambda double DrawGetStrokeOpacity (const drawingwand)))

(define draw-get-stroke-width
  (foreign-lambda double DrawGetStrokeWidth (const drawingwand)))

(define draw-get-text-alignment
  (foreign-lambda aligntype DrawGetTextAlignment (const drawingwand)))

(define draw-get-text-antialias
  (foreign-lambda bool DrawGetTextAntialias (const drawingwand)))

(define draw-get-text-decoration
  (foreign-lambda decorationtype DrawGetTextDecoration (const drawingwand)))

(define draw-get-text-encoding
  (foreign-lambda c-string DrawGetTextEncoding (const drawingwand)))

(define draw-get-text-kerning
  (foreign-lambda double DrawGetTextKerning drawingwand))

(define draw-get-text-interline-spacing
  (foreign-lambda double DrawGetTextInterlineSpacing drawingwand))

(define draw-get-text-interword-spacing
  (foreign-lambda double DrawGetTextInterwordSpacing drawingwand))

(define draw-get-vector-graphics
  (foreign-lambda c-string DrawGetVectorGraphics drawingwand))

(define draw-get-text-under-color
  (foreign-lambda void DrawGetTextUnderColor (const drawingwand) pixelwand))

(define draw-line
  (foreign-lambda void DrawLine
                  drawingwand (const double) (const double)
                  (const double) (const double)))

;;(define draw-matte
;;  (foreign-lambda void DrawMatte
;;                  drawingwand (const double) (const double)
;;                  (const paintmethod)))

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

;;(define draw-polygon
;;  (foreign-lambda void DrawPolygon
;;                  drawingwand (const size_t) (const PointInfo)))

;;(define draw-polyline
;;  (foreign-lambda void DrawPolyline
;;                  drawingwand (const size_t) (const PointInfo)))

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

(define draw-set-border-color
  (foreign-lambda void DrawSetBorderColor
                  drawingwand (const pixelwand)))

(define draw-set-clip-path
  (foreign-lambda bool DrawSetClipPath
                  drawingwand (const c-string)))

;;(define draw-set-clip-rule
;;  (foreign-lambda void DrawSetClipRule
;;                  drawingwand (const fillrule)))

;;(define draw-set-clip-units
;;  (foreign-lambda void DrawSetClipUnits
;;                  drawingwand (const clippathunits)))

(define draw-set-fill-color
  (foreign-lambda void DrawSetFillColor
                  drawingwand (const pixelwand)))

(define draw-set-fill-opacity
  (foreign-lambda void DrawSetFillOpacity
                  drawingwand (const double)))

(define draw-set-font-resolution
  (foreign-lambda bool DrawSetFontResolution
                  drawingwand (const double) (const double)))

(define draw-set-opacity
  (foreign-lambda void DrawSetOpacity drawingwand (const double)))

(define draw-set-fill-pattern-url
  (foreign-lambda bool DrawSetFillPatternURL
                  drawingwand (const c-string)))

;;(define draw-set-fill-rule
;;  (foreign-lambda void DrawSetFillRule drawingwand (const fillrule)))

(define draw-set-font
  (foreign-lambda bool DrawSetFont
                  drawingwand (const c-string)))

(define draw-set-font-family
  (foreign-lambda bool DrawSetFontFamily
                  drawingwand (const c-string)))

(define draw-set-font-size
  (foreign-lambda void DrawSetFontSize
                  drawingwand (const double)))

;;(define draw-set-font-stretch
;;  (foreign-lambda void DrawSetFontStretch
;;                  drawingwand (const stretchtype)))

;;(define draw-set-font-style
;;  (foreign-lambda void DrawSetFontStyle
;;                  drawingwand (const styletype)))

(define draw-set-font-weight
  (foreign-lambda void DrawSetFontWeight
                  drawingwand (const size_t)))

(define draw-set-gravity
 (foreign-lambda void DrawSetGravity
                 drawingwand (const gravity)))

(define draw-set-stroke-color
  (foreign-lambda void DrawSetStrokeColor
                  drawingwand (const pixelwand)))

(define draw-set-stroke-pattern-url
  (foreign-lambda bool DrawSetStrokePatternURL
                  drawingwand (const c-string)))

(define draw-set-stroke-antialias
 (foreign-lambda void DrawSetStrokeAntialias
                 drawingwand (const bool)))

(define draw-set-stroke-dash-array
  (foreign-lambda bool DrawSetStrokeDashArray
                  drawingwand (const size_t)
                  (const (c-pointer double))))

(define draw-set-stroke-dash-offset
  (foreign-lambda void DrawSetStrokeDashOffset
                  drawingwand (const double)))

;;(define draw-set-stroke-line-cap
;;  (foreign-lambda void DrawSetStrokeLineCap
;;                  drawingwand (const linecap)))

;;(define draw-set-stroke-line-join
;;  (foreign-lambda void DrawSetStrokeLineJoin
;;                  drawingwand (const linejoin)))

(define draw-set-stroke-miter-limit
  (foreign-lambda void DrawSetStrokeMiterLimit
                  drawingwand (const size_t)))

(define draw-set-stroke-opacity
  (foreign-lambda void DrawSetStrokeOpacity
                  drawingwand (const double)))

(define draw-set-stroke-width
  (foreign-lambda void DrawSetStrokeWidth
                  drawingwand (const double)))

;;(define draw-set-text-alignment
;;  (foreign-lambda void DrawSetTextAlignment
;;                  drawingwand (const aligntype)))

(define draw-set-text-antialias
 (foreign-lambda void DrawSetTextAntialias
                 drawingwand (const bool)))

;;(define draw-set-text-decoration
;;  (foreign-lambda void DrawSetTextDecoration
;;                  drawingwand (const decorationtype)))

(define draw-set-text-encoding
  (foreign-lambda void DrawSetTextEncoding
                  drawingwand (const c-string)))

(define draw-set-text-kerning
  (foreign-lambda void DrawSetTextKerning
                  drawingwand (const double)))

(define draw-set-text-interline-spacing
  (foreign-lambda void DrawSetTextInterlineSpacing
                  drawingwand (const double)))

(define draw-set-text-interword-spacing
  (foreign-lambda void DrawSetTextInterwordSpacing
                  drawingwand (const double)))

(define draw-set-text-under-color
  (foreign-lambda void DrawSetTextUnderColor
                  drawingwand (const pixelwand)))

(define draw-set-vector-graphics
  (foreign-lambda bool DrawSetVectorGraphics
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

(define drawing-wand?
  (foreign-lambda bool IsDrawingWand (const drawingwand)))

(define new-drawing-wand
  (foreign-lambda drawingwand NewDrawingWand))

(define peek-drawing-wand
  (foreign-lambda drawinfo PeekDrawingWand (const drawingwand)))

(define pop-drawing-wand
  (foreign-lambda bool PopDrawingWand drawingwand))

(define push-drawing-wand
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

;;(define get-wand-view-extent
;;  (foreign-lambda RectangleInfo GetWandViewExtent (const wandview)))

;;(define get-wand-view-iterator
;;  (foreign-lambda bool GetWandViewIterator
;;                  wandview getwandviewmethod c-pointer))

(define get-wand-view-pixels
  (foreign-lambda pixelwand GetWandViewPixels (const wandview)))

(define get-wand-view-wand
  (foreign-lambda magickwand GetWandViewWand (const wandview)))

(define wand-view?
  (foreign-lambda bool IsWandView (const wandview)))

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

;;(define update-wand-view-iterator
;;  (foreign-lambda bool UpdateWandViewIterator
;;                  wandview updatewandviewmethod c-pointer))

)
