FROM runpod/worker-comfyui:5.2.0-base



RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    wget \
    git \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# you can uncomment this if you want to install the nodes. To see the names you can go to https://registry.comfy.org/
RUN comfy-node-install ComfyUI_UltimateSDUpscale ComfyUI-Easy-Use  ComfyUI-fal-API ComfyUI-Frame-Interpolation ComfyUI-Manager ComfyUI-VideoHelperSuite "https://github.com/mav-rik/facerestore_cf.git" rgthree-comfy "https://github.com/danTheMonk/comfyui-int-and-float.git" 


# for updating the comfyui with latest github commit

RUN rm -f /comfyui/extra_model_paths.yaml
ADD extra_model_paths.yaml /comfyui/extra_model_paths.yaml
RUN rm -f /comfyui/test_input.json
RUN ls /comfyui