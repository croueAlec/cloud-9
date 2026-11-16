TEST_INVENTORY_FILENAME=./inventory/test_hosts.yml

SECRETS_FILENAME=secrets.yml
PLAYBOOK_FILENAME=playbook.yml

encrypt:
	@ansible-vault encrypt ${SECRETS_FILENAME}

decrypt:
	@ansible-vault decrypt ${SECRETS_FILENAME}

edit:
	@ansible-vault edit ${SECRETS_FILENAME}

test_aplp:
	@ansible-playbook ${PLAYBOOK_FILENAME} --ask-vault-pass -i ${TEST_INVENTORY_FILENAME}

aplp:
	@ansible-playbook ${PLAYBOOK_FILENAME} --ask-vault-pass
