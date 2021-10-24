<?php

require_once __DIR__.'/vendor/autoload.php';

use Twig\Environment;
use Twig\Loader\FilesystemLoader;

$loader = new FilesystemLoader(__DIR__ . '/templates');
$twig = new Environment($loader);

$file = file_get_contents('database.json');
$data = json_decode($file);
echo $twig->render('index.html.twig', ['data' => $data]);
