<?php

namespace App\Commons;

use JsonSerializable;

class ResponseWrapper implements JsonSerializable
{
    protected int $code;
    protected bool $success;
    protected string $message;
    protected $data;

    function __construct(
        int $code,
        bool $success,
        string $message,
        $data,
    ) {
        $this->code = $code;
        $this->success = $success;
        $this->message = $message;
        $this->data = $data;
    }

    public function jsonSerialize()
    {
        return get_object_vars($this);
    }
}
