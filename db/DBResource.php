<?php

/**
 * Created by PhpStorm.
 * User: afanasev
 * Date: 24.03.16
 * Time: 16:15
 */

namespace db;

class DBResource
{
    public $name;
    public $url;

    public function __construct($name, $url) {

        $this->name = $name;
        $this->url = $url;
    }
}