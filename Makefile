# -----------------------------------------------------------------------------
# The install target is supposed to copy all scripts into:
# /usr/local/vcard2abook/ and make a link to it in /usr/local/bin/.
# The idea behind it is, that I want to easily be able to see where the
# installed scripts in /usr/local/bin/ come from.
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
# variables/constants
# -----------------------------------------------------------------------------

INSTALL_DIR_BASE = /usr/local
INSTALL_DIR_SCRIPT = $(INSTALL_DIR_BASE)/vcard2abook
INSTALL_DIR_BIN = $(INSTALL_DIR_BASE)/bin
SCRIPT_NAME = vcard2abook.sh


# -----------------------------------------------------------------------------
# targets
# -----------------------------------------------------------------------------

# Print available targets
.PHONY: help
help: Makefile
	@echo ""
	@echo "The following targets exists:"
	@sed -n "s/^## //p" $<


## install:            Install all scripts and templates, and make links
.PHONY: install
install: $(SCRIPT_NAME)
	mkdir -p $(INSTALL_DIR_SCRIPT)
	cp $< $(INSTALL_DIR_SCRIPT)
	ln -svn $(INSTALL_DIR_SCRIPT)/$< $(INSTALL_DIR_BIN)/$(basename $<)


## uninstall:          Deletes installed scripts.
.PHONY: uninstall
uninstall:
	rm -rf $(INSTALL_DIR_SCRIPT)
	rm -f $(INSTALL_DIR_BIN)/$(basename $(SCRIPT_NAME))
