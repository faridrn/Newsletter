<?php


require 'Slim/Slim.php';
\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();
$app->response->headers->set('Content-Type', 'application/json');
$app->config('debug', true);


require 'libs/includes.php';

$app->run();