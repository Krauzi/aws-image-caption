const WebSocket = require('ws');
const polly = require('./polly');

const websocketServer = new WebSocket.Server({ port: 8080 });

websocketServer.on('connection', connection = (ws) => {
    ws.send('Connected');

    ws.on('message', processText = async (request) => {
        console.log(request);
        try {
            ws.send('Processing text');
            const parsedRequest = await JSON.parse(request);
            const buffer = await polly(parsedRequest.textToSpeech);
            
            if(buffer) {
                if (buffer.AudioStream instanceof Buffer) {
                    const response = {
                        response: buffer.AudioStream
                    }
                    ws.send(JSON.stringify(response));
                } else {
                    ws.send("Error with polly");
                }
            } else {
                ws.send('Error with polly.');
            }
            console.log("Finito");
        } catch (exception) {
            console.log("error");
            ws.send(`Internal error: ${exception}`);
        }
    });
});

console.log('Server ready.');