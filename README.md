# Neural functional theory for inhomogeneous fluids - Tutorial

This is a tutorial for the methods presented in:

**Neural functional theory for inhomogeneous fluids: Fundamentals and applications**  
*Florian Sammüller, Sophie Hermann, Daniel de las Heras, and Matthias Schmidt, [Proc. Natl. Acad. Sci. **120**, e2312484120](https://doi.org/10.1073/pnas.2312484120) (2023); [arXiv:2307.04539](https://arxiv.org/abs/2307.04539).*

**Why neural functionals suit statistical mechanics**  
*Florian Sammüller, Sophie Hermann, and Matthias Schmidt (2023); [arXiv:2312.04681](https://arxiv.org/abs/2312.04681).*

## Instructions

### Run online in Binder or Google Colab

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/sfalmo/NeuralDFT-Tutorial/HEAD?labpath=Tutorial.ipynb) [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/sfalmo/NeuralDFT-Tutorial/blob/master/Tutorial.ipynb)

You can try out the tutorial in your browser using Binder or Google Colab.
If you are particularly interested in the machine learning part, use Google Colab with a free GPU instance, but you will have to do some manual steps to get Julia running.
Binder comes with Julia and is ready to go, but it has no GPU, so the machine learning will be very slow (it might still suffice for proof-of-concept work).
In both cases, remember to manually save your changes and generated data/models, as they will be deleted once the instance is shut down.

### Run locally

You need a working install of Julia.
Launch the Julia interpreter in this directory and type `]` to enter the package manager.
Then activate the environment and install the required packages as follows:

```julia
activate .
instantiate
```

Type backspace to exit the package manager.
Then start a Jupyter server:

```julia
using IJulia
jupyterlab()
```

This should open up JupyterLab in your browser where you can navigate to `Tutorial.ipynb`.
