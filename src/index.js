const express = require ('express');
const morgan = require('morgan');
const path = require('path');
const session = require('express-session');
const validator = require('express-validator');
const passport = require('passport');
const flash = require('connect-flash');
const MySQLStore = require('express-mysql-session')(session);
const bodyParser = require('body-parser');
const cors = require("cors");

const { database } = require('./keys');



//---------Init---------
const app = express();
const passportconfig = require('./lib/passportconfig');
passportconfig(passport);

//-------Settings-------
app.set('port', process.env.PORT || 4000);

//------Midlewares------
app.use(morgan('dev'));
/*app.use(
    cors({
      origin: "http://localhost:3000", //locacion del liente en react
    })
  ); //permitir cross origin requests*/
app.use(session({
    secret: 'clinicapsicoudp',
    resave: true,
    saveUninitialized: true,
    store: new MySQLStore(database)
  }));
app.use(flash());
app.use(express.urlencoded({extended: false}));
app.use(express.json());
app.use(passport.initialize());
app.use(passport.session());
app.use(validator());

//--Variables globales--
app.use((req, res, next)=>{
    app.locals.message = req.flash('message');
    app.locals.success = req.flash('success');
    app.locals.user = req.user;
    next();
});

//--------Routes--------
app.use(require('./routes'));
app.use(require('./routes/authentication'));
app.use(require('./routes/user'));
app.use(require('./routes/convenio'));
app.use(require('./routes/tipoinstitucion'));
app.use(require('./routes/coordinador'));
app.use(require('./routes/derivacion'));
app.use(require('./routes/hechosconsultantes'));
app.use(require('./routes/motivo'));
app.use(require('./routes/paciente'));
app.use(require('./routes/contacto'));

//-----Start server-----
app.listen(app.get('port'), ()=>{
    console.log('server on port', app.get('port'));
});