FROM alpine:edge
COPY update_to_edge.sh /update_to_edge.sh
COPY install_deps.sh /install_deps.sh
COPY generate_images.sh /generate_images.sh
COPY entrypoint.sh /entrypoint.sh
COPY outputAllImagesOnTestFailure.patch /outputAllImagesOnTestFailure.patch
ENTRYPOINT ["/entrypoint.sh"]
