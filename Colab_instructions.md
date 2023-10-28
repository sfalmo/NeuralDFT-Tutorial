# Instructions for Google Colab

In Google Colab, you can use a machine with an Nvidia GPU for free, but you first have to install Julia and the required packages.
Follow these steps each time you start a new runtime:

1. Connect to a GPU runtime:
   - In the Google Colab interface, click the arrow (&#9660;) next to *Connect* and select *Change runtime type*
   - Under *Hardware accelerator*, select some option with "GPU" in its name
   - Save the runtime settings and click *Connect*
2. Create a new code cell, copy the script below and run it. Wait a few minutes for the Julia install to finish.

```shell
%%shell
set -e

JULIA_VERSION="1.9.2"

if [ -z `which julia` ]; then
    JULIA_VER=`cut -d '.' -f -2 <<< "$JULIA_VERSION"`
    echo "Installing Julia $JULIA_VERSION on the current Colab Runtime..."
    BASE_URL="https://julialang-s3.julialang.org/bin/linux/x64"
    URL="$BASE_URL/$JULIA_VER/julia-$JULIA_VERSION-linux-x86_64.tar.gz"
    wget -nv $URL -O /tmp/julia.tar.gz
    tar -x -f /tmp/julia.tar.gz -C /usr/local --strip-components 1
    rm /tmp/julia.tar.gz
    
    echo "Installing IJulia package..."
    julia -e 'using Pkg; pkg"add IJulia; precompile;"' &> /dev/null
    
    echo "Installing IJulia kernel..."
    julia -e 'using IJulia; IJulia.installkernel("julia")'
    KERNEL_DIR=`julia -e "using IJulia; print(IJulia.kerneldir())"`
    KERNEL_NAME=`ls -d "$KERNEL_DIR"/julia*`
    mv -f $KERNEL_NAME "$KERNEL_DIR"/julia
fi

git clone https://github.com/sfalmo/NeuralDFT-Tutorial.git
cp NeuralDFT-Tutorial/*.jl NeuralDFT-Tutorial/*.toml .

echo "Done."
```

3. Switch to the Julia kernel:
   - Click the arrow (&#9660;) next to *Connect* and select *Change runtime type*
   - Under *Runtime type*, select the option "julia 1.9.2" (do not change the *Hardware accelerator* which you have chosen in step 1)
4. Install the required Julia packages: create a new cell, copy the following code and run it. This will also take a few minutes.

```julia
import Pkg
Pkg.activate(".")
Pkg.add("CUDA")
Pkg.add("cuDNN")
Pkg.instantiate()
```

You can now start the tutorial.
As all required packages have just been installed, the GPU is automatically used where needed.