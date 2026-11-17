TEST_INVENTORY_FILENAME=./inventory/hosts.yml
INVENTORY_FILENAME=./inventory/aws_ec2.yml

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

test_inventory:
	@ansible-inventory -i ${TEST_INVENTORY_FILENAME} --graph

inventory:
	@ansible-inventory -i ${INVENTORY_FILENAME} --graph

.PHONY: inventory
