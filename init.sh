./config.sh --environment \
    --environmentname $ENVIRONMENT_NAME \
    --acceptteeeula \
    --agent $AGENT_NAME \
    --url $ORGANIZATION_URL \
    --work $WORKDIR \
    --projectname $PROJECT_NAME \
    --auth PAT \
    --token $AUTH_TOKEN;
    
./run.sh
