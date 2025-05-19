const buildItemText = (name, type) => {
    const messages = {
      comment: `${name} left a comment on your work!`,
      feedback: `${name} gave you feedback!`,
      follow: `${name} is following your work now!`,
    };
    return messages[type] || `${name} did something!`;
  };
  
  const decodeBase64 = (text) => {
    try {
      return Buffer.from(text, 'base64').toString('utf8');
    } catch (err) {
      console.error('Base64 decoding failed:', err);
      return '';
    }
  };
  
  module.exports = { buildItemText, decodeBase64 };
  