const express = require('express');
const morgan = require('morgan');
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: false }))

app.use(morgan('dev'));

app.use(require('./controllers/authController'))
app.use(require('./controllers/routeController'))
app.use(require('./controllers/requestController'))

module.exports = app;