# Ansible

## WSL setup caveat: sudo and Ansible

On Ubuntu 24.04/25.x WSL installations using `sudo-rs`, Ansible's local `become` handling may fail with:

```text
Task failed: Premature end of stream waiting for become success.
sudo: interactive authentication is required
```

This can happen even though regular `sudo` works correctly.

The Ansible playbook runs against the local WSL machine and requires root privileges. The Docker setup already configures the `lkmliz` user with passwordless sudo, so the WSL environment should use the same configuration.

### Fix

Create a sudoers entry:

```bash
sudo visudo -f /etc/sudoers.d/lkmliz
```

Add:

```text
lkmliz ALL=(ALL) NOPASSWD: ALL
```

Then verify that sudo works without prompting:

```bash
sudo -n whoami
```

Expected:

```text
root
```

After that, run the playbook normally:

```bash
ansible-playbook -i inventory.ini playbook.yaml
```

Do **not** use `-K` once passwordless sudo is configured.

### Ansible environment

Use a Python virtual environment rather than installing Ansible into Ubuntu's system-managed Python:

```bash
sudo apt install python3-venv

python3 -m venv ~/.venvs/ansible
source ~/.venvs/ansible/bin/activate

python -m pip install --upgrade pip
python -m pip install --upgrade ansible-core
```

Verify:

```bash
ansible --version
which ansible
```

The latter should point to:

```text
~/.venvs/ansible/bin/ansible
```

### Quick troubleshooting

If Ansible fails with:

```text
sudo: interactive authentication is required
```

check:

```bash
sudo -n whoami
```

If this does not return:

```text
root
```

verify the sudoers configuration before troubleshooting Ansible itself.

> **Note:** This is a WSL/Ubuntu environment caveat, particularly relevant to installations using `sudo-rs`. It is not necessary to modify the Dockerfile; the Docker configuration already uses `NOPASSWD` sudo for the `lkmliz` user.
