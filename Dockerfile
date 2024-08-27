FROM jraviles/dump1090

RUN apt-get update && apt-get install -y \
rtl-sdr
# Copy a custom startup script into the container
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set the entry point to the custom script
ENTRYPOINT ["/start.sh"]
