# TensorFlow Lite's CMake build downloads its third-party sources with
# FetchContent (and XNNPACK downloads four more with ExternalProject), which
# needs network access in do_configure. This class fetches the same sources in
# do_fetch, pinned to the revisions that TensorFlow 2.21.0 (and XNNPACK) ask
# for, and points CMake at them so nothing is downloaded at configure time.
#
# Sources are unpacked to ${UNPACKDIR}/tflite-deps/<name>. To update this for a
# new TensorFlow release, read GIT_REPOSITORY/GIT_TAG from
# tensorflow/lite/tools/cmake/modules/*.cmake and XNNPACK's cmake/Download*.
#
# Keep in step with the patched flatbuffers tag in
# files/001-flatbuffers.cmake.patch (v25.12.19).

TFLITE_DEPS_DIR = "${UNPACKDIR}/tflite-deps"

SRC_URI += " \
    git://github.com/pytorch/cpuinfo;protocol=https;nobranch=1;name=cpuinfo;destsuffix=tflite-deps/cpuinfo \
    git://github.com/google/farmhash;protocol=https;nobranch=1;name=farmhash;destsuffix=tflite-deps/farmhash \
    git://github.com/google/flatbuffers;protocol=https;nobranch=1;name=flatbuffers;destsuffix=tflite-deps/flatbuffers \
    git://github.com/google/gemmlowp;protocol=https;nobranch=1;name=gemmlowp;destsuffix=tflite-deps/gemmlowp \
    git://github.com/jax-ml/ml_dtypes;protocol=https;nobranch=1;name=ml_dtypes;destsuffix=tflite-deps/ml_dtypes \
    git://github.com/google/ruy;protocol=https;nobranch=1;name=ruy;destsuffix=tflite-deps/ruy \
    git://github.com/google/XNNPACK;protocol=https;nobranch=1;name=xnnpack;destsuffix=tflite-deps/xnnpack \
    git://github.com/Maratyszcza/FP16;protocol=https;nobranch=1;name=fp16;destsuffix=tflite-deps/fp16 \
    git://github.com/Maratyszcza/FXdiv;protocol=https;nobranch=1;name=fxdiv;destsuffix=tflite-deps/fxdiv \
    git://github.com/ARM-software/kleidiai;protocol=https;nobranch=1;name=kleidiai;destsuffix=tflite-deps/kleidiai \
    git://github.com/google/pthreadpool;protocol=https;nobranch=1;name=pthreadpool;destsuffix=tflite-deps/pthreadpool \
    git://github.com/petewarden/OouraFFT;protocol=https;nobranch=1;name=fft2d;destsuffix=tflite-deps/fft2d \
"

# tensorflow/lite/tools/cmake/modules/*.cmake at TensorFlow 2.21.0
SRCREV_cpuinfo = "8a9210069b5a37dd89ed118a783945502a30a4ae"
# OouraFFT v1.0 (TensorFlow downloads the v1.0 archive of this repository)
SRCREV_fft2d = "c6fd2dd6d21397baa6653139d31d84540d5449a2"
SRCREV_farmhash = "0d859a811870d10f53a594927d0d0b97573ad06d"
# v25.12.19 (annotated tag), see files/001-flatbuffers.cmake.patch
SRCREV_flatbuffers = "7e163021e59cca4f8e1e35a7c828b5c6b7915953"
SRCREV_gemmlowp = "16e8662c34917be0065110bfcd9cc27d30f52fdf"
SRCREV_ml_dtypes = "00d98cd92ade342fef589c0470379abb27baebe9"
SRCREV_ruy = "3286a34cc8de6149ac6844107dfdffac91531e72"
SRCREV_xnnpack = "25b42dfddb0ee22170d73ff0d4b333ea1e6edfeb"
# XNNPACK's cmake/Download*.cmake (FP16 is the same revision as TensorFlow's
# fp16_headers.cmake). FXdiv is "master" there; pinned to the head that the
# configure step fetched when this class was written, 2026-11-16.
SRCREV_fp16 = "0a92994d729ff76a58f692d3028ca1b64b145d91"
SRCREV_fxdiv = "63058eff77e11aa15bf531df5dd34395ec3017c8"
SRCREV_kleidiai = "63205aa90afa6803d8f58bc3081b69288e9f1906"
SRCREV_pthreadpool = "0e6ca13779b57d397a5ba6bfdcaa8a275bc8ea2e"

# More than one SCM: bitbake needs to know how to combine the revisions
SRCREV_FORMAT = "tensorflow_cpuinfo_farmhash_fft2d_flatbuffers_gemmlowp_ml_dtypes_ruy_xnnpack_fp16_fxdiv_kleidiai_pthreadpool"
SRCREV_FORMAT:append:x86-64 = "_neon2sse"

# neon2sse is only fetched for x86-64 (001-Set-CMAKE_POLICY_VERSION_MINIMUM-NEON2SSE.patch)
SRC_URI:append:x86-64 = " git://github.com/intel/ARM_NEON_2_x86_SSE;protocol=https;nobranch=1;name=neon2sse;destsuffix=tflite-deps/neon2sse"
SRCREV_neon2sse = "a15b489e1222b2087007546b4912e21293ea86ff"

EXTRA_OECMAKE:append = " \
    -DFETCHCONTENT_FULLY_DISCONNECTED=ON \
    -DFETCHCONTENT_SOURCE_DIR_CPUINFO=${TFLITE_DEPS_DIR}/cpuinfo \
    -DFETCHCONTENT_SOURCE_DIR_FARMHASH=${TFLITE_DEPS_DIR}/farmhash \
    -DFETCHCONTENT_SOURCE_DIR_FFT2D=${TFLITE_DEPS_DIR}/fft2d \
    -DFETCHCONTENT_SOURCE_DIR_FLATBUFFERS=${TFLITE_DEPS_DIR}/flatbuffers \
    -DFETCHCONTENT_SOURCE_DIR_GEMMLOWP=${TFLITE_DEPS_DIR}/gemmlowp \
    -DFETCHCONTENT_SOURCE_DIR_ML_DTYPES=${TFLITE_DEPS_DIR}/ml_dtypes \
    -DFETCHCONTENT_SOURCE_DIR_RUY=${TFLITE_DEPS_DIR}/ruy \
    -DFETCHCONTENT_SOURCE_DIR_XNNPACK=${TFLITE_DEPS_DIR}/xnnpack \
    -DFP16_SOURCE_DIR=${TFLITE_DEPS_DIR}/fp16 \
    -DFXDIV_SOURCE_DIR=${TFLITE_DEPS_DIR}/fxdiv \
    -DKLEIDIAI_SOURCE_DIR=${TFLITE_DEPS_DIR}/kleidiai \
    -DPTHREADPOOL_SOURCE_DIR=${TFLITE_DEPS_DIR}/pthreadpool \
"
EXTRA_OECMAKE:append:x86-64 = " -DFETCHCONTENT_SOURCE_DIR_NEON2SSE=${TFLITE_DEPS_DIR}/neon2sse"

# The sources are outside ${S} and ${B}, so file names that end up in the binaries
# (assert messages, debug info) would carry the build directory: map them like
# ${S} and ${B}. (DEBUG_PREFIX_MAP_EXTRA is no use here: toolchain/gcc.bbclass
# assigns it.)
DEBUG_PREFIX_MAP:append = " -ffile-prefix-map=${TFLITE_DEPS_DIR}=${TARGET_DBGSRC_DIR}/tflite-deps"

# These sources are fetched ahead of time, so nothing needs network access any more
do_configure[network] = "0"
