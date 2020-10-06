PYTHON_VERSION ?= 3.8
REQUIREMENTS_FILE ?= requirements.txt

VENV_DIR ?= venv

$(VENV_DIR)/bin/%: $(REQUIREMENTS_FILE)
	virtualenv --python=python$(PYTHON_VERSION) $(VENV_DIR)
	$(VENV_DIR)/bin/pip install --requirement $<

JUPYTER_KERNEL_NAME ?= python-data-analytics

jupyter-kernel: $(VENV_DIR)/bin/ipython
	$< kernel install --name "$(JUPYTER_KERNEL_NAME)" --user

jupyter-notebook: $(VENV_DIR)/bin/jupyter-notebook jupyter-kernel
	$< -m jupyter-notebook

jupyter: jupyter-notebook

notebook: jupyter-notebook

shell: $(VENV_DIR)/bin/python
	$<

clean: $(VENV_DIR)/bin/jupyter
	$< kernelspec remove "$(JUPYTER_KERNEL_NAME)"
	rm --recursive --force $(VENV_DIR)
