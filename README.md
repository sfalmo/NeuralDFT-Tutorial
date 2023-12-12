# Neural functional theory for inhomogeneous fluids - Tutorial

This is a tutorial for the methods presented in:

**Neural functional theory for inhomogeneous fluids: Fundamentals and applications**  
*Florian Sammüller, Sophie Hermann, Daniel de las Heras, and Matthias Schmidt, [Proc. Natl. Acad. Sci. **120**, e2312484120](https://doi.org/10.1073/pnas.2312484120) (2023); [arXiv:2307.04539](https://arxiv.org/abs/2307.04539).*

**Why neural functionals suit statistical mechanics**  
*Florian Sammüller, Sophie Hermann, and Matthias Schmidt (2023); [arXiv:2312.04681](https://arxiv.org/abs/2312.04681).*

## Instructions

### Run locally (recommended)

A recent version of [Julia](https://julialang.org/downloads/) needs to be installed on your system.
Launch the Julia interpreter within this directory and type `]` to enter the package manager.
Activate the environment and install the required packages as follows:

```julia
activate .
instantiate
```

Type backspace to exit the package manager.
Start a Jupyter server:

```julia
using IJulia
jupyterlab()
```

This should open JupyterLab in your browser where you can navigate to `Tutorial.ipynb`.

### Run online

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/sfalmo/NeuralDFT-Tutorial/HEAD?labpath=Tutorial.ipynb)

You can try out the tutorial in your browser using Binder.
Note that Binder provides very limited computational resources and no access to a GPU, so the machine learning parts will be very slow (it might still be sufficient for some proof-of-concept work).
Remember to manually save and download your changes and generated data/models, as they will be deleted once the instance is shut down.

We also provide [instructions](Colab_instructions.md) for an experimental setup in Google Colab.