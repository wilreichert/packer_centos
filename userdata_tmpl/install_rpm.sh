#!/bin/bash
printf "\033c"
echo "Installing Application"
rpm -Uvh __RPM_URL__ 2>&1

