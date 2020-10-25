PYTHON_VERSION ?= 3.8
REQUIREMENTS_FILE ?= requirements.txt

VENV_DIR ?= venv

install: $(VENV_DIR)/bin/python

$(VENV_DIR)/bin/python: $(REQUIREMENTS_FILE)
	virtualenv --python=python$(PYTHON_VERSION) $(VENV_DIR)
	$(VENV_DIR)/bin/pip install --requirement $<

JUPYTER_KERNEL_NAME ?= python-data-analytics

$(VENV_DIR)/bin/ipython: $(VENV_DIR)/bin/python

jupyter-kernel: $(VENV_DIR)/bin/ipython
	$< kernel install --name "$(JUPYTER_KERNEL_NAME)" --user

$(VENV_DIR)/bin/jupyter-notebook: $(VENV_DIR)/bin/python

jupyter-notebook: $(VENV_DIR)/bin/jupyter-notebook jupyter-kernel
	$< -m jupyter-notebook

jupyter: jupyter-notebook

notebook: jupyter-notebook

shell: $(VENV_DIR)/bin/python
	$<

clean: $(VENV_DIR)/bin/jupyter
	$< kernelspec remove "$(JUPYTER_KERNEL_NAME)"
	rm --recursive --force $(VENV_DIR)
