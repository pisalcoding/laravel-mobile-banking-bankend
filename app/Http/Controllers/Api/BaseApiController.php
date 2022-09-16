<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Commons\ResponseWrapper;

class BaseApiController extends Controller
{

    /**
     * Constructs a common JSON response
     */
    protected function jsonResponse(
        $data = null,
        bool $success = true,
        string $message = null,
        int $customCode = 000,
        int $httpCode = 200,
        array $headers = []
    ) {
        $result = new ResponseWrapper(
            $customCode,
            $success,
            $message,
            $data
        );
        return response()->json($result->jsonSerialize(), $httpCode, $headers);
    }
}
