var AWS = require('aws-sdk');

const config = new AWS.Config({
  region: 'us-east-1',
  accessKeyId: '',
  secretAccessKey: '',
  sessionToken: ''
});

AWS.config.update(config);

const client = new AWS.Polly({
  signatureVersion: 'v4',
  region: 'us-east-1'
});

const synthesizeSpeechReq = async(text) => {
    const params = {
	  Text: text,
	  OutputFormat: 'mp3',
	  VoiceId: 'Matthew'
	};
	
    return client.synthesizeSpeech(params).promise();
};

module.exports = synthesizeSpeechReq;