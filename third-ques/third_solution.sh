#!/bin/bash
ansible-playbook -i hosts.ini find_swap_space.yml

ansible-playbook -i hosts.ini install_iperf3.yml

ansible-playbook -i hosts.ini install_vim.yml
