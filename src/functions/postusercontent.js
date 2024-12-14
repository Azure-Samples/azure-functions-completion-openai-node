const { app, input } = require("@azure/functions");

// This OpenAI completion input requires a {name} binding value.
const openAICompletionInput = input.generic({
    prompt: '{content}',
    maxTokens: '100',
    type: 'textCompletion',
    model: '%CHAT_MODEL_DEPLOYMENT_NAME%'
})

app.http('PostUserContent', {
    methods: ['POST'],
    route: 'postusercontent',
    authLevel: 'function',
    extraInputs: [openAICompletionInput],
    handler: async (_request, context) => {
        var response = context.extraInputs.get(openAICompletionInput)
        return { body: response.content.trim() }
    }
});