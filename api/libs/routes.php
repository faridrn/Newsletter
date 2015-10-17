<?php

// GET route
$app->get('/', function () {});
$app->post('/', function () {});
$app->put('/', function () {});
$app->patch('/', function () {});
$app->delete('/', function () {});

// Users
$app->get('/users(/)', function () {
    echo Helper::callProcedure('getUsers');
});
$app->get('/users/:id(/)', function ($id) {
    echo Helper::callProcedure("getUsersById", $id, 'int');
});
$app->post('/users', function () {
    // add new user
});
$app->put('/users/:id', function ($id) {
    // update user with id = $id
});
$app->delete('/users/:id', function ($id) {
    // delete user with id = $id
});

// Types
$app->get('/types(/)', function () {
    echo Helper::callProcedure('getTypes');
});
$app->get('/types/:alias(/)', function ($alias) {
    echo Helper::callProcedure("getTypesByAlias", $alias, 'string');
});
$app->post('/types', function () {
    // add new type
});
$app->put('/types/:id', function ($id) {
    // update type with id = $id
});
$app->delete('/types/:id', function ($id) {
    // delete type with id = $id
});

// Emails
$app->get('/emails(/)', function () {
    echo Helper::callProcedure('getEmails');
});
$app->get('/emails/:id(/)', function ($id) {
    echo Helper::callProcedure('getEmailsById', $id, 'int');
});
$app->post('/emails', function () {});
$app->put('/emails/:id', function ($id) {});
$app->delete('/emails/:id', function ($id) {});

// Newsletters
$app->get('/newsletters(/)', function () {
    echo Helper::callProcedure('getNewsletters');
});
$app->get('/newsletters/:id(/)', function ($id) {
    echo Helper::callProcedure('getNewslettersById', $id, 'int');
});
$app->post('/newsletters', function () {});
$app->put('/newsletters/:id', function ($id) {});
$app->delete('/newsletters/:id', function ($id) {});