FROM node:18.2.0-alpine3.15
RUN npm install -g ajv-cli@5.0.0 ajv-formats@2.1.1
# Overwrite entrypoint (see [1]) of the 'node' base image [2], which is a
# docker-entrypoint.sh script (see [2,3]). This entrypoint script executes
# executable arguments in a standalone way, however, it passes non-executable
# arguments as arguments to the 'node' command. In this way, commands like
# 'docker run ... xxx', where xxx is either non-executable or non-existing,
# would result in attempting to run 'node xxx' in the container. This situation
# can easily happen due to a typo, an unset executable bit of a script, or a
# wrong path. Overwriting the entrypoint avoids this situations and makes it
# clear that the problem is that the provided argument is not executable.
# [1] https://stackoverflow.com/a/41207569/4747193
# [2] https://github.com/nodejs/docker-node
# [3] https://github.com/nodejs/docker-node/blob/main/docker-entrypoint.sh
# [4] https://github.com/nodejs/docker-node/blob/main/Dockerfile-alpine.template
ENTRYPOINT ["/usr/bin/env"]
CMD ["sh"]
