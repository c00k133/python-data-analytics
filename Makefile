PYTHON_VERSION ?= 3.8
REQUIREMENTS_FILE ?= requirements.txt

VENV_DIR ?= venv

$(VENV_DIR)/bin/python: $(REQUIREMENTS_FILE)
	virtualenv --python=python$(PYTHON_VERSION) $(VENV_DIR)
	$(VENV_DIR)/bin/pip install --requirement $(REQUIREMENTS_FILE)

shell: $(VENV_DIR)/bin/python
	$(VENV_DIR)/bin/python

clean:
	rm --recursive --force $(VENV_DIR)
