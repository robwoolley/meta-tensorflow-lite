# Some TensorFlow Lite recipes (libtensorflow-lite-c, python3-tensorflow-lite,
# tensorflow-lite-benchmark) do not use the system abseil-cpp, Eigen and
# protobuf the way libtensorflow-lite does (it deletes the Find modules and
# DEPENDS on them), so CMake downloads those as well. Fetch them in do_fetch too.
inherit tensorflow-lite-offline-deps

SRC_URI += " \
    git://github.com/abseil/abseil-cpp;protocol=https;nobranch=1;name=abseil;destsuffix=tflite-deps/abseil-cpp \
    git://gitlab.com/libeigen/eigen;protocol=https;nobranch=1;name=eigen;destsuffix=tflite-deps/eigen \
    git://github.com/protocolbuffers/protobuf;protocol=https;nobranch=1;name=protobuf;destsuffix=tflite-deps/protobuf \
"
# tensorflow/lite/tools/cmake/modules/{abseil-cpp,eigen,protobuf}.cmake at TensorFlow 2.21.0
SRCREV_abseil = "d38452e1ee03523a208362186fd42248ff2609f6"
SRCREV_eigen = "dcbaf2d608f306450f1e74949eb87e9a22a7ef4b"
SRCREV_protobuf = "90b73ac3f0b10320315c2ca0d03a5a9b095d2f66"
SRCREV_FORMAT:append = "_abseil_eigen_protobuf"

EXTRA_OECMAKE:append = " \
    -DFETCHCONTENT_SOURCE_DIR_ABSEIL-CPP=${TFLITE_DEPS_DIR}/abseil-cpp \
    -DFETCHCONTENT_SOURCE_DIR_EIGEN=${TFLITE_DEPS_DIR}/eigen \
    -DFETCHCONTENT_SOURCE_DIR_PROTOBUF=${TFLITE_DEPS_DIR}/protobuf \
"
