<?php
/**
 * Created by PhpStorm.
 * User: afanasev
 * Date: 24.03.16
 * Time: 18:29
 */

// composer autoload
require_once __DIR__ . '/vendor' . '/autoload.php';

// my autoload
spl_autoload_register ('autoload');
function autoload($className)
{
    $className = ltrim($className, '\\');
    $fileName  = '';
    $namespace = '';
    if ($lastNsPos = strripos($className, '\\')) {
        $namespace = substr($className, 0, $lastNsPos);
        $className = substr($className, $lastNsPos + 1);
        $fileName  = str_replace('\\', DIRECTORY_SEPARATOR, $namespace) . DIRECTORY_SEPARATOR;
    }
    $fileName .= str_replace('_', DIRECTORY_SEPARATOR, $className) . '.php';

    if (is_readable($fileName)) {
        require $fileName;
    }
}