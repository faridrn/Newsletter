<?php

// GET route
$app->get('/', function () {});
$app->post('/', function () {});
$app->put('/', function () {});
$app->patch('/', function () {});
$app->delete('/', function () {});

// Users
$app->get('/users', function () {
    echo Helper::callProcedure('getUsers');
});
$app->get('/users/:id', function ($id) {
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
$app->get('/types', function () {
    // return all types
});
$app->get('/types/:name', function ($name) {
    // return type with name = $name
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
$app->get('/emails', function () {});
$app->get('/emails/:id', function ($id) {});
$app->post('/emails', function () {});
$app->put('/emails/:id', function ($id) {});
$app->delete('/emails/:id', function ($id) {});

// Newsletters
$app->get('/newsletters', function () {});
$app->get('/newsletters/:id', function ($id) {});
$app->post('/newsletters', function () {});
$app->put('/newsletters/:id', function ($id) {});
$app->delete('/newsletters/:id', function ($id) {});