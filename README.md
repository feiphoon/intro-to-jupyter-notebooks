# Intro to Jupyter notebooks
__Data COP 11/07/2019__

## Setup

### Mac users

Check for Python & `pip`:
```
python --version
pip3 --version
```

Install `virtualenv`:
```
pip3 install virtualenv
virtualenv --version
```

Navigate to your project folder (here!), and set up a virtual environment for Python 3.
```
cd [project folder]
python3 -m virtualenv venv3
```

Activate the environment:
```
source venv3/bin/activate
```

Install any non-core Python packages you will use:
```
pip install jupyter pandas [things] # space-delimited list of multiple packages
```

Save the dependencies for your project:
```
pip freeze > requirements.txt
```

Exit the environment:
```
deactivate
```

To load your dependencies next time:
```
source venv3/bin/activate
pip install -r requirements.txt
```

### Windows users


## Run Jupyter

### Mac users

```
source venv3/bin/activate
pip install -r requirements.txt
jupyter notebook
```
