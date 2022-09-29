<?php

namespace App\Services\Contracts;

use JsonSerializable;

class AesResult implements JsonSerializable
{
    /**
     * IV
     */
    protected string $x;

    /**
     * Salt
     */
    protected string $y;

    /**
     * Cipher Text
     */
    protected string $z;

    function __construct(
        string $iv,
        string $salt,
        string $cipherText
    ) {
        $this->x = $iv;
        $this->y = $salt;
        $this->z = $cipherText;
    }

    public function jsonSerialize()
    {
        return get_object_vars($this);
    }
}
