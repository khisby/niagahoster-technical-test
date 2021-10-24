<?php

require_once __DIR__.'/vendor/autoload.php';

use Twig\Environment;
use Twig\Loader\FilesystemLoader;

$loader = new FilesystemLoader(__DIR__ . '/templates');
$twig = new Environment($loader);

$filter = new \Twig\TwigFilter('currency', function ($currency) {
          return number_format($currency, 0, '.', '.');
});
$twig->addFilter($filter);

$filter = new \Twig\TwigFilter('currency_style', function ($currency) {
          $currency = number_format($currency, 0, '.', '.');
          $list = explode('.', $currency);
          $string = "Rp <span class='font-roboto-bold'><b style='font-weight:600;font-size:250%;vertical-align:middle;'>".$list[0]."</b>.".$list[1]. "</span>/ bln";
          
          return $string;
});
$twig->addFilter($filter);

$filter = new \Twig\TwigFilter('feature_format', function ($teks) {
          $teks = str_replace("<star>", '<i style="color: #008FEE;" class="fas fa-star"></i>', $teks);
          $list = explode('|', $teks);
          $list[0] = "<b class='font-roboto-bold' style='font-weight:600;'>".$list[0]."</b>";
          return implode($list, " ");
});
$twig->addFilter($filter);

$filter = new \Twig\TwigFilter('button', function ($diskon, $best_saller) {
          if($best_saller){
                    $class = "btn btn-primary";
          }else{
                    $class = "btn btn-outline-dark";
          }
          if($diskon == false){
                    return "<button class='".$class."' style='border-radius: 40px; padding: 8px 20px;font-weight: bold;'>Pilih Sekarang</button>";
          }
          return  "<button class='".$class."' style='border-radius: 40px; padding: 8px 20px;font-weight: bold;'>Diskon " . $diskon . "</button>";
});
$twig->addFilter($filter);

$file = file_get_contents('database.json');
$data = json_decode($file);
echo $twig->render('index.html.twig', ['data' => $data]);
