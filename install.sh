#!/bin/bash

# # Install habitat-sim from source
# Ensure the latest submodules
git submodule update --init --recursive

cd habitat-sim
pip install -r requirements.txt
python setup.py install --bullet --headless
cd ..

# Install habitat-lab
cd habitat-lab
pip install -r requirements.txt
python setup.py develop
cd ..

# Install requirements
pip install -r requirements.txt

# Install habitat manipulation
python setup.py develop

# Download ReplicaCAD v1.4, YCB objects, and Fetch URDF
python -m habitat_sim.utils.datasets_download --uids rearrange_task_assets

# Generate physical config to correctly configure the simulator backend
python -c "from habitat.datasets.utils import check_and_gen_physics_config; check_and_gen_physics_config()"

# Download generated episodes
pip install gdown
gdown https://drive.google.com/drive/folders/1oEhsiqoWcEA2FNuQd9QfCPKNKgSwHbaW -O data/datasets/rearrange/v3 --folder

# Post-installation
echo "export MAGNUM_LOG=quiet HABITAT_SIM_LOG=quiet" >> ~/.bashrc

echo "Installation complete. Please restart your terminal or run 'source ~/.bashrc' to apply environment variable changes."
