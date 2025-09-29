FROM runpod/worker-comfyui:5.2.0-base

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    wget \
    git \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install ComfyUI registry nodes (upscaling workflow essentials)
RUN comfy-node-install \
    comfyui-kjnodes \
    comfyui_controlnet_aux \
    was-node-suite-comfyui \
    comfyui-art-venture \
    comfyui_essentials \
    comfyui-impact-pack \
    comfyui-logicutils \
    comfyui-impact-subpack \
    comfyui-custom-scripts \
    cg-use-everywhere \
    comfyui-easy-use \
    comfyui-advancedliveportrait \
    comfyui_ultimatesdupscale \
    comfyui_fill-nodes \
    tinyterralynodes \
    rgthree-comfy

# Cloning repos
#RUN git clone https://github.com/Comfy-Org/ComfyUI-Manager.git /comfyui/custom_nodes/ComfyUI-Manager && \
#   git clone https://github.com/rgthree/rgthree-comfy.git /comfyui/custom_nodes/rgthree-comfy && \
#    git clone https://github.com/yolain/ComfyUI-Easy-Use.git /comfyui/custom_nodes/ComfyUI-Easy-Use && \
#    git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git /comfyui/custom_nodes/ComfyUI-VideoHelperSuite && \
#    git clone https://github.com/Fannovel16/ComfyUI-Frame-Interpolation.git /comfyui/custom_nodes/ComfyUI-Frame-Interpolation && \
#    git clone https://github.com/mav-rik/facerestore_cf.git /comfyui/custom_nodes/facerestore_cf && \
#    git clone https://github.com/danTheMonk/comfyui-int-and-float.git /comfyui/custom_nodes/comfyui-int-and-float && \
#    git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git /comfyui/custom_nodes/ComfyUI_UltimateSDUpscale && \
#    git clone https://github.com/CodeAcme-io/loadVideoFromURL.git /comfyui/custom_nodes/loadVideoFromURL

# Install dependencies using absolute paths
RUN pip install -r /comfyui/custom_nodes/ComfyUI-Manager/requirements.txt
RUN pip install -r /comfyui/custom_nodes/rgthree-comfy/requirements.txt
RUN pip install -r /comfyui/custom_nodes/ComfyUI-Easy-Use/requirements.txt
RUN pip install -r /comfyui/custom_nodes/ComfyUI-VideoHelperSuite/requirements.txt
RUN pip install -r /comfyui/custom_nodes/facerestore_cf/requirements.txt

# for updating the comfyui with latest github commit
RUN ls /comfyui
RUN rm -f /comfyui/extra_model_paths.yaml
RUN ls /comfyui
ADD extra_model_paths.yaml /comfyui/extra_model_paths.yaml

RUN rm -f /comfyui/test_input.json
RUN ls /comfyui
ADD test_input.json /comfyui/test_input.json
