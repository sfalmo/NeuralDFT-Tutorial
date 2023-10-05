# Neural functional theory for inhomogeneous fluids - Tutorial

This is a tutorial for the concepts presented in

**Neural functional theory for inhomogeneous fluids: Fundamentals and applications**  
*Florian Sammüller, Sophie Hermann, Daniel de las Heras, and Matthias Schmidt (2023); [arXiv:2307.04539](https://arxiv.org/abs/2307.04539).*

and

**Why neural functionals suit statistical mechanics**  
*Florian Sammüller, Sophie Hermann, and Matthias Schmidt (2023).*

## Instructions

### Run online in Binder

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/sfalmo/NeuralDFT-Tutorial/HEAD?labpath=Tutorial.ipynb)

You can try out the tutorial in your browser using Binder (click on the above badge).
Starting the Binder instance might take quite some time as some packages might have to be installed, so be patient.
Note that any changes you make to the notebook and code are not saved after closing the Binder instance!

### Run locally

You need a working install of Julia and Jupyter.
Launch the Julia interpreter and type `]` to enter the package manager.
Then activate the environment and install the required packages as follows:

```julia
activate .
instantiate
```

Type backspace to exit the package manager and return to the Julia interpreter.
Then start a Jupyter server:

```julia
using IJulia
jupyterlab()
```

This should open up JupyterLab in your browser where you can navigate to `Tutorial.ipynb`.
