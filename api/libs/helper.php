<?php

abstract class Helper {

    static function getDbo() {

        $config = new Configuration();
        $dbo = new PDO("mysql:host=$config->host;dbname=$config->db", $config->user, $config->pass);
        $dbo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $dbo;
    }

    // TODO: trow error on sanitize error
    static function callProcedure($sp, $args = null, $filter = null) {
        if ($filter) {
            if (is_array($args))
                foreach ($args as $key => $arg)
                    $args[$key] = self::sanitize($arg, $filter);
            else
                $args = array(self::sanitize($args, $filter));
        }
        $query = 'call ' . $sp . '(';
        for ($i = 0; $i < count($args); $i++)
            $query .= ($i == 0) ? '?' : ', ?';
        $query .= ')';
        try {
            $db = self::getDbo();
            $stmt = $db->prepare($query);
            $stmt->execute($args);
            $data = $stmt->fetchAll(PDO::FETCH_OBJ);
            $db = null;
            return json_encode($data);
        } catch (PDOException $e) {
            return '{"error":{"text":' . $e->getMessage() . '}}';
        }
    }

    static function query($sql) {
        try {
            $db = self::getDbo();
            $stmt = $db->prepare($sql);
            $stmt->execute();
            $data = $stmt->fetchAll(PDO::FETCH_OBJ);
            $db = null;
            return json_encode($data);
        } catch (PDOException $e) {
            return '{"error":{"text":' . $e->getMessage() . '}}';
        }
    }

    static function prepareArguments($args) {
        return implode(',', $args);
    }

    static function validate($value, $type) {
        switch ($type) {
            case 'int':
                return filter_var($value, FILTER_VALIDATE_INT, FILTER_NULL_ON_FAILURE);
            case 'boolean':
                return filter_var($value, FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE);
            case 'email':
                return filter_var($value, FILTER_VALIDATE_EMAIL, FILTER_NULL_ON_FAILURE);
            case 'ip':
                return filter_var($value, FILTER_VALIDATE_IP, FILTER_NULL_ON_FAILURE);
            case 'url':
                return filter_var($value, FILTER_VALIDATE_URL, FILTER_NULL_ON_FAILURE);
        }
    }

    static function sanitize($value, $type) {
        switch ($type) {
            case 'int':
                return filter_var($value, FILTER_SANITIZE_NUMBER_INT, FILTER_NULL_ON_FAILURE);
            case 'email':
                return filter_var($value, FILTER_SANITIZE_EMAIL, FILTER_NULL_ON_FAILURE);
            case 'string':
                return filter_var($value, FILTER_SANITIZE_STRING, FILTER_NULL_ON_FAILURE);
        }
    }

}
