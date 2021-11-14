FROM ubuntu:latest

# Install CLI tools.
RUN apt-get update && apt-get install -y ffmpeg miller

# Define mountable directories.
VOLUME ["/home/lsf/scripts", "/home/lsf/list-signs", "/home/lsf/videos"]

# Copy entrypoint.
COPY ./docker-entrypoint.sh /home/lsf/docker-entrypoint.sh
RUN chmod u+x /home/lsf/docker-entrypoint.sh

# Copy default CMD script (help).
COPY ./docker-help.sh /home/lsf/docker-help.sh
RUN chmod u+x /home/lsf/docker-help.sh

# Scripts is working dir.
WORKDIR /home/lsf

ENTRYPOINT ["/home/lsf/docker-entrypoint.sh"]

# Display help by default.
CMD ["docker-help.sh"]
