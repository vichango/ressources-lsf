#!/bin/bash

echo
echo "Create image:    docker build -t lsf-code:local ."
echo
echo "Usage:"
echo
echo "1. Regenerate sign list:"
echo
echo "   \`\`\`sh"
echo "   docker run --rm \\"
echo "        --volume=\"\$(pwd)/scripts:/home/lsf/scripts\" \\"
echo "        --volume=\"\$(pwd)/list-signs:/home/lsf/list-signs\" \\"
echo "        lsf-code:local \"scripts/regenerate-sign-list.sh\""
echo "   \`\`\`"
echo
echo "2. Resize/encode videos:"
echo
echo "   \`\`\`sh"
echo "   docker run --rm \\"
echo "        --volume=\"\$(pwd)/scripts:/home/lsf/scripts\" \\"
echo "        --volume=\"\$(pwd)/videos:/home/lsf/videos\" \\"
echo "        lsf-code:local \"scripts/resize-encode.sh\""
echo "   \`\`\`"
echo
