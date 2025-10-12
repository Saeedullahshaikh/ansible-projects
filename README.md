# Ansible Automation Projects

Ansible playbooks for automating server deployments with Docker containerization and GitHub Actions CI/CD integration.

## Features

- **LAMP Stack Deployment** - Automated Apache, MySQL/MariaDB, and PHP installation
- **Nginx Installation** - Quick web server setup
- **Process Management** - Kill processes by name across servers
- **Cross-Platform Support** - Works on Debian/Ubuntu and RHEL/CentOS
- **Docker Integration** - Run playbooks in containers
- **CI/CD Ready** - GitHub Actions automation included

## Available Playbooks

| Playbook | Description | OS Support |
|----------|-------------|------------|
| `lampsetup_pb.yml` | Install LAMP stack | Debian/Ubuntu, RHEL/CentOS |
| `nginxinstall_pb.yml` | Install Nginx | Debian/Ubuntu |
| `test_pb.yml` | Test connectivity | Localhost |
| `killprocess_pb.yml` | Kill processes | All Linux |

## Usage

### Local Execution

```bash
# Clone repository
git clone https://github.com/Saeedullahshaikh/ansible-projects.git
cd ansible-projects

# Install Ansible
pip install ansible

# Create inventory file
echo "192.168.1.100 ansible_user=ubuntu" > hosts

# Run playbook
ansible-playbook -i hosts lampsetup_pb.yml --become
```

### Docker Execution

```bash
# Build Docker image
docker build -t ansible-runner .

# Run playbook in container
docker run --rm \
  -v $(pwd):/ansible \
  -v ~/.ssh:/root/.ssh:ro \
  -e PLAYBOOK="lampsetup_pb.yml" \
  -e INVENTORY="hosts" \
  -e BECOME="true" \
  ansible-runner
```

### Docker Environment Variables

- `PLAYBOOK` - Playbook file to execute (required)
- `INVENTORY` - Inventory file or host list (required)
- `BECOME` - Enable sudo (true/false)
- `EXTRA_VARS` - Additional variables (key=value)
- `VERBOSITY` - Output verbosity (0-4)
- `CHECK` - Dry run mode (true/false)

## CI/CD with GitHub Actions

The repository includes automated deployment via GitHub Actions. The workflow runs on push to main branch.

### Workflow Configuration

Edit `.github/workflows/main.yml`:

```yaml
- name: Run Ansible Playbook
  uses: ./
  with:
    playbook: "lampsetup_pb.yml"    # Playbook to run
    inventory: "ansible/hosts"       # Inventory file
    extra_vars: "env=production"     # Extra variables
    become: "true"                   # Enable sudo
    verbosity: "2"                   # Verbosity level
```

### Available Action Inputs

- `playbook` - Playbook file path (required)
- `inventory` - Inventory file path (required)
- `extra_vars` - Extra variables in key=value format
- `become` - Enable sudo privileges (true/false)
- `verbosity` - Output verbosity level (0-4)
- `check` - Dry run mode (true/false)
- `limit` - Limit to specific hosts
- `tags` - Run specific tags only

## Requirements

- Python 3.8+
- Ansible 2.9+
- SSH access to target hosts
- Sudo privileges on target hosts
- Docker (for containerized execution)

## Author

**Saeedullah Shaikh**
- GitHub: [@Saeedullahshaikh](https://github.com/Saeedullahshaikh)

## License

MIT License
