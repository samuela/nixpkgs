# The following version combinations are supported:
#  * cuDNN 7.4.2, cudatoolkit 10.0
#  * cuDNN 7.6.3, cudatoolkit 10.1
#  * cuDNN 7.6.5, cudatoolkit 10.2
#  * cuDNN 8.1.1, cudatoolkit 11.0-11.4
#  * cuDNN 8.3.0, cudatoolkit 11.0-11.4
{ callPackage
, cudatoolkit_10_0
, cudatoolkit_10_1
, cudatoolkit_10_2
, cudatoolkit_11_0
, cudatoolkit_11_1
, cudatoolkit_11_2
, cudatoolkit_11_3
, cudatoolkit_11_4
}:

let
  generic = args: callPackage (import ./generic.nix (removeAttrs args [ "cudatoolkit" ])) {
    inherit (args) cudatoolkit;
  };
in
rec {
  # cuDNN 7.x
  cudnn_7_4_cudatoolkit_10_0 = generic rec {
    version = "7.4.2";
    cudatoolkit = cudatoolkit_10_0;
    srcName = "cudnn-${cudatoolkit.majorVersion}-linux-x64-v7.4.2.24.tgz";
    sha256 = "18ys0apiz9afid2s6lvy9qbyi8g66aimb2a7ikl1f3dm09mciprf";
  };

  cudnn_7_6_cudatoolkit_10_1 = generic rec {
    version = "7.6.3";
    cudatoolkit = cudatoolkit_10_1;
    srcName = "cudnn-${cudatoolkit.majorVersion}-linux-x64-v7.6.3.30.tgz";
    sha256 = "0qc9f1xpyfibwqrpqxxq2v9h6w90j0dbx564akwy44c1dls5f99m";
  };

  cudnn_7_6_cudatoolkit_10_2 = generic rec {
    version = "7.6.5";
    cudatoolkit = cudatoolkit_10_2;
    srcName = "cudnn-${cudatoolkit.majorVersion}-linux-x64-v7.6.5.32.tgz";
    sha256 = "084c13vzjdkb5s1996yilybg6dgav1lscjr1xdcgvlmfrbr6f0k0";
  };

  cudnn_7_6_cudatoolkit_10 = cudnn_7_6_cudatoolkit_10_2;

  # cuDNN 8.x
  cudnn_8_1_cudatoolkit_11_0 = generic rec {
    version = "8.1.1";
    cudatoolkit = cudatoolkit_11_0;
    # 8.1.0 is compatible with CUDA 11.0, 11.1, and 11.2:
    # https://docs.nvidia.com/deeplearning/cudnn/support-matrix/index.html#cudnn-cuda-hardware-versions
    srcName = "cudnn-11.2-linux-x64-v8.1.1.33.tgz";
    hash = "sha256-mKh4TpKGLyABjSDCgbMNSgzZUfk2lPZDPM9K6cUCumo=";
  };
  cudnn_8_1_cudatoolkit_11_1 = cudnn_8_1_cudatoolkit_11_0.override { cudatoolkit = cudatoolkit_11_1; };
  cudnn_8_1_cudatoolkit_11_2 = cudnn_8_1_cudatoolkit_11_0.override { cudatoolkit = cudatoolkit_11_2; };
  cudnn_8_1_cudatoolkit_11_3 = cudnn_8_1_cudatoolkit_11_0.override { cudatoolkit = cudatoolkit_11_3; };
  cudnn_8_1_cudatoolkit_11_4 = cudnn_8_1_cudatoolkit_11_0.override { cudatoolkit = cudatoolkit_11_4; };
  cudnn_8_1_cudatoolkit_11 = cudnn_8_1_cudatoolkit_11_4;

  cudnn_8_3_cudatoolkit_11_0 = generic rec {
    # 8.3.0 is the last version to respect the folder structure that generic.nix
    # expects. Later versions have files in a subdirectory `local_installers`.
    # See eg https://developer.download.nvidia.com/compute/redist/cudnn/v8.3.1/.
    version = "8.3.0";
    cudatoolkit = cudatoolkit_11_0;
    # 8.3.0 is compatible with CUDA 11.0-11.5:
    # https://docs.nvidia.com/deeplearning/cudnn/support-matrix/index.html#cudnn-cuda-hardware-versions
    srcName = "cudnn-11.5-linux-x64-v8.3.0.98.tgz";
    hash = "sha256-RMb1rVyxL7dPoMmh58qvTwTXVa3xGi5bbJ5BfaN2srI=";
  };
  cudnn_8_3_cudatoolkit_11_1 = cudnn_8_3_cudatoolkit_11_0.override { cudatoolkit = cudatoolkit_11_1; };
  cudnn_8_3_cudatoolkit_11_2 = cudnn_8_3_cudatoolkit_11_0.override { cudatoolkit = cudatoolkit_11_2; };
  cudnn_8_3_cudatoolkit_11_3 = cudnn_8_3_cudatoolkit_11_0.override { cudatoolkit = cudatoolkit_11_3; };
  cudnn_8_3_cudatoolkit_11_4 = cudnn_8_3_cudatoolkit_11_0.override { cudatoolkit = cudatoolkit_11_4; };
  cudnn_8_3_cudatoolkit_11 = cudnn_8_3_cudatoolkit_11_4;
}
