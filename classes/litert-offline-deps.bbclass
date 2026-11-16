# LiteRT's CMake build downloads its third-party sources with FetchContent
# (and XNNPACK downloads more with ExternalProject), which needs network access
# in do_configure. This class fetches the same sources in do_fetch, pinned to
# the revisions LiteRT 2.3.0 asks for, and points CMake at them.
#
# The revisions differ from TensorFlow 2.21.0's (see
# tensorflow-lite-offline-deps.bbclass): LiteRT carries its own copy of the
# TensorFlow Lite CMake modules. Read GIT_REPOSITORY/GIT_TAG from
# tflite/tools/cmake/modules/*.cmake, litert/CMakeLists.txt and XNNPACK's
# cmake/Download*.cmake to update it.
#
# Sources are unpacked to ${UNPACKDIR}/litert-deps/<name>.

LITERT_DEPS_DIR = "${UNPACKDIR}/litert-deps"

SRC_URI += " \
    git://github.com/abseil/abseil-cpp;protocol=https;nobranch=1;name=abseil;destsuffix=litert-deps/abseil-cpp \
    git://github.com/pytorch/cpuinfo;protocol=https;nobranch=1;name=cpuinfo;destsuffix=litert-deps/cpuinfo \
    git://gitlab.com/libeigen/eigen;protocol=https;nobranch=1;name=eigen;destsuffix=litert-deps/eigen \
    git://github.com/google/farmhash;protocol=https;nobranch=1;name=farmhash;destsuffix=litert-deps/farmhash \
    git://github.com/petewarden/OouraFFT;protocol=https;nobranch=1;name=fft2d;destsuffix=litert-deps/fft2d \
    git://github.com/google/flatbuffers;protocol=https;nobranch=1;name=flatbuffers;destsuffix=litert-deps/flatbuffers \
    git://github.com/google/gemmlowp;protocol=https;nobranch=1;name=gemmlowp;destsuffix=litert-deps/gemmlowp \
    git://github.com/jax-ml/ml_dtypes;protocol=https;nobranch=1;name=ml_dtypes;destsuffix=litert-deps/ml_dtypes \
    git://github.com/protocolbuffers/protobuf;protocol=https;nobranch=1;name=protobuf;destsuffix=litert-deps/protobuf \
    git://github.com/google/ruy;protocol=https;nobranch=1;name=ruy;destsuffix=litert-deps/ruy \
    git://github.com/google/XNNPACK;protocol=https;nobranch=1;name=xnnpack;destsuffix=litert-deps/xnnpack \
    git://github.com/Maratyszcza/FP16;protocol=https;nobranch=1;name=fp16;destsuffix=litert-deps/fp16 \
    git://github.com/google/pthreadpool;protocol=https;nobranch=1;name=pthreadpool;destsuffix=litert-deps/pthreadpool \
    git://gitlab.arm.com/kleidi/kleidiai;protocol=https;nobranch=1;name=kleidiai;destsuffix=litert-deps/kleidiai \
    git://github.com/dcleblanc/SafeInt;protocol=https;nobranch=1;name=safeint;destsuffix=litert-deps/safeint \
    git://github.com/Maratyszcza/FXdiv;protocol=https;nobranch=1;name=fxdiv;destsuffix=litert-deps/fxdiv \
    git://github.com/KhronosGroup/OpenCL-Headers;protocol=https;nobranch=1;name=opencl_headers;destsuffix=litert-deps/opencl_headers \
    git://github.com/KhronosGroup/Vulkan-Headers;protocol=https;nobranch=1;name=vulkan_headers;destsuffix=litert-deps/vulkan_headers \
    git://github.com/KhronosGroup/OpenGL-Registry;protocol=https;nobranch=1;name=opengl_headers;destsuffix=litert-deps/opengl_headers \
    git://github.com/KhronosGroup/EGL-Registry;protocol=https;nobranch=1;name=egl_headers;destsuffix=litert-deps/egl_headers \
"
SRCREV_abseil = "5650e9cf76d3be4318d5fa3af38ee483ddfd5e4a"
SRCREV_cpuinfo = "8ce83db858065145192c97af90cb668ad72a12e9"
SRCREV_eigen = "ea13a98decd497a8c5588fb5de71b57bcf10d864"
SRCREV_farmhash = "0d859a811870d10f53a594927d0d0b97573ad06d"
# OouraFFT v1.0
SRCREV_fft2d = "c6fd2dd6d21397baa6653139d31d84540d5449a2"
# v25.12.19 (annotated tag) after files/0001-update_flatbuffers_ver_*.patch
SRCREV_flatbuffers = "7e163021e59cca4f8e1e35a7c828b5c6b7915953"
SRCREV_gemmlowp = "16e8662c34917be0065110bfcd9cc27d30f52fdf"
SRCREV_ml_dtypes = "00d98cd92ade342fef589c0470379abb27baebe9"
SRCREV_protobuf = "90b73ac3f0b10320315c2ca0d03a5a9b095d2f66"
SRCREV_ruy = "3286a34cc8de6149ac6844107dfdffac91531e72"
SRCREV_xnnpack = "d89ef6669a14db203b3b7935b1b3862cb63fb6df"
# tflite/cmake/DownloadFP16.cmake and XNNPACK cmake/Download*.cmake
SRCREV_fp16 = "0a92994d729ff76a58f692d3028ca1b64b145d91"
SRCREV_pthreadpool = "15a6644ba1c45f1acc16ac1e883efc3e56c6bed2"
SRCREV_kleidiai = "4bc7bd457930de119f8b826ecfdebfbd9c08cf8c"
# litert/CMakeLists.txt
SRCREV_safeint = "72f0745e26091af6d1186fd91426377f16688ba7"

