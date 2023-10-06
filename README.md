# Neural functional theory for inhomogeneous fluids - Tutorial

This is a tutorial for the methods presented in:

**Neural functional theory for inhomogeneous fluids: Fundamentals and applications**  
*Florian Sammüller, Sophie Hermann, Daniel de las Heras, and Matthias Schmidt (2023); [arXiv:2307.04539](https://arxiv.org/abs/2307.04539).*

**Why neural functionals suit statistical mechanics**  
*Florian Sammüller, Sophie Hermann, and Matthias Schmidt (2023).*

## Instructions

### Run online in Binder

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/sfalmo/NeuralDFT-Tutorial/HEAD?labpath=Tutorial.ipynb)

You can try out the tutorial in your browser using Binder (click on the above badge).
Starting the Binder instance for the first time might take quite long as some packages have to be installed, so please be patient.
Note that any changes you make to the notebook and code are not saved automatically after closing the Binder instance!
However, you can save the state of the notebook and download generated data manually.

### Run locally

You need a working install of Julia and Jupyter.
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
