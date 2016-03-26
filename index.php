<?php
/**
 * Created by PhpStorm.
 * User: afanasev
 * Date: 21.02.16
 * Time: 20:52
 */

require 'autoload.php';

use Slim\Slim;
use RedBeanPHP\R;
use db\DBConnect;
use db\DBResource;

// Application
$app = new Slim();

// CORS
$corsOptions = array("origin" => "*");
$corsRoute = \CorsSlim\CorsSlim::routeMiddleware($corsOptions);
$app->add(new \CorsSlim\CorsSlim());

// Database Connect
$db = new DBConnect();
R::setup($db->connect, $db->user, $db->pass);
R::freeze(true);

// Resources
$cR = new DBResource('company', '/items');

// CREATE
$app->post($cR->url,
    $corsRoute,
    function () use ($app, $cR) {

        $limit = 0;
        $page = 0;

        try {
            // get and decode JSON request body
            $request = $app->request();
            $body = $request->getBody();
            $input = json_decode($body);

            // store item record
            $item = R::dispense($cR->name);
            $item->name = (string)$input->item->name;
            $item->ownAddress[] = R::dispense('address');

            $i = 0;
            foreach ($input->item->ownAddress as $inputAdr) {
                $item->ownAddress[$i]->city = $inputAdr->city;
                $i++;
            }

            // сохраняем
            R::store($item);

            // нам нужна последняя страница, потому что при создании нового мы переходим в конец
            // и все фильтры отменяются
            $totalItems = R::count($cR->name);
            $limit = $input->limit;
            $totalPages = ceil($totalItems / $limit);
            $page = $totalPages;

            $items = R::find($cR->name, 'LIMIT :start, :limit ', [
                ':start' => (($page - 1) * $limit),
                ':limit' => $limit
            ]);

            // return JSON-encoded response body with query results
            $exportArray['items'] = R::exportAll($items);
            $exportArray['pagination'] = [
                'page' => $page,
                'limit' => $limit,
                'totalItems' => $totalItems,
                'totalPages' => $totalPages
            ];
            $app->response->header('Content-Type', 'application/json');
            $app->response->write(json_encode($exportArray, JSON_UNESCAPED_UNICODE));
        } catch (Exception $e) {
            $app->response->status(400);
            $app->response->header('X-Status-Reason', $e->getMessage());
        }
    });

// READ - GET Object of Objects
$app->get($cR->url,
    $corsRoute,
    function () use ($app, $cR) {
        $limit = 0;
        $page = 0;
        $totalItems = 0;

        // некоторые условия
        if (isset($_GET["limit"])) {
            $limit = $app->request->get('limit');
            settype($limit, 'integer');
        } else {
            $limit = 10;
        }
        if (isset($_GET["page"])) {
            $page = $app->request->get('page');
            settype($page, 'integer');
        } else {
            $page = 1;
        }
        if (isset($_GET["filter"])) {
            $filter = $app->request->get('filter');
            $filter_array = explode(" ", $filter);
        } else {
            $filter = "";
        }

        // попытка
        try {
            if ($filter == "") { // если фильтр пустой, то...
                $items = R::find($cR->name, ' LIMIT :start, :limit ', [
                    ':start' => (($page - 1) * $limit),
                    ':limit' => $limit
                ]);
                $totalItems = R::count('company');
            } else {
                $sql = "SELECT DISTINCT c.*
                FROM company c, address a
                WHERE ";
                $i = 0;
                foreach ($filter_array as $filt) {
                    if ($i == 0) {
                        $sql = $sql . "(c.id = a.company_id AND instr(concat_ws('', c.name, a.city) , '$filt') > 0)";
                    } else {
                        $sql = $sql . " OR (c.id = a.company_id AND instr(concat_ws('', c.name, a.city) , '$filt') > 0)";
                    }
                    $i++;
                }

                $allrows = R::getAll($sql);
                $totalItems = count($allrows);
                //здесь надо вырезать кусок из массива
                $rows = array_slice($allrows, ($page - 1) * $limit, $limit);
                $items = R::convertToBeans($cR->name, $rows);
            }

            $totalPages = ceil($totalItems / $limit);

            // return JSON-encoded response body with query results
            $exportArray['items'] = R::exportAll($items);
            $exportArray['pagination'] = [
                'totalItems' => $totalItems,
                'totalPages' => $totalPages
            ];
            $app->response->header('Content-Type', 'application/json');
            $app->response->write(json_encode($exportArray, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));
        } catch (PDOException $e) {
            echo '{"error":{"text":' . $e->getMessage() . '}}';
        }
    });