# pthreadpool downloads FXdiv, "master" there; pinned to the head at 2026-11-16.
SRCREV_fxdiv = "63058eff77e11aa15bf531df5dd34395ec3017c8"
# tflite/tools/cmake/modules/{opencl,vulkan,opengl,egl}_headers.cmake
SRCREV_opencl_headers = "dcd5bede6859d26833cd85f0d6bbcee7382dc9b3"
SRCREV_vulkan_headers = "32c07c0c5334aea069e518206d75e002ccd85389"
SRCREV_opengl_headers = "0cb0880d91581d34f96899c86fc1bf35627b4b81"
SRCREV_egl_headers = "649981109e263b737e7735933c90626c29a306f2"

SRCREV_FORMAT = "litert_tensorflow_abseil_cpuinfo_eigen_farmhash_fft2d_flatbuffers_gemmlowp_ml_dtypes_protobuf_ruy_xnnpack_fp16_pthreadpool_kleidiai_safeint_fxdiv_opencl_headers_vulkan_headers_opengl_headers_egl_headers"

# neon2sse is only fetched for x86-64
SRC_URI:append:x86-64 = " git://github.com/intel/ARM_NEON_2_x86_SSE;protocol=https;nobranch=1;name=neon2sse;destsuffix=litert-deps/neon2sse"
SRCREV_neon2sse = "a15b489e1222b2087007546b4912e21293ea86ff"
SRCREV_FORMAT:append:x86-64 = "_neon2sse"

