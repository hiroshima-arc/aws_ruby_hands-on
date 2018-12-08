const env = process.env.NODE_ENV;
const devUrl = 'http://127.0.0.1:9393/api';

function getApiUrl(service) {
  if (env === 'development') {
    return `${devUrl}/${service}`;
  }
};

export { getApiUrl };
