<?php

if (!function_exists('safeMessage')) {
    function safeMessage($debugMessage, $productionMessage)
    {
        if (env("APP_DEBUG")) {
            return $debugMessage;
        } else {
            return $productionMessage;
        }
    }
}