EXTRA_OECMAKE:append = " \
    -DFETCHCONTENT_FULLY_DISCONNECTED=ON \
    -DFETCHCONTENT_SOURCE_DIR_ABSEIL-CPP=${LITERT_DEPS_DIR}/abseil-cpp \
    -DFETCHCONTENT_SOURCE_DIR_CPUINFO=${LITERT_DEPS_DIR}/cpuinfo \
    -DFETCHCONTENT_SOURCE_DIR_EIGEN=${LITERT_DEPS_DIR}/eigen \
    -DFETCHCONTENT_SOURCE_DIR_FARMHASH=${LITERT_DEPS_DIR}/farmhash \
    -DFETCHCONTENT_SOURCE_DIR_FFT2D=${LITERT_DEPS_DIR}/fft2d \
    -DFETCHCONTENT_SOURCE_DIR_FLATBUFFERS=${LITERT_DEPS_DIR}/flatbuffers \
    -DFETCHCONTENT_SOURCE_DIR_GEMMLOWP=${LITERT_DEPS_DIR}/gemmlowp \
    -DFETCHCONTENT_SOURCE_DIR_ML_DTYPES=${LITERT_DEPS_DIR}/ml_dtypes \
    -DFETCHCONTENT_SOURCE_DIR_PROTOBUF=${LITERT_DEPS_DIR}/protobuf \
    -DFETCHCONTENT_SOURCE_DIR_RUY=${LITERT_DEPS_DIR}/ruy \
    -DFETCHCONTENT_SOURCE_DIR_XNNPACK=${LITERT_DEPS_DIR}/xnnpack \
    -DFETCHCONTENT_SOURCE_DIR_SAFEINT=${LITERT_DEPS_DIR}/safeint \
    -DFP16_SOURCE_DIR=${LITERT_DEPS_DIR}/fp16 \
    -DPTHREADPOOL_SOURCE_DIR=${LITERT_DEPS_DIR}/pthreadpool \
    -DKLEIDIAI_SOURCE_DIR=${LITERT_DEPS_DIR}/kleidiai \
    -DFXDIV_SOURCE_DIR=${LITERT_DEPS_DIR}/fxdiv \
    -DFETCHCONTENT_SOURCE_DIR_OPENCL_HEADERS=${LITERT_DEPS_DIR}/opencl_headers \
    -DFETCHCONTENT_SOURCE_DIR_VULKAN_HEADERS=${LITERT_DEPS_DIR}/vulkan_headers \
    -DFETCHCONTENT_SOURCE_DIR_OPENGL_HEADERS=${LITERT_DEPS_DIR}/opengl_headers \
    -DFETCHCONTENT_SOURCE_DIR_EGL_HEADERS=${LITERT_DEPS_DIR}/egl_headers \
"
EXTRA_OECMAKE:append:x86-64 = " -DFETCHCONTENT_SOURCE_DIR_NEON2SSE=${LITERT_DEPS_DIR}/neon2sse"

# The sources are outside ${S} and ${B}, so file names that end up in the binaries
# (assert messages, debug info) would carry the build directory: map them like
# ${S} and ${B}. (DEBUG_PREFIX_MAP_EXTRA is no use here: toolchain/gcc.bbclass
# assigns it.)
DEBUG_PREFIX_MAP:append = " -ffile-prefix-map=${LITERT_DEPS_DIR}=${TARGET_DBGSRC_DIR}/litert-deps"

# These sources are fetched ahead of time, so nothing needs network access any more
do_configure[network] = "0"

# litert/CMakeLists.txt adds ${CMAKE_BINARY_DIR}/opencl_headers and
# ${CMAKE_BINARY_DIR}/FP16-source/include to the include path if they exist,
# which is where the downloads used to end up. Provide them from the fetched
# sources.
do_configure:prepend() {
    mkdir -p ${B}
    ln -sfn ${LITERT_DEPS_DIR}/opencl_headers ${B}/opencl_headers
    ln -sfn ${LITERT_DEPS_DIR}/fp16 ${B}/FP16-source

    # opengl_headers.cmake and egl_headers.cmake have no license file in the
    # repository and download the Apache-2.0 text from LICENSE_URL when it is
    # missing; supply it from oe-core so nothing is downloaded.
    for n in opengl_headers egl_headers; do
        cp ${COMMON_LICENSE_DIR}/Apache-2.0 ${LITERT_DEPS_DIR}/$n/${n}_LICENSE.txt
    done
}
