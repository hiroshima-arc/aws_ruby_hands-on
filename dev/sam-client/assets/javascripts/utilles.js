const env = process.env.NODE_ENV;
const devUrl = 'http://127.0.0.1:9393/api';
const prdUrl = 'https://api-hiroshiam-arc.org/Prod/api';

function getApiUrl(service) {
  if (env === 'development') {
    return `${devUrl}/${service}`;
  } else {
    return `${prdUrl}/${service}`;
  }
};

export { getApiUrl };
