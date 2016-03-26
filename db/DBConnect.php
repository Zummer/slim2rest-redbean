<?php
/**
 * Created by PhpStorm.
 * User: afanasev
 * Date: 21.03.16
 * Time: 16:41
 */

namespace db;

class DBConnect
{
    public $connect;
    public $user;
    public $pass;

    public function __construct()
    {
        $this->connect = 'mysql:host=localhost;dbname=slim1';
        $this->user = 'root';
        $this->pass = '123';
    }
}