// READ - GET One
$app->get($cR->url . '/:id',
    $corsRoute,
    function ($id) use ($app, $cR) {
        try {
            $item = R::findOne($cR->name, 'id=?', array($id));

            // if found, return JSON response
            if ($item) {
                $exportArray = R::exportAll($item);
                $app->response->header('Content-Type', 'application/json');
                // в нашем случае нам нужен лишь один объект [0]
                $app->response->write(json_encode($exportArray[0],
                    JSON_FORCE_OBJECT | JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT));
            } else {
                // else throw exception
                throw new ResourceNotFoundException();
            }
        } catch (ResourceNotFoundException $e) {
            // return 404 server error
            $app->response->status(404);
        } catch (Exception $e) {
            $app->response->status(400);
            $app->response->header('X-Status-Reason', $e->getMessage());
        }
    });

//UPDATE
$app->post($cR->url . '/:id',
    $corsRoute,
    function ($id) use ($app, $cR) {
        try {
            // get and decode JSON request body
            $body = $app->request->getBody();
            $input = json_decode($body);

            // query database for single article
            $item = R::findOne($cR->name, 'id=?', array($id));

            if ($item) {
                $item->name = (string)$input->name;

                foreach ($item->ownAddress as $itemAdr) {
                    foreach ($input->ownAddress as $inputAdr) {
                        if ($itemAdr->id == $inputAdr->id) {
                            $itemAdr->city = $inputAdr->city;
                        }
                    }
                }
                // store modified item
                R::store($item);
                // нам нужен лишь один объект [0]
                $exportArray = R::exportAll($item);
                $app->response->header('Content-Type', 'application/json');
                // return JSON-encoded response body
                $app->response->write(json_encode($exportArray[0], JSON_FORCE_OBJECT | JSON_UNESCAPED_UNICODE));
            } else {
                throw new ResourceNotFoundException();
            }
        } catch (ResourceNotFoundException $e) {
            $app->response->status(404);
        } catch (Exception $e) {
            $app->response->status(400);
            $app->response->header('X-Status-Reason', $e->getMessage());
        }
    });

//DELETE
$app->post($cR->url . '/:id' . '/:action',
    $corsRoute,
    function ($id, $action) use ($app, $cR) {

        $limit = 0;
        $page = 0;

        if (isset($_GET["limit"])) {
            $limit = $app->request->get('limit');
            settype($limit, 'integer');
        } else {
            $limit = 10;
        }
        if (isset($_GET["page"])) {
            $page = $app->request->get('page');
            settype($page, 'integer');
        } else {
            $page = 1;
        }

        try {
            // query database for item
            $item = R::findOne($cR->name, 'id=?', array($id));

            // delete item
            if ($item && $action == 'delete') {
                foreach ($item->ownAddress as $itemAdr) {
                    R::trash($itemAdr);
                }
                R::trash($item);
                $totalItems = R::count($cR->name);
                $totalPages = ceil($totalItems / $limit);

                if ($page > $totalPages) {
                    $page = $totalPages;
                }

                // ответ должен прийти со страницей
                $items = R::find($cR->name, 'LIMIT :start, :limit ', [
                    ':start' => (($page - 1) * $limit),
                    ':limit' => $limit
                ]);

                // return JSON-encoded response body with query results
                $exportArray['items'] = R::exportAll($items);
                $exportArray['pagination'] = [
                    'page' => $page,
                    'limit' => $limit,
                    'totalItems' => $totalItems,
                    'totalPages' => $totalPages
                ];
                $app->response->header('Content-Type', 'application/json');
                $app->response->write(json_encode($exportArray, JSON_UNESCAPED_UNICODE));
            } else {
                throw new ResourceNotFoundException();
            }
        } catch (ResourceNotFoundException $e) {
            $app->response->status(404);
        } catch (Exception $e) {
            $app->response->status(400);
            $app->response->header('X-Status-Reason', $e->getMessage());
        }
    });

$app->run();