FROM ubuntu:latest

# Install CLI tools.
RUN apt-get update && apt-get install -y ffmpeg miller

# Define mountable directories.
VOLUME ["/home/lsf/scripts", "/home/lsf/list-signs", "/home/lsf/videos"]

# Copy entrypoint.
COPY ./docker-entrypoint.sh /home/lsf/docker-entrypoint.sh
RUN chmod u+x /home/lsf/docker-entrypoint.sh

# Scripts is working dir.
WORKDIR /home/lsf/scripts

ENTRYPOINT ["/home/lsf/docker-entrypoint.sh"]

# Regenerate the sign list by default.
CMD ["regenerate-sign-list.sh"]
