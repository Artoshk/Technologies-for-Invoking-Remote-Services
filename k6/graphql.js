import http from 'k6/http';

export default function () {
  const query = `
    query {
      usuarios {
        nome
        idade
        id
      }
    }
  `;

  const url = 'http://localhost:4000/api';
  const headers = { 'Content-Type': 'application/json' };

  const response = http.post(url, JSON.stringify({ query }), { headers });

  console.log('Response status code:', response.status);
  console.log('Response body:', response.body);
}
